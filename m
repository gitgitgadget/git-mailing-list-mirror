Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907FF1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 02:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfJaCb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 22:31:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56866 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfJaCb6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Oct 2019 22:31:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AFDA26052F;
        Thu, 31 Oct 2019 02:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572489117;
        bh=j/ZLglkfkSNZngc+GKOCJ2nHX5++vJV2KibzbWD3fjk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Bd0nxUe2cvUPRoKrUJ4tTtBpxdK3vYguM/FcOvAv+7ymzpgpbI5sab9CD8A71S61S
         C0jrSlOixLN3EsnNx4pXDOPJ8VyXeFDB4uQhdU/Q56/jy9+IoOspXNgcPccMx849gv
         fV4VFqCt+uApv3pBAWIRkcklnQTymhpPcNpXJE5kqirBPvKHEWIC4+uk9RB9brFa9I
         LqA1ZMZhLg9psfyC+2bReB1tZyTo/enpfxBK00w90DXKxZ8COmYio0qNC4adhs7/0v
         086ss8OA2bUulEkQtIzIILpIaDF7LvAoTn6HtLGUIzRCt9YFJi9VQpRidtUt4vfQHt
         GhdO026E9Ow1UgPFfZ4M4aTkkC9Gm6+l7HrJ8UAlGCmVsOQtx3p1XemHB43BK9tAZH
         P3Bg+GfZifEwlXKv77ZR7QWUmSFYvHEs4enYnnczN+ASVn2TPUHGouS4hFqG0zJgAg
         ALapzUWyuVIu4FBjNu44V1lRZDZcHZDJfrA3VIy6qab2YrJGjVb
Date:   Thu, 31 Oct 2019 02:31:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] manpage-bold-literal.xsl: provide namespaced template
 for "d:literal"
Message-ID: <20191031023150.mdbj74sthrftnqie@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20191030204104.19603-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azgdk4usaq4ki4vc"
Content-Disposition: inline
In-Reply-To: <20191030204104.19603-1-martin.agren@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--azgdk4usaq4ki4vc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-30 at 20:41:04, Martin =C3=85gren wrote:
>  I've kept thinking lately that "wow, are we behind on marking up stuff
>  to be monospaced/boldened"...
>=20
>  I'm pretty sure about the background here, but I'm not at all sure=20
>  that this is the prettiest or correctest fix.

This fix is correct.  Thanks for sending a patch for this, and sorry
about regressing our bolding behavior.

> diff --git a/Documentation/manpage-bold-literal.xsl b/Documentation/manpa=
ge-bold-literal.xsl
> index 608eb5df62..172388d6cf 100644
> --- a/Documentation/manpage-bold-literal.xsl
> +++ b/Documentation/manpage-bold-literal.xsl
> @@ -1,11 +1,20 @@
>  <!-- manpage-bold-literal.xsl:
>       special formatting for manpages rendered from asciidoc+docbook -->
>  <xsl:stylesheet xmlns:xsl=3D"http://www.w3.org/1999/XSL/Transform"
> +		xmlns:d=3D"http://docbook.org/ns/docbook"
>  		version=3D"1.0">
> =20
>  <!-- render literal text as bold (instead of plain or monospace);
>       this makes literal text easier to distinguish in manpages
>       viewed on a tty -->
> +<xsl:template match=3D"d:literal">
> +	<xsl:value-of select=3D"$git.docbook.backslash"/>
> +	<xsl:text>fB</xsl:text>
> +	<xsl:apply-templates/>
> +	<xsl:value-of select=3D"$git.docbook.backslash"/>
> +	<xsl:text>fR</xsl:text>
> +</xsl:template>
> +
>  <xsl:template match=3D"literal">

If you want to avoid duplication, you can write the existing template as
follows:

  <xsl:template match=3D"literal|d:literal">

That will match both literal and d:literal tags.  You still need the
namespace declaration you added, of course.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--azgdk4usaq4ki4vc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl26R5YACgkQv1NdgR9S
9ovQUxAAk/AQihYM84WSiZzH7Dyvrc8elmtXlK+8fegXIlYSxmSiDiVcjTP4PfMM
Nhvvb8gDNwSBm8o8QBQ0Hl6ovEQ4zksW1swLy+5CQIfMVgv7YiZAY3bvKsuPO1ca
whzdd8NqzGbZk22Wgf6fzHYcT38bf2kcbXg0TZ0Sc/DxJ9cV8ZAHXWEqBa04CzOD
nud4D4b4DfeprwkjK5xqZb/chCHXwkaSD5F/M4JEGToNvd0aOY/ryiQggGhWlAYi
M68LkotF6KSrnuU1rW3dTItsfHsjJonTlTR1vR48BTg+rFqeoZ3tWyhpXhe+oAw0
5rFvsYfYYGdW9nyxZFcPIDa9IBkmrFkBcsOfr/YFg0BBJ/0rHz9+fZMpg+mDWsAY
c5AmoLpS3ovJr67hrdGbZIZqKONYLwWM3mMhniKIBPhsMVXJMVyBsCdJpC/nye7z
L3n0/ARj/ZnC0EftG3AfV5QLgbmWqbgaqVaO4y1HB0nACBxgRIX1IdfC9HN6roES
siVr9XnurOr7YQjg4kNjsydXIQfQjF75F1HqLjTt8M7wtOoY7QJOPZhnAnIVPJ5w
ZQUUaJZnobO3MkRm2yxummw1jaMnce+UgFqVdOwIC7HhVQB6ajROjWzW1C0W9AUs
wwvedssIeiWC2OYx5KFnixrLSRPkZir3xDVfNogl1JnIf24RY4s=
=tLxL
-----END PGP SIGNATURE-----

--azgdk4usaq4ki4vc--
