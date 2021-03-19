Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16322C433E6
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25C064F30
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhCSAH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 20:07:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43986 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhCSAHd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Mar 2021 20:07:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2585760457;
        Fri, 19 Mar 2021 00:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616112452;
        bh=Qst1+G9JILAAZe1KRhJo3mThciixwmP488Y2b8C+Ns0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YkczA7R1/I3P6rmRqPwImzzrO4zWqSWNcF0Vxd922q5XSKZEMtQ4mMB33V23M49c6
         sUYksTCsPVOi25Lt9T1f69pk1EBktvEgbSfFXN9E64L39kIsIzZ3FTgbhOYtz7z+2L
         uNGsRLN1Ov13L0JhyC0JhNyhRB5tgVClmbP9H44NHk4skS+MV5ITQmOUOlkAvSAksG
         d1xlQLlFea7AnyJsaOpSEhl/O0dvH1m6SzN3IX4LOkt88P5BMPxHO9xmxGP5u8iw0F
         O+aOueF6RY5Atl71lu99theAxh4hMERh2u7sOpepIaCYsjDq94slRzkj1ZBsBjzjsS
         jYsS4ti0ednGosxG+DtlqooJSEsGVjTXFWLScHI48sUbeXTtAtQ6/rN46z9//6hzYu
         FZCXbF1SV2rCSrsrHe1imZfYkHnQDbj4MVXjc/MxBCm6fNbGoooIZZyVKc+5Xi69NR
         fgHOhJaX10dgQZnctGbxrGdGRPdceVp8VfpyZt9G3PMYZF1HPHw
Date:   Fri, 19 Mar 2021 00:07:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] INSTALL: note on using Asciidoctor to build doc
Message-ID: <YFPrP/hqTFZQB8jy@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <20210318112339.38474-1-bagasdotme@gmail.com>
 <xmqqwnu4rzw0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s0xycyr1YRaK9Yj+"
Content-Disposition: inline
In-Reply-To: <xmqqwnu4rzw0.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s0xycyr1YRaK9Yj+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-18 at 20:05:35, Junio C Hamano wrote:
> Mention of asciidoctor may be a good idea, but this gives an
> impression that everything between this new paragraph and the line
> that says
>=20
> 	"All formats require at least asciidoc 8.4.1."
>=20
> are irrelevant if you choose to use asciidoctor.  Is that really the
> case (e.g. is docbook-xsl unneeded with asciidoctor)?

No, we use Asciidoctor in the same way as AsciiDoc, which is to generate
the DocBook (v5 with Asciidoctor, v4 with AsciiDoc) and then convert.
While Asciidoctor can generate PDFs with an extension and manpages and
HTML with a built-in converter, it doesn't natively know how to generate
other formats, such as Texinfo, so we need to generate DocBook anyway
and it makes sense to make the two processes as similar as possible.

> If not, then wouldn't it make the result easier to follow if you did
> something along this line instead?
>=20
>=20
>  INSTALL | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git c/INSTALL w/INSTALL
> index 9ba33e6a14..d8e75a7c59 100644
> --- c/INSTALL
> +++ w/INSTALL
> @@ -198,7 +198,9 @@ Issues of note:
>     Building and installing the pdf file additionally requires
>     dblatex.  Version >=3D 0.2.7 is known to work.
>=20
> -   All formats require at least asciidoc 8.4.1.
> +   All formats require at least asciidoc 8.4.1.  Alternatively, you
> +   can use AsciiDoctor by passing USE_ASCIIDOCTOR=3DYesPlease to make.
> +   You need at least asciidoctor verison X.Y.Z.

This seems fine as an approach.  I think 1.0 is probably sufficient, but
I always use Debian sid, so the oldest version I'm confident that works
is 1.5, since that's the oldest version I've used recently.

Debian 9, which came out in 2017, and Ubuntu 16.04, which came out in
2016, both ship with 1.5.4, so it's probably safe to just say 1.5.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--s0xycyr1YRaK9Yj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFPrPwAKCRB8DEliiIei
gfikAQCp8XXjoafPJB+Uh20azIhQQT0ZH8RJqTUbiDDUA8sg6wEAlP/x2juxrVzc
X1JUnryMYjcqHnJV8SVrKaLNfqdf3QA=
=6KWD
-----END PGP SIGNATURE-----

--s0xycyr1YRaK9Yj+--
