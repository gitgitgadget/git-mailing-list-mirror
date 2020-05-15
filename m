Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A7DC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 23:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8509C2065C
	for <git@archiver.kernel.org>; Fri, 15 May 2020 23:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k2mPVnNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOXWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 19:22:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38374 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOXWS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 19:22:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E390060443;
        Fri, 15 May 2020 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589584937;
        bh=PgPezNHbt2zaiGfamWcu1GBLUvMT+PNPh6sVQter4Og=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=k2mPVnNVKhLXvXNtkFRFY9xgUYiTQKVqei2tpqn4jrYCr0M4ZkUkbIKy6h4bkoSLS
         CyWtDLM2lTVMWzB4fItzkISATM5TfnJ/grK35SkdbQQvPwFcP0DVG425qc5XIaOVaM
         lTOl0rHbzwVBL7ZTTOzYc17vRpX2qVL2WhQL3S8A7GtyZJvSsQcQFKlmUkxOPCXlYY
         lb46nOUkEjqBUi5WqOeTxjUNtNWybU9/srgSaXU9aPgYeQ79FV2DyoWfrpNZzILIZo
         a2BjXeKeHddTLBkNwMhsaqajQ1N6cZy9H1QMz32HqBoI+toO1bRZtM+Ip2ZIFVtxED
         UXnG0ekJG4iSjahPro2fz2tFmFLbyOayzjlx2P54bdFNmHcuo5w5GuPf+M2zKjr7iJ
         l/JfAVzraCSFUTLkHVspQ62NzoXGtAoD6ZaJf1StRJoi8RktVd9K9YWC3buohRRubs
         3nWhq44m6muOi9C4V3kchMvjtSbfASnaVoue+3ktyAfW7SgX/WP
Date:   Fri, 15 May 2020 23:22:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 02/44] Documentation: document v1 protocol object-format
 capability
Message-ID: <20200515232212.GB6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-3-sandals@crustytoothpaste.net>
 <CAN0heSqYsTZDnTG+roZ9pydUcEXJBayWXnijOcAZqb3-Rqegjg@mail.gmail.com>
 <xmqqh7wjqpzg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <xmqqh7wjqpzg.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-14 at 01:12:19, Junio C Hamano wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>=20
> > On Wed, 13 May 2020 at 02:56, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >
> >> @@ -189,7 +204,6 @@ refs being sent.
> >>
> >>  Clients MAY use the parameters from this capability to select the pro=
per initial
> >>  branch when cloning a repository.
> >> -
> >>  shallow
> >>  -------
> >
> > Looks like a spurious line deletion snuck in.
>=20
> Indeed.  I wonder if that is why our documentation build fails near
> the tip of 'pu'.

I'll definitely do a reroll this weekend and kick a basic doc build off
before I send it out.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXr8kJAAKCRB8DEliiIei
gXwWAQCDQdOMqFGclrLB6DUUD1TitGqeKWPd0xvqqGTOkowlcQEAlWYP4CpRCFIF
2DbD0ELGa42y6DXwQrB4QYsPuWs5mwc=
=ZZ57
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
