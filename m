Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCABC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D406113E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhIWBnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:43:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46102 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238177AbhIWBnQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Sep 2021 21:43:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 43B8C60426;
        Thu, 23 Sep 2021 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1632361305;
        bh=7xO0zSWjfCs1gNIj+/DnHBUuPTH4bxOeIG8ipnXFXMQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RHd8KaYlesgAXbYlIF1BgRUF0ucQKc4Hofxs0A3HbYR5gBSUmCaUlqzJMS/dv/y3d
         4rdMoIE4zJGV3HBWQRLfSZ7ZmQ+/Vqg66yfAuJvR85kqDBVBIIGPbEUyhi9Ufaf2uK
         Pqm+6F1662tlcBUETV6dPNwjevkOZrGLDBgvqHoG4nJIst0jbwIad4Uhe35eZdkU3Y
         CftHai97T9GCSmp0LfqLr0SB6UBJmc+CsNJf+s8p4YctS3eCgKGZ3i+gw+DPNBTTgZ
         MiNEn76rP9wmJYA2jSUN40JN/WG326ZlzvIBEf/tXQxNLimxJY4wFVh18GfNOawtVj
         rY+2yeLU9sXTXPNGWq/hkNoo6GfJS7pB9euOSJ5De0b9m0zSLb6x30JH3c+HRorVt3
         SAQzXq1IzMrHvLZLRfl+qcDPmjF53AsBi9Sn78AYnh4VAuyya0p3y2Y2Om6zLdnjnM
         fV4Hq6tLiK4+gzp375D862LiIQ3lgPqrdOqRe6Dky7Tk4aSE51Q
Date:   Thu, 23 Sep 2021 01:41:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        levraiphilippeblain@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Makefile: avoid breaking compilation database
 generation with DEVELOPER
Message-ID: <YUvbU9HX6JA+MKd0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        levraiphilippeblain@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20210922183311.3766-1-carenas@gmail.com>
 <20210922185702.4328-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZCiUEiknG1xpP7Jz"
Content-Disposition: inline
In-Reply-To: <20210922185702.4328-1-carenas@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZCiUEiknG1xpP7Jz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-09-22 at 18:57:02, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> 3821c38068 (Makefile: add support for generating JSON compilation
> database, 2020-09-03), adds a feature to be used with clang to generate
> a compilation database by copying most of what was done before with the
> header dependency, but by doing so includes on its availability check
> the CFLAGS which became specially problematic once DEVELOPER=3D1 implied
> -pedantic as pointed out by =C3=86var[1].
>=20
> Remove the unnecessary flags in the availability test, so it will work
> regardless of which other warnings are enabled or if the compiler has
> been told to error on them.
>=20
> [1] https://lore.kernel.org/git/patch-1.1-6b2e9af5e67-20210922T103749Z-av=
arab@gmail.com/
>=20
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 9df565f27b..d5c6d0ea3b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE =3D no
>  endif
> =20
>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> -compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
> +compdb_check =3D $(shell $(CC) \
>  	-c -MJ /dev/null \
>  	-x c /dev/null -o /dev/null 2>&1; \
>  	echo $$?)

Are you sure this results in a functional set of files?  As I understand
it, the reason that clangd needs these files is because it needs to know
what include arguments and headers are supposed to be used, since C
programs don't have a standard layout.  In this case, it looks like
you're removing all of the -I arguments, so in that case clangd wouldn't
be able to find all the files it's supposed to.

Of course, if I've misunderstood, and somehow we get those arguments
elsewhere, that's fine, but I just want to be sure we don't regress the
behavior.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ZCiUEiknG1xpP7Jz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYUvbUgAKCRB8DEliiIei
gZHpAP48TJcrwAPch7WA19jRPbeWh0pAa0OES14nMghyqt1kAwEAp96O5/SAw71v
5dAOXye4qEZTlOYhepjmO2Vh8FOKTQE=
=9MFA
-----END PGP SIGNATURE-----

--ZCiUEiknG1xpP7Jz--
