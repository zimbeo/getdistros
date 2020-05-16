# Make the CSV
Add-Content C:\Users\$env:USERNAME\Desktop\groups.csv -Value '"Group","users"'

# Get all the Distro Groups
$distrogroups = Get-ADGroup -Filter * | Where-Object -Property groupcategory -eq -Value distribution | Select-Object -ExpandProperty name > C:\Users\$env:USERNAME\Desktop\allgroups.txt

$gc = Get-Content C:\Users\$env:USERNAME\Desktop\allgroups.txt

#Loop through each distro group, select member & name, store data in csv
foreach ($i in  $gc)
{

$members = Get-ADGroupMember -Identity ("${i}") | Select-Object -ExpandProperty name | out-string

$string = [pscustomobject]@{
    "Group" = $i
    "Users" = $members
    }

    export-csv -Append -InputObject $string -NoTypeInformation -Path C:\Users\$env:USERNAME\Desktop\groups.csv
}

Write-Host "Distribution groups exported to groups.csv on Desktop" -ForegroundColor Red  