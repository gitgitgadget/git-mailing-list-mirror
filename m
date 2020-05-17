Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB614C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82070206F4
	for <git@archiver.kernel.org>; Sun, 17 May 2020 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yeWTXblv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgEQUwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 16:52:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38462 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgEQUwx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 May 2020 16:52:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6FAE66045A;
        Sun, 17 May 2020 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589748772;
        bh=Ey6cecPtK8Xdf9qSEQW6BXYExYvYyPQejXlW+URkDhg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yeWTXblvjYJFSrwz2yi1e+w3YbaEDRytEVqvU1Lc9pNrBlngd+vCdt6cI4XFLSTHS
         jCY8DCdYmzq6zhkkXGMNcypsKtk0ogmw9mflwJtnuro33w0cVjK34dfmd9GLSCqhH8
         ey1ooRjoymZXWk5KI3KTEwIn4fkkFYtCMNS5x4mYnYqt5p2vDUGFzEULpDf8Ck8kGf
         gZwEWys1HKEJ16KY81gu7V6A04L3hKUuZ+2SzGNhR8EdsXR194etXILcJc66TSY5uc
         SmFYgv7YJZ9wudfJOo5BpESTQo1UyRFwldzTx3QAKC1OlV2ZczAdueEGOOt/p1OTCl
         55V/s2PLk2XfA6jNJxPwmMALDM4nP/LMjqMBgcVfJDwgHeWCS5h1D4aKJVOr39OIfJ
         Veo7loBP6l71e5UjgIYB5LIbCMIy4RBkLcaY0G8fdUxcA6c7BTZyUNDdlaHwW7SMeN
         rMlngqwQVv61mlod3h++NR9vKqKYjBuN2+FP5Kmhj19lfdvDh5i
Date:   Sun, 17 May 2020 20:52:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 36/44] builtin/index-pack: add option to specify hash
 algorithm
Message-ID: <20200517205245.GJ6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-37-sandals@crustytoothpaste.net>
 <CAN0heSqpqAyKyaz+Er-SppR8k5W=zfw31rLR=Z8yZzqu=BCnTA@mail.gmail.com>
 <20200516204710.GI6362@camp.crustytoothpaste.net>
 <CAN0heSqXSPXG38aqQggxA6yjkg_+PVVdh3M01RQKJM0gO0wAPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <CAN0heSqXSPXG38aqQggxA6yjkg_+PVVdh3M01RQKJM0gO0wAPA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-17 at 18:16:37, Martin =C3=85gren wrote:
> On Sat, 16 May 2020 at 22:47, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >  That is valid without --stdin, if uncommon, and it needs to be
> > supported.  I can prevent it from being used with --stdin, though.
>=20
> Hmm, that might make sense. I suppose it could quickly get out of
> control with bug reports coming in along the lines of "if I do this
> really crazy git index-pack invocation, I manage to mess things up". The
> easiest way to address this might be through documentation, i.e., "don't
> use this option", "for internal use" or even "to be used by the test
> suite only" for which there is even precedence in git-index-pack(1).
>=20
> On the other hand, if we need to detect such hash mismatch even once the
> SHA-256 work is 100% complete, then I suppose we really should try a
> bit to catch bad invocations.

I can add documentation and a warning there.

If we actually verified the checksum at the end of the pack first, then
we'd be able to distinguish the two cases, because we'd try to compute a
clearly invalid hash over the body, and the likelihood of it matching
would be very small.  We don't at the moment, for reasons I'm unclear
about, but it's probably performance.

> As a tangent, I see that v2.27.0 will come with `git init
> --object-format=3D<format>` and `GIT_DEFAULT_HASH_ALGORITHM`. The docs for
> the former mentions "(if enabled)". Should we add something more scary
> to those to make it clear that they shouldn't be used and that you
> basically shouldn't even try to figure out how to enable them? I can
> already see the tweets and blog posts a few weeks from now about how you
> can build Git from source setting a single switch, run
>=20
>   git init --object-format=3Dsha256
>=20
> and you're in the future! Which will just lead to pain some days or
> weeks later.... "I've done lots of work. How do I convert my repo to
> SHA-1 so I can share it?"...
>=20
> We've added "experimental" things before and tried to document the
> experimental nature. Maybe here we're not even "experimental" -- more
> like "if you use this in production, you *will* suffer"?

Well, the option is there, but it produces the following:

  % git init --object-format=3Dsha256
  fatal: The hash algorithm sha256 is not supported in this build.

which can be distinguished from this:

  % git init --object-format=3Dblake2b
  fatal: unknown hash algorithm 'blake2b'

Right now it's pretty broken without this series, so you can't use it.
I mean, you have the source and can remove the check, but it doesn't
work as it stands, so I'm not too worried about people trying to do that
at the moment.  I'll sneak in some documentation for the end product,
though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsGkGwAKCRB8DEliiIei
gWOhAQC1l/8e3+CPU2TzViPpR6ya1tO2dAmfgQkWHzWD/Mx1ugD/Y8jrl0A2J39N
lzF9HTUGvJKmUg0agRqI0hhE8Tceews=
=Wijn
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
