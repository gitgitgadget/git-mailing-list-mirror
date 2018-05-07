Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A6E200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeEGXaH (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:30:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41980 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752719AbeEGXaG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 19:30:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2474460444;
        Mon,  7 May 2018 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525735805;
        bh=0ZIuUsZlhcpahU90jjdq0zWScAcKqcSw92YUpH/0mHY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=d+MuMdc2hwSIHtfOLvMkZNs3OOPfv76VCHkAfxfbOiJyanpzrq3KMOMRWy2s2mdoS
         ZsoFfDz3TuMRKWHw6pZRWNGw17DEKvEbEtqNy0/kMk2JgqkSOqi7V56p+qveVq7MjG
         KmFhbPyt7Cs03kqNZMlEw2WpBlQZjP3f6Mk39zufuhmpeoSC9ZFHy+PVeFkszfnMrE
         RfhEPQrQRQ6ca6eKxiwLxsN2QyeOAh7XJumf6hJ0XFV4obrN8Dc1JnojmNW1oyvDK7
         DVTelEG+0zjoW/ZkCoi9T87Rvg/0D2+hmRCo8Zh1S4d6+KwNL397k9aC2vZW5XGLzg
         8sy4DJwArWJ5Xm7TbUnF3FVnvVygqkz+1mWOS4PxL8eTHLi9IVB+N8jsB61dZH/Uer
         GGBmcrtZm30jxaAGHs1nfxTRKLP/McdctyvbaxQCcGTkkKTakb7KrR3kb5yO95xPFF
         aTPmXpUfH0XAeavNp+7OOa0Ozy2vXUkOEmXx87MpPpXntQ4PZ81
Date:   Mon, 7 May 2018 23:30:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 01/28] t/test-lib: add an SHA1 prerequisite
Message-ID: <20180507233000.GI953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-2-sandals@crustytoothpaste.net>
 <CAN0heSqk0siv4y5BGz2+sLhAyNG=TEZmgucKoCDGyx2i8_O+tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Content-Disposition: inline
In-Reply-To: <CAN0heSqk0siv4y5BGz2+sLhAyNG=TEZmgucKoCDGyx2i8_O+tQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 12:10:39PM +0200, Martin =C3=85gren wrote:
> On 7 May 2018 at 01:17, brian m. carlson <sandals@crustytoothpaste.net> w=
rote:
> > Add an SHA1 prerequisite to annotate both of these types of tests and
> > disable them when we're using a different hash.  In the future, we can
> > create versions of these tests which handle both SHA-1 and NewHash.
>=20
> Minor nit: s/can/can and should/

I agree with that sentiment.  I can change that.

> > +
> > +# SHA1 is a test if the hash algorithm in use is SHA-1.  This is both =
for tests
> > +# which will not work with other hash algorithms and tests that work b=
ut don't
> > +# test anything meaningful (e.g. special values which cause short coll=
isions).
> > +test_lazy_prereq SHA1 '
> > +       test $(git hash-object /dev/null) =3D e69de29bb2d1d6434b8b29ae7=
75ad8c2e48c5391
> > +'
>=20
> So SHA1 means roughly "git hash-object uses SHA-1, so supposedly
> everything on disk is SHA-1." I could imagine one or two different
> meanings: "Git was compiled with support for SHA-1 [oids]."

Currently it means that, yes.  It may specialize to mean, "git emits
SHA-1 output, regardless of the format on disk."  See cases 1 and 2
below.

> Do we actually need more SHA-1-related prereqs, at least long-term, in
> which case we would want to find a more specific name for this one now?
> Is this SHA1_STORAGE, or some much better name than that?

We may.  The transition plan anticipates several states:

1. Store data in NewHash, but input and output are SHA-1.
2. Store data in NewHash; output is SHA-1; input can be either.
3. Store data and output in NewHash; input can be either.
4. All NewHash.

At this point, I'm working on getting the tests to handle case 4, as
that's actually the easiest to fix (because if things are wrong, the
code tends to segfault).  Case 1 will be next, in which case, we may
need SHA1_STORAGE or such.

I plan to make the SHA1 prerequisite go away or at least be far less
used in a few releases.  Once we know what NewHash is going to be, it's
pretty easy to write tooling and translation tables that do the
conversion for most tests, and a test helper can simply emit the right
output for whichever algorithm we're using in that situation, whether
that's the on-disk algorithm, the input algorithm, or the output
algorithm.

> I am thinking for example about a repo with NewHash that gets pushed to
> and fetched from a SHA-1 server, see hash-function-transition.txt, goal
> 1b. We'd want to always test that SHA-1-related functionality in git.
> (But only until the day when someone defines a prereq such as "SHA1" to
> be able to test a git that was compiled without any traces of SHA-1
> whatsoever.)

I anticipate that by the time we get to that point, the SHA1
prerequisite will be long gone and can be reused for that purpose,
should we need it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrw4XgACgkQv1NdgR9S
9ou+hxAAmSnTpAvaDfV65dT1xqK+P2g7HHcEfujRUl6adIu3m5/wrejFn4rcCDdU
gdwP+SI0JYU5NeIvbVnkOBZV7nzxW+SPoOeo5fNuKj7rkI7tZm2tpgRkZ/eh9T7a
5Rwr2F8yzg8fPYykOU0ObpdQL3cOlQyb/kX3PGAUyr9b4x1uLt1TthI/k2yzriy7
kTGOynCX/Hf3xpgA4V2WQP396OgM+/hNbVsjaVfgZfePgoslHmaTauXVFUS64gyC
Wv2KCuG+A/BUeEmo9W+H3JL/ai1opRqNM6pHZXQZ7DZ1TAhracrQDsefd8wlAT74
g98gim5ohhVfx39rclJNxM4CryUT3jnLvNTnG5hYKvCTYZQ9Uz285wYPEtnKvSAc
1bnaEFtOYmVl39hkd6qDkGVvl6K4LW0UzFR8qHViCl3o/uLsii6SI0KNhkL1upiW
GNKC+REdSHxu8jxBm0LkyRN6M7fH5QLWXd0zlu/U85HYzUm51oSqgdNZ/LyGs2na
Pe0gGWYTQBH+kytGgjQGYaqr0g0+6LC0K66dQyvWKXbtov2IEdw1OG50G2Bw4Rbe
8VqvpONneQeZcM7/OyDQJT5J5yZmbAfU/wgADGT3IY91czThcyUVSqDnTJVMKr2a
nePtx9oG9yExJNUNfjc+gJIbVj5037IGET0AoyAS6LYrUO25tRo=
=L/Lb
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
