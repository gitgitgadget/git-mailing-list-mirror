Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CEC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhLMAL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 19:11:59 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:51476 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLMAL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 19:11:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D9A235D407;
        Mon, 13 Dec 2021 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1639354317;
        bh=V5hMYn+KzwZmt50ExiJAKEq2Y7NiQCqnsK6yPGM6LOY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G3B1t6hyoMNjwBrhEbgSkErcxhz1POyFQYytSPv3iNaaXyQqmK5GhuVIyJmKYozxE
         kL6edK+LD0tIegpF2ByS3qokhoxHsJRnA7pMFnU6sp4YDeA+/x/3bHXIHQi+QexlFB
         IekLHuUBgZIQpBGH6uuZMknqf/BxUhU3+jUoiBgm2HnpWuxmn3rZhW+LS+WqrB8HbG
         YFSnwF93xb07miu1u3fsqYSh0Ie1fgIy9c9cHfb0f4pSI/Igj24DlHCRbQv1ScNTH8
         CuJe5YLOooHdOllD60MuGQU34Uo94D6lUyZ1/3othKU9Bo3Hu7d4zUinyIHYeTUJbR
         WvGbsxvihOmuntdy821KVqchBgLChfMvhtj7jgy7qCp6mDVe9ewAl5bM4fDqL0a4To
         I5LPl/1/eKwZ4/ln0QyOlxX38RldREqHk40Y8lBUJD2JNGG9KhwuGe3ysQwCzi8svE
         Xb/ukZBwPiH/CbnVOHHuqkHS0Rd4h/fDte/W3wYIOSKjy54zsYP
Date:   Mon, 13 Dec 2021 00:11:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Mailing List <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 3/3] git-p4: add "Nvidia Corporation" to copyright
 header
Message-ID: <YbaPy8UhzIwRuNYm@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Mailing List <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
References: <20211210153101.35433-1-jholdsworth@nvidia.com>
 <20211210153101.35433-4-jholdsworth@nvidia.com>
 <CABPp-BEyBLzWY2andDXZV6AgkQpnt1sp_rSThy84=qXMt2D8nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MDh7u5yUj/lJK6y/"
Content-Disposition: inline
In-Reply-To: <CABPp-BEyBLzWY2andDXZV6AgkQpnt1sp_rSThy84=qXMt2D8nA@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MDh7u5yUj/lJK6y/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-11 at 21:19:18, Elijah Newren wrote:
> On Fri, Dec 10, 2021 at 12:30 PM Joel Holdsworth <jholdsworth@nvidia.com>=
 wrote:
> >
> > The inclusion of the coorporate copyright is a stipulation of the
> > company code release process.
> > ---
> >  git-p4.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index 5568d44c72..17e18265dc 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -5,6 +5,7 @@
> >  # Author: Simon Hausmann <simon@lst.de>
> >  # Copyright: 2007 Simon Hausmann <simon@lst.de>
> >  #            2007 Trolltech ASA
> > +#            2021 Nvidia Corporation
> >  # License: MIT <http://www.opensource.org/licenses/mit-license.php>
> >  #
> >  # pylint: disable=3Dinvalid-name,missing-docstring,too-many-arguments,=
broad-except
> > --
> > 2.33.0
>=20
> Can we just git rid of these lines entirely?

In the case of the MIT License, it is a condition of the license that
the copyright notices be preserved, so no, we cannot remove them.
Specifically, the first paragraph, which grants permissions states that
they are "subject to the following conditions", one of which is as
follows:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

The other is the total exclusion of warranty or liability.

As for the rest of the codebase, the GPL v2 states that the exercise of
copying and distribution is permitted, "provided that you conspicuously
and appropriately publish on each copy an appropriate copyright notice
and disclaimer of warranty."  I am not an attorney, but I'm pretty sure
that it would not be permissible to remove a copyright notice unless the
code to which it referred were no longer present and that would not
count as publishing an appropriate copyright notice.

However, that doesn't mean we need to add to them, but I will state that
as a contributor who primarily contributes on his own time, I don't
think it's unreasonable for a contributor to request that a copyright
notice be applied where applicable as attribution, since that's the only
compensation one receives for one's contributions.  Such copyright
notices could live in a central file for convenience, however.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MDh7u5yUj/lJK6y/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYbaPywAKCRB8DEliiIei
gVwwAP9Z4vY35dw1NK48VQRdKKDxGF+BLxX/qFxF5iMwSqMZBQD7Bl7pS66SVhbo
3KLb+kjAbwHGJKH+JCPg8JKcIQEk4wk=
=Q9V0
-----END PGP SIGNATURE-----

--MDh7u5yUj/lJK6y/--
