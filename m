From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri, 5 Jun 2015 18:25:23 +0200
Message-ID: <20150605162523.GA25914@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-3-git-send-email-johannes@kyriasis.com>
 <xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
 <20150605161225.GA23368@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 18:25:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uR0-00048D-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbFEQZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:25:26 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52867 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbFEQZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:25:25 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id de32dde7;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=jHjyU21XIAgj59+vKVr11nrooSw=; b=Oo0nLb
	+oaEkCtSC1LSSGLpgvDDpsHVGLgu7qFeCOeFQCaLfV4cfDuBNsbUAfGPqpwsoUis
	zY9BQBmuutBpQAWUr9gJnanm6h709f3LCQ0l1EMknFM7YFPCuxbUSny4LXDm1BWz
	WCDTgub9SDsPJcgf63WevHkmtW2j8EJD21r3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=PRhad8dJDHk0NrAL8dtbeAVtSqhVSszc
	TaR8g+Wm6a++ugXO69lE4K/Qe38kJ6DOvCdTwqR5pT3NolmVnrRo0pDWdtT+Kra1
	CQfOegVL1oh3pSchHf0Bjn98ZMl25zuZYU+0h5fqJcznd4CO8Q+6JMyiL3SHR20R
	eg3Hvmot/UA=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 11717c5a;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 16:25:24 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150605161225.GA23368@leeloo.kyriasis.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270848>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Johannes L=C3=B6thberg wrote:
>On 05/06, Junio C Hamano wrote:
>>Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:
>>		git -C ../bare symbolic-ref HEAD >actual &&
>>		echo refs/heads/master >expect &&
>>               test_cmp expect actual &&
>>
>>		git -C ../bare rev-parse HEAD >actual &&
>>               git rev-parse HEAD >expect &&
>>               test_cmp expect actual &&
>>
>>
>
>Hmm, it seems that git-rev-parse doesn't handle GIT_NAMESPACE yet, so=20
>can't check it for the namespaced push right now. Not sure if I can=20
>fix that myself though.
>

Would it be acceptable to check against=20
=2E./bare/refs/namespaces/new_namespace/HEAD and=20
=2E./bare/refs/namespaces/new_namespace/refs/heads/master instead, until=20
rev-parse is thaught about namespaces?

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVcc1wAAoJEJAcHDIOsNRdF2Yf/iC4cyk5oZbTBDyScR0O73fJ
2qHT8zl3hog0+C+fEYStled1BVlqQcq7UcdURD5EHBEoS+Nnyl8nLF9Yi8pUAHs8
NslericrKnRD4UpgV/l2dPVzR+4S1gNJoGZYYOfwuxoDEqJrq9YRF/r9pJvSmlfm
SjshGPUytPHtD+Em9bBuxDTWzGeWRak5qWL+kcLovgK3HICVAksoWg9t6DtX6KgE
v+wVsVYKjGptei1ktgLL5mJ7H/DhkZ7zj9J9HABniphAsc/67RuTAVT/+AhuMGjW
gDJE16WFskt0UtUl/BcskF2Mt2dEaW4fYBgVSyBpBBQR41NGYB3/yJJgmm1f4tlZ
mdjegdq83334fnQM5zqE2CpNyPlz3tHt98LHk1aRExlWCXn4yBKRduG+7VUC/Lrq
lgKPMBoF9c3HwkY0hkwFXtOoQPXOYS2kWeTqUyMHND91urvAV5ZPBbNQq8nufJx/
5/05ZAAf/o7yOdv96Uy7x6n8HGCQva4lAQI0xzeMHSGmauLglCHUuRweKN2lFkiL
fzL6Ypl50OQaIuzgt08z7MKtfou3Xg4h+aSBS8pDuVJ0q6f4IdGf6edbAjhTCgBi
foal04vPzpJXiSMpXv+zd3uEmfkdDIbV3UVlPJmyZVg1NLjhUFlSsqk7CkTZZi7Y
uBqW+9tyg1zdVCmgqSK7Ne0eNvISKjZgJp9aaUBTDBSQ76i/+0Q+CfjtNV/Kh8kO
J0xK6RXgA7Cgq0rJ2iV/WQ1XPNtw2PArOFZK12eKmJ33I0FrEbx1m7ds68v5Eh1E
Oyqih5+aPOAR0FjfT/LMjo4AffKvpv72eMLQz9lpOWSNwMpoUxON3COZ64AtWeQz
Vk9FIUe7ZJJ3OyiZCz/FCRyfRO3yVmFek0XXy3Z6XK+CfYKq586uQoD06In1f/Xa
b6shaZ8HgYbdMC2Fq4AP53qC7YfOrcUgpBqg7su1wH2oepvWk0eKJESumawdBzd+
o3j7qpS7o+r6+BFqLmwNbx9FE6fY97ST3YaOQHyyYZHfO1/Kl9Vbi6SwnwC4WbRN
VnJmxC4uqEyZejGdS3j1BZGAkwsoD1L39SrEoAk6FiF7nJ+x62Zbk6vuBeii8Xm/
aNeTXQy6ItVR4Dk4Lbv22Jb0aL9doGzmY/NXUChoizcE9Rz7niXkPj7lQEq+3O5t
DfAfhBLCH+pwtTLauiE7NQFMEpTzJNOBVJxsKoDlwk3lzAzGXuBv2d3aRQ5W+5f9
qRHBwG8x8imSNgIJsf2Gb4HWNvaETA61ZRRGdDFBhQ9vKv73oQA1akcumgNepdRe
t7rn7HNh0Tkbd9u459PKUAXfaStT9gxrN2PjKCZWGvg2T45om+JjAjw2rvWuu+I=
=sANk
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
