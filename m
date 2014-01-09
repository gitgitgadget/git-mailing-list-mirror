From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Wed, 8 Jan 2014 18:22:22 -0800
Message-ID: <20140109022222.GP29954@odin.tremily.us>
References: <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
 <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us>
 <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R92lf0Oi2sxyK3LA"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 03:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W15GU-0004D4-6M
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 03:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaAICW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 21:22:28 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:37955
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750986AbaAICW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 21:22:26 -0500
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id Be2g1n0040bG4ec5AeNRsP; Thu, 09 Jan 2014 02:22:25 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id BeNP1n00W152l3L3PeNQuq; Thu, 09 Jan 2014 02:22:25 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id F0435EB4FB7; Wed,  8 Jan 2014 18:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389234143; bh=QJlLmy1H2LIN/4/zw6Khssc3cC3siPe4Y7KW81QWkhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XwSyFu5QeKM/9RXmvTQk7buWa+kEeJMyS7ObMjZiIS2EwkcngC03ndaVyliYDmnMT
	 G3Zj/1ikfLSl5TvyyHDJchJi3yu7ijslJq4QPkEYEimLj61kJWI5eP+TE1etspiyrB
	 GXVm+/cN4DZdf9QZvwuO519Os7k1N+dNgQRonysY=
Content-Disposition: inline
In-Reply-To: <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389234145;
	bh=MtMcyRLgahlIwZ19lDwvsUFdZbbAJlSyBItUGuhlnCY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=bWMZw5Yqt72E0yrCECwdjRM0BThyOEJOB8habHPaELBh0eBUXlhUVv5K9ezG3RGHs
	 IX0UiptzRVXAXKMWCf/0d37nMWXZK7D0f/kdE3C1r1kJIU1RNqGZg+NK/qFSv+kTBp
	 IQED2DAyZLFwJaqhsI3bJi4qOVYgn1x2QpCO5tzVuqrvpubKIpM9EUKTuJ+hnP1s58
	 mPV4CmFkep7R1SNnHwRA34SPIJo+Xn90O+8R0KH+ovC32oZByv9r/iAKBj2gnowp/C
	 TG44ir4337piZ6TdSDZa5bUQL3AyJhEV2SSMDPZe0qGmf3m7isQ2XP4tF37pPPvw5S
	 INO0G0RONITcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240240>


--R92lf0Oi2sxyK3LA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 02:09:37AM +0100, Francesco Pretto wrote:
> 2014/1/9 W. Trevor King <wking@tremily.us>:
> >   [branch "my-feature"]
> >         remote =3D origin
> >         merge =3D refs/heads/my-feature
> >         [submodule "submod"]
> >             local-branch =3D "my-feature"
> >
> > and I don't think Git's config supports such nesting.
>=20
> Aesthetically, It doesn't look very nice.

The INI syntax does not lend itself to easy nesting, but I'm pretty
sure some mapping from (<superproject-branch>, <submodule-name>) to
<submodule-local-branch-name> is what we need for submodule checkouts.
I'm just not sure where local overides to the per-branch .gitmodules
should live.  We could turn it around, and store:

  [superproject "<superproject-branch>"]
      local-branch =3D "<submodule-local-branch-name>"

in .git/modules/<submodule-name>/config, with the UI:

  $ cd submodule
  $ git config superproject.<superproject-branch>.local-branch =3D <submodu=
le-branch>

Not beautiful, but maybe a bit more palatable, and already supported
by Git's current config parser.  That's enough that I can work up a
patch that will hopefully clarify my position ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--R92lf0Oi2sxyK3LA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzgfaAAoJEKKfehoaNkbt0FgP/1VjhhE8Jn1jCk3HM4SX3CZc
gLqLvBF+bDifX9MM2WPwDDGCY8jerzkUUZTFU+dDKZHxaeGv7ml1abKWWOjWY4ub
QCo8EomJ5pozdEqaFrZTvhdbps3AyOdcs0bQGi9BulrbP+gN4OEFQFdMSaOOlByk
7QXjNzgQW1SyrTCGQtFTTLcc3GFv4oHzQ7mn/tdJkUZPZ5RdHPHj7s7qnb/RuxAq
vAyoS3YNvREskOwC++mjnUjfNAi2mDLdbN8M6OrTUE9YqHrzS5U6EI3bZWHvecmz
h+HESxkg2sEP4GWk6IXhM6uzfFcdSpcCnpE75YXqutoh2rY4bYQpa1IBy2zv5NVR
gxsiSupB2YLubhEgCT9N08WwunX+ewAQ/YL8uhQBs+OMZoF9XtR5/qrBAokIV7v7
6ym3muT9rh31QwBdjSF9d1I0e4diGhWZdp9r6AA7vqDMbOvlPrqIzYp1SXdTcZXz
G4zb8R2FsFMLsoszVmqMeU581Q0SZ7MMKQXw1ikgndgG2M+ttuHlT5GoqBwnFNBY
SsnQ0ddr50pcrN3s/Y9Cg0zByiN5vflF2tareZUSx1XF9A6dDo2MECNRWdde4Hyl
CnTU/u3wbtK+rk8ewz2+38TMUE3mkpwmU8LBq1sMZoMWsoJUXzOkBa2XBEHz0fE+
KnZEFncYS2YGedpE0TqF
=YEQ0
-----END PGP SIGNATURE-----

--R92lf0Oi2sxyK3LA--
