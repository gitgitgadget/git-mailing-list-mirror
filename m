Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2511F597
	for <e@80x24.org>; Sat, 28 Jul 2018 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbeG1Tck (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 15:32:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38730 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729939AbeG1Tcj (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Jul 2018 15:32:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE38B6046C;
        Sat, 28 Jul 2018 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532801119;
        bh=5QFST7D2J9nGTizQAD+y5yVyBRmaLjO0tvhDNL2belc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yaymU8o7JplrVyEN/ZCvkUxP+fJEIjMEcvydG1eNXFMldFaNx77RqEBbI5SrW+LNV
         KJwzk8kG7z86VJ25+7ZVOKEJwuYf0IUpysTgWPbixNgLZVl9sdMDX8GhfNH/fdBFHG
         kjH5adic0y/Sbu7q7tzqfCme6GpqNaJA32mbO+wZeC3ArDkL/z22KzCqpPtOxJsN25
         gvR8aIB5Drm/zrEZjEkiBN0lT3ZomqfVrcbjI6OVxuh7GVxOskE4IY6Sf78eY7KsCC
         maf61ktohauhbV7/SIJNC8SXWbqd7Wc9QtixIUOcb4goSXAkwkJtatfSPeFPldP8KD
         MuNR9iRylsDrFLHK33zcUtmGJ7mUSGLaRnGnDakdAG7qlYIjZb7Vpd3Ie0b7X/LKe0
         MAjeoWxpyRixPiwFIW2xueMsOBAnta1C//Ss9MROLQFFsQDVwlDr6smd+DOb8iyYNw
         aYgiEqZSDxEBWW0zlg5WjeHtCUHcowbU2dm9rB02MHp/nPI/0eq
Date:   Sat, 28 Jul 2018 18:05:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clone and case sensitivity
Message-ID: <20180728180514.GA945730@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net>
 <20180728051105.GA32243@duynguyen.home>
 <20180728095659.GA21450@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180728095659.GA21450@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 28, 2018 at 05:56:59AM -0400, Jeff King wrote:
> strcasecmp() will only catch a subset of the cases. We really need to
> follow the same folding rules that the filesystem would.
>=20
> For the case of clone, I actually wonder if we could detect during the
> checkout step that a file already exists. Since we know that the
> directory we started with was empty, then if it does, either:
>=20
>   - there's some funny case-folding going on that means two paths in the
>     repository map to the same name in the filesystem; or
>=20
>   - somebody else is writing to the directory at the same time as us
>=20
> Either of which I think would be worth warning about. I'm not sure if we
> already lstat() the paths we're writing anyway as part of the checkout,
> so we might even get the feature "for free".

This is possible to do.  From the bug I accidentally introduced in 2.16,
we know that on clone, there is a code path that is only traversed when
we hit this case and only on case-insensitive file systems.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltcsFkACgkQv1NdgR9S
9oswPA/+Ly7yp8mdG7Yd0/Yf5JRhyzncxa2tHChiVWTJ3jBSUMW1+VNVGw9JVfMp
j9+/Sy7PfYDh7ZKx4bEaAyJFIv7bfOnUFQSGRfEJ5066i/GiQdYQHabALDFdw0p2
AdQGi3rE01qGQeLP4x3gzWKD6InjWjVJwHC6H6K2NZmXKyfeLQLUZyi1WmPAgw7I
NBqXQ5bcdVvDcuCYvxyZG02BVWlmPr/2ZgkFDeDMTgDLUFuEBM05zquAr7i0yMFX
wpgUFSiccs3bjqY7g7WrGvnhkxefGEMQOQwQTOMdWaWbtA4VxFBPaMSFzxpgqRoT
WYWlKkuBayZUWAmf2FtesP+hCv/FBRij7D9Ot/KWW6NuJaETHhpUAu+T0WqApQUs
eQ343jDPsOTxgiw8APIcSulljNR9CH7zmk4caoPi7a708zpYXz/G+CLzdJG+29L2
f+tw98xewsAOQczy0WqHiEnm7SKTtpj+1W4zgxdR+txRKXS0PdblWmwcJy1CeqT+
/4Qrl23oDZv7Dr4VdFh8yHiWiPLOsxHPrlLCQfJarpmtBc7Yxf4/7WJ7M2xD4yxD
g6FbScmSBxAlEGUCER2AG8sJiEUrh146/iXgcjstqsprfuQUagVRs5fkUSighuha
3E0KGS/0n8CDeMovItg46adw3zp1fb4jah1jw1CCOdIUEXoKmhE=
=bIT9
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
