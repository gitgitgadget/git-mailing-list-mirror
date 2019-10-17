Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8FD61F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438377AbfJQWUp (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 18:20:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46116 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388926AbfJQWUo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Oct 2019 18:20:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0E5F96049B;
        Thu, 17 Oct 2019 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571350843;
        bh=3h1YeqBjSUHipN5u6zeB/AwZev3oeUcuAkokDimMXBw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ppGMe7pzPrJe4xz5TM+oxVpy2URRaObdDjj3Ib8ojy+Ih6DfWKYba5v3JZD5lzBfk
         KcMKT4Zvg4JDFztpvmmxkfH3MUEuoaDFCUZOLDMZUvBjs+ebE5gVi1ZwJZkf7cgBeI
         Rf819okMWDNJXsPBuw7N+ov9Ou/HQdCnrHDGxDVWhCoxMO/JGJ+m0yC8zJjRWH1Wiw
         iLuSPcakcmBE8gFUROnuuwXZxUvKaTbw4g7+H+OeO48uKuqNfo20lBcLU/HnEvK+wk
         l4B5GMbdwMYXi73Vg9UOt4AF1CglXLwCmxwAjd08iNrV/9RbrVuFdrGhDln/ZHI1wD
         AU3kPZNLis6xxsrkbbZxjqLUWaPY2QOME4kLDqE8I2w5gOzoa+MpJyrAsCAronK9pG
         0kJVsGLFLeaWSi3/HbFQ6YSvIB2JeYDglwg6j7cL0uSCY/z8r1glKB63T+yC8XeZly
         IJHaih62TTIPEZPxe0PoyECMsCYi4nmCvfy9ELkti7l9qBbtIhI
Date:   Thu, 17 Oct 2019 22:20:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] doc: provide guidance on user.name format
Message-ID: <20191017222038.t2qlqderp44q2m7v@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
 <20191017005330.9021-2-sandals@crustytoothpaste.net>
 <20191017054051.GA10253@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7l5lk3cysmzemj44"
Content-Disposition: inline
In-Reply-To: <20191017054051.GA10253@sigill.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7l5lk3cysmzemj44
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-17 at 05:40:52, Jeff King wrote:
> On Thu, Oct 17, 2019 at 12:53:28AM +0000, brian m. carlson wrote:
>=20
> > It's a frequent misconception that the user.name variable controls
> > authentication in some way, and as a result, beginning users frequently
> > attempt to change it when they're having authentication troubles.
> > Document that the convention is that this variable represents some form
> > of a human's personal name, although that is not required.  In addition,
> > address concerns about whether Unicode is supported.
> >=20
> > Use the term "personal name" as this is likely to draw the intended
> > contrast, be applicable across cultures which may have different naming
> > conventions, and be easily understandable to people who do not speak
> > English as their first language.  Indicate that "some form" is
> > conventionally used, as people may use a nickname or preferred name
> > instead of a full legal name.
> >=20
> > Point users who may be confused about authentication to an appropriate
> > configuration option instead.
>=20
> I think this is a good distinction to draw, but...
>=20
> >  Documentation/git-commit-tree.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
>=20
> ...I was surprised to see it here, where I think most users wouldn't
> find it. Would it make sense in git-commit(1), or in the description of
> the user.name config?

So the user.name config description points to git-commit-tree(1), which
describes these in detail, which is why I put it there.  I agree that
it's not a super discoverable place, since I don't know anyone that
actually uses git commit-tree these days.  git-commit(1) doesn't
describe these options at all.

There are, of course, options.  I can add this text into the `user.name`
option in git-config(5) nevertheless, which will likely be more
discoverable, but it will split the documentation on those into two
separate locations.  Or we can leave it in git-commit-tree(1) anyway to
keep it together.

Since you and Junio think this is an odd place (and I agree), I think
it's fine to separate the text out, and I'll reroll with that change
unless someone speaks up strongly against it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7l5lk3cysmzemj44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2o6TYACgkQv1NdgR9S
9ouT3BAAuwigUF+qcea3uo/CB+qyq2gNCikyiRrFVCoG7r04Rn+SSOOWHNXhGeMa
BrJLuSjKSMX7cCPxGCVUf43x/uheKHzgejGjaUCZ9ieBRTHgJbJTOhkieyuO2wbD
EwOsalu9P46HMNKLUteA9yXZCwl/blUaO326Pm44x5dDX7UWGCR9G9zs4IjhZ3+F
kiDCGkAh7zGEx7pbUiiUrJZwCWnSjg+k/6vBD/eL8p4IkLbYq9MhJKEdbvB1YDZs
szf5piB4lxRNtMBNPl6efkNafaB+90uaFQJttGggc5Ak1WdJmKJUMfQIX3mIKwLl
Q+904b5o26EwEo9QBeEHj//I9eBVHhhonTUHYt77ZQFUmAuorkO17RSTftdHgANR
BjciELMMV1QiK/u0/aT1WjwJx1YAWRg92pirebNiDEKU6/ZOSCc0iXQFbzGmSgOx
NbKn9G7mDYg66zMhG0dCSj+6K+TQKqyxVxJdbt3bd0OB7KNoUnojPj6WmyhSStHd
xAaQz/6wkud9t/hdVHDQGBMBjkwOyvnq3IV7rWY+dC0xIQJ2S1WSDBhdDvLI1Kw7
HnTrkmBLvciA3k6bZYrc/zE8TrQs1HcnWeL+e25IFfNwphG9jpiRJWvQyZYA3tyM
RIjYKasnKr7QMiyAhlybDFAZvg1dnM+kHLTdPiurKLZHzKQSjN8=
=ZKWa
-----END PGP SIGNATURE-----

--7l5lk3cysmzemj44--
