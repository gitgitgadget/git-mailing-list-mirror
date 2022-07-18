Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36A7C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 21:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiGRVtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiGRVs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 17:48:59 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB3DECB
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:48:58 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AA43C5A14E;
        Mon, 18 Jul 2022 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1658180937;
        bh=tJXNekFHmwA6108u3sUhBP2qqlM3pE1rGhAIe5oJqJU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=crR0TIQnPdnoLuLZL6X5XglVZHpVucrGFzzJZzJKU8awBlum9FBy2ugzMhmc2rd/k
         7hF+fgYy5CJuTDjy2F1QzjPBOq5RuEjxh54pBTnV6t20jPRyKFQRJGv408jd+OtF3y
         SqPEa9zFgydU7kxPUKXJE251us/uKxCr0go2yptfY6ZwObyg9P9zfeHMYrulJdNQho
         v0dV9/TwC/1ZQCl2UJPcmX1oiNItu0pDz1GlJUksadczqvWyazNs96TcDoXFAl5TBm
         17GZYF4oI8vzuXX5Uu7YXSwHtHueGKEtfORYVBRxYQmRgDB8KtSsV9I6wbSzoRx5P5
         fh/8uG664gkwuJOHrkusKXpTsulkZ8NloI0Oa8FIP1fDxTHRhvJ/g99+JwqQcPNYO+
         FI8OfKNS03CZ5l2TwZ18fRyTzLE0yWxmkpPhKIaN+3mWJiQHn5e6KCazUgQ5xJ9KHG
         FF3BSIqCWNp/d3syq/HFJFWv27Pkhdv7/P0/SDbH2+GHBHUdEBH
Date:   Mon, 18 Jul 2022 21:48:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Message-ID: <YtXVRgYJsN4ownRl@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com>
 <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="urJHr9CBEhFEVgL6"
Content-Disposition: inline
In-Reply-To: <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--urJHr9CBEhFEVgL6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-18 at 12:18:14, Derrick Stolee wrote:
> On 7/18/22 7:48 AM, Abhradeep Chakraborty wrote:
> > I just got to know that CRoaring doesn't support Big Endian systems (ti=
ll now) -
> >=20
> > https://groups.google.com/g/roaring-bitmaps/c/CzLmIRnYlps
> >=20
> > What do you think about this?
>=20
> Git cares enough about compatibility that that might be a
> deal-breaker for taking the code as-is. If we _did_ take it
> as-is, then we would need to not make it available on such
> machines using compiler macros.

Debian definitely targets big-endian systems and the Debian maintainer
will likely not be amused if functionality differs across systems.  That
tends to add a bunch of hassle to the maintenance process and ends up
resulting in bug reports and a poor user experience.

I certainly strongly feel that our code should be fully functional
across all architectures that make POSIX-compatible assumptions,
including big-endian systems.  I've ported code to make it work on
UltraSPARC before (for endianness and alignment) and it isn't usually
too hard to fix things, so we likely be able to ship code that's
portable.

In addition, we also need to consider that other systems like NetBSD,
Dragonfly BSD, and OpenBSD are not supported upstream, and thus we will
likely need to patch the code anyway.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--urJHr9CBEhFEVgL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYtXVRgAKCRB8DEliiIei
gRP2AP4z4WzQ4oAo+7n/2k6ZYqb3S+1PzWRvOv2cOlr+Z81AvgD/ayce0JRkmsak
H+aJXrYtY5Kkdh1yiEjcEWD023lDXg0=
=HMoB
-----END PGP SIGNATURE-----

--urJHr9CBEhFEVgL6--
