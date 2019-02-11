Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F421F453
	for <e@80x24.org>; Mon, 11 Feb 2019 01:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBKBU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 20:20:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfBKBUz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Feb 2019 20:20:55 -0500
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E58BE60443;
        Mon, 11 Feb 2019 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549848052;
        bh=DWW+p80251HWFWKz4Y7clQW9aaEs2yV4tBMTKZAplPQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Z8VQYWb2thwiklHz5EMs4X/4AoTbLwrvYVfvfCDBXub+/ZILu280Bj3Ow7WXVizRw
         YrsXnYL1Z5Wk8a0xizA20kYqwAissisplp0XqmDY7il5tToAw0r7FolsyxODtfq3j+
         8mmNV7RxUoq2kHbXCwkip7cC6mraqt+CzgP9LuDT2LYrqeNz6+JXvKyMaztQ2syQzi
         2QenlAFSYRuGHHeCoRBkwJkKNXz1caJ2OToS85yO38xbdv3SPn23mSqn6EK7qXgl4K
         RFZqbEpvvJjg3Myf9uwdTMHQSbMc2go03jqPpygru4ziJ213cdC83ji9OdoqIIOTu1
         XJ2UU/x9cPLPxEhG5Hp68PD3IDZ2lh6WCVTl88bef7YgBD3jHwLoF8fHRoU92RYl4C
         v86l/56oRzDSdroydjYzov3YEKU+RigPSn4G1CUQv/iyrxet0gUkP+Bn5au1yYYdEt
         i2No0rU5+G6LwDGGrrrPMK6fZDqyXySzMj9g//gWOxkcsqGV1j/
Date:   Mon, 11 Feb 2019 01:20:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v2] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190211012047.GA684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>, Kevin Daudt <me@ikke.info>
References: <20190209200802.277139-1-sandals@crustytoothpaste.net>
 <20190211002307.686048-1-sandals@crustytoothpaste.net>
 <CAPig+cRTRCeGZ115gJGGNPtQ7WyFWg4Y45WOPec-8CmnG6ZRMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <CAPig+cRTRCeGZ115gJGGNPtQ7WyFWg4Y45WOPec-8CmnG6ZRMQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2019 at 08:16:26PM -0500, Eric Sunshine wrote:
> On Sun, Feb 10, 2019 at 7:23 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > When serializing UTF-16 (and UTF-32), there are three possible ways to
> > write the stream. One can write the data with a BOM in either big-endian
> > or little-endian format, or one can write the data without a BOM in
> > big-endian format.
> > [...]
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>=20
> Premature git-send-email invocation? The commit message of v2 seems to
> be a bit different from v1, but the patch itself is identical.

Oof, I forgot to run "git add -u" before running "git commit --amend".
Thanks for catching this; I'll send out a v3 in a second.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxgze8ACgkQv1NdgR9S
9otP4xAAjf0ixHNqA0efgo+IEMFatIzh0ygd5tG9BEyc7GNFZNnjybs6iRnVrpap
5XrVB0qDnjPBfyiZCjpINH3SnO7FSz0i8ihYuh1jAZEX5wfQvVJ0X+inrzQWpaQe
vMZxWtCHaCgKxGuEkUJWDCQ6MbNttPFVb59geSCDyk4Sf8qcT9Tb9eEteZAIXiMc
6p91IFWFdFbNVhA6OavuIZ2HHYTEFRkwi7EUTzZie4gKxZD0hZC6ySl2OypVGoV0
790r+FRNeUGDECPtBu8p7Rf74Gv7TZK89Nw6KU67NIXkElyashOF5leUbOD9FToq
DSp2CqWBmcOT1aApYKMvwVruMvbpoqcU4ScZ/No4c1ulct03v2c+u6MNFtDfJ1fM
Opz5HouQWjlcdhaIPzYcMu3qZb9c2ljg64I4hJ3q7xAgk82dEn2gGSIDCDPWgn/t
sECc+f1EqMOds0BQJSD4P3Z4BTIXJHaMqy3J6yuBWnVuPu9yH/YX1ERsGM7+IUHZ
EwXfsSXl1pWHdtAMvbSTxAPN2UMNgyPu5Dh/RDK5OemqTuA2QZ+ZuL1v7yP3ySlI
sgoBECqvX/i1f1DoiCEAHJQVGHoSlCh4VGLHSgEMV7N1jMyDInI9snUfYG1/VTHP
Wo9gkP7UPocW2S+RxYmE1OUYSunxaZZB3Jx+u7vo0j2wnAdgeQU=
=WL1G
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
