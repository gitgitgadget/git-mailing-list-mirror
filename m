From: Scott Schmit <i.grok@comcast.net>
Subject: Re: git push --all --tags
Date: Sat, 15 Nov 2014 12:56:55 -0500
Message-ID: <20141115175655.GA27247@odin.ulthar.us>
References: <loom.20141115T054352-272@post.gmane.org>
 <20141115185836.103fc4f493ad55725eab38f0@domain007.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="jI8keyz6grp/JLjh"
Cc: Ryan Jacobs <ryan.mjacobs@gmail.com>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Nov 15 19:05:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XphjB-0002HR-NG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 19:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbaKOSFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 13:05:14 -0500
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:55925 "EHLO
	resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754152AbaKOSFN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 13:05:13 -0500
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Nov 2014 13:05:13 EST
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
	by resqmta-ch2-01v.sys.comcast.net with comcast
	id Ftwa1p00427uzMh01tx1A4; Sat, 15 Nov 2014 17:57:01 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-ch2-02v.sys.comcast.net with comcast
	id Ftwy1p00U2Ekl4801tx0QE; Sat, 15 Nov 2014 17:57:00 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id sAFHuvBR031198;
	Sat, 15 Nov 2014 12:56:57 -0500
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id sAFHutVU031197;
	Sat, 15 Nov 2014 12:56:55 -0500
Mail-Followup-To: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Ryan Jacobs <ryan.mjacobs@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20141115185836.103fc4f493ad55725eab38f0@domain007.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1416074221;
	bh=Y+iysgePGpOU9WJ8y+KPi8MS3weACSSYWcfzMBW1RXU=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=snJM7yQwDidXIankKGF+CNoNQ/m92RZz+McSzew+Kt3KxeIaXmp9C2TaHig+zra4Q
	 hMLQqxRBtNVdyzf7BkgUFeTIkWBpbgHo9EUmdRW4gR2wAGG+45PrUfSyY3kQNSUrcN
	 xCnze6J6P0z2/Gecf+stV+99B2t6qSLMgbrHqXfuG5yLPfqCexSBkbfTONnJHGSO/s
	 AGDjkrfIZ8ac5/ND0C40rpdRnW4pHzPKqVmHIu0xPBxCUztHYUz5gtJJUFZ5bIelP3
	 fT+u9mpLuduzSos85HClZhFA2gZ1Gl3Nh+9nCjM9m/DRQLYjLcUDHm3kX1gB/p6I5N
	 mKJk472iGHG6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2014 at 06:58:36PM +0300, Konstantin Khomoutov wrote:
> On Sat, 15 Nov 2014 04:44:19 +0000 (UTC) Ryan Jacobs wrote:
> > $ git push --all --tags
> > error: --all and --tags are incompatible
> >=20
> > Why are these flags incompatible? Just wondering 'cause I think that
> > it would be a good feature to be able to push all of your branches
> > and all of your tags to the server in one quick and simple command.
>=20
>   git push --mirror
>=20
> should do this.

Except that mirror also deletes anything removed locally.  --all and
--tags don't.

