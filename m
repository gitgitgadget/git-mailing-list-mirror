Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301631F453
	for <e@80x24.org>; Fri, 19 Oct 2018 22:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJTG3I (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 02:29:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51592 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbeJTG3I (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Oct 2018 02:29:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 835EE61B72;
        Fri, 19 Oct 2018 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539987670;
        bh=z5N1SCXCiCUSaBv3cQpEgXWXp+ODUP26+kQLHkdC1CE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EwtvobaY/p6uk+O74TqPLnm7vl9zFBPwd7MAICCtrXB97h+EC56XbZ5dthBeQnCcV
         Hw5+8jvb4fH2pEZ50PEIryOTAq7j8Z7pd1MRUu+Y1+GvBOQl3OsnK/0G2seojSh6Ly
         Pcl7/kadhak2o3usrfkKKKj6Z1kRmdTDWgAhAMdQ2GHKzsVRfMKWJxDNYpgoQbwCef
         266nUznfRNQnAPlx/yLc3vv2Tbmh6nDaKGky5kcxY8GfS0xmAfosgthRrk3xyC6Pgk
         1ZSle2lXE/R1pBn6LW5Bc4+1daIhp57wdQRf+LTywrYUSbUXTKwqXhj4unMSFUzgAw
         V5Vic2dPd7/ck6rzhWO1JnYXT/00KRkJdk2wRqshImT1Y7YzZqNpa5PWIvCHtWLQ0T
         WF3noye7auPl10M4kpqUqH4Kk2JJdDyI6Mphb1243QBjSmZHXaHayqCHMkc/NRUQsi
         WAXzxicaC5hIjryPXJ7tM8a3gT39mg7vOenvpCZuVQm2BLX4lmh
Date:   Fri, 19 Oct 2018 22:21:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
Message-ID: <20181019222103.GN432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
 <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
 <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
 <20181016224404.GD432229@genre.crustytoothpaste.net>
 <CACsJy8C9nySzG0Uqs6_5V2rXHkAKr-ShXU7N9sPp4N5z=D0zQA@mail.gmail.com>
 <20181018000618.GM432229@genre.crustytoothpaste.net>
 <734fb14a-b9c8-a27b-5cda-862486c77052@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sk1WQj/bN1s+tUrY"
Content-Disposition: inline
In-Reply-To: <734fb14a-b9c8-a27b-5cda-862486c77052@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sk1WQj/bN1s+tUrY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 09:03:22AM -0400, Derrick Stolee wrote:
> We should coordinate before incrementing the version number. I was working
> on making the file formats incremental (think split-index) but couldn't c=
ome
> up with a way to do it without incrementing the file format. It would be
> best to combine these features into v2 of each format.

For the moment, I'm happy to leave things as they are, and I'll
interpret version 1 of the hash version field as whatever hash is in use
elsewhere in .git.  If you're going to bump the version in the future,
feel free to CC me on the patches, and we'll make sure that we serialize
the format_version field in the file then.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sk1WQj/bN1s+tUrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvKWM8ACgkQv1NdgR9S
9ovQfRAAsAE0JSi81S72kknh4DOiEd+vmOWXpNVLEvCOr1yHH8+QAU9jNPVQHX8O
vYjqxLUKsVuW+hpT66tQUKVYxha8vXUTm3Rwz2a2vzbBJSxiUNrMp6r/ixkOSVER
N8cyzfnU7XOud4Q1fgTg5/T+TImkpPe56SP2UtS9zqHi0H+yDbvbRC1PfOojdFTb
m0D28Nhls10ZQBgAGLEQQHnoiGmvLoXg8TcFvj4ZkM8evFUT8FWTVJJRY0gQvLKD
95q7tn5ZejQp6ZXAjE/xCL5qSmQ/6uTlXa7SjH3WqOSY4l11qiwHWAvgvNP8dUlp
/Uqu46QCIongRHbQBQsTZceb5IJYYGZFopDLy9zy0r3biVaXv8IPGfmFEg8IdSlF
iOXWK4hxuQBu2ZLVRqsPTHvCDoCrtbZ3Don9ymwx4w++SPEnegjP7xkMmrS8YfHS
cPl2wEIMEoDZleG6iILWwLRzvzU5KWZSSnoS7ZCbm3vHtpqh3Xr5VzbFTP1ev653
eL4AmA2YtMWvcBZsSHyTEmR0ZJX+CeQe9yi/hlDD9Yt2QXI7xH6ap6pi7h27Wp9D
n98o7y5vGenD3FtlXsjSZ/6CzcekXLi5OHkdWXo/cILRecENkWB5EeKreHlJnec1
zuaQohwSt7Xlp2jfe4n6LotEORnZBGDsekGWsf7DWJ9++DSKaGY=
=d6YA
-----END PGP SIGNATURE-----

--sk1WQj/bN1s+tUrY--
