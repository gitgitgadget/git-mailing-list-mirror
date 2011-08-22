From: Andrew Berry <andrewberry@sentex.net>
Subject: Behaviour of git apply --directory
Date: Mon, 22 Aug 2011 11:21:55 -0400
Message-ID: <E21BC0F8-2DF0-44AB-B18A-013451CDB670@sentex.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/signed; boundary="Apple-Mail=_9CD5AE60-2C7A-49E5-A0B0-4F9F9B80E66C"; protocol="application/pkcs7-signature"; micalg=sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 17:31:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvWTf-0003AX-VY
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 17:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab1HVPbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 11:31:47 -0400
Received: from esa-jnhn.mail.uoguelph.ca ([131.104.91.44]:42571 "EHLO
	esa-jnhn.mail.uoguelph.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab1HVPbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 11:31:46 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Aug 2011 11:31:46 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvgGAFlzUk6DaFvH/2dsb2JhbABBmHWPFneDDxQ7nUqfXYVpXwSTFJET
X-IronPort-AV: E=Sophos;i="4.68,263,1312171200"; 
   d="p7s'?scan'208";a="135152579"
Received: from danube.cs.uoguelph.ca ([131.104.91.199])
  by esa-jnhn-pri.mail.uoguelph.ca with ESMTP; 22 Aug 2011 11:21:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by danube.cs.uoguelph.ca (Postfix) with ESMTP id 5E4821078050
	for <git@vger.kernel.org>; Mon, 22 Aug 2011 11:21:58 -0400 (EDT)
X-Virus-Scanned: amavisd-new at danube.cs.uoguelph.ca
Received: from danube.cs.uoguelph.ca ([127.0.0.1])
	by localhost (danube.cs.uoguelph.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9dpd5SXb4DU for <git@vger.kernel.org>;
	Mon, 22 Aug 2011 11:21:57 -0400 (EDT)
Received: from blizzard.lan (64-7-151-206.border7-dynamic.dsl.sentex.ca [64.7.151.206])
	by danube.cs.uoguelph.ca (Postfix) with ESMTPSA id 15115107821B
	for <git@vger.kernel.org>; Mon, 22 Aug 2011 11:21:57 -0400 (EDT)
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179868>


--Apple-Mail=_9CD5AE60-2C7A-49E5-A0B0-4F9F9B80E66C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

The behaviour of git apply --directory seems a little confusing. It =
looks to be dependent on the current directory, but I can't use relative =
paths to apply a patch in one directory to a sibling directory. Absolute =
paths don't work either. I'd expected the parameter to either be =
relative to the git repository root, or to expand relative directories.

Any thoughts?

--Andrew=

--Apple-Mail=_9CD5AE60-2C7A-49E5-A0B0-4F9F9B80E66C
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFfjCCBXow
ggRioAMCAQICEBT0qYr1VI/FTG7wqf3ZkxkwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMTAxMTI4
MDAwMDAwWhcNMTExMTI4MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZhbmRyZXdiZXJyeUBzZW50
ZXgubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9j1PuPvpSbXhrKhKkA/R1hZf
V40ModE0yJZPR8P39DkEJrG3dogns4If+8GxhC0Vi5SZUGdwQbGr8RnOSZjV5858rxDZis0DQQY6
aKmqraNUXqQN0A8Xs1UThCwi9zEuQBnVfnDVuSyU1lxTZXB/TX7RfJGhNXDa4FcUDVAnf5v5UNWS
d3Q6NSR1mWpT7cDIH7lOG1C5XSNEZqZid3Pc5o3jFn3JyC/5VBwI8iAAdyelMHIuxbz2n42+HE/w
UIAt8CRe7dm/31cj/LwjhpPZrVan0NcJ90BS9uqxb4ZWYdV8FIRgP1HBhUATNxiT34fdwimsrson
vJzODftwzIXYTwIDAQABo4ICGDCCAhQwHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0w
HQYDVR0OBBYEFJ5deq0XiUTzA6eyF+08K9YTwuLhMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAw
RgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUu
Y29tb2RvLm5ldC9DUFMwgaUGA1UdHwSBnTCBmjBMoEqgSIZGaHR0cDovL2NybC5jb21vZG9jYS5j
b20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDBKoEigRoZE
aHR0cDovL2NybC5jb21vZG8ubmV0L1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGljYXRpb25h
bmRFbWFpbC5jcmwwbAYIKwYBBQUHAQEEYDBeMDYGCCsGAQUFBzAChipodHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9VVE5BQUFDbGllbnRDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9k
b2NhLmNvbTAhBgNVHREEGjAYgRZhbmRyZXdiZXJyeUBzZW50ZXgubmV0MA0GCSqGSIb3DQEBBQUA
A4IBAQCqANyU48ZFPRkQ5HAh+gWHKFfTJvlKee7ogC4rGfqFKZjY1eo6btYSBiXFdunvq+ENSPH9
d6x9CqT99qoQkLT/xIbYwwE4LngUhmrIYfPESDyWTaaEdbi8H0sSAZGyx7rFHHhHAPlLCkBz/iUi
zRnuHPP2XohJV6SaS30Ofx8xurtVcMmXrFRy/lJZ7X6sMDd8VFZwRknDUCSRREZur/i8fSWuNHUu
YUgY6DGXdd/RlBqIlAXVA5DNMmJDIxsHghY8l1JeFAeTgr37fFWcBbOvfqxa7zjtDcj+CXho4CKV
tMCoAm1A0Hu6/Qg+fDPuRMlNI6qJDnwfhEwCb4h7uICKMYID/DCCA/gCAQEwgcMwga4xCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRo
ZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYw
NAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwCEBT0
qYr1VI/FTG7wqf3ZkxkwCQYFKw4DAhoFAKCCAg0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTEwODIyMTUyMTU2WjAjBgkqhkiG9w0BCQQxFgQUYX37FuicQTXqTPpc
FszHUqDjK6IwgdQGCSsGAQQBgjcQBDGBxjCBwzCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVU
MRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3Jr
MSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmly
c3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbAIQFPSpivVUj8VMbvCp/dmTGTCB1gYL
KoZIhvcNAQkQAgsxgcaggcMwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMO
U2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMY
aHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgRW1haWwCEBT0qYr1VI/FTG7wqf3ZkxkwDQYJKoZIhvcNAQEBBQAE
ggEAB6e1wrelTx7fPcd66EIkL8yW7ew9BVmGoXWFXNyJrl8Oi2TS2spB9z5v6U+vQYUl10sN2b36
Fn2uGePuE/Z8TjeDKmVmwJSIcMxZcvWRgt23x85H+uD1dbPVxO9fBSittvqW2fsCy3SkUEjKuQRn
w/tptwe40/R38HHob7KDmKXvNeMEj/fdI8Botf7+uShF43K+bKL/0EEM4xmTxzDxNnL/ChTr7iGK
3H2NLUwxwyTYN3Cb/gKamcd88JSs6sZ4pZqcBTKGROs4DB7yX2xqFFZmHwJsZBUhvfrZi3n9J1DN
ODfa/qeA6oWKdoYqo75/GXdbxExSkPAJ0pNBxxZqbgAAAAAAAA==

--Apple-Mail=_9CD5AE60-2C7A-49E5-A0B0-4F9F9B80E66C--
