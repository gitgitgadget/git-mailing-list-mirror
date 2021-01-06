Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41357C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A12622CE3
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhAFA3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:29:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47192 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbhAFA3X (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Jan 2021 19:29:23 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7185160810;
        Wed,  6 Jan 2021 00:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609892921;
        bh=uA0iRVMMm1nGYUj75D61rSRNsgeEXFov33GwXichPD8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gUBZ/BdLoN5kIm+K1HaLVQRzzeYDfWA9GwsQQsZ5Ibn3iS2J8BXk7/MKShSWp2F0v
         KCT30YVI/OMZzDwS7ZyzMZiQTSWSqgucr/qNBaXUowBwyZ3+6xE2IygG/RVALlmBtQ
         xtEFxLM9BnzxCClhe+18b10OWd8kI3MdZWdDIsxKp7Drad0uyHkhJ8v/LtEyg+YxNF
         67iXYtMpRJvdR5y7VtggMLLvb8y//7DNqmqMPomWYlVyqONQT/SyrQVBMb2UKPfRLo
         d+keG7fVtpsc1IkMPKcDN7XabkAYnVSchzTtsOzFaDWHv8UqbMKKYCq5nM1WU1xAyl
         KlbZkeZKASLhpNiAHPF2Zq0XQbJlvk5nRxA7wA5fUVuHNfp90MPd8i1aBQFXZs4y68
         T4LbDc+AW/4hSJ50kCnm3L5PpnBmnvWDaxpUSN+LGItcPQzC2SK6AnkU4f/nsrH/7e
         xK6DTAEfmmdMR2yiSGReKsxiNL/Qz9icBQkN0PAm4VYBrChuqmz
Date:   Wed, 6 Jan 2021 00:28:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
Message-ID: <X/UENS0EXyFjjjHA@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-6-sandals@crustytoothpaste.net>
 <xmqqft3fywsd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k68mWMkfY0oqe13O"
Content-Disposition: inline
In-Reply-To: <xmqqft3fywsd.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k68mWMkfY0oqe13O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-05 at 20:05:22, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > For example, a person may transition from one gender to another,
> > changing their name, or they may have changed their name to disassociate
> > themselves from an abusive family or partner.  In such a case, using the
> > former name or address in any way may be undesirable and the person may
> > wish to replace it as completely as possible.
>=20
> I am not sure if we want to even mention the "for example" here.
>=20
> These are certainly all legitimate reasons to want this feature, but
> after reading the "for example", lack of a corresponding negative
> statement (e.g. sometimes people also change their name or address
> to hide their bad behaviour in the past that is associated with
> these names) needlessly stood out and made me wonder if we need to
> somehow defend the feature with "...but we do not mean to abet
> people in hiding their past bad behaviour with this mechanism".  I'd
> prefer us not forced to defend the mechanism if we did not have to.

I added it because I imagine the use cases for this feature aren't
immediately obvious to a lot of people and the general rule is that
commit messages explain why we would implement such a feature.  If you'd
prefer I drop it and leave it up to the imagination (or to the list
archives), I can do that.

> > +SHA-1 is not accepted as a hash algorithm in mailmaps.
>=20
> Is this needed to be said?  After all, we won't take @md5: or
> @blake2: or anything other than @sha256: in this version (and
> probably any forseeable versions).  Unless we offer a way to plug-in
> algos of projects' choice, that is, and at that point, "SHA-1 is not
> accepted" is a statement too strong for us to make.

I'll drop that line.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--k68mWMkfY0oqe13O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/UENQAKCRB8DEliiIei
gYLcAQCk1HYrKlKL3Xa4w+4hlYfsS4oFafoksgcmql1SidhpKgD/RMToYnsNkUmr
R8+KCw5fJ9QAplNgZIR4jXVe++ixkAo=
=iXgP
-----END PGP SIGNATURE-----

--k68mWMkfY0oqe13O--
