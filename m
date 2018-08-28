Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188B21F404
	for <e@80x24.org>; Tue, 28 Aug 2018 00:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725744AbeH1EDG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 00:03:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36040 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeH1EDG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 00:03:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 99E3760428;
        Tue, 28 Aug 2018 00:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535415249;
        bh=grylnkKYnIzqKs+l2TCi1WPytOZVTrw0BtDbMZXrRWk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ayv3mFsy+YmEfWbxsEU8Myki0iYON/A3B4Z3smxfV4V7dZwOa6rGtN9tTFBtVHOe5
         SoL7aqveVBmfJtw2ZIu+RB8yNXdDIbGFENhgdVvrSkQ+miy/mbpRfDz2kB+iiFcrLe
         yrFs50CtaaEUS4EcjhNb3SvJA8+McsbiA/NJs6RYOeQuoRAEngmW5mXF8PZvQQcxQa
         3seF73FU41l/Hn0gDXThK2GS7zN3HA5/v7Ktm7acy6xVcW/xprcBs1lD+IlqXnB7na
         emz1HO/poDzUr7mrMVXpmMDNAgxP9iPdfDIpr7xC76VaMbJFwGZ+RgZA8gPQ298Fov
         GUIR9XusxegX/db7/W+j2DP1LYsAgIIJL/P1R+mHggClMcxjZgUNLHkBBikRmF3eNY
         F6UiPbhrRGpV1Gt8lfKe0ycVP/ak3YABfogzwwU7rLVmFhmb+koX8+cP5fQ8NwtaTi
         3dezysN+te7uUVj+aUtLFyWfiM/T4pN0Rfx/6RQtE0IFS844ohu
Date:   Tue, 28 Aug 2018 00:14:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Automatic core.autocrlf?
Message-ID: <20180828001403.GA432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrei Rybak <rybak.a.v@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180827153524.GA18025@tor.lan>
 <CACsJy8Bik2Hokgv46ifsFhhvGzdcB=FoWnWs6_k2361s15wOPA@mail.gmail.com>
 <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <94afe154-53e1-761a-4a66-4f77188036f7@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 07:32:08PM +0200, Andrei Rybak wrote:
> On 2018-08-27 17:52, Duy Nguyen wrote:
> > On Mon, Aug 27, 2018 at 5:37 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> >>> In those cases, when it falls back to
> >>> configuration for line ending management, I want it to be
> >>> automatically configured based on the host platform.
> >>
> >=20
> > An alternative is supporting conditional config includes based on
> > platform or host name, but I don't know if there are more use cases
> > like this to justify it.
> >=20
>=20
> How about just using unconditional includes?
>=20
> global.gitconfig (synced across machines):
>=20
>   [include]
>       path =3D platform-specific.gitconfig
>=20
> And two version of file named "platform-specific.gitconfig", which
> are not synced, and include only code.autocrlf setting.

There's actually a way to do this that works with older Git versions as
well: put global config in .gitconfig and per-system config in
=2Econfig/git/config.  Or you can use some sort of script (say, a
Makefile) to install the proper values based on your system.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluEk8sACgkQv1NdgR9S
9ovExw/8DbNpShqXq78kFHDq5Y2btLiyCTvCr7jAxYU8HLpiJvtFBuAx1LIh7jz6
hXs3+nAACl022FSOr+NOTgIPmlMl9dm+A4AiyS/UDoq/o9elwR9M5CDnmSzemEnJ
VDftvu7DeVD+U6Q9Ng/tJ8QG3NZBu+pttKehcZo0CuKPRvJ67BfAmv3UdJNM2kwv
yY2NExWqVwpcnBXyacNQtJFeqalNGAZgQPnYfUzdVyKwQeUPDfqXwzu3jbTXbpc/
5FqSw/4j6iqRwgXyointaQkLTrZL0aIWIOJEVyLiZom/E/mnl/D+sDDMEkKxvJcv
V55k+5yEdeDCgvnNYbX+oSoUN0S+6PQ882slkwo0adzZl+Prc4RfCF2siCoY9WYc
/4yMNuxHtJkODM/CQl+bRB0Fdw2IFlURzykLE1guAd6qsXa1+YbM8+4zer1HiNlz
g6RmIodHDvvkrNkpSzgJ9A0oROYHtZId1968E729CDidWYZsjXonpC73lkwZHoVQ
CeG/BhRBI9dLfmp9QRna+LZa/5eBXH2DtXTnLYQVcKGBy5q6oOg0w/ftXFucn+/a
LRKcPoTLs10QFdkoCUDe266dpz76aFPnr/c5ROZaiLXBp2mGlHZMfzw+4oUQeSpF
n/4HEF979GzlQbceDJewU8CqKpuXjuF/v8mvn1PSG8Emts2TVWM=
=DHWv
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
