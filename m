From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 14:05:51 -0500
Message-ID: <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cix
 it.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-15--703147818; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1yT-00013U-M4
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYAUTFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbYAUTFz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:05:55 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:45081 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751403AbYAUTFy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:05:54 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id ADFC6EEE8C;
	Mon, 21 Jan 2008 11:05:52 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71308>


--Apple-Mail-15--703147818
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 21, 2008, at 1:12 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>> On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
>>>
>>> I happen to prefer the text-as-string-of-characters (or code points,
>>> since you use the other meaning of characters in your posts), =20
>>> since I
>>> come from the text world, having worked a lot on Unicode text
>>> processing.
>>>
>>> You apparently prefer the text-as-sequence-of-octets, which I tend =20=

>>> to
>>> dislike because I would have thought computer engineers would have
>>> evolved beyond this when we left the 1900s.
>>
>> I agree. Every single problem that I can recall Linus bringing up =20
>> as a
>> consequence of HFS+ treating filenames as strings [..]
>
> You say "I agree", BUT YOU DON'T EVEN SEEM TO UNDERSTAND WHAT IS =20
> GOING ON.

I could say the same thing about you.

> The fact is, text-as-string-of-codepoints (let's make the "codepoints"
> obvious, so that there is no ambiguity, but I'd also like to make it =20=

> clear
> that a codepoint *is* how a Unicode character is defined, and a =20
> Unicode
> "string" is actually *defined* to be a sequence of codepoints, and =20
> totally
> independent of normalization!) is fine.
>
> That was never the issue at all. Unicode codepoints are wonderful.
>
> Now, git _also_ heavily depends on the actual encoding of those
> codepoints, since we create hashes etc, so in fact, as far ass git is
> concerned, names have to be in some particular encoding to be =20
> hashed, and
> UTF-8 is the only sane encoding for Unicode. People can blather about
> UCS-2 and UTF-16 and UTF-32 all they want, but the fact is, UTF-8 is
> simply technically superior in so many ways that I don't even =20
> understand
> why anybody ever uses anything else.
>
> So I would not disagree with using UTF-8 at all.
>
> But that is *entirely* a separate issue from "normalization".
>
> Kevin, you seem to think that normalization is somehow forced on you =20=

> by
> the "text-as-codepoints" decision, and that is SIMPLY NOT TRUE.
> Normalization is a totally separate decision, and it's a STUPID one,
> because it breaks so many of the _nice_ properties of using UTF-8.

I'm not saying it's forced on you, I'm saying when you treat filenames =20=

as text, it DOESN'T MATTER if the string gets normalized. As long as =20
the string remains equivalent, YOU DON'T CARE about the underlying =20
byte stream.

> And THAT is where we differ. It has nothing to do with "octets". It =20=

> has
> nothing to do with not liking Unicode. It has nothing to do with
> "strings".
>
> In short:
>
> - normalization is by no means required or even a good feature. It's
>   something you do when you want to know if two strings are =20
> equivalent,
>   but that doesn't actually mean that you should keep the strings
>   normalized all the time!

Alright, fine. I'm not saying HFS+ is right in storing the normalized =20=

version, but I do believe the authors of HFS+ must have had a reason =20
to do that, and I also believe that it shouldn't make any difference =20
to me since it remains equivalent.

> - normalization has *nothing* to do with "treating text as octets".
>   That's entirely an encoding issue.

Sure it does. Normalizing a string produces an equivalent string, and =20=

so unless I look at the octets the two strings are, for all intents =20
and purposes, the same.

> - of *course* git has to treat things as a binary stream at some =20
> point,
>   since you need that to even compute a SHA1 in the first place, but =20=

> that
>   has *nothing* to do with normalization or the lack of it.

You're right, but it doesn't have to treat it as a binary stream at =20
the level I care about. I mean, no matter what you do at some level =20
the string is evaluated as a binary stream. For our purposes, just =20
redefine the hashing algorithm to hash all equivalent strings the =20
same, and you can implement that by using SHA1 on a particular =20
encoding of the string.

> Got it? Forced normalization is stupid, because it changes the data =20=

> and
> removes information, and unless you know that change is safe, it's the
> wrong thing to do.

Decomposing and recomposing shouldn't lose any information we care =20
about - when treating filenames as text, a<COMBINING DIARESIS> and <A =20=

WITH DIARESIS> are equivalent, and thus no distinction is made between =20=

them. I'm not sure what other information you might be considering =20
lost in this case.

> One reason _not_ to do normalization is that if you don't, you can =20
> still
> interact with no ambiguity with other non-Unicode locales. You can =20
> do the
> 1:1 Latin1<->Unicode translation, and you *never* get into trouble. In
> cotnrast, if you normalize, it's no longer a 1:1 translation any =20
> more, and
> you can get into a situation where the translation from Latin1 to =20
> Unicode
> and back results in a *different* filename than the one you started =20=

> with!

I don't believe you. See below.

> See? That's a *serious*problem*. A system that forces normalization BY
> DEFINITION cannot work with people who use a Latin1 filesystem, =20
> because it
> will corrupt the filenames!
>
> But you are apparently too damn stupid to understand that "data
> corruption" =3D=3D "bad", and too damn stupid to see that "Unicode" =
does =20
> not
> mean "Forced normalization".

When have I ever said that Unicode meant Forced normalization?

