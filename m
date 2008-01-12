From: Kevin Ballard <kevin@sb.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 20:43:35 -0500
Message-ID: <08E42D03-7AAA-4ADD-9F5B-215AB30E34E1@sb.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org> <200801120115.41274.robin.rosenberg@dewire.com> <191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org> <7v7iif28i2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de> <B2968E86-D43E-4F5E-921F-DF8A15886C98@sb.org> <7vprw7zv7s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-15-604199469; micalg=sha1; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:44:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVPp-0003VZ-Id
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbYALBnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbYALBnh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:43:37 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:55033 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754440AbYALBnh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 20:43:37 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id 638BF195915;
	Fri, 11 Jan 2008 17:43:36 -0800 (PST)
In-Reply-To: <7vprw7zv7s.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70247>


--Apple-Mail-15-604199469
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 11, 2008, at 8:30 PM, Junio C Hamano wrote:

>> Apparently so. By Junio's definition, HFS+ is not a sane filesystem,
>> and as git grows more popular with OS X users, this issue is going to
>> crop up more frequently.
>
> It's not "my" definition, but you asked the reason and I gave
> the answer.  We can close this issue of "is HFS+ sane" now.
> HFS+ is insane, period.  And as Linus said, you cannot forgive
> its insanity using the historical baggage argument, like MS-DOS.

Fair enough, though I believe OS X has a good reason, namely it's an  
OS designed for regular users rather than servers or programmers. Case- 
sensitivity would confuse my mother.

> HOWEVER.
>
> It is a totally different issue if we want to refuse supporting
> insane filesystems.  And the answer is no.  It was not my
> intention to say that we do not intend to support them, when I
> explained the reason why the things are as they are, which was
> the original question by you.

Ok. I wasn't implying anything with that phrase there, I was just  
trying to reiterate that HFS+ is case-insensitive and emphasize that  
this issue will become more relevant as time goes by.

> See Robin's proposal to let us translate random names we get
> back from readdir() from the filesystem using an additional
> look-up table in the index extension section that stores mapping
> from canonicalized form to the form that the user registered to
> the index.  I think that is a sane approach to tackle this issue
> on insane filesystems like HFS+.

If I knew what the index extension section was, perhaps I would think  
that's a good idea ;) I have yet to dive into the gory details of how  
this stuff works.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-15-604199469
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTEyMDE0MzM1WjAjBgkqhkiG9w0BCQQxFgQUSlkfYNY6sh37XjgIL+no0gnAuhwwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAB8QIqXmmXi9PkVkcbQowk3wDP9bRaJzWCKtCGEun5SUs/HY5uDxr51Mu736dkIgYqNy5i5Q
yUD7vmXz+zQfKTtlrRfxF22aT4qEvd2StBMu+tU0M/HxmkOP7j1GtD9VDaqhhQgWQUMi3x1LURjV
iELlHE+ZlFSYdp9jK5bcguIdp/2WQ/Sw2q7TFidK/hW7OvJxhJWVVjDxyQ6eqCbkR+QBRxwUbnlP
78Cr7Mhqd4nSMW77Y6iJ70bUHAq7hGz9E4ihoGLin2YltoblemKl67w5aJo/gyJjNX2Qkz9ehml+
4qxSrxZpDx+ALc3IARmJhrcgpq7N5I9mmLKzKhjKdpwAAAAAAAA=

--Apple-Mail-15-604199469--
