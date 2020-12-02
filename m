Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA0C64E7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 00:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABCA20659
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 00:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgLBAmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 19:42:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51868 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbgLBAmJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 19:42:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8B886042E;
        Wed,  2 Dec 2020 00:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606869687;
        bh=o389LNQYZGdQdYqaORYbOxCvwY1IGbcx5GAWhPzDNqc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AxJXFn9lYXTi/v+B0w5h7FTq9PY/bm+q6tavmD2xxpp/3vUXlQmLGOQ/m99XAjw+l
         l1pBIALl+iMZGbSBjz1lgwAAASgSeosBQYUx6yoNY/Siqlrl8mQtTHjSnIJdUNReMm
         4/GCdjqLcIJRA3xh2Nb9vucgk0vsOUpDTr9KLqyaz1bIjZC783KVi5a30gKU061d2B
         i19oCEf5uJ1v8zob9hmjwN7QrollDJhTu+KMdrig+jEsXrSMqsyE//VcQqRrKwBbpe
         bkYRyoeT2DlnIQ5mNTU+T6fniE/qb+tuwont/uzS/YSHbf2oIzXpuBg4VGCpWxEIs+
         /We3fIfGZ9bTucypwuwVaZMdy2MTSuZfDx4LCgLTb6OVCc+s+Ox6EEjLuQMfdveA8t
         iRVOToSsjndyYHYTBj8Z5s9xZnNIt8bW4d4gSnJCNfQ6ZiruS6+OUK1rvDlbmpgxku
         rVTzYn+XSXif1Y2iKXOzjwJVV6RdVg5yUrnEVV1goNK2WtxZh7/
Date:   Wed, 2 Dec 2020 00:41:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arnout Engelen <arnout@bzzt.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <X8bis7ZnU8FViHjk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org
References: <20201201095037.20715-1-arnout@bzzt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W557ItFGdSmBDCqs"
Content-Disposition: inline
In-Reply-To: <20201201095037.20715-1-arnout@bzzt.net>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W557ItFGdSmBDCqs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-01 at 09:50:37, Arnout Engelen wrote:
> This makes sure the generated id's inside the html version of the
> documentation use the same id's when the same version of the
> manual is generated twice.
>=20
> Signed-off-by: Arnout Engelen <arnout@bzzt.net>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 80d1908a44..4d1fd5e31f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -380,7 +380,7 @@ SubmittingPatches.txt: SubmittingPatches
>  	$(QUIET_GEN) cp $< $@
> =20
>  XSLT =3D docbook.xsl
> -XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css
> +XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css --=
stringparam generate.consistent.ids 1

I think we'll want --param here, not --stringparam.  This is documented
to be an integer, not a string.  The difference is that --stringparam
sets the value to "1" (that is, a string with a single character)
instead of the integer 1.

We may also want to wrap this to the next line like so:

  XSLTOPTS =3D  --xinclude --stringparam html.stylesheet docbook-xsl.css
  XSLTOPTS +=3D --param generate.consistent.ids 1

Otherwise, I think this is a valuable change, as I've mentioned
downthread.  I already use this option on my own projects for the same
reason.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--W557ItFGdSmBDCqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX8biswAKCRB8DEliiIei
gTdjAQDnuhpBY65mRM6XYccPyI10g2DWtF2XooLaKCRQ9k/XwgEAmHgGy7T60KdG
DFl7aKgUwYkVCCWtMoU6/zIQF5F5XgE=
=k/I1
-----END PGP SIGNATURE-----

--W557ItFGdSmBDCqs--
