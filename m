From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 18:05:56 -0500
Message-ID: <CE44F12F-C056-46A6-9795-7F8E280AE9FC@sb.org>
References: <478E1FED.5010801@web.de> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <46a038f90801211456h4b16ff2cl4378df88023bbc34@mail.gmail.com> <53C76BEA-2232-4940-8776-9DF1880089A4@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-29--688743118; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 00:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5im-0002QU-5X
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbYAUXF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755387AbYAUXF6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:05:58 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:51738 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754597AbYAUXF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 18:05:58 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 648CAEEE8C
	for <git@vger.kernel.org>; Mon, 21 Jan 2008 15:05:57 -0800 (PST)
In-Reply-To: <53C76BEA-2232-4940-8776-9DF1880089A4@sb.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71369>


--Apple-Mail-29--688743118
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Yet another bounce.
Original CC: martin.langhoff@gmail.com, torvalds@linux-foundation.org, peter@softwolves.pp.se 
, mjscod@web.de, melo@simplicidade.org

On Jan 21, 2008, at 6:02 PM, Kevin Ballard wrote:

> On Jan 21, 2008, at 5:56 PM, Martin Langhoff wrote:
>
>> On Jan 22, 2008 11:46 AM, Kevin Ballard <kevin@sb.org> wrote:
>>> Again, I was talking about a system that used unicode top-to-bottom.
>>> On HFS+ you have to use UTF-8 for your filename or it simply won't  
>>> work.
>>
>> Hmmm. I m pretty sure HFS+ has a lot of problems if you run OSX as an
>> NFS server with clients in different encodings. It would never work  
>> in
>> real life. The "envelope" OSs have to work in is hugely varied --  
>> much
>> more so than any other apps. You should try writing one someday ;-)
>
> I'd imagine writing an OS to be a horrifically complicated task. And  
> yes, I can certainly imagine HFS+ might have issues when used to  
> back an NFS server with other clients, but that still leads back to  
> the original point, which is that all these problems stem from the  
> differences between HFS+ and other filesystems, not any inherent  
> problem with HFS+ itself.
>
>>> other words, I was trying to illustrate that HFS+ isn't wrong, it's
>>> just different, and the difference is causing the problem.
>>
>> Did you spot the rather nasty issues that Ted mentioned earlier in  
>> the
>> thread? I would say HFS+ is a bit "special" rather than "different".
>
> IIRC, the biggest problem he talked about was the changing unicode  
> standard, but since the technote appears to state that HFS+ will not  
> be changing its normalization algorithms to preserve backwards  
> compatibility with existing volumes, that doesn't appear to be a  
> nasty issue after all. Is there another issue I've failed to address  
> in this thread?
>
> -Kevin Ballard
>
> -- 
> Kevin Ballard
> http://kevin.sb.org
> kevin@sb.org
> http://www.tildesoft.com
>
>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-29--688743118
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
DxcNMDgwMTIxMjMwNTU2WjAjBgkqhkiG9w0BCQQxFgQU3wcNj9UFN0KdNMgkmklATklxelgwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBANWFce790EQ0Q4CaDGH3qHrxtiEmb33t2ImRttkI8uAFSBH/IMS3Jkjifcwg8Cuq0z09iPfS
QCPKnmc6LeJTX2I5DmO+sU2cq6WASRBCo3XGORNdl17fMDYtxwYMp3BZBIYXOW5acD2LLh+o5jir
R4BnYECw+viB2lFxGniZHCn4LXgWcwlzn2483UHNcYWmuJu8xK7A0exoXhjxMaoA0eauA5w9y89l
SJHbcfE9Xwr0VnFG0A801QKAgYqgxYi2R5a6vvUm+s3x0jD1el0ORdzRP3aUrVydUYMeXkOwLN0l
YYwsLymTW0cnY1RD/2nfhtqGqp4kpo4NxS2qW9C5hbgAAAAAAAA=

--Apple-Mail-29--688743118--
