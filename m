Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20AB1F424
	for <e@80x24.org>; Wed,  9 May 2018 00:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbeEIAOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:14:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42682 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933175AbeEIAOC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 May 2018 20:14:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 444086046C;
        Wed,  9 May 2018 00:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525824837;
        bh=OV7XW6N55ZEsTylXUSmq8bUWhQsmZf+linMtZg7kAao=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YKaLbItJQzw9edc8F3W7RDfqbUW88A+BL5nvPYRnxn3Dz2xC0DN5kTJOlbrgexES7
         TzMrfECMqI8JDJUdbxE9v4NLW0wOfK6hCDKp7+iPjJ9upVWhPK5Au9hd6bZ/eh+rec
         oWhIpECwcA8xFlqwqp+Xg15B9GvZ0CiRPvlT6Nnxjnuf9SgOPtMAp/G8iF+JUTXS74
         CE7EChttlqIaFL0LfMEavJuCbVx100bTSAIqL+tkGI0mEjqmpW3Q+QsbudR5dr30GH
         hpdMzhdiGsp1F8NfiuHyyn0QaxtDBrr1AdSoOGHkz0dIxGRVo13qwIWDGBPFtpqIUB
         X4R78HJ68ABBqSuCG9Ky9lqpP7Pl9yJVZmPFGponFcznFAozUtDGfY7WV+QNJxDUPn
         Rqpigsze5n0h3BGu+vhTdVmVqGgwEDBfboNCai0VMToSExVzr33SxatVhzr5+WpfVL
         JpsKC0rBN/u4w9dQYTpsqUhR/gKkjyLawi6sKI0cNCVSq1lBu1m
Date:   Wed, 9 May 2018 00:13:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 06/28] t0000: annotate with SHA1 prerequisite
Message-ID: <20180509001352.GD275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-7-sandals@crustytoothpaste.net>
 <CAN0heSqu9gwsrgV0rnPe8=vANhBA+Z7fZ3UNTeG9S1QiJBsksw@mail.gmail.com>
 <20180507234058.GJ953644@genre.crustytoothpaste.net>
 <CAN0heSq8EYxVx9Qpb==KgeBVT3AXtgK6f+CQyK_kNUXZHMMnLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <CAN0heSq8EYxVx9Qpb==KgeBVT3AXtgK6f+CQyK_kNUXZHMMnLA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 08:28:47PM +0200, Martin =C3=85gren wrote:
> On 8 May 2018 at 01:40, brian m. carlson <sandals@crustytoothpaste.net> w=
rote:
> > As I mentioned in an earlier email, I plan to set an environment
> > variable for the algorithms in use and then do something like:
> >
> >   test "$tree" =3D "$(test-tool hash-helper --output known-tree)"
> >
> > where "known-tree" is some key we can use to look up the SHA-1 or
> > NewHash value, and we've specified we want the output format (as opposed
> > to input format or on-disk format).
>=20
> My first thought was, can't we introduce such a helper already now? It
> would not check with the environment, but would always output SHA-1
> values. Thinking about it some more, maybe the exact usage/interface
> would be a bit volatile in the beginning, making it just as good an idea
> to gain some more experience and feeling first.

I think your second thought is spot on.  As we move on in this work, it
will become more obvious what functionality we need.

As a note, the benefit of using the prerequisite is in development work.
It's useful to know that all but a certain set of tests pass in the
codebase, because that gives me confidence that Git as a whole is mostly
functional as a result of my refactors.

Because I'm using a hash that may not be the final NewHash, it doesn't
make sense for me to compute translation tables.  Even if I did go
through that work, I couldn't submit it upstream, because nobody is
interested in carrying code for brian's development hash.  A helper that
output SHA-1 wouldn't be useful to me, because the tests would still
fail, and I wouldn't know what was failing because it was broken and
what just depended on SHA-1.

So part of the idea with the prerequisite is to provide code that can be
included in the main project and provides benefit to those that are
doing future development work.  The test helper approach becomes more
viable once we're clearer about what variations we need from the helper
and what hash we're actually using.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlryPUAACgkQv1NdgR9S
9ouyPhAAyQiasr+YPOIONucA7Ndjf4fbFl2v76QjufLWCDoMAU+cpsqM6tx6skhQ
F4zIe7jkoHREACL4R4XaTdlskjNaS4faEdTXVXY1Wcck4mZZhtKT3+pvik9GiL6p
L5dJ1QzMyBCM9qG/qDCpDRjmjMziaRiMbRxL3CF4roZL0TgN96p6kdcAqCraYD5j
KSjIXRq72t3NrrA2Iq1WMSM/edo1+7i113FSC9XWCuVxDgmlAC14lE8F595/ssFD
VMkjp4e5vF6f4Z1HVI6d9ggk8bF/akKMBT7ejFqJ9Qfjko43QrAj2L6ZTP+FJwpb
1CKfhOrCn4pzGh6phHGUUHeAZEpKwOfEuU3z0IyS4S7dRkPfuhbMmeQCEH6avCDw
VzKX26GmmzXCFnMgHMSr5qqbP/GxtD8tgVa9rg9Wf59TMzHr9wkxKLcYvK7CFgSR
i/AGK4RUdb5VQehN72YjQjWAOiphveCbRyFIGY/sEYPL5IYHenUkDbIajg/vc7NO
srCzC/4hbsYwKCPiCFBn5BYK7obnjvgQmE9PDI6mctcwdziOuGQExWce2Q3dsAkx
w7ihZH71B8sqRPsB1OFsaVpBVdNrfZa0blsYOY1Xw7P0SyCTtyluY+jSU/2rQOvY
I44Ma02bHkO+RQi1HBRNq+Lmer5kdxi0NcYnbUp1XRTtl4VW3bA=
=Sl+D
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
