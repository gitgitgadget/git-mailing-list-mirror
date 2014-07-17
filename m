From: Sajan Parikh <sajan@parikh.io>
Subject: Syncing Git Repositories
Date: Wed, 16 Jul 2014 21:26:07 -0500
Message-ID: <53C7343F.4090806@parikh.io>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000905000905010306010300"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 05:22:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7cGp-0001sP-1K
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 05:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbaGQDWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 23:22:06 -0400
Received: from mx1.noppix.net ([162.246.56.157]:54083 "EHLO mx1.noppix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbaGQDWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 23:22:05 -0400
X-Greylist: delayed 3355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2014 23:22:05 EDT
Received: from 173-23-208-195.client.mchsi.com ([173.23.208.195]:49150 helo=[192.168.1.65])
	by mx1.noppix.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <sajan@parikh.io>)
	id 1X7bOZ-00086Q-VG
	for git@vger.kernel.org; Wed, 16 Jul 2014 21:26:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mx1.noppix.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - parikh.io
X-Get-Message-Sender-Via: mx1.noppix.net: authenticated_id: sajan@parikh.io
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253720>

This is a cryptographically signed message in MIME format.

--------------ms000905000905010306010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On all my laptops and desktops, I have a directory at /home/sajan/Code=20
where all my active projects and repositories live.

/home/sajan/Code/repository1
/home/sajan/Code/repository2
/home/sajan/Code/repository3

=2E..etc...

Up until now I've relied on pushing and pulling to and from my Gitlab=20
server to keep my projects in sync across all my laptops and desktops. =20
It's worked great.

However, today I decided to add my code folder to my ownCloud server and =

sync it across all my laptops and desktops the same way I do for=20
/home/sajan/Documents, /home/sajan/Music, and a few application config=20
directories to keep all my devices in sync.

By syncing my code folder and git repositories in this way, do I risk=20
borking any repositories?  I'm 99% confident I'm not, since everything=20
is in .git/, and there are not external databases or log files that need =

to be updated.  Just making sure though.

I'm only doing this because sometimes I forget to pull changes down from =

my Gitlab server on a different laptop or desktop and start making local =

changes.  Which is fine, I can merge easily, but if everything were=20
sync'd automatically when I logged into my computer it would be great.

Another option I thought of would be to write a bash script that=20
executed at login and went into each of my repositories and ran git=20
pull, but I decided against this because of legitimate non-fast-forward=20
merges.

TLDR;

If I sync my repositories across computers using something similar to=20
Dropbox, rather than pushing/pulling to and from an central repository,=20
am I risking borking any respository?

--=20
Sajan Parikh



