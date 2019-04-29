Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDBC1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfD2XTh (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 19:19:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35764 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728565AbfD2XTh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Apr 2019 19:19:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B692260443;
        Mon, 29 Apr 2019 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556579975;
        bh=DtgMa4EXXXyhzU52k7VAEbqiBcAaqXk4ozGCiMzdMms=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ser632W7j/QRr1YVaoz5rPYV2G1FjiAJe52PxKTr6XMwlE5Y0J+dZqHyQH6U6zjE6
         HnLA0RS9xnNvxPW1UerpYNc2Te05eswCzQLerI9LzVvgk5qcMHUt//jyWm1AE4v5Wm
         V6b3GkSxU90PjnwIVTvz1pnwycWYjR6lKjSldbip0K2VOu2EEZ/zDNpsaU5WJuHzWP
         UM8Dt+0cvy1gb2Fe82p4BoYMN2bo9+aOVF6WXRg/cRkqexMp209NszwqXJOt6tQOiq
         GWjXm2VyI314PBmSDvauKU7YkCaPVtqsbKJ7dk8rMTQdsWwOiYxt+F0f3Z9lv9OYen
         mWxW/eDkq8nDgOnJAG+61ZH6Cv5ibGBnfK/XU4QmBlTDa2b+yHi3t87/HT6YEYA+B4
         GbiJsPXsEMd/GXeSX5bYiUryKNYgMXB92bpUmXn9xrgR6Bmk34tvrxb+Mzeg99JzNo
         r7T0Qp+4Rz1jo7KfNFa9j6pXQWnZlU+4jByiXkJItJCFxSZ7RC7
Date:   Mon, 29 Apr 2019 23:19:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for transport
Message-ID: <20190429231928.GQ6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
References: <pull.137.git.gitgitgadget@gmail.com>
 <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YkilVOb9qhI0mB+X"
Content-Disposition: inline
In-Reply-To: <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YkilVOb9qhI0mB+X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 03:04:36PM -0700, Thomas Braun via GitGitGadget wro=
te:
> From: Thomas Braun <thomas.braun@byte-physics.de>
>=20
> Since commit 0c499ea60f (send-pack: demultiplex a sideband stream with
> status data, 2010-02-05) the built-in send-pack uses the side-band-64k
> capability if advertised by the server.
>=20
> Unfortunately this breaks pushing over the dump git protocol if used
> over a network connection when using MinGW (but *not* when using
> mingw-w64).
>=20
> The detailed reasons for this, are courtesy of Jeff Preshing, quoted
> from https://groups.google.com/d/msg/msysgit/at8D7J-h7mw/eaLujILGUWoJ:
>=20
> 	MinGW wraps Windows sockets in CRT file descriptors in order to
> 	mimic the functionality of POSIX sockets. This causes msvcrt.dll
> 	to treat sockets as Installable File System (IFS) handles,
> 	calling ReadFile, WriteFile, DuplicateHandle and CloseHandle on
> 	them. This approach works well in simple cases on recent
> 	versions of Windows, but does not support all usage patterns.
> 	In particular, using this approach, any attempt to read & write
> 	concurrently on the same socket (from one or more processes)
> 	will deadlock in a scenario where the read waits for a response
> 	from the server which is only invoked after the write. This is
> 	what send_pack currently attempts to do in the use_sideband
> 	codepath.

Since this is a platform-specific issue, can we address this using a
compile-time constant instead of a config option? It would be better to
do the right thing automatically in this case and not have to have
people set a config option. It will also allow us to not to have to
maintain a config option indefinitely if MinGW becomes more capable in
the future.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YkilVOb9qhI0mB+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzHhoAACgkQv1NdgR9S
9osQTBAAzhPQVuE5ec7UpRwB46kC8ojiCM6OryvTfegjc+mcuCXa6hR4gNz0fMzn
k3TIobFLFBUXaeB8KkU/8TIoklNeSEQZDfzSQeL6h+zpYr+cU1pP1FVgAKhN6pkm
M95p95+hKLZIfqLqkuaov6kRAW/d0DckMtaN5/q0OQ/8bmDZnEX7Rryz6J7XgY62
OPMHfPbdMog9srk8I4gZx7+8u3e0d1EqGdfgRPgxq/hMCPzaH4UNRWTXzSVBNSeV
FTdHy+HfMLw6o/sgnOSoH2ihifLLuSqP9ZS2bb+87LsKyFzC4TL5TbuT2gsp8dbi
1SebhrzZ8baKhZHnQ96vcwjxZ7rfBGWru0QkR2+15zW0kCKbrtdjF6qj8dJgKlyH
z6lOTT15vfUJiWspcamFD4WlnrMgBczQ9ie9JX6TH6wLFQ4gFeR44Q9Ja8cRj0iW
/drmGBLBp8KsecHugR/RrQcsmRUmLFQ/CE3N1JnjyDO4qIKLUQZDKmpaks9D5Cb9
4O4yUmfSfYNy25PnZaIkz1DRqCOZgbXosBKHUerc/ayCm9oVPvqVgkc0L9VWhjI7
O0bpFiSxbl64vwmRcFIBViGADvMzkxuqEv3J7F+Olxrr5dCMgSUvc0YVTzgo6iuo
e7xp4ovvMz0SgZxJZzKC2uVExKWjOlBMMePlbjskbZPbW6zgBEY=
=5azj
-----END PGP SIGNATURE-----

--YkilVOb9qhI0mB+X--
