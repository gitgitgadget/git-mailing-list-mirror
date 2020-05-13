Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351CC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF5820693
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vIiBDhQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgEMWts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 18:49:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730841AbgEMWts (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 18:49:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BED066044D;
        Wed, 13 May 2020 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589410157;
        bh=T/xoPayjzc2xyZEC/uZHHV4R030DN9EcfB1OajeAREg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vIiBDhQ2YVj0NyI5qBLQ7A2uPhr8HHtqsIgOM3JuPjXN1QgYTAIR1pE6UIocAutFI
         oO454P4yGxAtboSv6IesR1+EQmZ9ESnUsQA+8Bt43hz626VDVzIXCthA4/jEIADNp7
         TbF/+CKV/WTnzrYNb51Bjm7cp04EkKRMWr4hT6W7srjpBA/s8QEPuuehx0DKNCwXAB
         NprrOkXBrg/xPPpz0EUhYhkweoAaTy3CqqfJk/qTFK/FJXW6+gXZh8eZ1PAEGnBILb
         2lvM3rzbSc96bAsJJ0ixbUhuiOguPrW+hvK1QcP6iwDpbWGWVyxRpB1CYfO7uO9A9m
         lQpBMkM89GeYrum7lDnZ0hE28wal/wHgx1Lljtd/0aGEA6TtcmH5fR1xU7mVCphY51
         LYByQ0SB5ZbGJnqYi//e4A2UfeNkHKyA5zxm0WcKVmt8D6Cqs0TNlyxRkWH9153Czc
         nX9lJ9udBC98PNGyHhBHKzd8GsQtE6vg/mIVsxEA95nkbuBs97a
Date:   Wed, 13 May 2020 22:49:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 10/44] connect: add function to detect supported v1 hash
 functions
Message-ID: <20200513224912.GE6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-11-sandals@crustytoothpaste.net>
 <CAN0heSosiP=vCcd1QBmWNsVUuHTmRJbjGrWV9tU0=BSU1ENmDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <CAN0heSosiP=vCcd1QBmWNsVUuHTmRJbjGrWV9tU0=BSU1ENmDQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-13 at 19:39:41, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:56, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > +       while (hash) {
> > +               if (!xstrncmpz(desired, hash, len))
> > +                       found =3D 1;
> > +
> > +               if (found)
> > +                       return 1;
>=20
> I first thought this structure was because this loop body would learn to
> do something else later in the series. But this is it. This looks like
> it could just be "if (!xstrncmpz(...)) return 1;" and drop "found".

Yeah, I think it could.  I originally didn't have the helper and the
code was pretty hideous, so I probably forgot to simplify when I used
the helper again.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrx5aAAKCRB8DEliiIei
gdm+AQCyzMNpVBDGtC7O3f0u29l4mmsdOcdqu3gB5/cBKoRsEQEA0KKEVdlj2CQc
DNZy3HmnGUDQ2ZSuC9nG8A2/lh15QQQ=
=ZOx9
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