--------------ms000905000905010306010300
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIzjCC
BBcwggL/oAMCAQICCwQAAAAAATGJxi2nMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0ds
b2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTExMDgwMjEwMDAwMFoXDTE5MDgwMjEwMDAwMFowXTELMAkGA1UEBhMC
QkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIDEgQ0EgLSBTSEEyNTYgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALTO/+yd1VLOKV+Vhs2LniCahWV+U8mhxl4Kc+90KYToks71//5ohE+KakDCMjHb
sarz2XHrXqI39F9W+bz1ywgQqTlVUaEpeSleB/rMRCQDnq/moVgFAPVXLy7a6vIBg2krwzZG
iQTlX5bctwmSldEfvFkDA9JYeco/8YTGyM0T4Lju9nS58ACeKza+yWIAn8U8tsPLXqIy3zTs
1k+1WGE5A4/0l9/j8VAysGjIBj9o8IvbRSZeCjmileGQB7qDRt+jHvwHDZwv7PbDdXhM9eko
Pcu8EIwI2cVEu0HlmQ6NKZPdyN/4dmilK4kBEFea2dz9pQeuIFvqcUaz3ow1wHMCAwEAAaOB
6DCB5TAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQU/imp
uP+cW8ntQtlud9g0V0GnbQUwRwYDVR0gBEAwPjA8BgRVHSAAMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDYGA1UdHwQvMC0wK6ApoCeG
JWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5uZXQvcm9vdC1yMy5jcmwwHwYDVR0jBBgwFoAUj/BL
f6guRSSuTVD6Y5qL3uLdG7wwDQYJKoZIhvcNAQELBQADggEBAAy3LufCX5LOCYQNodzoYD9v
OqFmXG4WaH48MH37laW7lvDdKcG8995H4KBDBqQG1kIlIVAsz8uulADG0JftZ6WiuOEkN1G4
duKCUtmCTz4wTmoZ75yuEC/GQNXaVJM0L+VD8g88yZL88obT7QV8pGcRy6qCjXdNNqTOwNTU
/SGRJR+9jBSaCKsUwbgLhQ9sqQhIBgc/UMPT8sL5jyJmfHdQFGGEmKBP58YIP719HSMwiEq7
kxVvCs+oW2R2hEdUPcwLj38syy+paTRIJsbTGEDlEpLQ7UbtzcY4De4Y1KFIjtZIHAv0TbNz
iVvehbxHKyQFqOcQW5TL93FYuYSoKz4wggSvMIIDl6ADAgECAhBmtFXDF72w67XdWUSDiz8i
MA0GCSqGSIb3DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAxIENBIC0gU0hBMjU2IC0g
RzIwHhcNMTQwNDE3MTg0MTEwWhcNMTUwNDE4MTg0MTEwWjA6MRgwFgYDVQQDDA9zYWphbkBw
YXJpa2guaW8xHjAcBgkqhkiG9w0BCQEWD3NhamFuQHBhcmlraC5pbzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAOAPBER9k9KJkMN/uJp7f/m5l1SbFETczIUHn/mbQzv9j6GS
928rBhz8rKyM0WG2eWZa9dyTBJjUSyVgWsYoCeWrU31ktp/L9Ol8OtuiFtIhqiBR9D1CQMBC
kUxYcdf718y8IzNSVRqkWatXX5od2PG2Vy0EoVZkTKOTAYKMcwp5W79n0ZRFsI6h4cfYydZ8
BfeB/BpCSmoN5sjBPBqj/Fje7Kw4KrGiKih97erOvuArES5piSDAuxGz86A5UUFDoKmSlabD
EHF191dcjxEUDlJxV0XruB6XarmZux4G4EePnYl41XDaZFMjiqZE7dF5ZrZpPwzw1qWxcAjU
ZfsI7D0CAwEAAaOCAYwwggGIMA4GA1UdDwEB/wQEAwIFoDBMBgNVHSAERTBDMEEGCSsGAQQB
oDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
b3J5LzAaBgNVHREEEzARgQ9zYWphbkBwYXJpa2guaW8wCQYDVR0TBAIwADAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwRwYDVR0fBEAwPjA8oDqgOIY2aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9ncy9nc3BlcnNvbmFsc2lnbjFzaGEyZzIuY3JsMFkGCCsGAQUFBwEBBE0w
SzBJBggrBgEFBQcwAoY9aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nw
ZXJzb25hbHNpZ24xc2hhMmcyLmNydDAdBgNVHQ4EFgQUvd2AycGEUam6nmvVdMoq98cQfHow
HwYDVR0jBBgwFoAU/impuP+cW8ntQtlud9g0V0GnbQUwDQYJKoZIhvcNAQELBQADggEBAH/t
kjFcOCe65Ouxi4P8G2Vh2b3CO+iFvVmxdomd+rWhJljmLTSaDT/7RB2V0UtkcnyBjzE5xmKd
EOrgoMXQpFC9ClcXZWuCoG4qXhaoticSdTxmW0gLJekaKH5ZU8YgmW9aPy778LmUCYi2nJQk
Qrhs9uaIfI89u9NRmf+iP094qgjmtKaBGTNwIo9nEN+rhUVvfnlPqcZBIraIPUTem5qvRj6g
V66ev6t0qNAA9vrBJzfMBqz5OmQNSaC7D28yoeqrTfexYr4neO9H0T5vW1vQpifdmE/bF7Km
nV3U2nkXy4XXPp/CMWQvQQgjVQLW8xNK/o1IwLAoSN9hdRQX45AxggNvMIIDawIBATBxMF0x
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9i
YWxTaWduIFBlcnNvbmFsU2lnbiAxIENBIC0gU0hBMjU2IC0gRzICEGa0VcMXvbDrtd1ZRIOL
PyIwCQYFKw4DAhoFAKCCAdMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTQwNzE3MDIyNjA3WjAjBgkqhkiG9w0BCQQxFgQUfofNfe+1Y2CZ07X+fr5A+Qzt
fREwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDCBgAYJKwYBBAGCNxAEMXMwcTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMSBDQSAtIFNI
QTI1NiAtIEcyAhBmtFXDF72w67XdWUSDiz8iMIGCBgsqhkiG9w0BCRACCzFzoHEwXTELMAkG
A1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNp
Z24gUGVyc29uYWxTaWduIDEgQ0EgLSBTSEEyNTYgLSBHMgIQZrRVwxe9sOu13VlEg4s/IjAN
BgkqhkiG9w0BAQEFAASCAQAGlm7PE4KBn0CbXxmgMqzvnpwodO6WbHd75MOnNXGdIfRyO0Iu
aPacXzWgmb5DiNaJ3BgGHIR79IE4sFRVIjM73Tbmw5+OUKTni70h7BeV4r0Z9goj0EahSA84
sQzVE8ASOYV1Cox0Qutmp36bEhAR1p7i9m21/jNDEzZ2HbNJeQzaOFHnJde+a1cTTXxDae5E
X9rqLOF61gE5JrlDmGjKsjp2mv4jVuk7VlX2haDT0gJ4S0zCvWvubnhu1DeQwoZup1wRI99N
la4WCUNNGgnFozwdzEpHe5WyLG+YAalxbaZH9bMAGH+8enIu5P/dfhAUvr+fuN4TBfDF23Mj
w6N7AAAAAAAA
--------------ms000905000905010306010300--
