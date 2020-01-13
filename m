Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF4C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FF52080D
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sQyNy4A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAMXRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:17:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbgAMXRK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 18:17:10 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69745607F7;
        Mon, 13 Jan 2020 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578957429;
        bh=ee9+pRZQ9aX24BjytnF+IvbjyMHTJ8+UTBD5i0c3GmY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sQyNy4A/tnlBrJU1cqhaM+D7o+vYGkdKsCjGT9+n8v0r98hOjH0h3L6d/u0EK5j4E
         qsuKXydXt1hKJLHYdHb4HuF5Ltclrs3HCJUKC0/mLJVe0JAlbxz9xG8zYmva6bKS0O
         Jse46SGNb9a3iHKRjzjLYNH4RRIRBe25s1AXkZBmoCEu0YE982qk+bPyaDjhY0ES0G
         LY3go0DxG8bmzehkeDI0Y78elDFy6X7Jdx6GY90vVnmINDhI6U2GfVX4bbudvkwT2o
         VNMH1XVM9d29LcinyZYC4g3M/4DdGRr2Mxk5w44HAlKj8GXmw2VuzZgJUABalYEJCI
         MHwrn3Fju559N6FfenKgDFxJtjMqun2XB6tRy87rytii+y60n1qRKAHeCY03rb1nUk
         VqHrRipZh2Dn3YHTUNooRUkyb4nZphlv/sp36Zjeb9l0GxIqLnGEqjPX6mQsLE4lP6
         NhrXYR3668gyutMG1Pq/xN8bmzBv98s1iXkcuXL1NMwqvIMyD1s
Date:   Mon, 13 Jan 2020 23:17:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/24] SHA-256 test fixes, part 8
Message-ID: <20200113231705.GU6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
 <CAPig+cReDPs8D1L3+Z4sMn__JuU-Ezs+fOSF00=_tNxa0DotFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Avw2VvEbzfULB0h1"
Content-Disposition: inline
In-Reply-To: <CAPig+cReDPs8D1L3+Z4sMn__JuU-Ezs+fOSF00=_tNxa0DotFQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Avw2VvEbzfULB0h1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-13 at 13:41:44, Eric Sunshine wrote:
> On Mon, Jan 13, 2020 at 7:40 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I suspect that t3404 also has a bug, since the object IDs that are
> > supposed to collide do not, according to my instrumentation of the test.
> > I'm unsure what the intended collision was and consequently haven't
> > fixed it.  However, it does work with SHA-256 as it stands and is no
> > more or less functional than with SHA-1, so I've removed the
> > prerequisite.
>=20
> The test itself is fine, but it is one of those unfortunate cases of
> checking for absence of something (which is a wide net). As explained
> by the commit message[1] of the patch which added the test, the
> collision occurred only between short OID's. The patch[2] which fixed
> the problem did so by avoiding short OID's in the scripted
> implementation of `git rebase -i` (and also flipped the test from
> `text_expect_failure` to `test_expect_success`).
>=20
> The test, as currently implemented, is very much specific to SHA-1
> since the FAKE_COMMIT_MESSAGE=3D"collide2 ac4f2ee" it uses only produces
> a collision with short OID's when SHA-1 is the hashing function, so
> the prerequisite is correct and serves as documentation (even if it
> doesn't affect the outcome of the test). Removing that prerequisite
> should only be done if the test is updated with a different
> FAKE_COMMIT_MESSAGE which causes a short OID collision when SHA-256 is
> used.

I'll take another look.  When I looked at the output, it looked like
they didn't collide anymore even under SHA-1, but perhaps I instrumented
the test wrong and therefore got the wrong result.  Thanks for double
checking.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Avw2VvEbzfULB0h1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4c+nEACgkQv1NdgR9S
9otl6g/+LScNwQvDGUxZKySjIkCPyXPMj1MsCSKFPXKqeGthCQB5Zl3uyF54XpRH
g/D9MIoSet4a2D3ArUe+QPGnGVbjrzSCPEY0NiXS2Mh/B6XSocx5/aFRER/5A6EF
Z8c1DNVaq0T0BO/kPT7R3hyG6kWHi6FGESA5FP5bvbHRJXAosdS40asOh6rbGgsJ
NfAh9HLEB3J+HAc2OjQXk3I/zF8TUeFGAYfqjo6HceF1mjjDsxZXzlXpq34EcME9
sNBxkRjU6PgIG6axD+1LW4F/dY/Cc2FDFLwelVtIsmtQKcsUrsXB7w8KDoIC+jHb
/cL9SKCcvNF3CSWuQK7W70YE3NdEoWixY5DmAdFTALGFn17pWL5mAyRm6PcDrO1f
Oav08zr197IP+7+0XbBWucsZi0xUe01cESK5BfJDWF0IJBvCW/q0U9aPHmgz7oin
HHpn1OQ0sSw8nJvpQ1ZLWWNn0L1vouKOy6gChHB7h5s4WVeuUwuGR4/SziPHGMcf
HDYWwrzs5gY8kJu4CHPAL9nzXzsouzpsG2XKDkc0vIugv7btMAPLHTgo2D+1DXk+
UNa+JhoXRO0PmPOsijNP5igSi/WrKsFbM2HKq36VBQ/1hsQl2IlqULNkUTGZg4ot
JHT7ze2RiY1VDdXJaeW2R00zj2oFNMPN0rbHS+ejA07h4aQRNmY=
=PIUB
-----END PGP SIGNATURE-----

--Avw2VvEbzfULB0h1--
