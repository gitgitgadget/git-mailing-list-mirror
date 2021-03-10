Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6553C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8960E64E25
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhCJXdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:33:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhCJXck (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Mar 2021 18:32:40 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A5D3C6048E;
        Wed, 10 Mar 2021 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615419130;
        bh=Bhd8T7cFbRvcSzXecbo9iP8CQhsnK+KRMdcePUFIi7Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Q0itcszwO7hXz6P0ne4LhZ9N15XAL5/RWsPjpIpWpmo/2A6z0M3ahRY+QyTdF2jQo
         ABIToogzp14/jX1tNrcp5x6Hi/I4asfUlOI6FpgECWePRZdLjzslg1rdjK5+W4xUsa
         b8vAlXvO+qoY2ZFB+3o65gwRd+Rl7cl9lLfl1aHcRHTWj+kafwLuB5pFhhb+VldHZc
         FSNS+HkjLwVEaXMmpaXo29z4in1paJXGkR8TsIvcz/Ay64OYsw4dd6FBPhkVlK0Dsi
         weBrUm5SUl+o24a/FbNLekBUPnFNp7tF3fkD/if+m2be7LgESL7VMkUH4BMKP8jA1/
         8HdcDkDBer6eWMXdoHzVCOQveBP2gf8KfYa/KeVlksLnUl1t/1HkQ/p/b/uRJ5QF2F
         JFYbyZSKOudHy22JfZkQnqSctPVtOzGFMgb4nF5/AzX5TtA4xV9whJszL+KGjONBDN
         EY6y2mHsu8HUOxycYDnD9QplrPzhsOcJlNHE2MDRjUBII+Vae+o
Date:   Wed, 10 Mar 2021 23:32:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] sha256 fixes for filter-branch
Message-ID: <YElW9CXsL29zybOk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
 <8735x3i59m.fsf@evledraar.gmail.com>
 <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lFVvyU6bcnqZGm5r"
Content-Disposition: inline
In-Reply-To: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lFVvyU6bcnqZGm5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-10 at 17:06:33, Jeff King wrote:
> It actually does get covered. Dropping that case-arm means we'll fall
> through to the one below, which does _roughly_ the same thing with a
> bunch of extra warnings. But none of the tests actually check the error
> messages, so they don't notice.
>=20
> Here's a series which fixes it, plus extra tests to notice the
> distinction.
>=20
>   [1/3]: t7003: test ref rewriting explicitly
>   [2/3]: filter-branch: drop multiple-ancestor warning
>   [3/3]: filter-branch: drop $_x40 glob

This series looked good to me.  Thanks for sending it.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--lFVvyU6bcnqZGm5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYElW8wAKCRB8DEliiIei
gaYDAP4m+9peA5TSCoJhB4CDBvFABvVSlTWaf36DAzZVehbXBgD+PewmP+aiqatL
c5iijQyi0NBhjCwavE6OwhoaNMBR7gI=
=A4xi
-----END PGP SIGNATURE-----

--lFVvyU6bcnqZGm5r--
