Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBAD1F97F
	for <e@80x24.org>; Tue,  9 Oct 2018 22:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJJGN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:13:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49676 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725750AbeJJGN2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Oct 2018 02:13:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 01B4E6077F;
        Tue,  9 Oct 2018 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539125655;
        bh=cIqLjc8+jQPSgtIJ+GnwkDEmzpW6ujJAwUR6vQDc5p0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bxd8TJdkkDGu/bLahD9b1HNNwNkRYAaVvMZY04BzpPWezizTq094NKZuIH5CiKGPe
         63QVnN0IGVxL/gNKia7IeqiCR3iARggxUtVhLjKyjG6PViq0iqecqXs7jGhxvPKZME
         g1IREodZGYYZLi0JWdq+5CJ7NaurJIg4qJYGSKwBQDW94kEA9gRt1Jb9FIRv2m85eb
         MdOy6jKbEmoohaw8xniC8uM1DEw/6aAtP0rJDPPhIFrtTy8SLKmbKNZrz+hdh6NLlD
         X8EHgSN2PLC0yIo/HqBaAheGLz8zy8cgmwIW7b+9k56xsFX616ObguTrSdbfIe8Aoc
         X777G4BryN5hPMOZJRnDSJt/1iZ6+a3ZQYjvfYfPUPlcLzPg7+aJaUS7a71sUdqEM2
         VrXRN7WlgDhzEAdxH71vgaayXDa31laugPPB1YO5mYx3ucSI8gGWsAnSjR3XkAqqQg
         +UKHZkTUQYxqmkeP4eCB6aVS0ZMQ+NxbeyIZtAQ/uGksc3+bgiW
Date:   Tue, 9 Oct 2018 22:54:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 06/14] packfile: express constants in terms of
 the_hash_algo
Message-ID: <20181009225410.GT432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
 <20181008215701.779099-7-sandals@crustytoothpaste.net>
 <CAGZ79kbirX6i+qkig6R1YOAsv=0BirhAVkar+AdBLyHgkrXYyg@mail.gmail.com>
 <20181009222516.GR432229@genre.crustytoothpaste.net>
 <CAGZ79kbADWhuwk=7jzht5wZkESgT5ZqhhBOkGYGkC1HSSvExEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JViz224v3YRbOSfM"
Content-Disposition: inline
In-Reply-To: <CAGZ79kbADWhuwk=7jzht5wZkESgT5ZqhhBOkGYGkC1HSSvExEA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JViz224v3YRbOSfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 03:34:17PM -0700, Stefan Beller wrote:
> On Tue, Oct 9, 2018 at 3:25 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > This code is mostly here on an interim basis to let us compile with a
> > fully SHA-256 (no SHA-1) Git.  Once that piece is done, we can move on
> > to a stage 4 Git, which can do either only SHA-256, or only SHA-1, where
> > we'll learn about various pack file formats and detecting the algorithm
> > from them.
>=20
> This second paragraph really helps to put things into perspective, thanks!
> I assume this interim base of code only applies to this patch?
> (In that case maybe put it into the commit message?)

That comment will apply to most of the changes to the packfile code,
whether in this series or in future series.  However, after your
question, I was indeed going to put it into the commit message when I
reroll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JViz224v3YRbOSfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu9MZEACgkQv1NdgR9S
9otsYQ/+I5bmRIEXk8mzZhI6rEY6Jp8knHAydt0CYd6mjdf3IAz1X/u+THHFNAVS
obpFt4fsxD9N69hcdakdVx5f5SSDuZgByKX1wGU+pI3g0lCqGU4iM8ROVRviCQGK
t3X81XlliDP0VmPTNAKm1cU4zSBuuHgBC3zVL0mEBGRxaG5zSLMCcKbic5P1k5lY
2GoKRTX1HV5zcfmHiaq+9sNaz3OHunVPyKpQUvHQ32slTQQkxGX3eOiJ5oHsg3rk
DYQPoHWNTGCDUUKZdB46RSZzEEoVomusmdsFVYmiXhERZOsKj1uX3vGplwwLIXzL
ekBux9dhd/QbM2HWzFVQoUNFm4kugBBRpZ/o81bAz5k4fR5wCZ0lYqoSO9G1V50a
KmyA//hQV99uA8Ulltv/YZwA3OfndpNWzVYHnv+fecEkG13wCVu3aVJ3YQh4ZG41
LbY0zaJ2Pw9yP50fT22xYJxBfNbJn4Eq9XyPoNgX2q2duNZs/vGLBigUM7pVux+E
Nc36gXGoA09VzEV7ExnaaE1I/shr33Fi7mhWtnxuYMCDtQaxEdOl5fihRPPSX6vb
V5qfhWm0I1eKLY/Ko20sCDz4v733BJviLlc766Nh/A1y3TgsgUqdqT7Qh0YmI9nK
J/8PymOHRNVawzjfLLoBkd0itpPFIhxZA1a2faHSGRLE+HqEQlk=
=d6RA
-----END PGP SIGNATURE-----

--JViz224v3YRbOSfM--
