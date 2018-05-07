Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21464200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeEGXlF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:41:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41990 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752954AbeEGXlE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 19:41:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 000CF60444;
        Mon,  7 May 2018 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525736463;
        bh=4Gx0hUe93y1wjAvi1TiElqXGDskPXpBJIKX7l9k1aIo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xW1j91w0E65/d55/FLpZnqvDjbVkZPC5w3P/tfbxMu23qyYmrkYOE3hB6oiDH1V5R
         pchUchN65hY41nlWgJkrpMw4d1kLqoPzEcEmMgwBxk9POFp76SgBGYwuBVbcRkxLw3
         BUOMv5/MPv26CnaLN46gWekx2t0CTBrkoJJBylDQCTP7MSsR8zkm0ORqG7UlO91Oc1
         nq40KinpjahZCtGoHL1tCxbmTIDCCsIxaNAuvr8+XualHr6eUhRw++OjPJZev447/K
         19ATIiMsLnfO8gcxjLxEgy+1xCkBhW5ZXh5NvkxMDw2swr/YTcUpOgCCC1/1X/bUqI
         t7F173IzOA0Iem0NOeqfptyo3pTzz2Jin4n9w6BWxxjpFh3u4bhJKJ+xeooYWMuhxs
         KYTrUxzZ0MQAVqLup3sIXzqsDLxheBBRHwmkquChQFSts/8Ah4LGlSq1I5XejacpRL
         N7y8+My74RvTHSgy7ZPdbS0zR5F1Q0qp91rTkMA+U7XobixJgr3
Date:   Mon, 7 May 2018 23:40:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 06/28] t0000: annotate with SHA1 prerequisite
Message-ID: <20180507234058.GJ953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-7-sandals@crustytoothpaste.net>
 <CAN0heSqu9gwsrgV0rnPe8=vANhBA+Z7fZ3UNTeG9S1QiJBsksw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Content-Disposition: inline
In-Reply-To: <CAN0heSqu9gwsrgV0rnPe8=vANhBA+Z7fZ3UNTeG9S1QiJBsksw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 12:24:13PM +0200, Martin =C3=85gren wrote:
> This could be more centralized at the top of the file, more likely to be
> noticed during a `make test` and easier to adapt in the future. Maybe
> something like this at the top of the file:
>=20
> if hash for storage is SHA-1 then
>         knowntree=3D7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>         path0=3Df87290f8eb2cbbea7857214459a0739927eab154
>         ....
> else
>         skip_all=3D'unknown hash, but you really need to expand this test'
>         # or even error out!
> fi

As I mentioned in an earlier email, I plan to set an environment
variable for the algorithms in use and then do something like:

  test "$tree" =3D "$(test-tool hash-helper --output known-tree)"

where "known-tree" is some key we can use to look up the SHA-1 or
NewHash value, and we've specified we want the output format (as opposed
to input format or on-disk format).

> When we add NewHash, we get to add an "else if". Otherwise, we'd be
> plugging in NewHash without testing some very basic stuff.
>=20
> Ok, so `skip_all` is quite hard, but skipping certain basic tests also
> feels really shaky. Adding a new hash algo without adapting this test
> should be a no-go, IMHO.

I agree that this test needs to be updated for NewHash, but since we
haven't decided what that's going to be, it makes sense during
development to still test the rest of the code if possible so that we
know what does and doesn't work.

This is a first step in making it obvious what doesn't work, and when we
know what the data is supposed to be, we can adjust it by fixing the
tests so that it works in all cases.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrw5AkACgkQv1NdgR9S
9oshiw//UCb07M85MUzjN6S2UrdiNl5RtOaQowaTeBgGi8fKV0SX2ojxBNNVqbT9
0Vbfn98yxXTEO/8t/1VfYADgqb3cIA5tb2JUiPcFGmWFD09pRbCJMc+TVOkBvhAw
K7Wv9V42J78N+J5OOO38u81oB0R5E7KcuBvrxsaWReX6XKqilBau1rUhA0bOJMHb
Qd9cq7FvQFyDW0XhdG76Z3oqB5GKTiJbA63uNz5shpPworM9dBp6sTxrY4YLVstv
VB5FbNZ1o9TNz6K9fMVT74ido57aYQZj3g9/0De/pqglLQ8Vg9E1QY9su9bjMWFO
S5tZZRIEMy2yAvAQbRvH9WQozjRnoYh0fl5QDDFYFhgjEbwD8b+TW+IfgfLfTycd
V0DpfbiB5f74am2+bj/x2Mkhs/vgJfjB4J4r2ls614epxXPD7W2QXUmW3T4PLfY1
cS2zsGezQjzgXRsEyqCONg95+A+SsO7E2kt+9bw2dIuJlh4nMEN29P5kS2ZMHGr9
mo22J44vxBbS7ihriBiLWUKjrq5bv87u3uXta1Wi0j+2vMYCtKVRN25Bsy+Mqtgb
VlfpRqqJRsUjAdJX60wYwP4VZ94AiexHqepGTCcIblmHVWzpX/I2J3aPJHp0aCk9
yfqS1ajsottq92lDFcK80T5/wolPV9B5QTZ4E1PdVQUhP2iRHyI=
=XecP
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--
