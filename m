Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946521F453
	for <e@80x24.org>; Wed, 13 Feb 2019 00:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfBMALR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 19:11:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728789AbfBMALR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 19:11:17 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 83A2360443;
        Wed, 13 Feb 2019 00:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550016675;
        bh=WmdaXBGR2JttMQ6AXiPhPcQ0cgjy5ZRvEpteXdkRGKU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wX8HHQIfxUpK3lE77FlhGkmL+OXtYpOzHkWseSwZ/s4ZJSZGe/dNWdYdc5pHqJh2D
         p5oUKyQ1dKUnu+y5t2K0C2tEyC9DREROEwFnU/T2H9rCPPS59JcQtqAXRKZNs4Ia+/
         p/cB+X4/3ZVgOsBRK4sd5fAmVoOPES10eb3rxbgu9xA2EhEa9l6N0dCluyVFCDj5kK
         +/8F7oiMB+AUPL1yGfN8OjPLXugUEQJX8Fos+I110RegI6haMPANJyO1kQyE3ENFRj
         w/rB0oNb33pJwYnCI+Gs2LelQTxEZd6ZzNLovKs6b8erU1kpvSgztfoA3X2YTk/nAG
         kO3LwGd16mCx/qcStoO/r4lDNoWolq7wyVtinSPHk6nlRaU+Vq2vS84mJtXN3hDRul
         3FPedmNhkVUCko1QRmRPkOiv9LpCGEu3gwoCCvoWokj4/7D4tcyT6OY5+eMhCiAR9/
         KcCE/luaSdNxIiwkkZJRj5coz0C7g7MZBh0/HEwL+jAJi2LcNyv
Date:   Wed, 13 Feb 2019 00:11:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/31] archive-tar: make hash size independent
Message-ID: <20190213001111.GH684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-25-sandals@crustytoothpaste.net>
 <2a6cf99a-c297-225c-b3c9-c30e1ac83948@web.de>
 <2e0ab97b-2a9f-6820-46fa-ba664c42cd87@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <2e0ab97b-2a9f-6820-46fa-ba664c42cd87@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 06:33:39PM +0100, Ren=C3=A9 Scharfe wrote:
> Am 12.02.2019 um 08:20 schrieb Ren=C3=A9 Scharfe:
> > That command currently prints the pax comment in tar archives if it
> > looks like a SHA1 hash based on its length.  It should continue to do
> > so, and _also_ show longer hashes.  Your change makes it _only_ show
> > those longer hashes.
> >
> > So it could check for all known valid hash lengths in turn, or accept
> > any payload length between 40 and the_hash_algo->hexsz, or loosen up
> > totally and show comments of any length.
>=20
> How about the following patch, as a preparation?
>=20
> -- >8 --
> From: Rene Scharfe <l.s.r@web.de>
> Subject: [PATCH] get-tar-commit-id: parse comment record
>=20
> Parse pax comment records properly and get rid of magic numbers for
> acceptable comment length.  This simplifies a later change to handle
> longer hashes.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/get-tar-commit-id.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
> index 2706fcfaf2..312e44ed05 100644
> --- a/builtin/get-tar-commit-id.c
> +++ b/builtin/get-tar-commit-id.c
> @@ -21,6 +21,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv, =
const char *prefix)
>  	char *content =3D buffer + RECORDSIZE;
>  	const char *comment;
>  	ssize_t n;
> +	long len;
> +	char *end;
>=20
>  	if (argc !=3D 1)
>  		usage(builtin_get_tar_commit_id_usage);
> @@ -32,10 +34,17 @@ int cmd_get_tar_commit_id(int argc, const char **argv=
, const char *prefix)
>  		die_errno("git get-tar-commit-id: EOF before reading tar header");
>  	if (header->typeflag[0] !=3D 'g')
>  		return 1;
> -	if (!skip_prefix(content, "52 comment=3D", &comment))
> +
> +	len =3D strtol(content, &end, 10);
> +	if (errno =3D=3D ERANGE || end =3D=3D content || len < 0)
> +		return 1;
> +	if (!skip_prefix(end, " comment=3D", &comment))
> +		return 1;
> +	len -=3D comment - content;
> +	if (len !=3D GIT_SHA1_HEXSZ + 1)
>  		return 1;

So it turns out I wrote a different patch for this in a later series,
but I like this style better. I'm going to squash my existing patches
together and then rework them such that they're based off yours.

My technique iterated over the entire header, comparing the entire
header, which is much less elegant than this solution.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxjYJ4ACgkQv1NdgR9S
9ou/fA//TCmIuEUzg5Ssl5NSKe0k5LQj6BNt48Oa2M9MvMopIm4xHtQbsvy06W8h
DuqNnBqQNEiw74TAZorF4pIlWxDDliKbps9XWvgYzwqeF7945KDJy3wJCDki/aBi
HwoHzysyjV93k5H1KTQoMB7i+Pugx82Dh78nJfs11kCgt1DXEkQM6RdZhWEJ/ACl
pSoOhFeJqfiEXSL6g5fRIfZCdEQb9JQ/BUPxq2cOkjULes6ufTVy66yryHZFNIkp
rDJspVHMWPZ8r7gIc0eD2AiCOeazN/kCRRluGCDzBBXOp7/GlVoJr57IMmZh10VP
qcydLtYZIANUjbBweT5k9fXVTSKx6p+T4e3jZEz3SdpMHwxzH5LoDkc+bPrIr/hZ
wRQHq8C4J5DmBlLStYXqptdODzrnoVcwWy/nI8I+v7JHJ3nmLvg5MnopyuKus8do
8tOas+Af1A/yC+qZN7UF/O/fP6wtr3cR/kZkH4GBzXo0RhKBRsDGYYOejfzstFqE
IM9omj7GdaLQu4LD39rAyPI6k3vtNSofHnavNwvBvZFFWO+nOOL/mFbO7/9kZ2Tr
EVDMVo4aYQmFgQdF699MeBVuW8cI7uzKIy0ah/DBdsqPMTIZcZE860NDfrjkkHvF
LiTPshXCfTklS1ZZTv5ECVXV4TSeyQ9QMblwbXpSYWvvNt2vwNo=
=5Rcm
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
