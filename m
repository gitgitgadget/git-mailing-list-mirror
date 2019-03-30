Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A107E20248
	for <e@80x24.org>; Sat, 30 Mar 2019 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfC3VFF (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 17:05:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730563AbfC3VFF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Mar 2019 17:05:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:cd73:609e:99e6:698f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2AAE560446;
        Sat, 30 Mar 2019 21:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1553979903;
        bh=6hkiNBtHjQoH4lesXGrzk7pQ26bLjJLa7BU+jiReggc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xxoNgdeDuXyGIl+3VZPANvYgDI2iGlvI9Lq9eYqfC9PMxebBNmeAi5Ce/JCO95dJm
         6qa6f3URwIPpB2Wx1JAbTINNIiPmGdTI9PYOhum1M4PVM4p0ifgtmZNNN4GuTY13KT
         VJaB1Bc5qpUOINhMCblUauAYYwgxanovZdKibkDbWoEYBGBAKDOGp9ego8NKxWDIxm
         UnOGQWyQDd+CIvYKNXv+WawJGwoPjOhLgGRirsQlknz5OgQtJH3FBUNy1I0WiGvaJj
         MGjS8aMiJF3alf5xjKzGSplRqF3EiBX9Ckw7INq00aw8tnwCFk99LSoYKqhEwzxknI
         hhvWrkiKcfrYqUb6J7ZgWKF6cRFdF9PGD72eb4cIUydAuYssELHdnvsDy7zyyyWKNL
         uydCin9vf8Y/cGMF2fgnnepp3upGwL+dYzeQptNY/9/kCRADd1DaUgnszDfghC5LvI
         RT9utY8kAESyBsPpN/gGnkcWSpNscqa3+s5wO5wMjMVkQOPoyXI
Date:   Sat, 30 Mar 2019 21:04:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190330210457.GC12419@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
 <20190328000612.GA12419@genre.crustytoothpaste.net>
 <20190330180014.GB4047@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <20190330180014.GB4047@pobox.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2019 at 02:00:14PM -0400, Todd Zullinger wrote:
> Thanks for the very useful docbook5/xmlto details!
>=20
> The hard-coded use of the non-namespaced stylesheets in
> xmlto is unfortunate.  I hadn't gotten far enough along to
> run into that limitation of xmlto, so many thanks for saving
> me from finding it myself.  I'm sure it would have taken me
> far longer.
>=20
> If it turns out that docbook5 causes us more pain than it's
> worth, I suppose we could choose to use the builtin manpage
> backend when using asciidoctor >=3D 2.

I suspect this will be the easiest way forward.  If we produce
semantically equivalent manpages, then this is also a lot nicer for
people who would prefer not to have a full XML toolchain installed.

> Or we could see about adding a docbook45 converter, which
> upstream noted as a possibility in the ticket=C2=B9 which dropped
> docbook45 by default.

Another possibility, depending on how responsive the xmlto upstream is,
is to add some sort of DocBook 5 support to it. This shouldn't be
terribly difficult, although we'd have to disable validation. DocBook 5
uses RELAX NG, and libxml2/xmllint's support for this has some bugs,
such that it will mark some valid documents using complex interleaves as
invalid. Still, if this is the direction we want to go, I have no
problem adding this support.

Since we'd have a quite new Asciidoctor and a new xmlto, distros should
have both around the same time.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.14 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlyf2fkACgkQv1NdgR9S
9oslrg/9HaLQTOQR04hlHH79D+j/ur+AUBHcjky0ZNeU2PopDELLcCC6wR+9Ksrg
x+ja0dfCJ4zMoKOS5yM/3TrV8CP8mA12zDuW9RoHaL0lR/iLeI9tra3FB+k5FOP/
OKGzn2mGlXvshhUvS0/qmwV/ZfbOn2QHK0BD/PXFJd58M/9JaGmoJe9uBV/KWZ2L
gU8LHRSrOBDq+uDcq9t4X9TN/xTN/O/vS59nscj4HASshvVVIBhvyUmSLaz/940S
4sA9A5psnby4FYd/D3SyraURwFX8jnJZ2PTGnFnw8RGX2psPU4+yB3i9WaApvEps
OljxKPqJ5LyOBXq3B/g3FtU4YMv/xgQpPN7ntAv2iiaq2lF3zQGPbRb5zRTL1OcZ
bWuY2S9BiE17aRbsaEHGxu+Avwxu8l8DM2H8cxBABHiu5O5vMokNzqH94+OulRWG
TM6biBcWpjHz2F8GE7+vNzLq5WKRWPfMdbgoYFnGAggIaPMyy0dJj7grpGPOb8oR
ZHaGITJ8umjEu6/gJ/cTkoXEGGDFaHErQrlx5yxiFDcXdEu0KNcghvCo8XxB+5aF
mGIIdBGjIiAPO/9PUzEyg6uS8DusMtKw9zzi5j6rcaRKpcLJ4BMwwLoYUPoe3+fP
EnPGtiovghsAQNs5hQHletpmk7VbCafFsT0q2QORLa/hdewtY/Q=
=zhCF
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
