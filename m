Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12714C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A7423976
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLHCwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 21:52:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55930 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727881AbgLHCwU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Dec 2020 21:52:20 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC2C660751;
        Tue,  8 Dec 2020 02:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607395899;
        bh=E299gR4976s+YDBHl0r/VZEMDqT6cwoCJwZZ2MC4scc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=c7koEpIA12KctV8Yt/jhA/atpU/FpqGLXX9q6Ht7zoqjBXGnw6epmY20GY97P3uKX
         80Pq3Yc2CC09NqG9FRzXFt2F07/607Q1g4GGYaCLVOeN56Vt0rx0iLrNA6TNb+kKxf
         2/S1QxHbEZ4q6wQMU9XRNH1mXoT7UnF/QwF0qSLP56S9Wy/gud0F4F92l9ISRXSC9n
         0+EzOz9f2eEwCqYQZd2uo/mBZoJkR0owsNvHjTwsdf62+0Wcbvnhvvl1dQmF689Feb
         U1F7YTdgl6Y/s+7LLAkJkbhuOz5n1EsL00j/jBEUpab9bJEdulrtLpklg8mbLbAvuI
         9kMm4+neUAWw328slzdHqeuJxqXBnggpRHNpk/EOXByuRNSE9btXDwl2UJbBcJ4w1I
         2lAHbsuPsPh9H2V3A1con5gp9M+YdJ43K5gXA+HOcl02ygd7eOwipZirqWRSWIyeh8
         ZRaor5nzUTJOYidM327FpHukl9uDZqZifEergoASIMXxjGyZEIh
Date:   Tue, 8 Dec 2020 02:51:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] abspath: add a function to resolve paths with
 missing components
Message-ID: <X87qNTiQDlnzm6e2@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
 <20201206225349.3392790-2-sandals@crustytoothpaste.net>
 <c1d1fe44-6a7d-3578-cd89-9aea59c4637a@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vY1cZ2vexlMIG2kz"
Content-Disposition: inline
In-Reply-To: <c1d1fe44-6a7d-3578-cd89-9aea59c4637a@web.de>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vY1cZ2vexlMIG2kz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-07 at 17:19:32, Ren=C3=A9 Scharfe wrote:
> I find the concept of a "real" path with imaginary components strangely
> amusing.  But perhaps a name like strbuf_resolve_path() would fit better?

I think I'm going to take the strbuf_realpath_forgiving solution from
Eric Sunshine because I think having similar names for similar functions
helps discoverability.

> So the original code errors out if there is a real error
> (errno !=3D ENOENT).  It also errors out if any component except the last
> one is missing (errno =3D=3D ENOENT && remaining.len); that's what the
> comment is about.  This patch adds the ability to ignore ENOENT for all
> components.
>=20
> Perhaps convert many_missing and die_on_error into a single flags
> parameter and implement the flags DIE_ON_ERR and REQUIRE_BASENAME or
> similar?  Callers would be easier to read because such an interface is
> self-documenting -- provided we find good flag names.

As discussed elsewhere in the thread, this will be moving to an internal
function, but I can make that function take two flag parameters.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--vY1cZ2vexlMIG2kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX87qNQAKCRB8DEliiIei
gcyiAQCzAseFPsbvkaNyEfgaGoDacjBmJIrejIHWWqThDPH2VAEAtTLhhZ0BjKnc
dyIU9W0dG2gXxiVy1rJb5UOf2tY0xws=
=SdbK
-----END PGP SIGNATURE-----

--vY1cZ2vexlMIG2kz--
