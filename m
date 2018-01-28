Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F34B1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 22:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeA1WAP (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 17:00:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752827AbeA1WAO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 17:00:14 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48BAD60431;
        Sun, 28 Jan 2018 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517176813;
        bh=HP3LUdiXJZJ1HbCB77r25wbERnA8FSJcyqW9ESe9R1Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=F+Ddp5uhd+tqq/mW/xlpnAuM5+WanYj6SvI+7QN1LJLOEpta9s6WqakZMK0B7VxsB
         eJx0jKrjwkSQStZc8joIosfSzFrpNhpL+ZeR0lwBpwfw0ZRhqjpdr9jsz5JEFAHJg4
         CwLVCGOz+c0EBoKN9Anr4iq1J9uJm4OgNHyNcUrrqr4p66r1hEh7YKS1y51L07N3Rl
         7OREa8zZWlXENeKrxpJqrN81kgb3KOsd5/VVhAxbgrAt6dEtIhkGZ8BLRMHT2savd2
         JHrUEmPuaOjc68VyPSCGn3SuQOUZFt6rwjRgi6Mj8xzrdfFu8glxZs4eGOY7pqelXq
         vjHmUvaIXEPRnxn/RuVOc+vbTBZmIeZVYHVKS6HwdOW67tkZ+CpYm4uDvBk6p2R8kN
         M1R5/AdiloXUtJ8HLQScDQ738J1qrQToxNX2prMqNL2dGP4UKid+tiWkwho9d6aq+X
         hbRsGPviFJYP0LbOHX9tmvPQ15WwaR051u1kD0xYcG3ZKOsvDbS
Date:   Sun, 28 Jan 2018 22:00:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/12] object_id part 11 (the_hash_algo)
Message-ID: <20180128220008.GM431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <1f464382-51f7-1e3b-509b-73f7fa49488f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <1f464382-51f7-1e3b-509b-73f7fa49488f@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2018 at 09:48:28PM +0100, Patryk Obara wrote:
> I looked at your branch object-id-part-12, and it conflicts with my next
> batch of object_id conversions in quite many places (mostly through
> formatting). Therefore I'll hold my horses and postpone my conversion
> patches at least until part 12 will be sent.

Okay.  I've just rebased it on top of your object_id series, so I'll
reroll this series and then once both series get picked up, rebase and
submit it on top.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpuR+gACgkQv1NdgR9S
9otU2w//fiffRSa/K1FnxbkGlKtahNKLhv5ZoV079ZuNKDyq+h+saGLNqRMG7Fbt
VhnxrTKDhWrwu7d0ebsheI+XDK+96mHPQJeezb5tFq4d3N/rqBVrgwoxdDX3IJcu
lLWyUKozlK25QkNkyDBfNnssmLcye6c69x9K/uXgZTCPdwLG1I8lFO2GkdSSfy5W
DJ1NM0mfhTniW2rC3qbZdRAMrvwFb5n3FcrPw0bsajnixuwI6oG0bNjniIFvjQFY
3lNSo7GGTTpsvk37DzE56T7r1FeUjlWkA+M7x1n9m7bpGSFB1a/dj1PZRAvBnWEl
uQLpYYfe+JZBj2ivlWwR+k/U8ts/uQmy1Ps77D/qOR1lbaBfrzRSqUbta5qoX0vB
LZJ+kioHsibJQwRbKkB6xuxUJle1Xf+8cZAyHm6dk+Pkkegeqa8GN7t0LZ4kDFgM
k4hsyPUfsXrxKY4i5NNEJ6noHaVgpGGVS69tmcqO4JUsANOvB1ISIzxlkxRTH+0V
1uEFazQkRWMdq/e6q8b9bwftryuhMqukgO4lJtOt9Paopk9kQfw79gaPBnsH4aAE
AcEjxITKoiFTEawjb9F9/NiQ3lyPhBbcedjzUrm65KpfCdp3AJIsv2BKeXh/OR8A
FCzpNDX4i18+U489I+LLvkHGt5sShAgNp1vN/Vr4ni4HrdjPZFk=
=xgWh
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
