From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Documentation: fix git-clone manpage not to refer to itself
Date: Tue, 20 Nov 2007 10:41:04 +0100
Message-ID: <3FC9A391-AED0-4988-B1F7-EE5C06AD1137@wincent.com>
References: <87ejeq1131.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-1366-348620179; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 20 10:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuPbq-0000iy-WC
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 10:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbXKTJlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 04:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbXKTJlQ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 04:41:16 -0500
Received: from wincent.com ([72.3.236.74]:51369 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbXKTJlP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 04:41:15 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAK9f9mu011570;
	Tue, 20 Nov 2007 03:41:10 -0600
In-Reply-To: <Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65536>


--Apple-Mail-1366-348620179
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

El 19/11/2007, a las 14:35, Johannes Schindelin escribi=F3:

> - it makes writing the perl script to do a very tiny subset of =20
> asciidoc
>  formatting much harder.  We encounter enough problems with the =20
> different
>  versions of asciidoc/docbook combinations that I think this perl =20
> script
>  would be actually useful.
>
> I know that the user manual uses some advanced features, too, but it =20=

> did
> not use ifdef in the main text, for example, let alone nested ifdefs,
> which your patch would encourage much more than the source before.

Out of curiosity, have you done any more work on that WIP AsciiDoc =20
replacement since you last wrote to the list about it back in October?

I'm on a new OS install now, so just yesterday and today I had to set =20=

up the AsciiDoc/DocBook/xmlto toolchain again, and was reminded of how =20=

painful it was. At least on Mac OS X, it requires installing a bunch =20
of dependencies (and specific versions of them otherwise it won't =20
work), hacking Makefiles, installing a bunch of XSL and DTDs, and =20
setting up XML catalogs. Doable but annoying.

Cheers,
Wincent



--Apple-Mail-1366-348620179
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGHzCCAtgw
ggJBoAMCAQICEAUo1lDjgREx86QFfIYO5oUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTExOTA3MzAwMFoXDTA4MTExODA3MzAw
MFowQTEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEeMBwGCSqGSIb3DQEJARYPd2lu
QHdpbmNlbnQuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmd/pgMVBWs0JR5Mn
CXh3wz3j4eKI9nxSHNwkeJHP2UiATeMqFzc6uWHyef2g5tOLGyyu6SCdcS0WwtJknt/q1LZtHtJl
KeaS5pGWFsO8+JWp5mrtygyMD394MnylCQQMB0695fDjdV+9R5GYn1EqhOwk9S1nwlc/XkFNtvk+
pqcT8pjmCL6Eeapyy/etEpjQGfNefCw57+TqHyX2lmHXGc5AvbYsbyAHMRP5gmgUEBKne/YcWJwM
tVsvciO+vBdZwnavRnqQ3sxlrCVvprLZyqvbBpD+xuETgYwYZvq2Vongq31hqwR0ZyG6FLg386eh
SjNdWXof9G6CSCTGs12MPQIDAQABoywwKjAaBgNVHREEEzARgQ93aW5Ad2luY2VudC5jb20wDAYD
VR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQCtrzOc75algdHXwDOZ8evhKFtOYXmkQUckV8IY
1z5r/4j/JMuwYHfMwusvGhgGIIghtWeKs9sRUlnaYAxyoeMo9aw0f8frxBiHUHGKHoASDXxMmqBB
sa0WjafwfPfIuJW96J1q2YwGCJqqWY5N8E88/Lseec6Bcy/VcQkETa+9eDCCAz8wggKooAMCAQIC
AQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUx
EjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsT
H0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNv
bTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065
yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FW
y688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5k
GXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0
dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQE
AwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcN
AQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t
4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8xggMQMIIDDAIBATB2MGIxCzAJBgNVBAYTAlpBMSUwIwYD
VQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIQBSjWUOOBETHzpAV8hg7mhTAJBgUrDgMCGgUAoIIBbzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNzExMjAwOTQxMDRaMCMG
CSqGSIb3DQEJBDEWBBSnTGCJesY0gRThGkOaiIluk1MTIjCBhQYJKwYBBAGCNxAEMXgwdjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEAUo1lDjgREx86QFfIYO5oUw
gYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1
bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vp
bmcgQ0ECEAUo1lDjgREx86QFfIYO5oUwDQYJKoZIhvcNAQEBBQAEggEAEF46hg/UTEIDgZZDgrBi
3weuD4dIUN4rPXdvTCncJfnEjwUj1z+ZAoVFQzxpNn4xJQQkif4aizuaqpbpxMwanKD6uZ+9IAet
dRo5eoBCJOs1PJoYuCuCPQ5vYRxqzCJrUXt/zdyfO0oSuwr6irJafeTvM0wy0egSSbKNQvWVdRd7
DP/ntsxaDMvxpp42lbDUoB3Oz6JRwh+t76OFuk7XHtYBsvKzUq3hhzb5UCgHAyMI7kj3t/QHaW55
Yih1N+RIbVzm9jj9wslQfDc+E1y+ob7Z0TIq24RvdCgm7w0eZ8V7Z68w9E6w7yRVKB6+cB5iB2m6
GHzE6qyEWIkAZIGUBwAAAAAAAA==

--Apple-Mail-1366-348620179--
