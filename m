Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096C51F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbeGHVCK (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 17:02:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54160 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754365AbeGHVCJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 17:02:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E572B6073C;
        Sun,  8 Jul 2018 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531083728;
        bh=foe+V/2a+owppE5IdQI8ThjLz1GBHS0qtaFRR2Bkcw4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1APZZoWjQ925gdfVC2DREtHomgTJ5zekaeEAowT5CYWBupUZbGS+O1JlBAd4pTlvR
         Syaxi0EigJok5UxF/bty15FrCLmUTlcR9uBq83XxDF4pA3WMTiaN4wFPEdqCE9GGzc
         UxfMBqqy7MLSK8HY+q/H/8uXzqw0+xHfGiStGVrJUKjtNScAOJwtlW7mkchnAhZJ1F
         49CX2PmhPEQbxlF6cVNSz4J/q8IpE81NiRcbToj3+ugSWVTFwvNXAMJR30LFMH5FKN
         b2zfVO05sD4TYv0nOX4oOFYEoJVuvy00ViSnuJdjR+WdtCJK8JjtKqYN7ckUNFoHWY
         SAtgNtCgx0AaZbgWa+zseHgyoufQ7nUKYEInZfrhxCQpAkrAktOswJxOZL1RO962bd
         ks+YqB/YtknPJSLnKkzQ1bGX+F+L4xkOqrQeilzaPmAWBDQ7hTycfM19DPQIncAo+o
         bUiaDR12BN4lTCv2LRp/iQELYJz3rA+3+OgvysUoB9hhhJQbu00
Date:   Sun, 8 Jul 2018 21:02:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Harding <dharding@living180.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
Message-ID: <20180708210200.GA4573@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Harding <dharding@living180.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180708184110.14792-1-dharding@living180.net>
 <20180708184110.14792-3-dharding@living180.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20180708184110.14792-3-dharding@living180.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 08, 2018 at 09:41:11PM +0300, Daniel Harding wrote:
> Signed-off-by: Daniel Harding <dharding@living180.net>

I think maybe, as you suggested, a separate test for this would be
beneficial.  It might be as simple as modifying 'script-from-scratch' by
doing "sed 's/#/>/'".

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 78f7c9958..ff474d033 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -56,12 +56,12 @@ test_expect_success 'create completely different stru=
cture' '
>  	cat >script-from-scratch <<-\EOF &&
>  	label onto
> =20
> -	# onebranch
> +	> onebranch
>  	pick G
>  	pick D
>  	label onebranch
> =20
> -	# second
> +	> second
>  	reset onto
>  	pick B
>  	label second

Should this affect the "# Merge the topic branch" line (and the "# C",
"# E", and "# H" lines in the next test) that appears below this?  It
would seem those would qualify as comments as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltCe8cACgkQv1NdgR9S
9os2hxAApc64jBmI29c7KMg2/gSYiZJfGCdqz46v82smEJGLK+llgK7RaOew6s1q
JWinXTKTBepOLvP4Fs4Ke8sQyYVvat4qg2+citdiTDs1++L3eAKT37y8Q4YX28Xu
qogVa889aXkwmsbImuzvn1A1zZIt0jZk85Vi+jPVSX/j15pa7/1748OG0l2/nj3/
kRKaBVuAlBHxj3I3GOGZhFA3c3DYILNT5m3kl49OHJdBiAgwuOArBMfMStBovy1G
odwIZtDjMTMolg0lG7FkhX3iCBzwsUGEDE5RJ58WqxW9RjGnrFN5GN+pRDbgoeVY
nC3nqbBmkH60vo8r0sd9pc7ndDgi0sOmvQQ6IbQcHzXyL9XPAEvqx+gK3tktcrcx
ZC9i604fA+0D4jRzekBqajkgJMgMYfijq6vLccXxwNZ9XQh7VhyGlxbcYmFvfQmI
gthXEgS6tD5bQTxoQBKSRn1bGRxqvkKZ1kMD1/totmrWWojfoHnIQ9hYMiLxq6s9
BxEgZcY5u8oY9wZjHH82itUvsSKEHl+UKXAyP3ORg7C67npWXahymh9R1zf1Qy/L
v4VpX0SzWywU1FfOQrrdouGjrAEjjkoElhbUWAhpkxxP5I3eP/+yFBemhojf7X2s
i4jhNQXcnDBjkeLk3yQ7asrDxSDadMI79+BE/ugw4u3XS7ETewY=
=kyv8
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
