From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 16:43:26 -0500
Message-ID: <45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121195703.GE29792@mit.edu> <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org> <20080121201530.GF29792@mit.edu> <8F85366A-C990-47B1-BF60-936185B9E438@sb.org> <20080121204614.GG29792@mit.edu> <6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org> <20080121211802.GH29792@mit.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-36--693692594; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4Qz-0008DV-0Z
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbYAUVna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYAUVna
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:43:30 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:44236 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753959AbYAUVn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:43:29 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id BC9E7109EB7;
	Mon, 21 Jan 2008 13:43:27 -0800 (PST)
In-Reply-To: <20080121211802.GH29792@mit.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71351>


--Apple-Mail-36--693692594
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 4:18 PM, Theodore Tso wrote:

> On Mon, Jan 21, 2008 at 03:58:03PM -0500, Kevin Ballard wrote:
>> You're making the huge assumption that the HFS+ normalization  
>> algorithms
>> will change. As the technote states:
>>
>> "Platform algorithms tend to evolve with the Unicode standard. The  
>> HFS Plus
>> algorithms cannot evolve because such evolution would invalidate  
>> existing
>> HFS Plus volumes."
>
> Great, so even worse.  Does the tech note then specify exactly what
> version of Unicode HFS+ is using to do its "normalization"?  Or
> exactly what characters it will normalize?  After all, Unicode has
> added all sorts of characters since 1998, and I'm sure some of them
> were combining characters.
>
> And you *really* want to continue argue that a sane thing for a
> cross-platform system to do is to pervert its hash algorithm to take
> into account *one* particular OS that happened to freeze a
> normalization algorithm at some arbitrary point in time, approximately
> nine years ago?  Talk about the tail wagging the dog!!  Especially
> when you can't even justify why it was done nine years ago!

I suggest you go back and read the emails where I specifically stated  
that I'm *not* suggesting this.

>> It must have bought somebody something, or they never would have  
>> done it.
>
> Your faith in the HFS+ designers is touching.

And your arrogance is troubling. Do you really believe you are so  
smart you can claim the HFS+ designers had no reason for this decision?

>> I have no idea why HFS+ stores filenames in a normalized form, and  
>> further
>> I am smart enough to know that speculating is completely pointless. I
>> assume the authors had a good reason (which should be a safe  
>> assumption,
>> filesystem authors are a smart bunch). The reason may not be valid  
>> anymore,
>> but if it was valid back in 1998, then I can accept it without  
>> complaining.
>
> Well, I *AM* a filesystem designer (ext2/ext3/ext4), and well before
> 1998, I knew that trying to do anything with Unicode normalization was
> a fool's errand.  So if you're going to blindly trust filesystme
> designers (not something I would recommend, actually :-), trust me.
> What HFS+ is doing is dumb, dumb, dumb.

Again, I'm not saying that they necessarily did the "correct" thing,  
as I can't evaluate that without knowing their reason. I'm just saying  
there must have been a reason.

> And even if *you* can accept it, why should the git designers pervert
> any core part of git's design to support this behaviour?  Especially
> if it's legacy behaviour which will hopefully be going away, say when
> MacOS adopts ZFS --- there's an opportunity for them to start afresh,
> and not make the same mistakes they made nine years ago!

And why do you believe MacOS is going to adopt ZFS? Sure, they might,  
but assuming stuff about the future is just as bad as assuming stuff  
about the past. And git should "pervert" itself because of the simple  
fact that git has a problem on HFS+. Keeping your code "pure" is all  
well and good, except it's not particularly practical. If the git  
project has any interest in being a viable system on OS X, it really  
should behave properly. I'm sure you have various "perversions" for  
other cases.

> So why don't you suggest some kind of sane fix in the Mac specific
> code that doesn't impact any core part of git, such as its hash
> algorithm?  It would be far more productive than trying to defend a
> bad design decision made nine years ago....   :-}

How many times must I say I never suggested actually changing git's  
hashing algorithm? And if you want me to suggest a fix to git that  
works, first you have to wait for me to learn how git's internals  
work, and frankly, I have too much work on my plate right now to  
devote the time necessary to learning git's internals well enough to  
fix this problem.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-36--693692594
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
DxcNMDgwMTIxMjE0MzI3WjAjBgkqhkiG9w0BCQQxFgQUO2Kd7F8n60LNeWFeG8jVOfZuH3owgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAJ6t92kHVpqfBX/UkZc56OBpAxy50XAwJNN870DxuFYzDX5y+5oeguw4EzyodCu+uRA9Ozc9
c876nB9mC0r1op6kq/xmOris8xbabaznEqaSy461TIkeLml06yFwd6eTZGjiLMMr/T0Tnf8O0zch
ofZ86e74rMsjdoFIwuibdcWlRh8epiOCsT8FoXOmq+NSZf14ErLuKHoy92vUVToRUxp+St9qcfvz
A1kur1grQaWp45QuN/JLsu/l2Msk9ZH+3sH8sQeKgaIK43d7jh1+UgU7xCU3zwDW0aBBGL+5WhHK
ZZlQJgsaNXWGp9kJBBhZRKXhODupQ+BZI+JIXEr+HWEAAAAAAAA=

--Apple-Mail-36--693692594--
