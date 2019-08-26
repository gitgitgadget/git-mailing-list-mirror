Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E771F461
	for <e@80x24.org>; Mon, 26 Aug 2019 22:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfHZWqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 18:46:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58360 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfHZWqy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 18:46:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E75CB6140C;
        Mon, 26 Aug 2019 22:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566859612;
        bh=3d6+S06peBnsQ0Zm2RZM4GagDzfORgHuRYN3JyfiITE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CIcWlcAre2xfqVV2M7wMGYzPoVQspoc4PLahStgAZakHrVvCxCo+4m2L7BwC48Vwz
         SDUf/paMawnDg+iM5tcgsc9A2NQ+DlYvI8g4FCvsRHJoJ34JZqXGCkHFNL0llQwBD4
         xeHeEAKCMasl8EvVtI2hf0egdxTJiCBtFChFqakc1WjXQ+XHfg06MD9EcVWHEwRyoe
         tb/B1ZVfWST/dou36Qkar27eGpNZZODsW4YobfKcPB6C8OMchv7jCzLf5Tfkun8qjw
         Yi0QxtRjFjVPvgr7m8KiMOALbjNwE44iO5IJPG93qie+jR7RgBiRNz/2aTzB0tbSXD
         rOPyos/BY7bysyygP6DBeNM8jLtJJrfD6665SzjIEvg6trCJXE8MjJJgw8dXc4OCYC
         kDSFPrEA6XhyEiLag8LCu2DhncKkQFyeR58rBWfoWSdMwLqxOdtbWU650pa4y5X9xJ
         Nbu59OkFnpE3ajrZ9oOmvBUyLukhq8RSRo6xCET4pgb7BpR91Nk
Date:   Mon, 26 Aug 2019 22:46:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ibrahim El <ibrahim.el@pm.me>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] Signing API: Added documentation for the new signing
 interface
Message-ID: <20190826224646.GA11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ibrahim El <ibrahim.el@pm.me>, git@vger.kernel.org
References: <ypmMJFfJKsMOkTyunHZWwCKR1v7qaULVMMH7qlGMGN-l06V37iCnXvQLpzkr0N-1neSgCpZAtd1eKzbed2GAxvgMM15rOe-cGRsHzrglV8k=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <ypmMJFfJKsMOkTyunHZWwCKR1v7qaULVMMH7qlGMGN-l06V37iCnXvQLpzkr0N-1neSgCpZAtd1eKzbed2GAxvgMM15rOe-cGRsHzrglV8k=@pm.me>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-26 at 19:57:53, Ibrahim El wrote:
> From: Ibrahim El Rhezzali <ibrahim.el@pm.me>
>=20
> 2f8f82549 Added documentation for the new signing interface

This seems out of place.  Also, your commit summary isn't in the
imperative mood.  See Documentation/SubmittingPatches for more details.

> This contains a model document and updated Documentation detailing new in=
terface and config aliases and their description

You'll probably want to wrap your commit messages at 72 characters.

> diff --git a/Documentation/config/signing.txt b/Documentation/config/sign=
ing.txt
> new file mode 100644
> index 000000000..b6b8b8825
> --- /dev/null
> +++ b/Documentation/config/signing.txt
> @@ -0,0 +1,63 @@
> +signing.default::
> +	The default signing format to use when signing commits and tags.
> +	The value must be one of: "openpgp", "x509", or "bettersign".
> +	The default value is "openpgp".
> ++
> +The default executable to run for "openpgp" is "`gpg`", for "x509" is
> +"`gpgsm`", and for "bettersign" is "`bs`".
> ++
> +The "bettersign" tool can be found here:
> +https://github.com/dhuseby/bs

I don't think we want to introduce the use of this tool.  The repository
contains three commits starting in May of this year.  GnuPG's gpg and
gpgsm tools have been around a long time and implement IETF-standardized
protocols that are mature and have been well researched.  This tool
doesn't seem to meet that threshold.

It should be fine to set up the API such that one could use it if they
wanted to with appropriate configuration, but I don't think we want to
add support for it by default.

> diff --git a/Documentation/technical/signing-interface.png b/Documentatio=
n/technical/signing-interface.png
> new file mode 100644
> index 0000000000000000000000000000000000000000..1a44a7f665d4a546ac6f18fb1=
0208547e6a5fced
> GIT binary patch
> literal 76116

This doesn't appear to be used in this patch, and the commit message
doesn't explain why it's included.  I haven't looked at it, but if it's
a chart of some sort, we usually prefer ASCII art for that purpose.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1kYVYACgkQv1NdgR9S
9oubjhAAtYVc0fxCcrnBV1enTjRMb6GAA78hy1xOi92+BATasp9+QFg1FLMdaWVi
z7lWWb5GwvFwkBtg8Qdm2XO+rKJeKyGJU/DHx3F0uG9iCfSIHr9iG/cMWKsPdGbH
w0tJKKuEZY8JCaYYh9fVyuuOShkOrnFCuprmnzx0fPQYjKI2gUdq7K2c7wrBseMe
2ngCaeit5AGHvE7he1cnR19wRosbZc0H7qsXURE+kQkUc+Es5IXOQgogCKnoufO8
zfFWlpkqb9gh0HP1k77a+PFjMo91SujTg9VKg4epGvWK71pfe/pK6IVJaxiWh55j
RCRLORYlcBfiLAQ5/jASqL+oxf6nk5UaTeaLK7CnUyDEMQ4kKBadJ7PAqwQr5ueK
gvAiphSuQr4P7hWWKOTaDxEW9cQ7B8r9xvChTyZcJNOPvYqxXqfPCIhmJmIEj7mx
KHuLCcmiJrdYANzqDSTf14xsH79n+3hy2Yr9EgRiGxBAi/EptDDBWpPtKKcz6a6u
tyUEpqRI15yd47u5xLO82FRVSd3TFOZ+IhUpG3AO2lQz4eled2iu1yOncqjgV635
wlCP8dxCxj7A0Q+H51abyqYva09+JTbKxvnmez2XdNi31SB5KggTg5EBx09COBsE
DIXy1O1T1qn0mdFWa7we7NSraFVgInGImyLQKNUWaS24YBPG9Ls=
=Xrdf
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
