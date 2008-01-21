From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:53:25 -0500
Message-ID: <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-fo
 undation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.0801211210270.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-26--696693480; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3eZ-00073m-JH
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbYAUUx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbYAUUx2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:53:28 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:38566 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753067AbYAUUx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 15:53:27 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 1998118CE21;
	Mon, 21 Jan 2008 12:53:25 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211210270.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71336>


--Apple-Mail-26--696693480
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 21, 2008, at 3:33 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>>
>>> It's what shows up when you sha1sum, but it's also as simple as =20
>>> what shows
>>> up when you do an "ls -l" and look at a file size.
>>
>> It does? Why on earth should it do that? Filename doesn't =20
>> contribute to the
>> listed filesize on OS X.
>
> Umm. What's this inability to see that data is data is data?

I'm not sure what you mean. I stated a fact - at least on OS X, the =20
filename does not contribute to the listed filesize, so changing the =20
encoding of the filename doesn't change the filesize. This isn't a =20
philosophical point, it's a factual statement.

> Why do you think Unicode has anything in particular to do with =20
> filenames?

I don't, but I do think this discussion revolves around filenames, =20
therefore it should not surprise you when I talk about filenames.

> Those same unicode strings are often part of the file data itself, and
> then that encoding damn well is visible in "ls -l".
>
> Doing
>
> 	echo =E4 > file
> 	ls -l file
>
> sure shows that "underlying octet" thing that you wanted to avoid so =20=

> much.
> My point was that those underlying octets are always there, and they =20=

> do
> matter. The fact that the differences may not be visible when you =20
> compare
> the normalized forms doesn't make it any less true.

Yes, I am well aware that the encoding of the *file contents* affects =20=

filesize. But when did I suggest changing the encoding of filenames =20
inside file contents? If you treat filenames as strings, there's no =20
requirement to change the encoding of filenames inside file contents. =20=

I'm talking specifically about the filenames, not about file contents, =20=

so stop trying to argue against that which is irrelevant.

> You can choose to put blinders on and try to claim that =20
> normalization is
> invisible, but it's only invisible TO THOSE THINGS THAT DON'T WANT =20
> TO SEE
> IT.

Don't want to, or don't need to? It's not a matter of ignoring =20
encoding because I don't want to deal with it, it's ignoring encoding =20=

because it's simply not relevant if I treat filenames as strings.

> But that doesn't change the fact that a lot of things *do* see it. =20
> There
> are very few things that are "Unicode specific", and a *lot* of =20
> tools that
> are just "general data tools".
>
> And git tries to be a general data tool, not a Unicode-specific one.

Yes, I realize that. See my previous message about discussing ideal vs =20=

practicality.

>> I'm not sure what you mean. The byte sequence is different from =20
>> Latin1 to
>> UTF-8 even if you use NFC, so I don't think, in this case, it makes =20=

>> any
>> difference whether you use NFC or NFD.
>>
>> Yes, the codepoints are the same in Latin1 and UTF-8 if you use =20
>> NFC, but
>> that's hardly relevant. Please correct me if I'm wrong, but I believe
>> Latin1->UTF-8->Latin1 conversion will always produce the same Latin1
>> text whether you use NFC or NFD.
>
> The problem is that the UTF-8 form is different, so if you save =20
> things in
> UTF-8 (which we hopefully agree is a sane thing to do), then you =20
> should
> try to use a representation that people agree on.
>
> And NFC is the more common normalization form by far, so by =20
> normalizing to
> something else, you actually de-normalize as far as those other =20
> people are
> concerned.
>
> So if you have to normalize, at least use the normal form!

Was NFC the common normalization form back in 1998? My understanding =20
is Unicode was still in the process of being adopted back then, so =20
there was no one common standard that was obvious for everyone to use.

>> The only reason it's particularly inconvenient is because it's =20
>> different from
>> what most other systems picked. And if you want to blame someone =20
>> for that,
>> blame Unicode for having so many different normalization forms.
>
> I blame them for encouraging normalization at all.
>
> It's stupid.
>
> You don't need it.
>
> The people who care about "are these strings equivalent" shouldn't =20
> do a
> "memcmp()" on them in the first place. And if you don't do a =20
> memcmp() on
> things, then you don't need to normalize.
>
> So you have two cases:
> (a) the cases that care about *identity*. They don't want =20
> normalization
> (b) the cases that care about *equivalence*. And they shouldn't do
>      octet-by-octet comparison.
>
> See? Either you want to see equivalence, or you don't. And in =20
> neither case
> is normalization the right thing to do (except as *possibly* an =20
> internal
> part of the comparison, but there are actually better ways to check =20=

> for
> equivalence than the brute-force "normalize both and compare results
> bitwise").

I could argue against this, but frankly, I'm really tired of arguing =20
this same point. I suggest we simply agree to disagree, and move on to =20=

actually fixing the problem.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-26--696693480
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
DxcNMDgwMTIxMjA1MzI2WjAjBgkqhkiG9w0BCQQxFgQU1+660Z+Ep80AgdFgP2pZFcZV41IwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBACEJzIAi9Zi5yeQbvdY6gh60V5nDxhNkXbhE0khLvwRZv21dLikpNUMbSvyFQ8kh44jHp4S4
mBVxSX3fUdk5EzzBxSXMESJ3ftVxud0Iqw5uN7gHed2vX1l5TitYwFMKdeI5reQxdWSNB6S81UTl
pG2tDgQo6ubwMQsM5iYYG3EKe3bFi7JKaT0KtetyRctKWu7+h4lhULSkInN75vSj1YxbjylR1X5o
zWRcEcCEFhs3Y/CczY17vISPEXqs2izcilyk2ul9HBlnLc3KNdH+Gp/0uXvZJYroqBrDvTldRsl8
zGal0CiICO6bLsVAqHgLCj+VuIDivH133dTha4ntAy0AAAAAAAA=

--Apple-Mail-26--696693480--
