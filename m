Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852501F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 01:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeGFBKV (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 21:10:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753439AbeGFBKU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 21:10:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6892760746;
        Fri,  6 Jul 2018 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530839419;
        bh=MlUXU1/it8M883Uv2EiSABVCspQrR3FBBPbhOvT2OSY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MzGLJyXeaQwtXZfkAdd0b2mI5rm7GTQEz8ggBMQnHIEVOsZRc9nmDPbMErhnmBCvb
         LwMK3OZcoKdUkls+Zy3Q/dTgUHzdblz8lTyGfg4GKTKzUeLBDgxjTN4SqHRaL0Regl
         WIWzjHClM1DSOrEqYGI+IRr/gKK/9rNbOz9C89h6DLWPK3VQrFoOcUXNv7RJ5ZdrKp
         s++OYMPivuk1yWiQvVHGZcIDXEq9hpnJZvthgislHJIel9pKO9lHX0iePCQv0INCUw
         rZPUyB6Hg+PBWICnswflmKwKxu3W8vgRS7dNQe5zOVWsz1/1NBbOghrzMxD/evaA9H
         0aTAN47Sjwqxac3eupJm4N8arcbKwjZJJZ+oqOERsMK0avcePo3tGBpHHBLehPqLUp
         lwLgAB+tt8mA7ovFTovt/XpyKFwXNjd7LqpvPi6Je/eMSSjdM01ARZDDL8lbbGl9TG
         YCOZxx/CtuMBttmeldL7lFA419DF7ejS6TnHiKL3PFraxN+I4XB
Date:   Fri, 6 Jul 2018 01:10:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/8] gpg-interface: introduce new signature format "X509"
 using gpgsm
Message-ID: <20180706011013.GB7697@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <1f99ef66bc5e115ec06a3c456658ad54ce405ce3.1530616446.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <1f99ef66bc5e115ec06a3c456658ad54ce405ce3.1530616446.git.henning.schild@siemens.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 02:38:19PM +0200, Henning Schild wrote:
> This commit allows git to create and check X509 type signatures using
> gpgsm.
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  Documentation/config.txt |  5 ++++-
>  gpg-interface.c          | 10 +++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c88903399..337df6e48 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1828,9 +1828,12 @@ gpg.program::
>  	signed, and the program is expected to send the result to its
>  	standard output.
> =20
> +gpg.programX509::

I'm not super excited about this name.  It seems to indicate we want a
level of hierarchy involved.

A hierarchy like sign.openpgp.program (falling back to gpg.program) and
sign.x509.program might be more logical.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index aa747278e..85d721007 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -16,13 +16,18 @@ struct gpg_format_data {
> =20
>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
>  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
> +#define X509_SIGNATURE "-----BEGIN SIGNED MESSAGE-----"
> =20
> -enum gpgformats { PGP_FMT };
> +enum gpgformats { PGP_FMT, X509_FMT };
>  struct gpg_format_data gpg_formats[] =3D {
>  	{ .format =3D "PGP", .program =3D "gpg",
>  	  .extra_args_verify =3D { "--keyid-format=3Dlong", },
>  	  .sigs =3D { PGP_SIGNATURE, PGP_MESSAGE, },
>  	},
> +	{ .format =3D "X509", .program =3D "gpgsm",

Similarly to my comment about "PGP", I think this would do well as
"x509".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls+wXUACgkQv1NdgR9S
9os4yRAAr/u9htAKL8bjz+EQOIit2ijdIP0eDXrGdxUizgbirOm6tK6dxfXWnyEz
QArw4+gy9CqKGX/4aAUg8C2TMjdbzyZ0KhNwCKDJQL7n5giQs+PD6BAx8o6xA5ow
z16+QkqHiHhG42hkb45BNfwcPVUHuM7XxauVOFaWJTA6xeYPZ0G1mafNNlXUEhOH
nutywW2CCOTmas6Sh1VMMVWY2GgI7ljrQJByr7wSjtAGYU4vRNJ2twnb7LA8wpS9
PAxLkFQ0+h9LQ9vzeI0hVFFW0Y6BfJoYjL5CjCIzOtxoTJR/i/k6DXtW7M1hJ29/
t283AISIi9pOX61cePjrC05iHSpS+hjNXi0FlK2CmdSP4hRlj9rhaTXcCsCNo7pw
oANcnAZxnZjpFN6DJLUWl0MpZA3UHppEvBX6bXmVVe8KINPppJwv9zabq2b+UlQL
W7yGuJH575uMEB8JFb4oPlYxamyZQp+9zHUQoMxB+Fz5UE76Ncew4ygNwo0Iqz/Q
q5qmT7M4/Jc+JZEo6h/6SG3G06IdtrSvzpxj2GqbnECDeXQMTDc65bfpsEzN3sab
oGjJ41Z9xcFmeB66FKwwFkzm5mQxjc7ckUAHcyErcW+IOwCle93IYaV5mo7ZnP2Y
ViZRJ/6ML4KPwDTzYg3suhOjnF7O2NhBW2NOCQdro+kirKh8Lno=
=pk5v
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
