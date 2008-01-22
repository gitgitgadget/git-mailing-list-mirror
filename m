From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 19:47:49 -0500
Message-ID: <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D5158
 4143C9@sb.org> <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-34--682629314; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:48:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7JU-00062B-QO
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 01:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbYAVAr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 19:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbYAVAr7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 19:47:59 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:48049
	"EHLO randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755841AbYAVAr6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 19:47:58 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 6AB2E18DA2E;
	Mon, 21 Jan 2008 16:47:51 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71381>


--Apple-Mail-34--682629314
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Please read to the bottom of this email. As near as I can figure out,  
you haven't done that on any of my previous emails.

On Jan 21, 2008, at 6:44 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>>
>> I find it amusing that you keep arguing against having git treat  
>> filenames as
>> unicode when
>
> NO I DO NOT!
>
> Dammit, stop this idiocy.
>
> I think it's fine having git treat filenames "as unicode", as long  
> as you
> don't do any munging on it.

When I say "treat filenames as unicode" I'm implying the equivalence  
comparisons and everything else that we've been talking about.

> Why? Because if it's utf-8, then treating them "as unicode" means  
> exactly
> the same as treating them "as a user-specified string".

If that's what "as unicode" meant, then the phrase "as unicode" has  
zero meaning.

> So stop lying about this whole thing. I have never *ever* argued  
> against
> unicode per se.

No, you've argued against unicode equivalency in filenames. Can't you  
figure out, when the entire time I've been talking about equivalency,  
that I'm *still* talking about equivalency?

> All my complaints - every single one of them - comes down to making  
> the
> idiotic choice of trying to munge those strings (not even strictly
> "normalize") into something they are not.

Yes, I understand quite well that you are against munging strings.

> And what you don't seem to understand is that once you accept  
> _unmodified_
> raw UTF-8 as a good unicode transport mechanism, suddenly other  
> encodings
> are possible. I'm not out to force my world-view on users. If they are
> using legacy encodings (whether in filenames *or* in commit texts or  
> in
> their file contents), that's *their* choice.

You're not using raw UTF-8, you're just using raw bytes. Calling it  
UTF-8 doesn't mean anything, since you don't actually know that's what  
it is. But this is fairly irrelevant.

> I actually personally happen to use UTF-8-encoded unicode.
>
> I'm just not stupid enough to think that (a) corrupting it is a good  
> idea,
> *or* (b) that I should force every Asian installation of git to also  
> force
> people to use unicode (or even having all the conversion libraries and
> overheads!)
>
> So stop this idiotic "unicode == normalization" crap.
>
> I'm a huge fan of UTF-8. But that does not mean that I think  
> normalization
> is a good idea.

How many times must I say the same thing over and over? I'm not  
arguing that forced normalization is a good thing. I'm arguing that,  
in a system which is unicode-aware top to bottom, forced normalization  
is irrelevant to the user, since they don't care about the exact byte  
sequence. And I'm also arguing that git should have some solution to  
this problem. I find it interesting that you're perfectly happy to  
rant and rail against your misperception of my argument, and yet you  
consistently and repeatedly ignore my offers to stop this argument and  
work towards a solution, as well as my comments on existing proposed  
solutions.

Are you even reading to the end of my emails?

- Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-34--682629314
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
DxcNMDgwMTIyMDA0NzUwWjAjBgkqhkiG9w0BCQQxFgQU6GmN2eNVgEfhk2611Y1m05u5k0swgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAGmTSceGeleP2HEM096dhniyGbeJCilruud3O7qzAHuBIza4cuxvcFM1dvd9XJEBjaNEGZaE
+qFmArtJtudMFmR4U680YmLPrCOAMYjQsHhSoeX5vy0OaF2uivtK9SMfEygm595PlOAIfm3/g5op
8BqwuMuhlYL2OKFrg7nNomOqJ+4uJ8MZhwrmnIIfP3bGUGrLvFsgxK0OeL5L3u/fg6xBTH16AzFY
fsVYywKt4tbhmQcyf3U3bVx97zcltC/LB1RhdoDVccgxYem6k12h2KK574MDYex5pOk8KMZbxjQ0
QZTnyOIkIElR8ap+T7UedaQ3RRAVRdMWdbQS6bd7Oq0AAAAAAAA=

--Apple-Mail-34--682629314--
