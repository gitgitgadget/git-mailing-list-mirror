Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F5F1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 22:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfHIWI5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 18:08:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57420 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfHIWI5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Aug 2019 18:08:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F245E60479;
        Fri,  9 Aug 2019 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565388535;
        bh=VpHhs9H3yH7FAe3sIdjwKwMl73JK2SyZ7yLndHuLTzs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xValA5Bku31jzJZnwmsUXWdb2W72AcvPIF40dPjoH1paqdN9RBMKiehKIV+ap/pha
         G0Z8WXVID7cj7Ma+HLwJyTTtrYdHCIq86il9yvLX4URKp5/zAJZ2Doer4NIO5sRBrS
         ZB2LBnxLyRIe1LfyngFHQ+JObrD1CckIrp23a6f1V/QQR772fVH0eJNzVVdd2krhin
         2ieA824mQ/dRJDj3qMCx7KoMHiGaNhIqpmeDbDNinehkNhF0FH2DSgQCEXOIX5F8jD
         QOhGWS7b7EAOIR729cA36R0EEUNT+zzinD+P4ypXptEdJeQKJKWD0xwWIANTAs2VbM
         LuouHVL0TKCeBx7w2nlegLEdDi3xkAJIamEP9Jxo0j4Xv5/6RCcN8mcJcaLwZB3D4p
         CAUKlhBBL7G/cUjVhZ5W+fvmxY8OpQsUmT6AtcD7+OEsLRhBCXOERanCQ4dW72AcPX
         QSnUzw+NbsdKJVwf68O/7IAYyZDv28n6v00YjUR5UK45kiUdTPu
Date:   Fri, 9 Aug 2019 22:08:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809220848.GO118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190809111452.GA93559@syl.local>
 <20190809112552.GM118825@genre.crustytoothpaste.net>
 <20190809113613.GA3957@sigill.intra.peff.net>
 <20190809124318.GJ20404@szeder.dev>
 <20190809135148.GA7495@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Content-Disposition: inline
In-Reply-To: <20190809135148.GA7495@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-09 at 13:51:49, Jeff King wrote:
> On Fri, Aug 09, 2019 at 02:43:18PM +0200, SZEDER G=C3=A1bor wrote:
> > But there is an other subtlety here: when I read the commit message
> > saying "patch that touches a path ending in ".gitattributes"." and saw
> > the new call to strip_path_suffix(), I immediately thought what would
> > happen with a file called 'foo.gitattributes'.  Only when I looked
> > into strip_path_suffix() became it clear that it only removes full
> > path components, so such a filename won't cause any trouble (though
> > perhaps the worst thing that could happen is that we unnecessarily
> > flush the attributes cache).
>=20
> Right. I think the term we want here is really "basename". So in fact:
>=20
>   if (!strcmp(basename(patch->new_name), GITATTRIBUTES_FILE))
>=20
> would do what we want, except for the annoying caveat that basename() is
> allowed to modify its parameter (to remove trailing directory
> separators, but we know we wouldn't have them here).

I think this is exactly the function I'm looking for. I'm a little
uncomfortable relying on the fact that typical implementations don't
modify the string when there's no trailing slash, though.

I think I'm going to end up refactoring out the strip_path_suffix
function into a has_path_suffix and use that. That will avoid the
allocation and it doesn't rely on the generosity of OS implementers.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1N7vAACgkQv1NdgR9S
9ovZWBAAm33M4bgmqZQuhzfEu4UcH508d5r9wxiZ6saAu7oAwCgLNM03Yjd2HZtH
VfDIXXvpgnq7M1Olu62KgyE4mzndeY7xRACIxDjB3IrszUI/Zgg6IoXU3UfAqRi0
yDCojJdm8XJJ/AvkA98Pk6EYuE8fg5W+zJJy281dG/tpk26RJ0Ptag4KtG7WZk77
jqAvZw0Kg/xaxJeQAfYAR1+mSsBozm3jRQZVMNVBqvncu21gVctqJco0Ojw1ComK
YyRDxMf56lGIWFmB6u4N61qGgxe3/oR3TTo6Bq656K8hVmhgBaD+3to+qUI/D+Sk
rKr8uukvnGTdwmoOQGjBb1rLfGAEZodE1WWoku++3bXk6srs4d+zW3cRt4QOis1p
JuE7etD37csDxTJit/6OVOWoFedio3E3ln7f0Y0mlno3IgkbjjjBels/caStVFs/
DZq00AJnYg+L074UXXRaZnm+0RuDModgfBmfQuKgIfS54Z8WT5/nAyQDnQ5j5Jpl
MeGY605WInUizonTrxRB554EcnSg680eYEG+Tae6Oco2DxHbxS4EHWmkeONHhzYZ
0sFGZdSNkqkf24yqf2rFp828d1yUBbolkH+dEzOtezcTtumCEvc9a547KoXwsrzi
YAp+RLc/MSVkWxJAubtKoDDajT/ScDJbtNK7Wk5xTyBCTKIbW2g=
=4gPH
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
