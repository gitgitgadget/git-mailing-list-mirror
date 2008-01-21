From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 17:53:50 -0500
Message-ID: <DC78D5CB-18FF-4504-BD8B-985D8B202817@sb.org>
References: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121205615.GY14871@dpotapov.dyndns.org> <DEC058ED-EBF0-4A1E-BF7B-448B16DBBD6E@sb.org> <20080121224131.GD14871@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-25--689469062; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:54:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5X5-0006wF-5T
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYAUWxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbYAUWxx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:53:53 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:43181 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751645AbYAUWxw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 17:53:52 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 64B78109EAF;
	Mon, 21 Jan 2008 14:53:51 -0800 (PST)
In-Reply-To: <20080121224131.GD14871@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71365>


--Apple-Mail-25--689469062
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 5:41 PM, Dmitry Potapov wrote:

> On Mon, Jan 21, 2008 at 04:07:27PM -0500, Kevin Ballard wrote:
>>
>> Again, I've specified many times that I'm talking about canonical
>> equivalence.
>>
>> And yes, HFS+ does normalization, it just doesn't use NFD. It uses a
>> custom variant. I fail to see how this is a problem.
>
> If you think that HFS+ does normalization then you apparently have no
> idea of what the term "normalization" means. Have you? But if you
> don't know what is "normalization" then you cannot really know what
> canonical equivalence means.

I would go look up specifics to back me up, but my DNS is screwing up  
right now so I can't access most of the internet. In any case, there  
are 4 standard normalization forms - NFC, NFD, NFKC, NFKD. If there  
are others, they aren't notable enough to be listed in the resource I  
was reading. HFS+ uses a variant on NFD - it's a well-defined variant,  
and thus can safely be called its own normalization form. I fail to  
see how this means it's not "normalization".

>>> I don't say they do that without *any* reason, but I suppose all
>>> Apple developers in the Copland project had some reasons for they
>>> did, but the outcome was not very good...
>>
>> Stupid engineers don't get to work on developing new filesystems.
>
> Assigning someone to work on a new filesystem does not make him
> suddenly smart. As to that stupid engineers don't get to work,
> it is like saying there is no stupid engineers at all. There are
> plenty evidence to contrary. And when management is disastrous
> then most idiots with big mouth and little capacity to produce
> any useful does get assignment to develop new features, while
> those who can actually solve problems are assigned to fix the
> next build, because the only thing that this management worries
> about how to survive another year or another months...

I'm not talking about assigning engineers, I'm saying developing a new  
filesystem, especially one that's proven itself to be usable and  
extendable for the last decade, is something that only smart engineers  
would be capable of doing.

>> And
>> Copland didn't fail because of stupid engineers anyway. If I had to
>> blame someone, I'd blame management.
>
> But if the code was so good then why was most of that code thrown away
> later when management was changed? Still bad management?

Yes. Even the best of engineers will produce crap code when overworked  
and required to implement new features instead of fixing bugs and  
stabilizing the system. Copland is well-known to have suffered from  
featuritis, to the extent that it was practically impossible to test  
in any sane fashion. Bad management can kill any project regardless of  
how good the engineers are.

>>>> The only information you lose when doing canonical normalization is
>>>> what the original byte sequence was.
>>>
>>> Not true. You lose the original sequence of *characters*.
>>
>> Which is only a problem if you care about the byte sequence, which is
>> kinda the whole point of my argument.
>
> Byte sequences are not an issue here. If the filesystem used UTF-16 to
> store filenames, that would NOT cause this problem, because characters
> would be the same even though bytes stored on the disk were different.
> So, what you actually lose here is the original sequence of  
> *characters*.

I've already talked about that, but you are apparently incapable of  
understanding.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-25--689469062
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
DxcNMDgwMTIxMjI1MzUwWjAjBgkqhkiG9w0BCQQxFgQUbdBXUSxiKT/3yAemfAsQfOzXBxAwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAICh3qLNpfnhq3V8H+4msOTTIZgnix1nn8Zc+ealp1JCGtHqwyY1lkuTW2kjda7CqjrrK5aI
SX/dawgWTfYTt2sI1a6aMM7cIUeLXVWJgKkma0ftw9+8cMZDtwvFQO+6ILlDHWXNJ4cwJ3O0lA4l
1WLgC5NWejvCtHBccXKLr3SsprN994rbXBaoaNzgh8XT6b2QY19ieN4mG5PgS3P+43xTeWUCeB+B
m3/GiYJZEc7bZiIANeq2UZK6bRrNc25Q/GTBHdSnQg2JLdcIbWTqWhxXYWgoZ1qndGnwmLxRIm46
fkskBZ9HxV/o2kR5xBhNeRRUccUm3HuM7q2LnwSX9nwAAAAAAAA=

--Apple-Mail-25--689469062--
