From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH] standardize usage info string format
Date: Tue, 13 Jan 2015 00:29:01 -0500
Message-ID: <20150113052901.GA10126@odin.ulthar.us>
References: <1420698501-15393-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="5vNYLRcllDrimb99"
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	Matthieu.Moy@imag.fr, krh@redhat.com, vmiklos@frugalware.org,
	madcoder@debian.org, barra_cuda@katamail.com, dpotapov@gmail.com,
	git@adamspiers.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, barkalow@iabervon.org, stefanbeller@gmail.com,
	shawn.bohrer@gmail.com, felipe.contreras@gmail.com,
	rhansen@bbn.com, pasky@ucw.cz, s-beyer@gmx.net,
	c.shoemaker@cox.net, grnch@gmx.net, jbowes@dangerouslyinc.com,
	l.s.r@web.de, philipoakley@iee.org, michal.kiedrowicz@gmail.com,
	cmn@elego.de, artagnon@gmail.com, rctay89@gmail.com,
	stefan.naewe@gmail.com, pbonzini@redhat.com, aspotashev@gmail.com,
	johan@herland.net, luksan@gmail.com, bebarino@gmail.com,
	Johannes.Schindelin@gmx.de, kevin@bracey.fi, jasampler@gmail.com,
	brad.king@kitware.com, git@drmicha.warpmail.net, peff@peff.net,
	chriscool@tuxfamily.org, a
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 06:53:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAuPe-000737-5x
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 06:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbbAMFxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 00:53:05 -0500
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:52838 "EHLO
	resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041AbbAMFxD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2015 00:53:03 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jan 2015 00:53:03 EST
Received: from resomta-ch2-18v.sys.comcast.net ([69.252.207.114])
	by resqmta-ch2-12v.sys.comcast.net with comcast
	id fHkq1p0032Udklx01HkrSu; Tue, 13 Jan 2015 05:44:51 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-ch2-18v.sys.comcast.net with comcast
	id fHjg1p0052Ekl4801Hjg3J; Tue, 13 Jan 2015 05:44:44 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id t0D5VQb4012484;
	Tue, 13 Jan 2015 00:31:26 -0500
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id t0D5T1tK012379;
	Tue, 13 Jan 2015 00:29:01 -0500
Mail-Followup-To: Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, pclouds@gmail.com, Matthieu.Moy@imag.fr,
	krh@redhat.com, vmiklos@frugalware.org, madcoder@debian.org,
	barra_cuda@katamail.com, dpotapov@gmail.com, git@adamspiers.org,
	sunshine@sunshineco.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	barkalow@iabervon.org, stefanbeller@gmail.com,
	shawn.bohrer@gmail.com, felipe.contreras@gmail.com, rhansen@bbn.com,
	pasky@ucw.cz, s-beyer@gmx.net, c.shoemaker@cox.net, grnch@gmx.net,
	jbowes@dangerouslyinc.com, l.s.r@web.de, philipoakley@iee.org,
	michal.kiedrowicz@gmail.com, cmn@elego.de, artagnon@gmail.com,
	rctay89@gmail.com, stefan.naewe@gmail.com, pbonzini@redhat.com,
	aspotashev@gmail.com, johan@herland.net, luksan@gmail.com,
	bebarino@gmail.com, Johannes.Schindelin@gmx.de, kevin@bracey.fi,
	jasampler@gmail.com, brad.king@kitware.com,
	git@drmicha.war 
Content-Disposition: inline
In-Reply-To: <1420698501-15393-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1421127891;
	bh=xqBDcd5D/qtd1EqKx13Got0DdiXWFtbKrobcrkX/vqs=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=psgsQsTrMYufvy94zD6mHZaKuga7TnVRuyaAPAzuYowDIzWSqsTmbywDYwpbnnrYp
	 XidUIgz2GYjT9bDYiIFGrVlkeI2aPBA0d3jzrmpzVTZDBUUXM+Bt6Fk/yf5PNgbzWh
	 Q/LsK+gG5Cgwku/OlqknMVLWHXUOzioukxz130CHbmd6pIo050bJo1uy8rnFn5ogRV
	 tFxKcT9hO0A6v0cjLpaEJloyxzVF9nnaxIfnzXWfYh+V+a1RVt8FK5YKPDIRzEqWxI
	 w2q6YZwirFBZ17Y/loNJRbpVXl9gWKDxF7fPIkSaBCQ2Nf+W/3lRSM3ybkySCb6fe5
	 i7O0Igoe10IDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262325>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 11:28:21PM -0700, Alex Henrie wrote:
> This patch puts the usage info strings that were not already in docopt-
> like format into docopt-like format, which will be a litle easier for
> end users and a lot easier for translators. Changes include:
>=20
> - Placing angle brackets around fill-in-the-blank parameters
> - Putting dashes in multiword parameter names
> - Adding spaces to [-f|--foobar] to make [-f | --foobar]
> - Replacing <foobar>* with [<foobar>...]
>=20
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---

> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 9200069..1abeba6 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -11,7 +11,7 @@
>  #include "submodule.h"
> =20
>  static const char diff_files_usage[] =3D
> -"git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path=
>...]"
> +"git diff-files [-q] [-0/-1/2/3 | -c | --cc] [<common-diff-options>] [<p=
ath>...]"
                         ^^^^^^^^^
This deserves cleanup too (the man page shows it as "[-0|-1|-2|-3|-c|--cc]"=
).

=2E..which makes me think the man pages need to be modified to match. =20

Also, it looks like items 1 & 4 are already codified in
CodingGuidelines, but items 2 & 3 are new.  If we care to make the
changes in 2 & 3, we should document the new conventions there.

Bike-shedding, I'm sure: I find "[-0|-1|-2|-3|-c|--cc]" more
readable/logical than "[-0 | -1 | -2 | -3 | -c | --cc]" (which I admit
seems counter-intuitive), but I wouldn't be surprised if opinions on
that are about as split as the existing usage lines are :-).

Hope this helps.

--=20
Scott Schmit

--5vNYLRcllDrimb99
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
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAxMTMwNTI5MDFa
MCMGCSqGSIb3DQEJBDEWBBSoO0qrk7qGxPDEOXsIOygepXgx1DB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAN
BgkqhkiG9w0BAQEFAASCAQBwzXrl0apQdILXJNDDcGBCFY4cU3dYEJBQE2xKcWZfrau0td+y
1pDENl4y0uHogEOZfyBdkXyuiI4TO9vI1iDLIxYSiSV5ZxknLxsHefLjrgI6qT8Ff7vVX1+c
k37dpz6xVuj/sSJUu0CYngE9QQIu8qejDPutcL8bqolbm8jvzywnxB/94vYjmX9yrm00eeuN
mmCM0oIgqAEDu+mROuHnmYUS+qJyIqTRnFce35yy6eVhjaaSiH5R8Tz4hjVx16weVwqIDtth
FXGXsLoSl/15zbMtwaaXDV2lhO+p6TVKg9J2G93mk/xT524gNu2VlMkThirTy50wa+LIggca
XpB8

--5vNYLRcllDrimb99--
