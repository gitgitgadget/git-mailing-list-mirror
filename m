Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B4C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 03:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfBZDWH (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 22:22:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35042 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfBZDWH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Feb 2019 22:22:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:a4e9:9ba4:4fd2:4493])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C156960429;
        Tue, 26 Feb 2019 03:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1551151326;
        bh=xsB3e0QbkWlER3+g0iJJ5+F+ZOFS/0MOuHndXCRbc9Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rAWzovJZ9FaSnR0wdsGIDDvPyVtV1RcuY/T0/wm/bLden2zd5Zo9yzlnVkoEb0qa/
         nKE1e8fnIsE4Niku2CTyrgNAPDrgLxGHiHSV2Nd8Yjcmmcb1n2lWNxexZ49mYH+RYq
         hfWnMf/GR6hGJ5e82JOKGbUa0eHnfbJwj0W1kuf0qUw18fU5vboMZswB0xHgY5pqqH
         4JCEClf+6z8QJYDVXNzPRXP1LQzmbdvL3EqrROzUlj3N0dFvmb9DJRG4fcFuJBLCQf
         cnQejaovk8kcGIb5bDfSeneIQP+tGSWHufG0T36KVVdUK1eSoiOFvjDIsF0Zq8QPRv
         nEOBjboqWJyfNhfx4ksSw6yPPjI/ODUCRtv1FQNzDRpnyYDAuuXSmAHidZH2xruW+Q
         biSxa/HYFPvMDxZVpuKkx+iamloeLPKs/C/7oiPkYef+OkRhW5qsgpNpkLMEcv8oXG
         wDRXaUj+k5Z4ElB/6HHgFYvUswGjmW3lkwXPpq/FtfydeKmygFq
Date:   Tue, 26 Feb 2019 03:22:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] asciidoctor-extensions: fix spurious space after
 linkgit
Message-ID: <20190226032201.GD601925@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1551123979.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <cover.1551123979.git.martin.agren@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 09:02:37PM +0100, Martin =C3=85gren wrote:
> Patch 3/3 gets rid of a spurious space which shows up immediately after
> Asciidoctor has expanded linkgit:foo[bar] if the macro is followed by
> punctuation such as a comma, period or closing parenthesis.
>=20
> Patch 2/3 adds a missing dependency to the makefile, so that the docs
> will actually be rebuilt with that final patch. Patch 1/3 isn't needed
> for this series, but could help someone in the future, similar to how
> already having patch 2/3 would have helped me...
>=20
> Martin =C3=85gren (3):
>   Documentation/Makefile: add missing xsl dependencies for manpages
>   Documentation/Makefile: add missing dependency on
>     asciidoctor-extensions
>   asciidoctor-extensions: fix spurious space after linkgit
>=20
>  Documentation/Makefile                  | 4 ++--
>  Documentation/asciidoctor-extensions.rb | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Thanks for putting this series together. I would suggest an update to
the commit message in 1/3 explaining the edge case that Eric Sunshine
mentioned, but otherwise, I think this looks good.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlx0sNkACgkQv1NdgR9S
9osjFBAAxEmkepGV10HALLNIM6fmn8yYcIvM6VZLq2z6QdU5w14AdNG/mMTe4pxa
EqSnIhRXxR2Tw63Agsq0tytgOHsHPIh37GxfUgl99xek8N+ZwC2IGLA7XzzImm2o
F57RRsKMaEiLUJ7p2itq5pSfg8jvU1jGI7b65ynsA28g4mlSAvVpeHuLqbyRU1Wy
YtDhRmHsAO7ckoJCgk/Wv4fnefdtNAvCGUviSs8j/jw66oo0EEA4Gnt0OXFIt6Y7
lZyDNo1IRc1uPU0EM/7KzruoXQRYalm0StGPn0aoSMf4g6dfMl3Ln/rtZtnUSEvs
Lx6DJSe4NkX14wrb9mjVHkhXS89Jp4L8VM3nRZtvCYNXpRACC4kkl/TS7x6Nl/Ic
rfDlisztEMPm3FG7BqB/FtKOw0fshl7n2Q493jn8xVy3q8r81jTHVAfOIUMQlMmI
q/KcFwAcjJlSGuvZptg2nK2mhDNwO+i3sMNAZVbqi569VYUSFaIaXt3/LSlofETY
qRCWGcPtppTLR3caE/Nqew5YoxHeXGF88HvCHjlFWATaO8r9KLGxKar20KqrN7Cv
Gvmr+IG03ZSNlpFuLXUisC/ZTvb1JfeN6UgEVFU1KUcI6jGXQjPCkXm5q75mdGRb
eiMGHKbnXJ3vjp1oNGwTokSxje5m15K7QxRT/8YuLbYsF+ZrDh0=
=Wavu
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
