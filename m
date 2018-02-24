Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C571F404
	for <e@80x24.org>; Sat, 24 Feb 2018 22:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBXW6q (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 17:58:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33786 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751449AbeBXW6p (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Feb 2018 17:58:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06FC86096B;
        Sat, 24 Feb 2018 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519513124;
        bh=zOA3ThFFQbSihr2KC/IeHXcXygL/IjBSOb8FNHGyezU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ibz2UlvPrvTP9ksQZF92Y6CGBKd32aDwyphNxV2F695mCAWk6454rPM4HIL7kwx+O
         L39uDnYKWHqqqTx7a6NmUVtNJOxqS2fBK3EKurLKds24PN6KDt4BuhXSzJskB9xcVH
         /TQlnpMphXs58C4VvfURBIMZEYZseTD2YfOeRNb74pGBg/2B35XqGPVeGjNVOnYzrt
         P9IYIVX0bt8rb6Nn2x3xqTFbcCPdZcROZY1F/u8UYmQF7SoZyX26iQ6kgYgEUfUs7a
         MXTaFqbn/1a4+FDpoV18vsUF5och1AKrJNkooe+YIrB8HCXbL+V+ysEjM7A4naChJu
         ECpm2Kprl10rl+v93d0UO6M5jOMg3shvcOAzEZyqIVidyVNB/Yx9MXVIe24i6tVg+Q
         Cgxb4q7p2Y9r0B2YsU+rv1fEIVrf9MWaEDtC1milJg8f18WAPF6GYYSiEy8gA5XjkY
         tr+cnL/D/KypQTk7RHYDpMrohx6ZcYT6gSOkwALDKI+q/M4B/43
Date:   Sat, 24 Feb 2018 22:58:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 5/5] Revert "repository: pre-initialize hash algo
 pointer"
Message-ID: <20180224225839.GD4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20180224033429.9656-6-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 10:34:29AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> This reverts commit e26f7f19b6c7485f04234946a59ab8f4fd21d6d1. The root
> problem, git clone not setting up the_hash_algo, has been fixed in the
> previous patch.
>=20
> Since this is a dangerous move and could potentially break stuff after
> release (and leads to workaround like the reverted commit), the
> workaround technically remains, but is hidden behind a new environment
> variable GIT_HASH_FIXUP. This should let the users continue to use git
> while we fix the problem. This variable can be deleted after one or two
> releases.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  common-main.c                    | 10 ++++++++++
>  repository.c                     |  2 +-
>  t/helper/test-dump-split-index.c |  2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/common-main.c b/common-main.c
> index 6a689007e7..fbfa98c3b8 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "attr.h"
> +#include "repository.h"
> =20
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -40,5 +41,14 @@ int main(int argc, const char **argv)
> =20
>  	restore_sigpipe_to_default();
> =20
> +	/*
> +	 * Temporary recovery measure while hashing code is being
> +	 * refactored. This variable should be gone after everybody
> +	 * has used the_hash_algo in one or two releases and nobody
> +	 * complains anything.
> +	 */
> +	if (getenv("GIT_HASH_FIXUP"))
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
>  	return cmd_main(argc, argv);
>  }
> diff --git a/repository.c b/repository.c
> index 4ffbe9bc94..0d715f4fdb 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -5,7 +5,7 @@
> =20
>  /* The main repository */
>  static struct repository the_repo =3D {
> -	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash=
_algos[GIT_HASH_SHA1], 0, 0
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL,=
 0, 0

I'm wondering, now that you have the name field for the unknown value,
if that might be a better choice here than NULL.  I don't have a strong
preference either way, so whatever you decide here is fine.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqR7h8ACgkQv1NdgR9S
9oummxAAnjf6A9VEOj/QO5Et1DGNhzbXyV78y9wu1TKyErIuqlfAJTjBVObHwMM5
LHmErQ7gTypCg/7+cUu21NSbkrjOE6TVDBOdvCgbngf13DqK+daTzTysQzy7wrrB
+QpKM6zhtxHDz1fPIV50i8JTxQUtphW511XosN8L0fOtZFU59VEQKk8wtoI8yHHV
ka9C5m7eP2oaGRkzGtk4yAiTGig7dVyyXy6KqIWa/DmT7vrU3JHuWFL/g5FtHX9Y
+fZXcXgjXzRhJbpNXP5moVaFnOC9HzqjIn6mjUyLA9ng5MUi9UPfw7CKS/megLVs
lKfoVGeD291hJxeqNKS4kbhq6hoVfOGZL/YiNG9PX77pr+S8FZKByCpzO0XXYaRl
DgvGV7e6rxWOLvqUq0c4eGqBcSr5jChwMgqhC4GFxUitiJuHp2ZCwSACICUcH33J
vVhwrLwgWy6GXUutCfazY9ba2R4oqJtyQcgMMofojZ+F/Zg91NzUmj1lgpXs9FfS
AQ8GxNLKrTAqCDUD4Y6KswEi8ZCj9Eyfmu/+c5P+IZsTI0Jl2gIFtdn3OsPt0Qco
gvJ6TiQk3VNhmwQH9PoSurs0iw814DDJ2tkvIFv25/mzZfsDvf/kazYOepS217iG
qBsFbxkht/TufQ98vunY6lFrb+fj39cWsAbKzTJzRXABHuEXV3k=
=4One
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
