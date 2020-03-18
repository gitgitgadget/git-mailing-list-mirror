Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718D6C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 11:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9EA2076C
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 11:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gtxSKNpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCRLWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:22:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgCRLWV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Mar 2020 07:22:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CEE416049C;
        Wed, 18 Mar 2020 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584530540;
        bh=nKH5V4JT+3rwGZu+8cMkZqv61ouxOGEVSUtIJs85Rbs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gtxSKNpNwpDr/s+c7XbOztqYMEjjbEjfA4CoqIOU3wVSeJII2UEVuHV4HUMUD2jhR
         DB+ctHmHbTxi+QYHlFhtrYvm5x6T9ANtTKUUe9cbvmwHnhEGIjvt58r4WArCpmk2sH
         AbnF0Qy7qaagdtXfv4yff1gVvfOqoQRwsCdTFM1IoKm0sEPy6PvRLCJ8ErmZh2J8jA
         QvpANt1BlRymW7+efvYflMydGuvtUtG2ZzlYbp/LcoA2Wk4aJlLngj4EZX0OOB8bm0
         BRxqpPIU3hgbOMNHaWne7AMMGkVpL/xTOdWGkyMMEyQKgRlrA2RE/E5+PMakACoL+N
         YNcKetsUjLGfaQPyce6kRb1iNh56fnV2wAISZetkSOk7Hz/bTAxdwY+p++H4J4I/Or
         pJ71tx/RqntP2PbWp1nmr2waykZSLxfQQp18/jlBTS7U3gWFOxdltyIoDrD1+qO56o
         hkwgT7hIy6U1R5ezgWQTLXOEVFU2L1+Zr8Xmfb78UAdUno4OAFs
Date:   Wed, 18 Mar 2020 11:22:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] configure: respect --without-openssl
Message-ID: <20200318112213.GB366567@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1584516715.git.congdanhqx@gmail.com>
 <c08bf880c77b7c43256a275e1102308a829d0ee8.1584516715.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <c08bf880c77b7c43256a275e1102308a829d0ee8.1584516715.git.congdanhqx@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-18 at 07:38:02, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  configure.ac | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 7468eb6bc8..20a11e1f32 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -544,9 +544,15 @@ GIT_STASH_FLAGS($OPENSSLDIR)
> =20
>  AC_CHECK_LIB([crypto], [SHA1_Init],
>  [NEEDS_SSL_WITH_CRYPTO=3D],
> -[AC_CHECK_LIB([ssl], [SHA1_Init],
> - [NEEDS_SSL_WITH_CRYPTO=3DYesPlease NO_OPENSSL=3D],
> - [NEEDS_SSL_WITH_CRYPTO=3D          NO_OPENSSL=3DYesPlease])])
> +[
> +if "x$NO_OPENSSL" =3D xYesPlease; then
> +	AC_MSG_ERROR([Disabled OpenSSL is required for SHA1])

I don't see this in the original.  Wouldn't we want to fall back to the
default in this case, which would be SHA1DC?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnIEYwAKCRB8DEliiIei
gasfAPwP2tVSGPlbRZEge8zlqg838f/7Gdi88AVwoLkeWYURNgD/ZaQ+7kslc03W
DJ4uNMrNVLTyGOkdYNhSVkvulDNsDQ4=
=3Sa9
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
