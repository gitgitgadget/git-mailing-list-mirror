From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-svn should default to --repack
Date: Sat, 19 Jan 2008 10:05:01 -0500
Message-ID: <BB932B28-08F3-4243-8E3B-ACC4527F947E@sb.org>
References: <96C7A3A5-D750-43AB-A8A6-8A3A6D09AF4E@sb.org> <20080118155607.GA21236@diana.vm.bytemark.co.uk> <7vfxwudftz.fsf@gitster.siamese.dyndns.org> <20080119123557.GA30778@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-19--890398187; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 16:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFGK-000209-Fs
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbYASPFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbYASPFE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:05:04 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:45302 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756588AbYASPFD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 10:05:03 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 3DB26109EB5
	for <git@vger.kernel.org>; Sat, 19 Jan 2008 07:05:02 -0800 (PST)
In-Reply-To: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71109>


--Apple-Mail-19--890398187
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

Note: CC list pruned as, once again, my Mail client decided to send =20
the original message as HTML and it got bounced from the list.
Original CC list: kha@treskal.com, gitster@pobox.com

On Jan 19, 2008, at 7:35 AM, Karl Hasselstr=F6m wrote:

> On 2008-01-18 12:44:08 -0800, Junio C Hamano wrote:
>
>> Karl Hasselstr=F6m <kha@treskal.com> writes:
>>
>>> I believe so too. And nowadays there's "git gc --auto", which was
>>> made for occasions such as this, so it should be a breeze to
>>> implement. The overhead might be low enough that it can be called
>>> after _every_ imported revision.
>>
>> Careful. I made the same mistake and it had to be corrected with
>> e0cd252eb0ba6453acd64762625b004aa4cc162b.
>>
>> "gc --auto" after every 1000 or so feels like a good default and I
>> would agree that would be a real fix to a real usability bug.
>
> I think 1000 might be too high; considering that (at least in my
> experience) it takes on the order of 250-500 ms to import a commit,
> the gc --auto overhead of maybe 10 ms isn't so bad.
>
> A good compromise might be to run gc --auto after every 10-100
> commits, _and_ when the import is done.
>
> However, if gc --auto always takes a lot of time without accomplishing
> anything in the presence of too many unreachable loose objects it
> might not be a good idea to run it at all, since the use of git-svn
> involves frequent rebasing.

I don't know much about how this works, so if git gc --auto might have =20=

a problem, it seems the simplest fix for now would be to default git-=20
svn to having --repack=3D1000 on.

>> Patches?
>
> Just hot air and noise for now from my end. Sorry.

Same. I don't know Perl. Sorry.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-19--890398187
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
DxcNMDgwMTE5MTUwNTAxWjAjBgkqhkiG9w0BCQQxFgQU8rL7emttgXV0fSFhbVURssVEvxYwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAKc5KafmjyuuyY/fNGgitNcopleHu+iHjuMhSzjrdMZLMk37i7o2DXsDATX4vNqBUjMI9bBq
jfYOs8zOM7XB7shuaf0sjV+ISo8nIYgvpb20ogc9yMHP3rwl+pgJWf1mXPeTV8Vh9sUNynBCePb9
w9XQxZWgel8kiJwlETO3G9fSv6vxqjREWNh0QRdnIDxA9oo7KVtLRRka6II+hYa2OfgRn1tld09J
zgHK1M7jB1sq6M5EH1SYUXJ3xAWOrHO4HdhqYrJ26kSg9UVbIxloytlMH91lNjg0cpfjjPWivEPc
nqnqE353t3E6r6HKscB5i0XSbR5rjJF/6dj9a5wf4cAAAAAAAAA=

--Apple-Mail-19--890398187--
