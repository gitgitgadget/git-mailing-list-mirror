Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096DD200B9
	for <e@80x24.org>; Mon,  7 May 2018 02:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeEGC2K (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 22:28:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41388 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbeEGC2J (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 22:28:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 13EA960444;
        Mon,  7 May 2018 02:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525660088;
        bh=nvH7nW8rR0d+m+2S59i4d4nE77la/V6MS6hik8YfrO0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ye7hzF/kPHotiZmcMmDKf10sbjst/1lw3F86htGcjj8BlK+AmqB5sZr36MrnoByqm
         auuQr45DTewmRcIYdCjUZX5OaVU02PVUENLOApm48rmZre/0Oym6LTUtryyjQ1RtzG
         27YjvWYa+EDDvRqSB7/76Ung3kpARfO2AtS5+hEA5XiX5pvaxDESXJI0qVSoRrUhyq
         UdWfbtCHwr1mSN6BJthpx+/7Wp/74zkVazfW3Azv21GpBlv0/dKy557WCPAADxwjBg
         bx/LybrKDg0gycDCcMkYeJct1kgRbLBiXxBu+rYB3coPd2o6TyKb1wJYz51qzga2r8
         s0oLiOYEnwO7ASyNnxE1eg5IAiobvkS2irYny3EqjAUK2m/YxIBmUCX0eiXOsPHHs5
         7AGyGGhTsfzHlq+EH69Qp26e52yiWEViT8J7N/9JUvDEIEBSo5z80uMfyUIPJZJRdb
         ZGOEc6c837a1ELru+jM82r7klq95bQweAFIN8AcbVLtbTShShq3
Date:   Mon, 7 May 2018 02:28:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 04/28] t/test-lib: introduce FULL_HEX
Message-ID: <20180507022801.GC953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-5-sandals@crustytoothpaste.net>
 <CAPig+cTrLseKxznrMb63rQ4NK1JYvPraV=Bz6vbnO0sY6qkK=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <CAPig+cTrLseKxznrMb63rQ4NK1JYvPraV=Bz6vbnO0sY6qkK=Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 07:53:42PM -0400, Eric Sunshine wrote:
> On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Currently we have a variable, $_x40, which contains a regex that matches
> > a full 40-character hex constant.  However, with NewHash, we'll have
> > object IDs that are longer than 40 characters.  In such a case, $_x40
> > will be a confusing name.  Create a $FULL_HEX variable which will always
> > reflect a regex matching the appropriate object ID, regardless of the
> > length of the current hash.
>=20
> Bikeshedding: $FULL_HEX doesn't convey much. Perhaps $OID_REGEX? (And
> $_x05 and $_x35 can be named $OID_REGEX_SHORT and
> $OID_REGEX_{something}, respectively? Or perhaps they don't need
> renaming?)

I agree that $OID_REGEX is better.  Thinking about it, I'm wondering if
$_xoid might be shorter and familiar enough to people who are used to
$_x40.  I'll wait for other people to chime in, and then reroll.

I don't think the short forms will end up needing renaming, but I'll try
to pick something sane in line with the others should that be necessary.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrvubEACgkQv1NdgR9S
9osvFBAAjbkqv0RDNBBnU6sGbRRMZ+gbvS0gr1d9j5g0bz8MJ4uUgUMqYuUPOLix
hcW9meb81cjm7vwZAV83s80As0PV5xnULfGCUH5dkptJdDZ7G5MHYBQ6v2BnLUMq
whAprE/JnC2qhvWmxtc53u/EgAc7+A8XO180n+TqVx6/l6Pg0+1YEBiYdXr8oexZ
tzDZ4ExVrtWRax/ZbyxUDixAGBBPp43etHxJXyCGi3xhAQRSrAxUhukslMtAcm1N
covZ5O0h0YAj1rU3QTdDUp+d/6/P/BBdXTuJeTtPOHDkedLmPhJPT/2l6IIV/7zz
xS6Nejnt8skSiJywuerK9qvRJy7prrpcaB3yqKUmzm6RqXdEWqarydur+tKYn1om
7aA6Hk4YpauqSq8+AA2w085CCG3ZZoN24CVy87f7aRClfxQeJjhKMSgLLGbJnLZs
zboo/+mQdCowwU6x1BWgj67lj80iK/oEh8Pt9ApLbEil6TSbM6kLFcumJ69IUr62
T/DY3gaBVWmja/eCsl+jc0s57DQJnguCQoWDqvZVitcrpwlBak2kZHepf9al6tEg
mA0mO5ttKWL/I+CEsJmb3ThmLNVgDliVcUMsDTFS0FQiwNgt5vHqDmAJuYbI+x7h
17SrkaEh2mV2MwdeS9Z0CgUyyGnAwCX8NTmptxbZFuoUBR0FDwc=
=i0en
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
