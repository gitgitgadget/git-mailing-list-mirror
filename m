From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 16:49:46 -0500
Message-ID: <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-
 foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.00.0801211323120.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-37--693312974; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4X5-00021g-PK
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbYAUVtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYAUVtu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:49:50 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:35429 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752781AbYAUVtt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:49:49 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id E34D3AF838;
	Mon, 21 Jan 2008 13:49:47 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211323120.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71354>


--Apple-Mail-37--693312974
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 4:33 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>>
>> I'm not sure what you mean. I stated a fact - at least on OS X, the  
>> filename
>> does not contribute to the listed filesize, so changing the  
>> encoding of the
>> filename doesn't change the filesize. This isn't a philosophical  
>> point, it's a
>> factual statement.
>
> And my point was that your *whole* argument boils down to  
> "normalization
> is invisible".
>
> When it isn't. It's not invisible for filenames, it's not invisible  
> for
> file contents.
>
> You're trying to claim that normalization cannot matter. I'm just  
> pointing
> out that it sure as hell can. Exactly because lots of things don't
> actually look at data other than as just a Unicode string. They do  
> look at
> the raw format.
>
> And that's true both of file contents and file names.
>
>> I don't, but I do think this discussion revolves around filenames,  
>> therefore
>> it should not surprise you when I talk about filenames.
>
> I'm surprised that you make generalized sweeping statements about  
> how it's
> ok to normalize because normalization is "invisible", and then when I
> point out that that isn't true, you try to limit it.
>
> And no, that normalization is not invisible EVEN IN FILENAMES. If it  
> was,
> git wouldn't ever have noticed it, would it?

I'm really surprised that, after all of this, you're still horribly  
misunderstanding my argument. I never said it was invisible. NEVER.

I'm also surprised that you seem to care more about this argument then  
my offer to stop arguing and work towards fixing the problem.

>>> And git tries to be a general data tool, not a Unicode-specific one.
>>
>> Yes, I realize that. See my previous message about discussing ideal  
>> vs
>> practicality.
>
> I don't know which argument you're talking about. Git (and, btw,  
> Linux)
> does the "ideal" thing (don't screw up peoples data), and it turns  
> out to
> be the "practical" thing too (it can handle a wider range of cases  
> than OS
> X can).
>
> So no, this is not "ideal" vs "practical". They aren't in any conflict
> here.

You misunderstand my point. In a previous email I specifically used  
the words "ideal" and "practical" to describe arguments, which is what  
I was referring to here.

>> I could argue against this, but frankly, I'm really tired of  
>> arguing this same
>> point. I suggest we simply agree to disagree, and move on to  
>> actually fixing
>> the problem.
>
> .. and people have even suggested how. Hide the idiotic OS X choices  
> by
> making a OS X-specific wrapper around readdir() that turns it into  
> NFC.

And I've responded to that suggestion, multiple times, saying that  
this doesn't actually fix the problem, it only hides it.

> That's just about the best we can do. We can't *fix* the thing that  
> OS X
> loses information, but a least we can then show the lost information  
> in
> the same form it _probably_ was in originally.
>
> But no, it won't "fix" git on OS X.

Quite a while ago it was suggested that git uses a table that maps the  
original byte sequence as seen in the index to the form returned by  
readdir(). So far this has sounded like the best solution, but as I've  
said before I don't know git's internals enough (or, really, at all)  
to be able to work on this myself.

This solution should only "lose" information in the case where the  
index has 2 filenames that HFS+ treats as a single filename.

Is there some reason this won't work?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-37--693312974
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
DxcNMDgwMTIxMjE0OTQ2WjAjBgkqhkiG9w0BCQQxFgQUfHtzJpyW5WNuW072IRSc0xbImHMwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAIrpGgcr3/NvY4bkAPIsmui6qWctOsYNGZgT6Fm9CN7nIM2BO8Er76RnI9M6AdIqZKkmuY2A
wF3z0H9OwA1HQhteMmfIDutfsrCq1jAw1FgXRK2QL5plsg6PI6iZupQPAVlCpHoo5vvThogOPQTc
sWwPwXdx1nnqmW4vm1k2ksv6d8x9X4OI32VR2xTf+kMq6Vpbik2ZowsEayL1+gy27ZBcIfa+NH7b
pkzcKvkx/7StEqIgtMeBhkCE7bJD2Aktb3KURXZ5L9t8XEUmUIK9NQEYo8EBnVhUFsLq390Ch/Bh
n5NbCli8qJDEhqegG1YGClJzbQ5aCY+CDSloBPsYiPUAAAAAAAA=

--Apple-Mail-37--693312974--
