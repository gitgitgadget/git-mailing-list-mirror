Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4514C1FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbdA3Wsi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:48:38 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:47512 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753041AbdA3Wsh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Jan 2017 17:48:37 -0500
Received: from genre.crustytoothpaste.net (ng2.cptxoffice.net [208.74.121.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 37BAF280AD;
        Mon, 30 Jan 2017 22:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485816507;
        bh=Bgd3+kOCgJ1ybMIWpMKUGV2wjbZCXMTbtwFb/oW1mlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRPHI02LMunN274gvQ2Uq7LXY7K3tFIcvaTEEhFtrFshCLouOHOClXvG+5HGh/Ab+
         HbWFiY0zWC2fyMDkiWvsfZfh+7lBeZ8vmkhW38XKzuLn8fggmJCZHvqXJTaGZ5kyxR
         DR8eQcf9rPLtewhI+wMqwW5uwkHBDB+JK56cZ1rMlikSN+P2RS0U+iOCxjT0K6vt8W
         R/gXnVbdzyJyr+heMzMU/AK2lE7vSMXqJw0cu1yFKECivO2csFkT50wklsHJ08BqGn
         gDzV0+mLYefapKD3iuIPcA1BkQ/hvIPTNpc6t7QMLMIEHwJ8vKw/gFOllWPtwzlgNt
         4NRpqIxeHQU4HcnkeCTRy5bBa4qtTgySAt65PUxZZzEg1KxIPx53MDwlwFwjyDaQng
         j16wM8texx9+BL36hdTCa+933drrg+Rlc/GIwwsaefSh3rylE0UFdmBAnu791Gnj2q
         X9wx6l13KELiUxBflwKNwJtXXXVMuxXHz9J1T8J/0sjEAM9zycz
Date:   Mon, 30 Jan 2017 22:48:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: convert post_checkout_hook() to struct
 object_id
Message-ID: <20170130224822.uehscfwrgav5r6pc@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <b30e5d34-436a-af5f-dbad-b1df464bf303@web.de>
 <alpine.DEB.2.20.1701301359500.3469@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="re2y2cb5jgacm5sl"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701301359500.3469@virtualbox>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--re2y2cb5jgacm5sl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 02:01:12PM +0100, Johannes Schindelin wrote:
> Hi Ren=C3=A9,
>=20
> On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:
>=20
> > Signed-off-by: Rene Scharfe <l.s.r@web.de>
>=20
> These three SHA-1 -> OID patches all appear correct to me.

I concur.  These look good.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--re2y2cb5jgacm5sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliPwrUACgkQv1NdgR9S
9ouiZw//aXyH2RCA0UUBUiuaB4PQFqYDuM5v8k9M3BElS+tIfrvMfnjLF7i5+fJl
NOsAk3x23pFHui+U1bglOqnGMn/JPuHsHK46RwIcPYGQKzpFpWUbYkDSaGCAazGX
BPHhSaW+cEsn/fXA3SGzUCiouqClvyLxbdKsRJO/xJji2k3MTN8PPxm/s9ujRVwW
vbT/Whz6QUHhnNowtZ1P8gfCk4ZSCDh7pKz3Z+KH6EIEkiPv891d37sFMpJ1BV4B
8snRbT1tdRKzFsTnrC16kCcGcOI5phcaLaswk2xLwpm6f5IGXCR27C0lKX6bTcw7
e1+G6DbWyA0zMCDtqczWpIYuEvgJG8yGEx1Gb9UEdTzX0eyJRMnvBrTw5zPTDewA
29d6i8dGvZBNuyvtSj3RuwN1M+4OuhcjltVuBsEkjltabyua0C0v33uz6SZrpsn1
XLJII6Lq7vmcxeVDyGzmCC296LmCQjANJc0kOsic8Brqfavde69Uj+5bmO+ykZRE
KCSH+q1UM0k6AWGcAE4MRiIWT2qwZX1YcX7jatIA/C1PGB1tbSWObQjV6nIlHlTg
JK/o/dRi5YOAggkm9sfGOLVcPWV6MhhukqygMmbWHKmbZMSXHTgjaCV81AIpHP09
PhT43lrl+K4oT4l9jz+kgF1+O7dJeAcnbKepCzhuncF+iD1iGn0=
=nd0C
-----END PGP SIGNATURE-----

--re2y2cb5jgacm5sl--
