Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4D920248
	for <e@80x24.org>; Fri, 12 Apr 2019 00:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDLABS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 20:01:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35454 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbfDLABS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Apr 2019 20:01:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4828:c54d:8751:d24b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D3BA600FB;
        Fri, 12 Apr 2019 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1555027275;
        bh=hPfuLhItA9+3dAnQUHyTuY+22eStE8gGaO0FHtky2Dw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dwZJ4Gy+2skTiBT+WWXxRf3+kBY1ZbKIJ14ZchkAt1V7Ih9kCLEillHVFYM9lHwf5
         HAMEEiiZAYonvXqbl6R+CqhCMAc0M6GI4Hthqi3mc9VT2iJnZSIvLjBcPNdcpu5j8+
         cm9DRn3nz9XRQ4V8H20K+axSK4U2p17ytIfz+iJHt31KQQiqtAHK7exyQQ/rwN1S+M
         y/n1jm8VvURKfvBGaWXTUpyO8bedh1JwUxSfglZFTSUICCZWNH1dW5Ojw+QuiKCmGq
         qGcoq8h4v/8kY700LC1WHzRzQuuc77nRiK/PyXZlY+XI866WmSzmDGwyk4GODurBpx
         E/YDJlj9XuG+kJdATmqcHz0xPka6o01jo8wydfuQhFL+tIZ9EUtGc5tRTu/2NNTlKt
         iCI76HF4CUCZySdUUCovVC92vD8cU61i5hb6YY/MZPvyiNeXI7U5IUP5UsjSlW0k7E
         yCcfksG2hliqMpbtDnbULUfqobjcTOwnTDv3TWdu6jNXOG2TPDu
Date:   Fri, 12 Apr 2019 00:01:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] send-email: default to quoted-printable when CR is
 present
Message-ID: <20190412000107.GK12419@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20190410233450.765424-1-sandals@crustytoothpaste.net>
 <CAPig+cT5-r=QqVDcD7viJj0-fPp+6OjnKq8aP4NLwKNdrAHFKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OmL7C/BU0IhhC9Of"
Content-Disposition: inline
In-Reply-To: <CAPig+cT5-r=QqVDcD7viJj0-fPp+6OjnKq8aP4NLwKNdrAHFKw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OmL7C/BU0IhhC9Of
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 01:44:06PM -0400, Eric Sunshine wrote:
> On Wed, Apr 10, 2019 at 7:35 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > [...]
> > Note that we are guaranteed to always correctly encode carriage returns
> > when writing quoted-printable since we explicitly specify the line
> > ending as "\n", forcing MIME::QuotedPrint to encode our carriage return
> > as "=3DOD".
>=20
> s/=3DOD/=3D0D/
>=20
> (That is, replace capital "O" with zero "0".)

Ah, yes. Thanks for pointing that out.

I'll wait to see if there's any other feedback and then reroll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OmL7C/BU0IhhC9Of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlyv1UMACgkQv1NdgR9S
9otTkA/+M7zwdQpQQ6p5wchdaUEcqXG03T4ih3HoQq4soNog5v7pqWU6+YnyWhLE
flHS7adKBjhGzey/gJasz/yNxRme23NQ8nwtW9cedXCEGrPADmBiWc7QfCPMIASF
SPkpZoqpyBrm2ohaZMdTwn3Mxpp+AuKCV2bIeyx9E28VZXf06C+2CKdh0zEhojNe
zjk3RpHHxW1IeCHskw4DQi6nm+oN8Hx7xB9PyDKPd39YdTrRMvXvCOtGWxXSq7xa
AqJf1L3jUljXfp+xHQK1gfqVZJbefIeefkacq3TA8V7DL96JaIJeNWCqGImTMmPN
A+d0uNSwX1E32rdxIldms8+2MMPxiG/0yZP1qHyI1DdM4tZ2Sd3r9gU8vMgF0BtT
HCRczCLljnUX/eJJfRx8uEYTgLlGQIeb3pFY22PZF+uioY520vJPqTJ4E/tPWXoF
LiB5yycCzmZKLCouEPtQ2kb6h+PxKVMam4r+GhNnI3LQ0iO+42PmlXftrLm7f1/z
E1v9butcHbHax+kpXn5mrIJ/VVg2RwTVii4ap1498ce5ciFGBhZu3Xcj39YSJQwh
EYbbrQUrl7yqhQ4ydebXuymKyK4v3IfHAHFzLUKH1yZrl9Tgo0O3rOMARSCzH4Lp
MhJnW+wHOjwBTfe3RJqqlWG8GfkPTssnwozoqgV5+Q+rH7zUzU4=
=LLST
-----END PGP SIGNATURE-----

--OmL7C/BU0IhhC9Of--
