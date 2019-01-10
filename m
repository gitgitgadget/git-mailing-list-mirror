Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D441F803
	for <e@80x24.org>; Thu, 10 Jan 2019 23:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfAJXz7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 18:55:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58440 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727705AbfAJXz7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jan 2019 18:55:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F27EB60736;
        Thu, 10 Jan 2019 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547164557;
        bh=Cm0IiExEAKU/zLwAZI9pokGZmDy3VSABAPkvRPH+TAg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dsUerkJj/pWiLmKqsXQRVSvPuOKMrxDEJf87cxlwSNv2HYQy0Mdo/dwOr/bTHuSLX
         BcQMRpZ9GjdPWkNcr5x5qJ7JFGygTo3GqzzYxGvxk3EJEq/XjT4kb9kVealEVMe0r0
         dmffXGuoB/Cp74MMqnq3XrKG+9AKC0PrcjZZ+QzJWuya3N57/kbjMwqBRZr0pNaoPQ
         QoMc3amf2Qn1/lUw6vUSouDUGe8s/Vu2Gm0/ci7GifApc3oqiTy8/e5bfPUzpFDMuF
         Bo1sXRp8PP6tAXiHNmMx7lUsBcCIcGybB/Zyf4Q5oto7dXUJxE7+2WZIpCThOP1P+x
         usv95+ci/XPs2Benc3yOVHq3Vr440ALMW+HfkGmS4ZQDrP/s3zoeKmekI+4zcI6grm
         zgHU4GYOBJd7Mk/W+SD7yBVAEI8Ntc0nXI9kbvXV31o+kd60QKy7c+JRwd6nmvxE8a
         RuAYn8ijMbCNsAPg8VUIZ0AtVwdy2vaOc2qDk4tcvMlgjWnjDL1
Date:   Thu, 10 Jan 2019 23:55:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] match-trees: use hashcpy to splice trees
Message-ID: <20190110235551.GM423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-4-sandals@crustytoothpaste.net>
 <20190110064520.GC20497@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hD6P3ib1XCFtz2ni"
Content-Disposition: inline
In-Reply-To: <20190110064520.GC20497@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hD6P3ib1XCFtz2ni
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 01:45:20AM -0500, Jeff King wrote:
> On Thu, Jan 10, 2019 at 04:25:49AM +0000, brian m. carlson wrote:
> > diff --git a/match-trees.c b/match-trees.c
> > index feca48a5fd..b1fbd022d1 100644
> > --- a/match-trees.c
> > +++ b/match-trees.c
> > @@ -224,7 +224,7 @@ static int splice_tree(const struct object_id *oid1=
, const char *prefix,
> >  	} else {
> >  		rewrite_with =3D oid2;
> >  	}
> > -	oidcpy(rewrite_here, rewrite_with);
> > +	hashcpy(rewrite_here->hash, rewrite_with->hash);
>=20
> Hrm. Our coccinelle patches will want to convert this back to oidcpy(),
> though I see you drop them in the final patch.
>=20
> However, I wonder if it points to another mismatch. Isn't the point that
> we _don't_ actually have "struct object_id"s here? I.e., rewrite_here
> and rewrite_with should actually be "const unsigned char *" that we
> happen to know are the_hash_algo->raw_sz?

Correct.

> I think the only reason they are "struct object_id" is because that's
> what tree_entry_extract() returns. Should we be providing another
> function to allow more byte-oriented access?

The reason is we recursively call splice_tree, passing rewrite_here as
the first argument. That argument is then used for read_object_file,
which requires a struct object_id * (because it is, logically, an object
ID).

I *think* we could fix this by copying an unsigned char *rewrite_here
into a temporary struct object_id before we recurse, but it's not
obvious to me if that's safe to do.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hD6P3ib1XCFtz2ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlw324cACgkQv1NdgR9S
9ospahAAl1idleJ95Vy/o9h7iZwWGgbMbEdxgI5G6mlXAV6/YgNCm2cfEpyJxrBa
TnGKaRai1woijdd61YuxlKJNDxMRHL2Y7q36VEWUKU+AsD7WiEpiz9gyAs8SWi47
J7ymHDu/kdzBd3t1zeRKtiE9//CZ5b8QCQ8ugk+SM+oBvHki21I+4kgXWvYd5w8s
kH5B+WxnGv/HwrJc5E4Uj/Rq6Dk8bo842QTQt9S4JeyX9OXO+MB05o+8COHwLwhm
5xfo6elNKosbuaSp7/504cFxbQ0g5d02dAubc1htpfsp6L9Ec+Du49EHnN4kCkwU
GfCe/hs5mWtB4qstVka2Qxm/1rNGZo8uKoZie9AVmsexdkaywXS7GXgVURRLMtry
bDcSTjv/rQvbLpurJIE3qfdKuotZT5x8xilWaL3e7pR+SEhY51/p68wcQEERtroB
pByD/7Wby4QACtu44iCKRhlYmybiXAc18lYIUcJcCMcKMwmfVSGLTuWO50FCOBeT
vjYRVwIoALhIi1FjW3FdKlOuOhQH7DmcG/0zMwLv4z0vnfptqSRUBM3qaC5+hmAB
kIWyapig9ISqJFsPiav5EVPv20q7wiaJJJY30p2vA7v62BGwHb7729f4Yo3WiHy+
8U10wcgWKq/SvEVGae05BwN36ebhI3rMYR5j5J3CKNmWOBwgD58=
=Lft7
-----END PGP SIGNATURE-----

--hD6P3ib1XCFtz2ni--
