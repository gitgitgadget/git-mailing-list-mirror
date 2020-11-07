Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E5DC388F9
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 22:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DBD2087E
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 22:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKGWsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 17:48:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgKGWsX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Nov 2020 17:48:23 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 675C66074C;
        Sat,  7 Nov 2020 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604789272;
        bh=Qvc4ZEEm0NISxhvPF9C9z06zSjWmwvUDQxRQzAPL+KI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zC6z1QOJxN8tCMmetqcerExU6HK4AwiruZMGRx6tSPC9jVPYyRy6dMns6PVXy16Fq
         6GltGGpymTH80vPoyzlr4cMSjTsQyKi5rbErTuRTisuIHBf9rhzk+yqRCZAiSezAfy
         +x5D6r6zJjJR0LXXbWNNkpIFliPsAxLTDE7MWO+7X/VIEHe5WpilKDdHekGVlHMEjZ
         QTNVoLLN66hA5PKbVNyf9AafYeRVc76s+PG7UFKSpGN2mfF2uWUN22ho42hnAH73tB
         Vd/03eLF9iYepJqsIAT3Xs2hKoTzy6WQmjj1dCGFMH6Ik7dxWOpRLSN9EJ/rv+L3Rs
         4Ukji+1v/I9r6cKQmQERVSNqMyvQeLTqq+5xnIJhvqSmdXFpn/oMFEHcVt1nDl/Ppq
         DD+ynvVdjPgONcf530oVOgZyWaIUA5nDftWHTH4QIVHkilz9ST7Z1iN0jiugEtBP2r
         zT7AXjFZMyfVytlU35xpoUaECKEeK/V8WfNbjzL3yJzM6lF1NYl
Date:   Sat, 7 Nov 2020 22:47:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Gurney <dgurney99@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] compat/bswap.h: detect ARM64 when using MSVC
Message-ID: <20201107224747.GF6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201107221916.1428757-1-dgurney99@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <20201107221916.1428757-1-dgurney99@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-07 at 22:19:16, Daniel Gurney wrote:
> Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
> ---
>  compat/bswap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/compat/bswap.h b/compat/bswap.h
> index c0bb744adc..512f6f4b99 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
>  }
>  #endif
> =20
> -#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defin=
ed(_M_ARM64))
> =20
>  #include <stdlib.h>
> =20

I think this is fine as it is, but I have a question here: why, if we're
using MSVC, is that not sufficient to enable this?  In other words, why
can't this line simply be this:

  #elif defined(_MSC_VER)

As far as I know, Windows has always run on little-endian hardware.  It
looks like MSVC did run on the M68000 series and MIPS[0] at some point.
Are those really versions of MSVC we care about and think Git can
practically support, given the fact that we require so many C99
constructs that are not practically available in old versions of MSVC?
If not, wouldn't it make sense to simplify?

[0] Wikipedia does not specify the endiannesses supported by the MIPS
edition.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6ckEgAKCRB8DEliiIei
gXa1AP45NqPGYG0Ih465brKowHqAKlVnEolXhz0qsOGO2rth3gEA1HTpHBKObSo/
+xFG3o+ZzioTeoFTlPwq+Z/FRt8SdwU=
=+bn7
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