--jI8keyz6grp/JLjh
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIPLwYJKoZIhvcNAQcCoIIPIDCCDxwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
DGAwggY0MIIEHKADAgECAgEeMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYD
VQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0
ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0
ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEp
pC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVCk6U9
b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIqu54q
zHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/
4ebfeZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8E
BTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIw
HwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsG
AQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4IC
AQAKgwh9eKssBly4Y4xerhy5I3dNoXHYfYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8py
TUnFsukDFUI22zF5bVHzuJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMm
CeUTyMyikfbUFvIBivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhTMXIz
uQ8CnykhExD6x4e6ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/O75CDUHDRHCCKBVm
z/Rzkc/b970MEeHt5LC3NiWTgBSvrLEuVzBKM586YoRD9Dy3OHQgWI270g+5MYA8GfgI/EPT
5G7xPbCDz+zjdH89PeR3U4So4lSXur6H6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lAp
sbAonrqASfTpaprFVkL4nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076
khXO7cNbBIRdJ/6qQNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklAxtm8
J7GCUBthHSQgepbkOexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV27ioRKbj/cIq7JRX
un0NbeY+UdMYu9jGfIpDLtUUGSgsg2zMGs5R4jCCBiQwggUMoAMCAQICAwo/3zANBgkqhkiG
9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNV
BAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0
Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTE0MDYxNjAw
NDQ1NVoXDTE1MDYxNjE3MzYyNFowQDEbMBkGA1UEAwwSaS5ncm9rQGNvbWNhc3QubmV0MSEw
HwYJKoZIhvcNAQkBFhJpLmdyb2tAY29tY2FzdC5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC3HoziY3IySZbVkCfbjfgjTKO5CISA2+1GKzBNbzycTCXBWLnHvzrlFPlI
17z3noLux8ebSYz+TFiCUuVdwKkFOpN0WWxGzD6K/Hb0AJtKZp62YKtyRkCV51n5NrEepo28
hFkRhjgSkZA9t/4vtaWt0Ds8pIpUoQ1sNaUDWzjJ3UALl7m6b3XZmIouND+jq1AQv0ivMLuk
QNXO2a0KcuRVHDhAEdBvTi9LSePi8+Q8UWWBOeWmGhiKwL5X98Ne03GKxxQnLXDJbrX+cNcC
uaZIPdrmhbZCo+zegLfrApLRu9/6ox6/dnRsvmMpGcjNKLCgKoEh4cwyb+mhyzPXWlpXAgMB
AAGjggLYMIIC1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFKtASVM24m5BiMPABLNlKft1oxbCMB8GA1UdIwQYMBaA
FFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB0GA1UdEQQWMBSBEmkuZ3Jva0Bjb21jYXN0Lm5ldDCC
AUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFy
dENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3
YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVt
ZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUg
aW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9j
cnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2Nz
cC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6
Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNV
HRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQADggEBALTg
t4rndUh0up2qJuskCTx4iRQd59+R0kOm7vJa94t+fSa8Wip4WeVOJZaHs1XIp17yoLTzcXN9
+L5lTC7HaHrBGOdB8su0muQyS///XwbDgn3/9+D0stPJZYLMrfRSm/FzQEk5j5McmODTCq8a
tQrlQilnBDcY00CYKBTKGAleOPjQ8yg/QVb/uqNuKE88+mfEdc6AKykYg7VXqxdL54ylqR3o
P8+PsP1YgCE2wqWWfGUp6hxIKa2XGtqVdHqL1yc5equX97TiUiIQ51j+nmU8tXTuR7OPRA1B
cHA+jx6rchpnZMEJn9DYPFOvkkC86mxOCax9r5HOtdidcw8uZSoxggKXMIICkwIBATCBlDCB
jDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3Vy
ZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMKP98wCQYFKw4DAhoFAKCB2DAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDExMTUxNzU2NTVa
MCMGCSqGSIb3DQEJBDEWBBQM9ZVxieWPd6oOMXUC0ZIYyzJWYTB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAN
BgkqhkiG9w0BAQEFAASCAQByqw7FCNvkNtRmOgPVx0RF/3E7jfgMSVJ03m1FZTelrW+vwtvV
thB8v0ylg3ilUSnVJfRldYxApzvZugyBYeVn9hKNenfX0pUxsEKjnE4LR+h1v3L3FQRWykQy
9OVqD7qfZT/BzhaL/YE3O4RII3GOMCxYWcLUmHcf0trrZy+OKO40r9EvK2ZUogIwF4jtyQgr
mTPrfIbDl3j+ZGYuhIQTEPcZ9ZUgvJOIH5Cjq0aGKQa7WfPIUEAnbR2jE5bUB8L0Qcu7NooS
1lcLh5NIc/mryDtZbBg2lgfDj0ENi+m7tIeG1ZxdBBYQzdf91IAIAaAPFN299wzFIIMWKEGp
HHFk

--jI8keyz6grp/JLjh--
