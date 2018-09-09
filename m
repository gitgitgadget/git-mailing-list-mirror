Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045131F404
	for <e@80x24.org>; Mon, 10 Sep 2018 03:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIJIDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 04:03:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50936 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbeIJIDk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Sep 2018 04:03:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace9:16cb:2872:156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A9EB60735;
        Sun,  9 Sep 2018 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536531883;
        bh=iyNECqkuvL7LwNZ/0RV8ZcLNH6Z1jBY4orV7RdGVG1o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bhUZl8IdJYJK02SgNvCe1PqykTibzbbXWYIL8iFKDbNMQ8aI5o1UbMTX1IAeGgQFb
         +JFiPB/WzYpBvX31soFcAGHijqiKB/sT1htall6jFS9N1EY5Vc36TTVGuadFhT4PJq
         xyNnBPs94glg57tXwMH537oXaxO2DJlDAWgbK4eWGWJhTDuE0q4FaSvRPz8JlduZHu
         3cUe44PYwmZ2G2LgIdIeN6njms/KBEKdPhDX45G3MpNw+SH6cOQmUM5Vr3+c0i+OlL
         S74LQhRVbdIlZqYbxiySuerJ2pWlVX0mvelwcaBbp/FVfU5cbzACkwgqwRLbEsdC64
         Vc6pWljFGCdM5yw2xvxqRyVws1n8/BAZ/VSwwas7ix36HEZ9/+6a/SRPe0+JUdNW09
         cpgVO+ZzT9VwezqomEnPWgEJ4ZKp3Ej23ZEJRoV3ZF3fPCHzz5AvZcU3x5UT8Ddf/Y
         8gKkhXTrIiT2huy8i/6uMgNBDxpFkZWX7tf/dGBbDzv8iGO7EdG
Date:   Sun, 9 Sep 2018 22:24:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] t/helper: keep test-tool command list sorted
Message-ID: <20180909222438.GR432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
References: <20180909173631.1446-1-pclouds@gmail.com>
 <20180909173631.1446-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KJvkvZqQCzHgjKcr"
Content-Disposition: inline
In-Reply-To: <20180909173631.1446-2-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KJvkvZqQCzHgjKcr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 09, 2018 at 07:36:26PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  Makefile             | 2 +-
>  t/helper/test-tool.c | 2 +-
>  t/helper/test-tool.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 5a969f5830..1208584fa1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -729,8 +729,8 @@ TEST_BUILTINS_OBJS +=3D test-repository.o
>  TEST_BUILTINS_OBJS +=3D test-revision-walking.o
>  TEST_BUILTINS_OBJS +=3D test-run-command.o
>  TEST_BUILTINS_OBJS +=3D test-scrap-cache-tree.o
> -TEST_BUILTINS_OBJS +=3D test-sha1-array.o
>  TEST_BUILTINS_OBJS +=3D test-sha1.o
> +TEST_BUILTINS_OBJS +=3D test-sha1-array.o
>  TEST_BUILTINS_OBJS +=3D test-sigchain.o
>  TEST_BUILTINS_OBJS +=3D test-strcmp-offset.o
>  TEST_BUILTINS_OBJS +=3D test-string-list.o

Thanks for fixing this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KJvkvZqQCzHgjKcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluVnaYACgkQv1NdgR9S
9ovdfRAAxNTR2mwC/qO7Ri2AYGBvlEswrxBwRVp19MtRK87VKLVM9fk4eanWFeE4
tNm3Nv8ip1gbsWOA4GE5ELgN8TpSMIWYcgzHhYtSsDkftHLM1h7CGKdEWvX/+6Qw
pKxPu0LLQL7sS+kazNEQ3aFaLwWOAh84QF7ri+0XJwfBVoYx31UcwhyMl/9YueCo
t2CqgilpQkViy77F+8sZfKjg83HI1m1yub7x3c8F9JOy1uYTUXrJLmupMCyg3O1a
L6d2BcLRvDpdErrAWqOB4BW570R+Tfy4AvX/mEhaPRrUgyWKsRDRc8AHNBmVTYn0
bdauqiwOOneSxI7n6wi5iJHEwXlrimxkNr6a5VuGGHpV4Z5etuLhTvQWTrZ2fupI
Q3+Xyx5qgmZTyZYtOkq9gw56ap7VMfYIo/Nrdmvox60AmC/oEub1vNdTVtAV0fjx
LWTl16tNbMMXmJ2mrBbz/w3sX2Mh6CbiwYWxRIrbiY4T9oOplxGqe1PEUYH6L4MB
fhNOyz2B2jYsAT3WZksIIvNmLHENnHYP3chij//3B6fui9yjO9XCe3nFACdWoUBx
MgTIJbZKRZvilMOheJWB1OsPE0xzmLQ6NZ26MhTjbi8VvY0fhGEHBOk7YuDKeCnb
5sYGf2K/s1qBuL7E1WcuwBiQ9BiIP15/g6WfhpbTQqvQvHcJ0Fk=
=4F6J
-----END PGP SIGNATURE-----

--KJvkvZqQCzHgjKcr--
