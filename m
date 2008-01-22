From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 19:30:11 -0500
Message-ID: <A8C7EBCD-8E7F-44AA-89F2-89F6026980B0@sb.org>
References: <478E1FED.5010801@web.de> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <46a038f90801211456h4b16ff2cl4378df88023bbc34@mail.gmail.com> <53C76BEA-2232-4940-8776-9DF1880089A4@sb.org> <46a038f90801211516j1f4e10c3q364b446d1293542b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-32--683687266; micalg=sha1; protocol="application/pkcs7-signature"
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:30:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH72O-0001t2-2z
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 01:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbYAVAaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 19:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbYAVAaS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 19:30:18 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:42035 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755893AbYAVAaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 19:30:16 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id 8623A1958F9;
	Mon, 21 Jan 2008 16:30:13 -0800 (PST)
In-Reply-To: <46a038f90801211516j1f4e10c3q364b446d1293542b@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71376>


--Apple-Mail-32--683687266
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


On Jan 21, 2008, at 6:16 PM, Martin Langhoff wrote:

> On Jan 22, 2008 12:02 PM, Kevin Ballard <kevin@sb.org> wrote:
>> I'd imagine writing an OS to be a horrifically complicated task.  
>> And yes, I
>> can certainly imagine HFS+ might have issues when used to back an  
>> NFS server
>> with other clients, but that still leads back to the original  
>> point, which
>> is that all these problems stem from the differences between HFS+  
>> and other
>> filesystems, not any inherent problem with HFS+ itself.
>
> Right. If you are defining the requirements for a new FS on a new OS,
> would you not include a requirement that says "must not add any funny
> rule that prevents clean interoperation with other filesystems or
> OSs"? Forgetting that requirement is... a big one! And if someone asks
> "how do we do nice user-friendly filename matching with these
> technical differences that users mostly don't care about"... wouldn't
> you say "do it in the GUI facilities, changing the FS to handle this
> is wrong because it will break the OS as a server, as a reliable file
> storage"?

Sure, but you have to remember, HFS+ was developed back for Mac OS 8,  
which really wasn't a very good server machine.

> FSs have pretty hard requirements these days -- all the modern FS
> you've heard about respect the requirement above, and a ton more that
> you have to be in the FS business to be aware of. Mostly anyway,
> wherever they don't, users have all sorts of trouble.
>
>> IIRC, the biggest problem he talked about was the changing unicode  
>> standard,
>> but since the technote appears to state that HFS+ will not be  
>> changing its
>> normalization algorithms to preserve backwards compatibility with  
>> existing
>> volumes, that doesn't appear to be a nasty issue after all. Is  
>> there another
>> issue I've failed to address in this thread?
>
> Well, Ted answered that part, noting that then the "normalisation" is
> patchy, and everyone else is left to guess what chars are normalised
> and what chars aren't so being HFS+ compatible becomes a very weird
> game indeed. You didn't reply to his explanation -- you called him
> arrogant instead. Did you manage to read to the end if his email?

I've read every single email in this thread, all the way through. Ted  
was arguing against calling it "normalization". If you want to argue  
that it's using a non-standard normal form, go ahead, but surely you  
can figure out that can you simply re-normalize it to whatever form  
you want.

> The HFS+ designers mucked it up -- and then papered over it with the
> OSX libraries. But a good chunk of the world does not use them, they
> forgot about the little "interop" requirement.

Sure, maybe they did forget about interop. Or maybe they developed  
this back on Mac OS 8 where the only real competitor was Windows, and  
they didn't have to worry about the Mac being used as an NFS server,  
and thus interop wasn't even a requirement.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-32--683687266
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
DxcNMDgwMTIyMDAzMDEyWjAjBgkqhkiG9w0BCQQxFgQUo9UGbEM31BbPe9c4xwJXFKL9L10wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBADGU7KVojDQdK0PBd1/Ccs0E9Jv5CGVN8gK2TkCeyz3mwKVhyKrNwUCp/g60CjGiPLelJX+L
w7SiBIywCJh7yn05G8heFqNRiTy03p72kdY1daAqvJYAp9HlXoB/XDQ1ffuD6/dwdxmVoUeXxwRG
wleDlE20XHrlZQuajIY8XTz9E/WwCrDr7pFWJNR0AbeUv2ugxd/LXrzuni8HLSLdXxdScmz02NMJ
eA6VFBardEey5FfJh8DgLezrW2dZKrYsJPX1I7lwvN92TzTYnsoibGFBTaWUWl8ckMbpe3kMMc4w
80fQ13whRAWCKWrd1/wlOITtcIUYJDIsKi3/olbv5BIAAAAAAAA=

--Apple-Mail-32--683687266--
