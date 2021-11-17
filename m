Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B55C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C081E6128C
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhKQBrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhKQBrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:47:23 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA68C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:44:25 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BDB255B463;
        Wed, 17 Nov 2021 01:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637113464;
        bh=qeCjAmML9qH+qPCIwCUz3dtQP/zLrNjaCjsQ8TczdY4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OvYr4CS24+bN2zXMdMimxKYZoxrjuE4gNuCkWJp03RYpOc/Px3/sE3xcLeqcGfcNN
         +TSsd9WmlFvSZGo9HploviLnCV48tvOHzPql6Yx+6wr5aTb1YGtDTg/p5dHWRYGoK3
         VFDarPBOB9g2njQwR3OyaScpBP1mQ5xPLpHAnzOkzKMNnMoH6LxKFa380M3ijkHc3H
         3Fq4E8fwVuJKdg1x6O0p/Tkg2xvn7HQqmbp1w+JwjOMoQheUSwjLAwLabOJEABs4Im
         CaW9bghHy0x0Ndv7p4g9zIrujxox6hyAWrdl6UD1Q+NuBeaUKb++QhUTUnomEQVlOW
         DKMn//WYgq0U9q7eGXQRTb4v4wQ5/fDZh/BgaPnzbZa+rf8uvjojuIoKIiOF92CQUN
         Kn9piDbrL7TAD33/ikpHZ8qPIg81zIqMSsHSIvuXRwSirw8Oo2Ua9aWvJ9S+fMJumY
         FFcoiZQ1ayllyeclPgcEC1BVumq1+BliLmdklyNBUhdPDzMVYGh
Date:   Wed, 17 Nov 2021 01:44:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZRedzMSodOYjjPP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RgqSSh5Y3byCkais"
Content-Disposition: inline
In-Reply-To: <YZOh370ZMMqSADUE@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RgqSSh5Y3byCkais
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-16 at 12:19:43, Jeff King wrote:
> On Tue, Nov 16, 2021 at 02:12:41AM +0000, brian m. carlson wrote:
>=20
> > The C99 standard was released in January 1999, now 22 years ago.  It
> > provides a variety of useful features, including variadic arguments for
> > macros, declarations after statements, variable length arrays, and a
> > wide variety of other useful features, many of which we already use.
>=20
> I like the idea of being able to assume C99. And I know this list is
> just "here are some things we could do". But I'd like to express caution
> over variable length arrays. We've already had problems with alloca()
> causing stack exhaustion, and VLAs are basically the same thing. And the
> worst part is there's no way to recover; you just get a segfault.

Since it looks like I'll be doing a v3, I'll reroll without that.

> > diff --git a/Makefile b/Makefile
> > index 12be39ac49..893d533d22 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1204,7 +1204,7 @@ endif
> >  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
> >  # tweaked by config.* below as well as the command-line, both of
> >  # which'll override these defaults.
> > -CFLAGS =3D -g -O2 -Wall
> > +CFLAGS =3D -g -O2 -Wall -std=3Dgnu99
> >  LDFLAGS =3D
> >  CC_LD_DYNPATH =3D -Wl,-rpath,
> >  BASIC_CFLAGS =3D -I.
>=20
> Do most compilers understand -std=3Dgnu99? It seems like we're breaking
> the out-of-the-box build for everything that isn't gcc or clang.

I'm pretty sure -Wall is GCC- and clang-specific, as is -Wl,-rpath, so I
think we've already crossed that bridge.  There are places in
config.mak.uname where they're specifically overridden for that reason.

-std=3Dgnu99 (or -std=3Dc99) is absolutely required for sparse, though,
since it defaults to C89 (at least in CI).

> I understand that older versions of gcc (prior to 5.1.0, from my
> digging) default to gnu89, and so they would be broken _without_ this.
> So it is a tradeoff one way or the other. But somehow this seems
> backwards to me. We should assume that modern compilers support C99 out
> of the box, and put the burden on older ones to trigger C99 support in
> whatever non-portable way they need.

We'll have to adjust the CI job that builds with GCC 4.8, but I can do
that.  I just am not eager to hear complaints from people that it
doesn't work out of the box, especially since CentOS 7 is going to hit
this case.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--RgqSSh5Y3byCkais
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZRedgAKCRB8DEliiIei
gbFlAQCncSNZ/GQDaMRbW8uAoYlgPP/3x9YeGozPnJAz8rHR7gD+NMxNdrZpCNkn
LqQftL33OmkI8pcJXNaediHAKvwF0AY=
=XTFX
-----END PGP SIGNATURE-----

--RgqSSh5Y3byCkais--
