Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D269DC38A29
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 23:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09CF20578
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 23:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wlgcj7SB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634381AbgDNXpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:45:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37108 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2634364AbgDNXpk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 19:45:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C95886042C;
        Tue, 14 Apr 2020 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586907909;
        bh=5s8XvZCtvet5Ogs2KExx6nbdYjcZJe0ADZrNqI2g1t0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wlgcj7SBO2OUDTBwlQhTUlNYOgkiYx+cShYnac/pxfMgCy3hq+XobFNE70mSL4iVJ
         TUvYU47sGSplk3uZAJG/GJRtK4Kn1PrFi+LVxLWCu4QR2ZX2nZJKRAXjiWCIzQniQg
         ebJLUHHB6ZyBfAJB7t6ifJXP6WCTgdQTNz9HvfLj3Ql6jSNK1qWOutkDhjzoXSkfmL
         odWTb3g9ChHgWCebKMw8k6qHIlNDKFXC0KLN8S1v3ukV11w0vqYLhFMj2OGl6Easy3
         0Ls9ggCRxKT8rH7A8jYulw0Gygp5nmjq/0IuDzfZFVwNcSyoW3qFx4ai0SkptyQF67
         rru8Rd/QY5mZf4rZXtCYPC5y6DBkMf3gf1udyQHDz71PpnSvkrxmtvJGHaN56B+4ok
         EoKBFWuwDahfUE3hrsfu3p4T1v42jvQe6IcqfIFhEkQ3NZuhiApyHBAsPKkDrgr9fK
         rl5rRUilOQNp1hUSIvzCBkJ5qEhFF4nToBseXdX69y30aLlaId/
Date:   Tue, 14 Apr 2020 23:45:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] More ISO-8601 support
Message-ID: <20200414234504.GD2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <cover.1586856398.git.congdanhqx@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-14 at 09:31:53, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2020-04-14 00:03:24+0000, "brian m. carlson" <sandals@crustytoothpaste=
=2Enet> wrote:
> > git-commit(1) claims we support ISO 8601 format.  However, our
> > approxidate code misparses some dates with fractional seconds.
>=20
> We have never fully supported ISO-8601, those representation are
> perfectly valid ISO-8601 (for 2020-04-14) but it would require
> more code to parse correctly, perhap "tm_wday" and "tm_yday",
> and mktime may help.
>=20
> 	2020-W16-2
> 	--04-14
> 	2020-105
>=20
> I don't think not many people interested in those formats.
> If someone really need them, we can get back to them later.

Yeah, I agree we don't need to support those.  I would be happy if we
said "RFC 3339", which is a more limited profile, and implemented that.
The problem, as you alluded to (and I did as well in my original
report), is that ISO 8601 provides a huge number of potential formats,
most of which are not interesting for typical software.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpZK/gAKCRB8DEliiIei
gSqaAQCb6BhWa2kiKxmYpdXFbHTPAoEaZFw8TKud7LXsRVrWWwEA1l9QGSfQk7o1
kzVks1Te6BAbvCX10rpHTuPsi3J2KwE=
=1PkD
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
