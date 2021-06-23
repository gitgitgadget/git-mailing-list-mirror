Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0125C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA776128C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFWCl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:41:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhFWCl1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 Jun 2021 22:41:27 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5057660459;
        Wed, 23 Jun 2021 02:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624415920;
        bh=ag8dBzJdMGit7Or/HWK83mTaB3N1mA4zYFMFyw5eXTU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i9ErC4eaiz4QBNlQHboTRkzHhtUmFgokwy7bGAih96hR1hzgC8Xj/hrrOhWhBNmcr
         VvWdV4R7RvA3Qk0B6Ah538mp+sQgavimjQu/80zdQNdKjVXVFHi7aDVYhOxbmj80n1
         lk3UMpEj36kD3ZgcQ+RkVH+Ptb6AGhahVcom66+r4gjlTDwdfJ/DfP+QHOB17LJJAO
         ci5rBl64lDe3PtS5fYI/jSfHSZvdJpI6PXt0vExLuCp27bS/sXeoZiAhAoBVkxTNcv
         tTER1mJj+hG9OzRImqxEISTgI2PCQgpwJgEhN5xTjHyLR3hI/fW6M0QrgihbX0j3XX
         tek5V/o6kD9rVne8GEbGcan+6w7YdoEO6HXnuf0eHCo0TuolBnE32kjS4COdKke6i/
         F3FjTw4fha/wiL6Ae3iB8bhqI8UIo/z48Xfi4E5L+UZoa6J9Ea6udLYq++XmQJI2Yd
         oiYYDaYawSdJi/O6aIY0Hfi+5LPbZG92deQ3UIF9E6L++Q91DhT
Date:   Wed, 23 Jun 2021 02:38:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tim Hutt <tdhutt@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug: branch checkout is detached if the case doesn't match
Message-ID: <YNKeq5mSu3f0A/5I@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hutt <tdhutt@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
 <87czsg429h.fsf@evledraar.gmail.com>
 <CAKuVd4Bfykm0xe0P5FMy3W8HuECJHqP-RGo+T_VK4hn43sgEpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q+WxFom0kN4hwlrW"
Content-Disposition: inline
In-Reply-To: <CAKuVd4Bfykm0xe0P5FMy3W8HuECJHqP-RGo+T_VK4hn43sgEpg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q+WxFom0kN4hwlrW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-21 at 17:20:28, Tim Hutt wrote:
> Ah of course!
>=20
> > git pack-refs --all
>=20
> Yeah that "fixes" things so you get `fatal: invalid reference: MASTER`.
>=20
> I guess `git checkout` checks whether `MASTER` exists (yes, according
> to MacOS), but git log checks whether the current branch (`MASTER`)
> matches `master` (it doesn't).
>=20
> Very unfortunate, but I guess it's not worth fixing.

I should point out that there is work underway to add a ref backend
called reftable that doesn't store things in the file system and hence
doesn't suffer from this problem.  It's just a big project and it
involves touching a lot of code, so it's slow going, but when it's
completed, people who are using that won't have this problem ("MASTER"
will be rejected if the branch is "master").

You aren't the first person to report this problem in some variation (it
comes up quite frequently); we've known about it a long time, but fixing
it just isn't trivial.  In the mean time, you may prefer to adopt a
naming convention for your project branches; for example, even though I
use Linux and don't have this problem, I always use lowercase, which
makes things easier for colleagues on other systems (and is also easier
to type).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Q+WxFom0kN4hwlrW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNKeqgAKCRB8DEliiIei
gV3kAQCzcgMPvq3/067R4wg1DqBB8Beg7vMFIS5vStRWfDmASwD+Nd94nvydkFmF
lo+ay/kZNDDCwplpzquPI0Ql0uciBA4=
=wnl5
-----END PGP SIGNATURE-----

--Q+WxFom0kN4hwlrW--
