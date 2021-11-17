Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A94C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D643A61269
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbhKQXVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:21:20 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:43846 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhKQXVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:21:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 299445B463;
        Wed, 17 Nov 2021 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637191100;
        bh=uMS0w7C7cZmn3Pg6Ael0WAMF772RZSCVWhawl5LClOc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XH+v3vwUULrUYF8WBjHMLszbNe2E7r46/YT14oaRbT76JQGLfxvBSL4JByoB1oITn
         ZBDUsA7PYsZ5YGMD2di+lID2FLwqhDb77TIx9pkypJSMq77b1Xp4biQM0Z9WIEF+GX
         pflGyWNfz43VQKLH3D+osqX6LLWjyHPj8PI9k+v/oCcdvUNtstt0WHmB2QwtSBEzzA
         SLzYcNwtpNqB5KrYbgauJfDJLQxkr+Ss0b2T6nqCGbzkoQ1urYGM+PTXwvw+z5v/4L
         QFQXquMFHXcCiQ0isBpzvNhU3l53kMTnry17uH+uya3ci/Xx4maa+ewDx0p2IWEqov
         z776ySHaobTqo5M5BrrB/cgQd10J5BMji3n5qpXoREReNkwXEINyBE74WazlE/sUAI
         nyjCNzw6j5AvpuMkBBOyFAqF4LI/dTnteI51aBF5QKxOr9VC9yEM7P6MsNVD4exlXC
         Sq7YfSavMsDtcapGi/EBmZsw/Zxwla9qrmb+LHcOiTs3va/ZKJp
Date:   Wed, 17 Nov 2021 23:18:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZWNumAlsek9Gi22@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
 <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
 <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
 <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
 <YZRwpekXlilhOEx4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8W9BxcRuWHh4bQxl"
Content-Disposition: inline
In-Reply-To: <YZRwpekXlilhOEx4@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8W9BxcRuWHh4bQxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-17 at 03:01:57, Jeff King wrote:
> Yes, but I'm not at all worried about breaking our CI. That's just a
> patch away from fixing. I'm much more worried about confused users
> building from source, because helping them is more difficult to scale.

That's one of the reasons I had proposed the current patch, because it
pukes in a very noticeable way with directives on where to look to
continue.  Just using C99 features means that Git breaks in a very
subtle way where the user compiling may not be familiar with C and may
not know how to fix it otherwise.  For example, my previous employer
ships Git, but many of the folks who are doing the package updates are
not C programmers.

> My thinking was that breaking older compilers was preferable to breaking
> non-gnu ones, because at least old ones go away eventually. But your
> other email makes me wonder if those non-GNU ones may already be
> overriding CFLAGS.

Our only problem platform, as far as I can tell, is RHEL/CentOS 7.  That
uses GCC 4.8, and even Ubuntu 18.04 ships with GCC 7.

> Still, if we can come up with a solution that breaks neither (with some
> light auto-detection or heuristics in the Makefile), that could be the
> best of both worlds.

I can move COMPILER_FEATURES out of config.mak.dev and into Makefile so
that we can make use of it.  We'll need to depend on GCC 6 for this
because we lack a way to distinguish 5.1 (which should work) from 5.0
(which will not).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8W9BxcRuWHh4bQxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZWNuQAKCRB8DEliiIei
gYlFAQC7DBBf/Dp93iauLLCEXR4e1ptePO7GsIW7A95mDpsyQgD/XLKUAkhA3Nlr
jOHUzbiyoYlM7UzFOmxDHadvS1yIiAU=
=LwqL
-----END PGP SIGNATURE-----

--8W9BxcRuWHh4bQxl--
