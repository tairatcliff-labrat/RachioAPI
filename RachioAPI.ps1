<#
The first thing to do is to get the Bearer Token from your Rachio online account - https://app.rach.io/


Comand Examples

## Get the user id
    Rachio-GetUserId

## Return all of the Rachio device details. Expand the JSON properties to get device settings and zone settings
    $UserId = (Rachio-GetUserId).Id
    Rachio-GetDeviceDetails $UserId
    (Rachio-GetDeviceDetails $UserId).devices.zones

## Start a Zone by passing through the Zone ID and duration in seconds
    Rachio-StartZone "c053455g-7551-4269-1236-7h8j836f8562" 20

#>

$BearerToken = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
$Headers = @{
  "Authorization" = "Bearer $token"
  "Content-type" = "application/json"
}


Function Rachio-GetUserId(){
    $uri = "https://api.rach.io/1/public/person/info"
    Try{
        $UserId = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        return $UserId 
    } Catch {
        Write-Host "Could not retrieve Device ID"
    }
}


Function Rachio-GetDeviceDetails($UserId){
    $uri = "https://api.rach.io/1/public/person/$UserId"
    Try{
        $DeviceDetails = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        return $DeviceDetails
    } Catch {
        Write-Host "Could not retrieve Device details"
    }
}


Function Rachio-StartZone ([string]$ZoneId, [string]$Duration){
    $uri = "https://api.rach.io/1/public/zone/start"
    $Body = "{`"id`" : `"$ZoneId`", `"duration`" : $Duration}"

    Try{
        $StartZone = Invoke-RestMethod -Uri $uri -Headers $headers -Method Put -Body $Body
    } Catch {
        Write-Host "Failed to start zone $ZoneId"
    }
}