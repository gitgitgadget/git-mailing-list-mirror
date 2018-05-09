Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951621F424
	for <e@80x24.org>; Wed,  9 May 2018 00:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeEIAYI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:24:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42694 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932475AbeEIAYH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 May 2018 20:24:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9049F6046C;
        Wed,  9 May 2018 00:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525825446;
        bh=dgToJk8POolw+TbY+n7ISVB3Zubre5ORV1bd99j0xFs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cmjQh5EoiTjby6sq25Y4lEYMD9CNvlphYMarckgCtHG49YmsEy8TddLCunBzODukP
         n9GbLhjl29LuaI3BdoIsEbQ6+3GYm74cKABAn+AC0mMyLwCTff/WmtiWZR3AgfPoZ7
         RYE2UOYWVseCWBb4T2LNO/d8Pc3cVst3DjOjGzZTxIWo2fhdiOF+8jtoe4+VxGaB59
         f2WLJogxD4womjg0AKfns99gi8hCYi/IrHAUU6++1kJz5M/geUdGhjI+prlDE6FRkS
         rxbWZ4daPetYNv21ihLxVMto5hc0h8uE6BIoBleFhVnY7Y7eN+l4HhZB2PVhL3pIf6
         2Z0UWsdNtgKlIbOcCHvPxA5L/3J4BcXUqnjS6jacoc/TMrRQtbJLnQXg+Hx7qUnLty
         2L9fNvY8eQcXpFb18XO2mJWWH0SVo6XXilQeF/ZfIwi1BXeyQN2qaGX5aEXhPOCizr
         TUvlvU0Zo6xzlHeDXvp1O/UtZJ4crIX3raxnKDx7d6A5x/9GqYg
Date:   Wed, 9 May 2018 00:24:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: render revisions correctly under
 Asciidoctor
Message-ID: <20180509002401.GF275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
 <20180506204226.955739-1-sandals@crustytoothpaste.net>
 <20180506204226.955739-2-sandals@crustytoothpaste.net>
 <CAN0heSrth+ZheEsHuVdyUv9fcnP07O=YvK6y+=rmaGqZf7X3_w@mail.gmail.com>
 <20180508011352.GM953644@genre.crustytoothpaste.net>
 <CAN0heSpaETw_v_a_zL7Cp+cDNHP9je2ZqTHh37FfDHjAbRn18A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <CAN0heSpaETw_v_a_zL7Cp+cDNHP9je2ZqTHh37FfDHjAbRn18A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 08:31:10PM +0200, Martin =C3=85gren wrote:
> On 8 May 2018 at 03:13, brian m. carlson <sandals@crustytoothpaste.net> w=
rote:
> > Since this patch fixes the present issue, I'd like to leave it as it is
> > and run through a cleanup series a bit later that catches all the
> > literal indented blocks and marks them explicitly to avoid this issue in
> > the future.
>=20
> Sounds like a plan. :-) As noted elsewhere, I have no immediate idea how
> to identify which of the 13000 tab-indented lines are really part of
> diagrams and ascii-art. Counting the number of spaces? Anyway, thanks
> for this mini-series.

I have an utterly terrible Ruby one-liner which I wrote in a few
minutes.  It has some false positives, but not enough that I'd mind
sorting through them.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlryP6EACgkQv1NdgR9S
9osGPQ//Sr2zCAURFSHi9wzGoC+qXdWVapK+ckPLuguGO/sHo7nTrM71RmL/4evO
sHXsUyQgvKvv85JLlkbEuFE+FpHlURlwNpjcWjMXRAMhnOJdB7/8aQ1l8ittQ9y7
sjXIm4Qqn1hg2CWTK5XYEW1uZUI8XNmtRGzXQyiJTXerObyAWBiCWJTMr2oJbonp
lTDxnGouCKd0DDwwcqpVjFcqSZOjJM8ajCuYgrq8mZPvRP2VVNELEMwBgskuppzu
2cKe+0n9v50fzKIWUOCwJ6ZIpZX3j9YiWjhS1+6EtZGLmohtG1ksDsjk4H6x4wos
eD9+I3O5go4o5ASp2b803V0nw/8EAu9y4sSslzodCv2FPO4WHO979+QArC7zFOFO
xIsXy3vWmY1rrOQRdici5i8dfKCF3thh5yua2V/eXQggyyWXoAR8P4UOY1av5Dw0
+hxxvUqxPayNxN8nj9Iuni6Qnb+yemA05+ltqVtGHafv6bZOhu+YR0QgSS4L92by
TGkR10yqvQGPKDSwqyVbW6kmEbQVWM7bRdYdkFB8whPukZWZieDkWXOkaApjEcjS
ES8XS0Issvq/gfTv8z4R79yrPKWBHRuLTuBmN+4m4BonYsg8ozSFzjXEiP7svAog
k6gfeDYhYWmkfj9QUfZolTAIKpPOTrT4W872JFGoM/IS5ABGTOs=
=JV20
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
