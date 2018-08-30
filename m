Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8274F1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH3GVp (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 02:21:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbeH3GVp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Aug 2018 02:21:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F00EE60428;
        Thu, 30 Aug 2018 02:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535595716;
        bh=wXdrNh0AcAY+naZq7nQ0T73unXExC24kjTo3F14DyBs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=D8lmYHKsl64qUdGB5vvA6ek+m5bvRR648nLX4SvhHZoPVCxYJBac0tXtDvbb4LaTJ
         SdtA0GOaGkXTseK/ec3/j5OTID1b0O7TQY1L2y3gONCEtznmlrLIGWNOgs0U76M2WK
         cfwRWZDadQfEYw8zEx3BEzYbl51R65JNot3zwqp81Yxq6mBNZfvib1uLUCbFkUgAJk
         ympRJysKzOIO7V/L4NdYZhruHBJuW1f3n4tUSvBosizExAZjSCk+9w7OCWmNHfXPYc
         4W/RhIqyjnpLYtk+1eJCKLCAKtMJkon6mlfa1I0o5cMGENp84b4aWEhzEd6IYcgM0G
         XYEVCKaZoN6Xe23RVCUZTe9J/0SWYtFNOA/0hJXrxG7z8vi5KBlhNJPL6uwl9RPQNT
         PYFVVuoEnayYhDTIz/9qSwGIkG50cszTvhs1nn4a2KnEf+RWKvnE7eGLxZI4Ki++sP
         0erILjsZxpIwD8oKkSznV9rcdH5sFo9rHU59qbTwJBSsrkUBX6o
Date:   Thu, 30 Aug 2018 02:21:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] Base SHA-256 algorithm implementation
Message-ID: <20180830022151.GI432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <874lfdecoa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <874lfdecoa.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 11:37:25AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:

> It seems to me that aside from t/helper/test-hash-speed.c and
> t/t0014-hash.sh everything being added here modifies existing files with
> many authors, and would thus also need their permission to re-license as
> anything except GPLv2.
>=20
> Or do you mean whatever fixes/changes you did to libtomcrypt (living in
> sha256/block/ in this series) you consider e.g. LPGL instead of GPL?

Yes, that's what I mean, specifically the code in sha256/block.  libgit2
is GPLv2 with a linking exception, I believe, but either way I'd be fine
with it.

It wasn't my intention to offer code I didn't wholly author, so thanks
for clarifying.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHVL8ACgkQv1NdgR9S
9osQXxAAt926PZhDuBPyvusUT63qsfVmlZAfL3SYr5JYIrdXXhSUA8fAxBoQ6xFv
+SdWeuhA6Oqx66H8oCW3fiKSik5lR+FM9lw60m3lLpuOnqNBbTG20Tmm7P+STS49
pKtEhT1TOSmBMP0m+j0LrVyHAwTSwerIeuLVx7Q7ldBKS6a+t/aU8zV4urCmNqY6
rQihx5tehS5FE5+pBNI4yd1vtA7GgyVbbRfnGrgQVUonFy0PlwH9NWX0DP6wpig/
aZGPtoFOxh/7b7czNLQ12Sb0rZlWWdKxCTBkzizPBDbGWfJ2O0FuJy2NYbj/2QpJ
SFvynz+T8KV+3P9X7xsaTBX6VxuxaKnkmCo0KF790Ve8NzNTggv9O4tJW0jpbhGA
m/SbziDEfP9NOqk1NXJHsU95/hn07cnG0LhHhxOWJRuON2QWw3K2/6xPwOG/3ZW8
U0yCKJwEruX71pvBJjbrNskViLtMML//SvU9IniLhYjt1NkkpnmVn2dwXWkMilZV
/sL5CbtD/h4tO+z7FcBfPdId8irISp63812tH6JP6k+H/cI2ChPxQDEqaTQCPago
Ia2PuMJdzFfoE5Is2wmS0/+ejvGxID77EKiaoFPjjAd2ws6LN0fdNewZP2Ryk1+F
PVhUqgooQFWVoQ+uXLtbc8UYpXtMr1PhQJ2iQGdOB8qCPZMK9a0=
=B3I5
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
