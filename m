Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFACE1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeA1UKn (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 15:10:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58464 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752398AbeA1UKm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 15:10:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D6D360431;
        Sun, 28 Jan 2018 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517170238;
        bh=iYQiHGyhmuE9iPS7xb9VRAw4vuhE1f9aep+WkvWErt0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oYrHpFm704572MRj2B49FkPp01J3Xe+zwXgKogOUkPGdQk26ChQqV0zl5yZeJ5QGm
         yIk/wDY/rs1HE0lpi3MzWVlkLyj9pCUAqTx47CTyB956pxlLZA/5GpJwg79Ie4uPi3
         bhBFveqaab8DoKjHeSU+jm+xbYL4LcglS4IY3HAaz3hwmcafpI1IYIJZVFzTLtouLn
         4d6PrZ7ocwdG1C768RwhSQ/W507kU3R9Ro8HDT64Su8qhvSDNG/XY25fnRAgd+9Vxp
         7xNyJALy6D24Gpq/UACJyROYyihOLDIbSdRO6pWdkBlbZwhyoBYuwlk9+rLftAZcPT
         3Rg+JNXyZaGbtn4p2uyt65ZlPs5DX6rOjJwaI1yNnt2B4m0u56CmhPav7DtSS/Lpgh
         neOqoNTMZvMzWAfG8V+bi0tYB/d9QOMgPjeRNcOFP4WVlu30SyM8QQjCYGSwq0I8Nh
         bAi2kcE6Txx1yRtQnPv+o+JuULBujdkIQfi5vnoHE3Ud9YJf7Av
Date:   Sun, 28 Jan 2018 20:10:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/12] read-cache: abstract away uses of SHA-1
Message-ID: <20180128201032.GJ431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>, Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <20180128155722.880805-10-sandals@crustytoothpaste.net>
 <CAPig+cQ6UZJh5sZJURTiZ+T8eV8pyBSMTM8Re-BN7ZVwGc60+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ6UZJh5sZJURTiZ+T8eV8pyBSMTM8Re-BN7ZVwGc60+A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2018 at 02:50:18PM -0500, Eric Sunshine wrote:
> On Sun, Jan 28, 2018 at 10:57 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Convert various uses of direct calls to SHA-1 and 20- and 40-based
> > constants to use the_hash_algo instead.  Don't yet convert the on-disk
> > data structures, which will be handled in a future commit.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/read-cache.c b/read-cache.c
> > @@ -2000,26 +2000,26 @@ static int write_index_ext_header(git_SHA_CTX *=
context, int fd,
> >         /* Flush first if not enough space for SHA1 signature */
>=20
> Did you want to update the comment to remove the SHA1 reference also?
> (Or was the omission intentional per the commit message?)

These weren't intentional, so I'll fix them in a reroll.

The only reason I didn't touch the ondisk data structures is because
they're directly mmap'd.  So if I change them to use struct object_id,
as soon as we expand the structure size, the ondisk structures become
unusable.  Some sort of union hack or multiple subroutines will probably
be required.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpuLjcACgkQv1NdgR9S
9osVzw//V7U36WcoM4df+kSf9FdqlYctc2afujfNCofD+h/IIJAwVUDyE7qOMebf
n3/9MgAatPMD2jivxe/zVxYAH4cGmF6AeQW582kP4nWewYajA6nZvR/8vuGCToHc
T/HjFnxC+hzEvWrLgEbKOpjAikuS99n3KG+Wz5oAhn7VF+WFi7NQvj0BfoJwZ94L
xX02poTx57bk6EE+XnalusZ41gkOJHWN4d0mHCepPZIvXtFA5mZh9dY/zl9vGm0v
1lqy8UDxuOd/I7juJUnkpUsR7dAmwBZb9s5vf4YnzISEc5TpxARFOYGN6fXC8keq
LEtSjRg4v0OMkWKFTJxqqgOGuBb/mu8qrCTfUz2y5/AHowtIDzqbN2uEAAjNtd0A
ty04CtPysu64AjpLX5H3+9AmWqyAkCFpB13lKJ+GXV7lQRer8NEe6SGDI96eFqE2
7sxkz7tjG2meJeDxoKAO8kTHPg2In9wK77l2Ni7Ujp/hUxJ3Oq6n+FVWLinUZH0I
Ent9G+3ejFJzZxhClIaomHkZqMwcVAnhLsxs2U3D8gTg23VTG89g96Km+mTT3Tw1
AMm2XIji1Nde1PirrNTfKRbSHLZdgYj+X36EQ6Q83+peTkweeG1RACKuqbauZ/RZ
X7r4LxJ2vIjZIKqp1iFZ29bwMpbrb35hpd5AccYVJJrAkb/zG0A=
=Livy
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
