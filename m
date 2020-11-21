Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B731C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 22:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5F72100A
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 22:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgKUW1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:27:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45356 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728541AbgKUW1l (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Nov 2020 17:27:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9020E6045A;
        Sat, 21 Nov 2020 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605997660;
        bh=tBj3Jhj3IX68mAk4H91RXnN/zPXQGFX4TtHfs3Bja4w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hN1PLgwlkaBIKfd4nKsySX1nqJv52FCOVx2GJQTlfhGGqwZdRVfQBuAC3Jmy26tB2
         b8BDuNTP4etf9+RisD26S0mZN9KmE9D46ipQpPziLEQJhj9eyibWDyrn9/JW5WJKsP
         isoR27aBwFzxhIsyP9kYJMFaZ1LUYw6b1k1B0zI+iwSp785QbQVWHwqgl+8mjoxZt/
         75lvwiSvcx0y2VhaOL9Ntf3JsJgK2IsIAlbDJTvFOtFcKAIXQbuDiMUpgVMEjr0+ZF
         CzMXuAXYmUCOoAUSJdVgAag5ATvS9OmrC9EZOlJnPlUTXXlN5BlNhiTWkHhHNKmDuR
         tkorLNgXu/mpvlrgiLkerwQncAD6u7dWUKofTwWvU5r+ekJTQyHK0wsi755a3gqFQF
         EJOftCilFB5+MTn700dINAbmIfycH8BOS/FU+o8zVLRx5xDpdyPu/9kqZ3Aj6ewuH0
         W0Jm3fn7JrS3Ypv2xGkslOTqQjnQed4I05nvXKkQOaQdGga73pZ
Date:   Sat, 21 Nov 2020 22:27:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
Message-ID: <20201121222734.GG389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
 <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
 <20201120183903.GA320614@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline
In-Reply-To: <20201120183903.GA320614@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-20 at 18:39:03, Jeff King wrote:
> t1300 is full of this kind of junk. Several years ago, while working on
> some of the repositoryformatversion code, I noticed that we will accept
> a repository that does not have core.repositoryformatversion set at all,
> nor even has a .git/config present!

Yup.  We test this in t3200 as well.  I don't love it, but it exists.

> It's easy to fix in the code, but it causes failures all over t1300. So
> then I started converting t1300 to use "config --file" (which
> almost certainly didn't exist back when most of those tests were
> originally written).  I don't remember how or why it got hairy, but it
> was enough that I eventually dropped it (unlike many of my other stale
> topics, I don't think I've even kept rebasing it forward as a WIP).
>=20
> Possibly I was concerned that people in the wild were relying on a blank
> or missing config being the same as repositoryformatversion=3D0. That will
> definitely stop working in a sha256 world anyway, though, because
> they'll need the objectFormat extension.

Which is exactly why that test in t3200 has a SHA1 prerequisite.  I'm
sure we'll hear someone complain about the fact that SHA-256
repositories have to have a config file, but I'm fine with us not
supporting it.

I should point out that lacking a config file also only works on Unix
systems with a POSIX file system (including case-sensitive macOS), since
otherwise core.ignorecase (and core.symlinks, if appropriate) aren't set
correctly.  It also doesn't work for bare repositories on any OS.  So
hopefully the number of people doing this is quite small.

> So that got a bit off-track, but I think:
>=20
>   - t1300 already is very much like this, so it's not a new thing
>=20
>   - but I would be happy not to see it go further in that direction,
>     even if it means inconsistency with the rest of the script

I agree we shouldn't make things worse.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7mUVQAKCRB8DEliiIei
gTV0AQDEiNYPb4vVokFBTjM8Qsb2rNN6juhZ6mCNGzziP5BivQEApQlyTrcuZdN0
CxLtn6qpJawzOOMPz72L326bU7eqEgM=
=nV/3
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
