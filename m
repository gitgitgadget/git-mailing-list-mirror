From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH] Consider object stores in alternates during a
 dissociating clone
Date: Fri, 23 Oct 2015 03:14:54 +0200
Message-ID: <20151023011454.GA21004@zorg.kyriasis.com>
References: <561F8DE9.4040703@cetitec.com>
 <alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
 <561FBA48.3050609@cetitec.com>
 <56274922.80007@cetitec.com>
 <xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
 <5628EBAF.1030205@cetitec.com>
 <xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
 <562911AD.50004@cetitec.com>
 <xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
 <56292612.3020609@cetitec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 03:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpR37-0005Ee-Kk
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 03:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966024AbbJWBVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 21:21:37 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:53158 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965590AbbJWBVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 21:21:36 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2015 21:21:36 EDT
Received: from theos.kyriasis.com (localhost [127.0.0.1])
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 8d2d34df;
	Fri, 23 Oct 2015 01:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=nyM+KHEXEaWaYwa3YA659ZQ/oUM=; b=qZrIYU
	dL1Gu8RuShjcqkGfh6lBFvbjg4fcihM5G9FCzkkYeItKWLafvSDbdFpSG3zPQALg
	IJUiv/hvz5cFNKAqP8pHylMlvscoZKNJ5Hnp3I1Q0aJSYRd/UnW2x7gPY41/jlzq
	Fs15EYTTLxtrDSy1ME/koY4+K5dlTRJh5pFK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=YuOecXmgcz8EliZT1cPTjTjR9L/L6PvO
	OadIzhjzeu23uQgKsrx0h/3d9HjthC5S6S5YLITWlSL9jdNXCyzHjWpPonXbGSrt
	sLgEbakkh/+dr+k1SwssLdfTI9CHDhaFsRysPUxpoDwcUQtgzEt2//NCpFb6dPwL
	ruAqsWperMk=
Received: from zorg.kyriasis.com (c83-253-170-71.bredband.comhem.se [83.253.170.71])
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id ac666ce0
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 23 Oct 2015 01:14:55 +0000 (UTC)
Mail-Followup-To: Alexander Riesen <alexander.riesen@cetitec.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
Content-Disposition: inline
In-Reply-To: <56292612.3020609@cetitec.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280080>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22/10, Alexander Riesen wrote:
>On 10/22/2015 07:50 PM, Junio C Hamano wrote:
>>Alexander Riesen <alexander.riesen@cetitec.com> writes:
>>
>>>>Content-Type: text/plain; charset=3Dwindows-1252; format=3Dflowed
>>I had to hand-munge it as the above lost all tabs and made the patch
>>unusable for machines X-<.
>I'm very sorry. I don't know why Icedove does that, nor do
>I know how to stop it mangling the text. Right now I just
>hate the damn thing.
>
>Thank you very much for reformatting the patch, as it would
>take quite some time until I configure a sane mail program
>to work here.
>

Tip: Just use git-send-email instead. There's even an example=20
configuration for gmail in the manpage.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQRQBAABCgA6BQJWKYoMMxSAAAAAABUAFXBrYS1hZGRyZXNzQGdudXBnLm9yZ2pv
aGFubmVzQGt5cmlhc2lzLmNvbQAKCRCQHBwyDrDUXQ3XH/0aOTl9qtz2nvURCbSC
zcCmP0IRob+VfRHdKxxUVeegmr+TozQkBuMyR0C88TqRQkKvwlQUQMRqoS68S32d
Z/g2Mn8Ycs0H+kNk9ppWhhTL4GukoTu8rKmihtzYBw/i0UFqCKNXnByNPTiIIebW
srdsFP15k8frtqQGPPA2HVMPl+vaBcduR5gPUMVvImFfxVh2ejX3kLz/dOL6n+Tt
Qu60bl4vpY8rGgmBJnXFpi236puEIjmzxcr4QASvezEMl9uJKZOUVg/SRUXNlqAI
HwS7Z1o/Tlb0ZvKecTo5hsciGFYEmNKOlkWxLC9Les0vhnrrKEPNoxojeRxiDQkg
kc0S+iv+7MH+/61l28Zn4ugSTc54Z7k3uypFMwR1YTHM6vloQn966hjBxpO81+4/
PMC+RVQm4XKE1o7ezcStN2wjppjSUC40mi8cFovQhoP5VYYWbDMyyjnG6vZvNWVE
98aU3dl2jAsuFOOPXkCE9PYQI8izQH4SPOtthl4HI0ujBx0yyLa+efBPG2mILXuO
Rwr1tEcZtb9FEOjAdDt2jtBH1rWK23QOhknj4dufgtrrVEQR0ADkrtU9pvLd07Yh
m3ofipu8HYNgZJosVUHSVfh00sFGE1MKzhH/75Eq42VdXzDvF3fG71gK5MZKBmR4
vSE5pPjJje5s3oOwAq/SFrv6aRcO9XWIpIlgIztmq1CX5uk89TYIZXSlv5+IFuJY
UOZx/6R7oQzTon623x5el4gu734eZUcFbxTBtiqoL+0km+Vtm1DeLumePEcR0YW0
eVOluwyH4uOv74IaHOzMamVDII7ezcUSZfCGov3rrnHGSR8kpNF9ClTejOovfR10
TMAkkjj9ibiBaYqqu6tJq2UExjEth2YR4/B2FuevdwwYB/pWfk38zC7Dz99zhji/
UFa/rq6Q7+1WyIaLV2LmHeel+e+aWH4Q4DOcZn7adB4GNmrhAVd0lDFnnwzaZRXg
qK+JW0HUWSzt8eodjC7v2ImeOroFgotryegRg8Fyl2pz3nskJHMYFGJCa3XBXYNl
zvUHEtrgcgr5nPDlsdbb1ly3kM8Vy4DhaYgKIT5t1mHCj55ck5hKca5I+olMi7D5
k2+SftzdpcgiEek6R2Yyo++KSR5QneKd2X2/TFv4iUqkS+whUWpVoMqmLQ84QXMQ
x71agJHmDlF7TREurveDexdJiUtkqQieMoWQmoKBKIkb2iMGO33W0FuxyiJp3Ig3
wO6a7xUG0KUqVISO+M5mbcpiW6VpqgHYc36bDI3xW5wH4xCut6RwDBDjSaZhezV+
8kRWHaWFJCHON486DZpV8fRV3tskgoyAz2O2PhuGTZRHtU6zBwRGqk5ElFJLROwL
bU3A
=tCQ5
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
