Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A3020357
	for <e@80x24.org>; Tue, 11 Jul 2017 00:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbdGKAKs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 20:10:48 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57672 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754832AbdGKAKr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jul 2017 20:10:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 512BF280AD;
        Tue, 11 Jul 2017 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499731846;
        bh=NmnUMsrMJBYm6NCsUYRgC9i6HFdAkZrH3b8zBoHPIf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxhl9GZL9BA7RB8fS1TiJiBFelns/aFDdF8Z8CurvgyyL8P2I02II8IG7ssKpx5FD
         yDWlkwq9BnPqHU8dQauzNrDZHpEith7RkU/HrHj6Dt9+QlHzIkeoVc2a50VmoINr5s
         hi21Y6Sws9MBRsQRPwRsYA+WpCO3vFHP3yGaUbW8fZLOUFJTNaTUZpIrt9yKNvu0eO
         56JE6ukD/GyMi5aSKd73RNxPPind/4Vfw0GjlppntUhDS1sLR8bD9c2UdQNKXnf+c2
         H56g/dI2tHGOq//E0HUTenGPsMb5fI/LhXE59J7+glUi2Pz/nUK9A75A6BoqYw7Ro9
         a5BGGLBh2zHM33/0Hf+PYOmOvBGljzkOxySTKhZDUp6a5AATWsLC8+P6OJypMnx4I6
         rQ8G87p100RT9PMdJaUeFdTwUKAr+izJc/AfQaVQo/iLrJ78G21Ptln3iHXi5xWlWy
         DGAaDxpDdwOPx8vTZrONZdInXQXY1IW9wwGlkfouI9oUtnXvW+N
Date:   Tue, 11 Jul 2017 00:10:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170711001042.73ht73fvecjoprt5@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
 <CAGZ79kbWQT9n9BAmoHQsZfaEC5GahgOfOVAQGTSGWU1Np8=Nkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uaa3a63whiqgo2aj"
Content-Disposition: inline
In-Reply-To: <CAGZ79kbWQT9n9BAmoHQsZfaEC5GahgOfOVAQGTSGWU1Np8=Nkw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uaa3a63whiqgo2aj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 05:07:43PM -0700, Stefan Beller wrote:
> On Mon, Jul 10, 2017 at 5:05 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Mon, Jul 10, 2017 at 09:57:40PM +0200, Johannes Sixt wrote:
> >> It's a pity, though, that you do not suggest something even more usefu=
l,
> >> such as C++14.
> >
> > I have tried compiling Git with a C++ compiler, so that I could test
> > whether that was a viable alternative for MSVC in case its C++ mode
> > supported features its C mode did not.  Let's just say that the
> > compilation aborted very quickly and I gave up after a few minutes.
>=20
> ... because we use reserved C++ keywords such as 'new' as variable names?

Yes, that was part of it ("template" stuck out to me).  I don't remember
all the issues, but they seemed quite numerous.  I'm sure it can be
done, though, if it's valuable to someone.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--uaa3a63whiqgo2aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllkF4IACgkQv1NdgR9S
9osB3g/+KhvoZE4O5EZu/8LoBtChAaP642RniBdBPaF9Pd7bJdmua0/8TSksMAZ7
jJBnyhvEp1DFZFlxpU70ZFwuTIKaRUedLFvCTHrP9AcSYPn4A3NZqMAFYAHwFCb5
lOsksmGzmoR5jaPe8vBgOcINka5DO/Zxa5qITJCJ2bwayXTpWr294ishKw4bFoYx
aUazZDGGwPXzdHz2KMErOfBlA4/XECI0/MWZHUOeUek28JjnOa9GK2EmDqWUeW6Q
Z2tFQa1JytlrbDF9ymWqjghMZh4xCgrCqIpQ8VgC+KuSj9R+ICZuTBuEUPg+GmZI
jfRq7UIFfG9r6mRjOsCaj8WNU56TqPgxzWYdEZKR3exmBNq9iRyuyC/BDYVURUgJ
gOP8KlfhSoIMWHKeVWa2y617wTyeVIAhfEEAb3kq5u54UebHaD4NTXk6Hd5oyaMF
zInPD006fbkyI/QaySB0FjqZ5sqLyDHyUdmgv9GNllvE4XikKsprqjXS2oh1xv5r
Ao9p2jY6k3vXheBz8ddJdONpqM+GIzRKHJCs2MoLlC3SHGwKMZy7xJwxXsusAtw5
9OtP25eApoy0M/+dg6E30z79fjqicOb6Q/+zoJ/QPQWtuZntZyWFeaqKECP8lqFz
CIBoVvfp7JPxs4PrV8OVG1KmBsroh5MRj5gIDmhKH1yslJWyhhQ=
=TEUJ
-----END PGP SIGNATURE-----

--uaa3a63whiqgo2aj--