> But I'll try one more time. Let's say that I work on a project where =20=

> there
> are some people who use Latin1, and some people who use UTF-8, and =20
> we use
> special characters. It should all work, as long as we use only the =20
> common
> subset, and we teach git to convert to UTF-8 as a common base. Right?
>
> In your *idiotic* world, where you have to normalize and corrupting
> filenames is ok, that doesn't work! It works wonderfully well if you =20=

> do
> the obvious 1:1 translation and you do *not* normalize, but the =20
> moment you
> start normalizing, you actually corrupt the filenames!

Wrong.

> And yes, the character sequence 'a=A8' is exactly one such sequence. =20=

> It's
> perfectly representable in both Latin1 and in UTF-8: in latin1 it is a
> two-character '\x61\xa8', and when doing a Latin1->UTF-8 conversion, =20=

> it
> becomes '\x61\xc2\xa8', and you can convert back and forth between =20
> those
> two forms an infinite amount of times, and you never corrupt it.
>
> But the moment you add normalization to the mix, you start screwing =20=

> up.
> Suddenly, the sequence '\x61\xa8' in Latin1 becomes (assuming NFD)
> '\xc3\xa4' in UTF-8, and when converted back to Latin1, it is now =20
> '\xe4',
> ie that filename hass been corrupted!

Wrong. '\x61\x18' in Latin1, when converted to UTF-8 (NFD) is still =20
'\x61\xc2\xa8'. You're mixing up DIARESIS (U+00A8) and COMBINING =20
DIARESIS (U+0308).

I suspect this is why you've been yelling so much - you have a =20
fundamental misunderstanding about what normalization is actually doing.

> See? Normalization in the face of working together with others is a =20=

> total
> and utter mistake, and yes, it really *does* corrupt data. It makes it
> fundamentally impossible to reliably work together with other =20
> encodings -
> even when you do converstion between the two!
>
> [ And that's the really sad part. Non-normalized Unicode can pretty =20=

> much
>  be used as a "generic encoding" for just about all locales - if you =20=

> know
>  the locale you convert from and to, you can generally use UTF-8 as an
>  internal format, knowing that you can always get the same result =20
> back in
>  the original encoding. Normalization literally breaks that wonderful
>  generic capability of Unicode.
>
>  And the fact that Unicode is such a "generic replacement" for any =20
> locale
>  is exactly what makes it so wonderful, and allows you to fairly
>  seamlessly convert piece-meal from some particular locale to Unicode:
>  even if you have some programs that still work in the original =20
> locale,
>  you know that you can convert back to it without loss of information.
>
>  Except if you normalize. In that case, you *do* lose information, and
>  suddenly one of the best things about Unicode simply disappears.

See above as to why you're not losing the information you so fervently =20=

believe you are.

>  As a result, people who force-normalize are idiots. But they seem to
>  also be stupid enough that they don't understand that they are =20
> idiots.
>  Sad.

People who insult others run the risk of looking like a fool when =20
shown to be wrong.

>  It's a bit like whitespace. Whitespace "doesn't matter" in text (=3D=3D=
 =20
> is
>  equivalent), but an email client that force-normalizes whitespace in
>  text is a really *broken* email client, because it turns out that
>  sometimes even the "equivalent" forms simply do matter. Patches are
>  text, but whitespace is meaningful there.
>
>  Same exact deal: it's good to have the *ability* to normalize
>  whitespace (in email, we call this "text=3Dflowed" or similar), and =
in
>  some ceses you might even want to make it the default action, but
>  *forcing* normalization is total idiocy and actually makes the system
>  less useful! ]

Sure, it all depends on what level you need to evaluate text. If we're =20=

talking about english paragraphs, then whitespace can be messed with. =20=

When we're talking about unicode strings, then specific encoding can =20
be messed with. When talking about byte sequence, nothing can be =20
messed with.

In our case, when working on an HFS+ filesystem all you have to care =20
about is the unicode string level. The specific encoding can be messed =20=

with, and the client shouldn't care. Problems only arise when =20
attempting to interoperate with filesystems that work at the byte =20
sequence level.

The only information you lose when doing canonical normalization is =20
what the original byte sequence was. Sure, this is a problem when =20
working on a filesystem that cares about byte sequence, but it's not a =20=

problem when working on a filesystem that cares about the unicode =20
string.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-15--703147818
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
DxcNMDgwMTIxMTkwNTUxWjAjBgkqhkiG9w0BCQQxFgQU8WHLdWOaOzovo4Vc7HJrSe9oGv4wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBALrUgwQOqxoYPMx64NygmfvYKBE0usgFsNk28ofRVOIarD08xRIzcEun4RFbifUG+cGuXify
4Qqn4NzvabWgN+7Yla2ZIm4GS2i64hr8h+OrV9gW1IuBzOlr1RsupAlsWzIi368rHyixvJBWNBK3
lwN3ycsoyiEbIqTnFHRnohszRpZ9XQuFkohz9Gwu55jWGSCUEmu+bfLtUJa1D6i+a5RluEm5sRZm
mM5S4wQmWdOb0chWg7yXm5VTUwaGDMphOFXWHfEV3KbrKeT/3W4hDfL+WdzEqOBiELQXJQRLvmgb
PwYW9n70xw+2fOahbWZ91opygyqokbRw3B93lZWy9uQAAAAAAAA=

--Apple-Mail-15--703147818--
