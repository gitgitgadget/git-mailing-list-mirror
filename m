From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 18:09:22 -0500
Message-ID: <C331E3F9-E177-4C10-B497-528ED08D1E1C@sb.org>
References: <alpine.LFD.1.00.0801!210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08!01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.!0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0!0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <20080121230053.GA317@mit.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-30--688536878; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:10:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5m9-0003Tj-GJ
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbYAUXJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbYAUXJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:09:26 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:33142 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755405AbYAUXJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 18:09:25 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id CDBB6AF832;
	Mon, 21 Jan 2008 15:09:23 -0800 (PST)
In-Reply-To: <20080121230053.GA317@mit.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71370>


--Apple-Mail-30--688536878
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 6:00 PM, Theodore Tso wrote:

> On Mon, Jan 21, 2008 at 05:46:27PM -0500, Kevin Ballard wrote:
>> I find it amusing that you keep arguing against having git treat  
>> filenames
>> as unicode when, if you had actually taken my advice and read my  
>> previous
>> email talking about "ideal" vs "practical"...
>
> If by "ideal" you mean a world where 100% of all computers were
> designed by Steve Jobs, you might have a point.

NO NO NO NO NO. READ MY EMAIL. STOP MAKING ASSUMPTIONS ABOUT WHAT I'M  
TALKING ABOUT.

The most frustrating thing about this thread is everybody keeps  
arguing about what they *assume* I'm talking about without actually  
bothering to read what I'm saying.

>> In other words, I was trying to illustrate that
>> HFS+ isn't wrong, it's just different, and the difference is  
>> causing the
>> problem.
>
> And if you want to interoperate with the rest of the world, where at
> least count over 92% of computers are NOT running HFS+, then "Thinking
> Different" is indeed causing the problem, yes.  And whose fault is  
> that?

And if you want to interoperate with the rest of the world, where at  
least count over 92% of computers are running Windows, then using  
another OS is stupid, right? Right? I mean, if everyone else is doing  
it, we should too, shouldn't we?

> The whole point of interoperability is that when we communicate, we
> have to do so in a uniform and predictable way.  If we can't, the next
> best thing is to have protocol translators; but in order to do that,
> we must avoid lossy transformations, such as HFS+'s
> pseudo-normalization.  (Why, by the way, will not result in a "normal"
> form for any glyph which can be encoded with and without a combining
> character if said glyph was introduced into Unicode after 1988.  So
> you can't even call it a "normalization" algorithm, but just a
> pseudo-normalization transformation which is lossy and which DESTROYS
> filename information in an irrecoverable way.)

Sure it's normalization, it's just not using one of the standard  
forms. But the form is well-defined.

And yes, protocol translators are a good idea. That's why I thought  
the original suggestion of using a table to map index filenames <-> HFS 
+ filenames sounded like it could work. The only time that should fail  
is if the index contains multiple filenames that HFS+ will treat as a  
single filename. Is there a problem with this approach?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-30--688536878
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
DxcNMDgwMTIxMjMwOTIyWjAjBgkqhkiG9w0BCQQxFgQUDo7y5y2us7stJEjcYQ775lbNopkwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAMkDxHJiOJMiBluBy6N8nDVlmjDzMLC2nAP35PbSG3xuyHzSHdq8Yxqrd9jj1rATimKA2SBG
LCX9vc3pGtPgHDAqxuhaRp1Alz73tHh4OKszd5nLwXUxzTiY+hs4GhntHv6JOtdBFVbvoA6RhN/Y
tphPT1r6gFt8LhKLAEfrBpDhTFt009jRPkGramcZaRMsqRyILRhnjxANJfjXm51BPyWwiBSUdkUz
mq8ujXfUhPEmTRcIcntCHqvUufc42/zqFBIHXaPSZCV+qB4p+EubU9fJhAY/bIvPu2OXZp5C35T2
+lnbilhRkrNhOfte0SWKiK1ujLe544wuLpR91jgBZXcAAAAAAAA=

--Apple-Mail-30--688536878--
