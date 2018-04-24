Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDB91F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbeDXAeW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:34:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60846 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932574AbeDXAeV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 20:34:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 55B5460400;
        Tue, 24 Apr 2018 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524530059;
        bh=U0WyMvW/iyLOCP9Bn4LGro07vQityzdwXxNGUNWrZM8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tm3Ku+Li313Vwb1WtsOAl3jNp3KWRzZ9zv4l5VN4f+j45F789RnmpLE0R1tP8LgV2
         F2mmWn7KZEcSQalXIz+q+jFf1SWpV/Ztd/9PJZncEp154HCiQ39Tfa3MkgdBHcup93
         IMlD/Rbwqm43a9Y6gGnGulnfBZyzt+0u8VQRyrWzOa+UTav3CXMjbt1Xh/O5A8Zoab
         y0pfBWxKpSwF6d1zVBGyc03wsY5szLZ8487j2BCtjQwsM/dgWhw+T6/KA6rGiJmuKZ
         llpQNo7PD+OxUIZTAe5VPV9oPzL+e4ML/yan3JKrcg2F2Yjby6stv8sS1CMRrGftIW
         +O4sOnlKv/pR9vViRQ6M895vV54l2hn1jQPgBRe29MEiAlNwG8nMZRBlBxJBmJY+Y9
         mIKXO7dKm7lHDYClW8Yr/EHK0q/LtmYgg1MMnv5iFOq21+9EQN4qIkJZNjyp9xdrQn
         AT1S/FTjN3Nt++w363OYGiuu8of9LZl5cCJV81HGceDzE3ZOYdw
Date:   Tue, 24 Apr 2018 00:34:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] cache.h: allow sha1_object_info to handle arbitrary
 repositories
Message-ID: <20180424003414.GB245996@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180423234327.250484-1-sbeller@google.com>
 <20180423234327.250484-10-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20180423234327.250484-10-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 04:43:27PM -0700, Stefan Beller wrote:
> This involves also adapting sha1_object_info_extended and a some
> internal functions that are used to implement these. It all has to
> happen in one patch, because of a single recursive chain of calls visits
> all these functions.

Ah, yes, I remember that recursive call chain.

Anyway, other than the one item I mentioned earlier, this series looked
good to me.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlree4YACgkQv1NdgR9S
9osKKw/9EXYRdBZ6KqP3cwCRY2MLE8JTUiLwkqq7cw7e+phZv0zGVmSxCc+5P3h3
r+v0IvzQNuiZO7hY5atbugq2CNgTE0oBEGkiBi9Vx0R/vhMevEMjuPlsx6Qm6vJm
F4eNQZiB6W/d5sIKYjYcDuGM89+UYO7YAG7iN5mwTixM/ZQTmW3zbr0omWiWaS9i
69lRz+wc5HKURpFqeQSCvWqfoNWph7v1ZY1AA3ccR9Vnf2uqDkQsaxKCcdB0NuFq
LIK/nyy9E3wOnWf5XBkBD/0Lu4Q4Gdir+XV14XomrEqjhyYHBYuyLCnIzA+mrvzp
Qf0owiQWMr4zRcFNTa7jX09ha4X2M+vhb7uCX8ZHEJFCOrgFicKY+W2tjPFBZdZT
QIyPRJK23KzLQs/9Cudw9UKnhh++A+yk3M6uNeFBLMmWoH80GDXYZ1suomdoz16P
2vBfAfVocpzU0/Hs3xjvUk2mk6jfFco1mtZf9r6snWPLMOL7g7RbbR16fSEhc1ig
GDnIoi1j33DuQXuQzUgMf0TDqktl6Fp0ntKLpT8baHw/eMriP2oPrYXIh3PlVzez
smPmnbHusT1E0GWjHROYFF2v8EopEYBCwJ8EXMHSexWr5Pit8UxMUYUDYmL+rcn/
VUekh4PqwCu/Vf16QzPP49lJeYi1uqIEpiKDJH13sLL53OoGM8Q=
=qL5g
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
