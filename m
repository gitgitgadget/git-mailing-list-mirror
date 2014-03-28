From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Thu, 27 Mar 2014 20:58:27 -0700
Message-ID: <20140328035827.GG25485@odin.tremily.us>
References: <20140328030556.GD25485@odin.tremily.us>
 <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
 <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com>
 <20140328035255.GF25485@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTNwF-0000Ds-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbaC1D6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 23:58:33 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:40776
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755140AbaC1D6a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 23:58:30 -0400
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id irwy1n0041ZXKqc56ryVnE; Fri, 28 Mar 2014 03:58:29 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id iryU1n00C152l3L3hryUA6; Fri, 28 Mar 2014 03:58:29 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id E1D5110DE346; Thu, 27 Mar 2014 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395979107; bh=b89jS9XaOWpUk1Po6tw8dodqWRy0wVnenUIuLH/VEMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CXJmZnE9MeVvYgE1A88jKyKGaZWUOXeVb9KHkLZqSfc9q5nlGqy9AhSwPtjzjSCaR
	 aQl0pUmTBzGVzlPsEWyQ/7MYLHFAHR26M1g2/+7GOOYQQgKOmvywignFNjx2PXgfDc
	 4PDH2TLpixl3bVhgc1dc273CFzSErihTBt2LVhCE=
Content-Disposition: inline
In-Reply-To: <20140328035255.GF25485@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395979109;
	bh=Bmo5cLofUr3l+wEDeFEpKObqePFo3CHGvGWWsliogP8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=avLnxQeTM30PynmEQnf+jH1JcIvVqZODEPrGTROwLfeEYCBcKRHFLE+jxf6wf1FR3
	 5YKKmjiKUsQvtEk2UWygFuPP25TTnjXmzWvbrf64rNcREYxXQipeJ+isEIaMdnXgSD
	 Xiqs7ibmBO8FzK3WzjXH6rbiKY4ypCCgRB+JOKIRHC+t5Ep5b13gPTaveh9as9lL3I
	 G+0IahBr735o8JyPSQizMiazs0aLf5y6OLGxLCqcLRHAFFWEFz3LowlYuREJXZNube
	 5bnNbfx1Hc/9p5yqeQ48z1pO0QXT3UJ+54EUfnvNapFfrddcqBjwnTeP6BItG2UQvQ
	 9/FAjlLry4j7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245361>


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 08:52:55PM -0700, W. Trevor King wrote:
> On Thu, Mar 27, 2014 at 11:43:47PM -0400, Eric Sunshine wrote:
> > On Thu, Mar 27, 2014 at 11:36 PM, W. Trevor King <wking@tremily.us> wro=
te:
> > >  submodule.<name>.branch::
> > >         A remote branch name for tracking updates in the upstream sub=
module.
> > > -       If the option is not specified, it defaults to 'master'.  See=
 the
> > > -       `--remote` documentation in linkgit:git-submodule[1] for deta=
ils.
> > > +       If the option is not specified, it defaults to the subproject=
's
> >=20
> > Did you mean s/subproject/submodule/ ?
> >=20
> > > +       HEAD.  See the `--remote` documentation in linkgit:git-submod=
ule[1]
> > > +       for details.
>=20
> No the remote branch is in the upstream subproject.  I suppose I meant
> =E2=80=9Cthe submodule's remote-tracking branch following the upstream
> subproject's HEAD which we just fetched so it's fairly current=E2=80=9D ;=
).

Hmm, maybe we should change the existing =E2=80=9Cupstream submodule=E2=80=
=9D to
=E2=80=9Cupstream subproject=E2=80=9D for consistency?

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNPNiAAoJEKKfehoaNkbtdLUP/jztQn9u2dMeBXUi3k3AFcMP
UbOzfg+BNBUzljw8BjPQpROwcnmvlwIUQiwqVCmrafrT7tEYKI2hm8BENew0agQK
P0cZXIml1mHq4W7tHs/x5eooiUzbmzUyesgS+2w1NbaICz/zuZbfRFUqQH3Z8U++
LDScTrLHkkXwSR9IfUHwsYqXpJnVFNx/Jg8/eIWom0u2PoZwvuaKo8VdCOc/Jz4b
+T/mwRWFBQEbfLe3i9yKN10Ge7+vXr1QCmZIswpDQhu4YS5hq84GJCA+Lrvs5xko
4yT9Hl0KHaxgna+Ne67lEc+j4Iyinnb8vckS5HkJOrXipZglJubCjKJz2mukGLpS
LeTp5ATWEk9416EJlmsv1X0VrZVhp1sSoXoJJULX+Hw88kuDdAmMXT8NRTM3HoWt
M2M7tLz347hBXw0XFVRsg4CRhfGtBeHUlML5rQ/5DkRWLd+kZ1wHZwmtyQW/pkQQ
mfavAuqiq6GLqFxxLW1BkppCR2bIZlQcua91XbE3S+Mtzj3BHWUF0Pkkz7L39g/W
g5E/yibTg9vWZQCTqjpZP880cRA+U+Ou5hQKXC/tNZnY68ju0ATW/T2yuS8zWzk3
r40Uxcl+mBTFwEUpRmpZPU1H/4Gq3DDi8DuyuO4DKZuiqFXZj6Ee4gbF9e7t7MQ9
jd/uUsd3WHpHYAHrTPI7
=8kPG
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
