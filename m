Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99250C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A8F20774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lBBTjSmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHNUVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:21:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41546 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbgHNUVG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 16:21:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 37D1660456;
        Fri, 14 Aug 2020 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597436435;
        bh=DwIgPU5cdhYuKB5X+UKVKtqBXvk9CK7zimHkR7kE7eE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lBBTjSmDTr+GI7eD+Fd7hwxTdfzFGQUMVJE81ee9+5m8cnhnu/epoHh4+45FvOlNB
         hNl92G52NZqEjzuDfNA2e+ecLdwPoXcG/V7OI7eiu6C86p+h3derO8QOfoGSFyQcHk
         T6j2JvI485TTTg4YU0hLu9PQMGTUh/xyGroV1RsNfecy15i+LA3LTBaVEEovS5daKx
         FUPxLzAD98gJeYqWFNVnLhDEZkBd9mT9sD7/LCBwobr1fnp1q5hfyaMQ3sWCtlLKfb
         p1AnDHZETG2GvOsZta2HpnfBnm8CHNisv6EdW/tVgcXiSn4Hn4lh/xf3mwfJvMOyaa
         rnrNhMEU1bCBwlNTaNI9GZYK7v5fEGlWQyCpFHm9WtaOX5inqlvCAOCcz/fX74z3pQ
         GhLLUA/Ioshw84P3DzmB+KDDRwlRyyfo1SCOtO6192sOqAZIFANsZNninzwR3BNeqG
         SFiSrOqNCze+KfVWm9hsYtODovti36q+Ytq8fUSh8QdKa1OuUom
Date:   Fri, 14 Aug 2020 20:20:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/2] Documentation updates for SHA-256
Message-ID: <20200814202031.GM8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com>
 <xmqqh7t5zve0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <xmqqh7t5zve0.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 04:47:19, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>=20
> > Is that really a concern? Maybe, but also Git will never move data like
> > that.
>=20
> I would say that we can safely say that this year ;-) as dumb HTTP
> would be mostly dead.

We do fetch the refs first for dumb HTTP so last I checked, we correctly
detected this case and failed.  I'd personally be happy to let the
DAV-based protocol die, but there are folks who like it.
--=20
brian m. carlson: Houston, Texas, US

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzbyDwAKCRB8DEliiIei
gbIhAP0TGaZxFB9QNgNPXuJnqoCNTNbWP4B/BrW+xxzlM2LjpgEAqFG9R2n8Zvm8
jX+YYop/UYM+/n1zde6uT24oFyApAA8=
=oZsU
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
