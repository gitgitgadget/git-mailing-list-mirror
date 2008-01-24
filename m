From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 21:05:50 -0500
Message-ID: <DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com> <1DC841ED-634F-412C-9560-F37E4172A4CD@sb.org> <76718490801231421l7b6552f8sec13f570360198b@mail.gmail.com> <4F906435-A186-4E98-8865-F185D75F14D4@sb.org> <76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-71--505148164; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 03:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHrU3-0004XA-FC
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 03:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYAXCF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 21:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYAXCF4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 21:05:56 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:49175 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752031AbYAXCFz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 21:05:55 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 88F1B109EB6;
	Wed, 23 Jan 2008 18:05:52 -0800 (PST)
In-Reply-To: <76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71580>


--Apple-Mail-71--505148164
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

I hope you don't mind that I'm redirecting this back onto the list.

On Jan 23, 2008, at 6:17 PM, Jay Soffian wrote:

> On 1/23/08, Kevin Ballard <kevin@sb.org> wrote:
>
>> I agree - the argument is fairly worthless. So why does everybody  
>> else
>> keep spending time accusing HFS+ of corrupting filenames? Most of
>> Linus's email was specifically about this point, but apparently  
>> that's
>> alright with you while only a *single* line out of my email in direct
>> response is called trolling?
>
> Everyone else considers what HFS+ does as corruption. You, alone in
> this thread, do not. You are not willing to concede the point, nor let
> it go. I'm accusing you of trolling because you are the single person
> defending HFS+'s behavior.

I don't understand how you can possibly think that disagreeing ==  
trolling. Similarly, just because I'm the only person *on this list*  
who holds my viewpoint doesn't in any way mean I should abandon it. In  
fact, it makes it much more important that I continue to stand up for  
what I believe, The whole notion of democracy is based on the fact  
that every person is important, and that every person has the right to  
their own opinion. I realize this is a mailing list, not a democratic  
body, but the same principles should still apply. If your criteria for  
judging any viewpoint is purely how many people hold that viewpoint,  
then you end up ignoring things just because they are different or new.

I may be the single person defending this behavior on this list, but  
if you were to leave your comfortable linux community and talk to  
people elsewhere, you might find yourself in the minority opinion.

> (Also, while it's certainly possible that you are right and everyone
> else is wrong, most of the other folks have significant experience as
> kernel, filesystem, or git developers, which leads credence to their
> point -- reputation matters.)

Why do you persist in thinking of this as right vs. wrong? I've tried  
to emphasize, many times, that HFS+ behaves this way not because it's  
"right" and ext4 is "wrong", but because HFS+ has a different set of  
values. The developers of HFS+ believed that, for a consumer OS like  
OS X, it made much more sense to treat visually indistinguishable  
filenames as the same file. I, and I'm sure the vast majority of OS X  
users, agree. Unfortunately this decision had some drawbacks, but they  
felt the trade-off was worth it. I'm well aware that you all don't  
think the trade-off was worth it, but like I said, this is a matter of  
behaving differently due to a different set of values, not behaving  
"right" or "wrong". I've been making an attempt to agree to disagree,  
but it seems that you would rather just squash dissent instead of  
accepting it.

>> Again, you're happy to let everybody else write long paragraphs
>> accusing HFS+ of bad behavior (and making horrible assumptions which
>> are generally completely untrue), and you don't think that's noise?
>
> They are responding to you. If you let the point drop, so will they.

I did let the point drop. Then you guys resurrected it. You can't pin  
this one on me.

>> I do ignore most of it, I'm only getting mad because a few people  
>> keep
>> telling me that I'm trolling, or being inflammatory, simply by  
>> posting
>> reasoned, factual replies, but everybody who keeps spewing insults
>> are, apparently, not a problem at all.
>
> I understand that you think your replies are reasoned and factual, but
> everyone else thinks you're wrong. They are getting frustrated
> defending a point with which you continue to disagree, hence the
> insults.

Don't you think I'm frustrated at the behavior of everyone else here?  
But you don't see me flinging insults.

>> At first, I did. Now it's just tiresome, since he keeps calling me  
>> and
>> HFS+ dumb for the exact same reasons he did at the start of the  
>> thread
>> no matter how I respond. Apparently he's simply more interested in
>> keeping his own opinion than in the actual reasons behind HFS+'s
>> decisions. It's rather frustrating.
>
> Have you considered that maybe he's right? In any case, you're not
> going to convince Linus of anything. From what I can tell, he forms
> his opinions based on facts he collects himself and his own
> experience. I gather that anything you say he will consider, *at
> best*, as hearsay. Besides that, he's actually working to solve the
> problem, while still taking the time to respond to your points.

Collecting facts yourself is fine, but insulting anybody with a  
dissenting *opinion* simply because it's different is just plain wrong.

> Really, please, go take a walk outside. Get some fresh air. Maybe stop
> reading the git list for a week or two. In the grand scheme of things
> it doesn't matter what git developers think of HFS+ as long as they're
> willing to make git work with it, which apparently, and in spite of
> you at this point, they are.

For the majority of this thread, nobody was making any indication that  
they cared at all about fixing this problem - that was my primary  
motivation to continue. If I had dropped this the first time someone  
told me to, do you think anybody would be working on the problem now?

As for dropping this conversation now, I'd love to. If you really want  
to drop it, I urge you to do just that - don't respond to this  
message. Read it, digest it, and then just let it sit. If this is the  
last message on the subject, that would be *wonderful*. But if you  
respond to this message then you have absolutely no ground to accuse  
me of refusing to drop it. So please, don't.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-71--505148164
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
DxcNMDgwMTI0MDIwNTUxWjAjBgkqhkiG9w0BCQQxFgQUZxQ2t5mm1FIa8It8wh7B6n5Z7oAwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBANP8wNiGA56/hD/r/QCA0ltK8rLzTuANr0SnPz2DnCvQR4aiZCq0w2Sdrb+ghsW7DhCSGnR3
ABQjibA/H2pn1A+jfpUwkSJVLvaHTSF6eQ4H2Um/teFkva4Gx1oNM7GO7ZP34sZhm9Vi8Gc5mJSS
pVwlg7HzPmXcZKIZvFDfSHPT3r9nArC6daEl5ENtv8bwaza4zGwnmOMkb1CKUV76MITxBj1+eJMC
MKbj947i8pUnF7g6E/L9kDSYYTODaKQBHKYHb92h8VbgyZi1/2UtqoWdjk24ho6G0ufA7q1/G1T+
GQ8pZlUmYnj/QpKZbTexyl/QGGk5V4Zfks94YQLCHiUAAAAAAAA=

--Apple-Mail-71--505148164--
