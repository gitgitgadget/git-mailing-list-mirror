Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6678CC34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3624C20578
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gzYzgUKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgBQRRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:17:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgBQRRW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Feb 2020 12:17:22 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8FC2360478;
        Mon, 17 Feb 2020 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581959841;
        bh=G5lqPEDLPqlFdzDvjlo5vFbyCNFI7+MuZeDG5KjFuwA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gzYzgUKpNYIuWpOZ4eCtlXrWdlRzhv3oyz5qewmTMHQbEE0dd+tSNqf3TQw0kLdUO
         ZRlZfygcTbWBW08L3DJSztAyolUVokJ1SHMD2RaDWddpi3rTrRZAmNiAkUduHcTe1k
         MXCm50eXxomH5P3cyr66USFs/s4exkciY5a80pjOyefhiRuALYq0n5CJmaYkZJspN1
         WZcp8mZ1BoZQXKiuMORvjRCcrFVnkOyNYS+e9KOwTsC7FO6mWC5+yOob8PJl0rqGUb
         2cdBjuyUdiFkMyDSnEqXYh5goi5BjdICJhogL/zdLZGQAVi0pCFZjgkuOkpMGUXART
         cEXQ5sOZ5l5QLo/sucqhvpqxgoYeGJbx6b/tWdqMNB9XJw77IhPc1NsId1cm/9tl6z
         pChQRJFYB2eemrs2Krd+6DR7/o0GGHzEZahsd0ko8P+94Vgh3dym657KBW8xr9w7In
         nyngphtKheJwwxJOdbGXgEZbElUwMjQy+mtVmt9JzJou3RIM47+
Date:   Mon, 17 Feb 2020 17:17:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     lyle.ziegelmiller@gmail.com
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ! [remote rejected] master -> master (unpacker error)
Message-ID: <20200217171717.GG6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        lyle.ziegelmiller@gmail.com, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com>
 <20200216211604.GE6134@camp.crustytoothpaste.net>
 <001801d5e5ae$e4375780$aca60680$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <001801d5e5ae$e4375780$aca60680$@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-17 at 16:25:38, lyle.ziegelmiller@gmail.com wrote:
> I wrote a bunch of emails about this in December 2019. Did they all get l=
ost?

No, I don't believe so.  However, sometimes people get busy and things
fall through the cracks, so pinging like you did is a good idea.

> I'm consistently able to clone the repository, but I can never push to it=
=2E I used to be able to. I've explored all possibilities that I know of.
>=20
> I'm using Windows 10, and the Cygwin version of Git.
>=20
> $ git --version
> git version 2.21.0

It looks like you're pushing to a UNC path, and I don't know how that
works with Cygwin.  It may be that it used to work, but something
changed in Cygwin or Git.

I've CC'd the Git for Windows maintainer (Dscho) in case he has some
ideas.  While he doesn't package the Cygwin Git, he might know what's
going on.  I'm not very familiar with Cygwin at all, not being a Windows
user.  You could also try reporting this to the Cygwin bug tracker and
see if they can figure things out.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5Kyp0ACgkQv1NdgR9S
9ov++xAAsAVZKqW5oJWAcoGm+3VIkz3OSjD9vikh0VuWZ6KICMeq7KDPYjjE9SX+
MB97l8KvyvBenPlMT5K/Ec0pPPCjN93zzkd+kVO8UVMyxWAX6HJmIPscr5m1TOKr
njvzqSPDgoUQ5GSXSW7TPqwPuF1Obv6ki65lnwgt6+lJ1myJS4WCR/S1CSDSH8K8
H+vLJO1hi7Wb2qYRuqfxr4ynojBToa79ijzzQ/9shwv3PyvP/WtYTUtw10rSpmTQ
GYpVv1biuswDjubiboCLZ0hcYLOwrhLb+/YY64Rjwxfc6Ay6Y6B6gGOc8gxuZgQQ
oOD+v8z2GUO4R+ULdTd+uG2SWy7ENCLfhfkAKapUE7ivm/dZC2Zr+/3EspRDCn1b
Mb02r8Z0pqJm1XddMODtwPpauRv4/lHIoS5xWkKGCVVbo0P/yLZgDqBfzqfuNnSj
3GeY3qDtlZbPazgjOn8m/OwRV1qmsSvdgwcyErTSEpmI2/RpL2VC97q0k6lmsoXS
tcsGyBimAcmdAcf9BhCSwMPrEjNT0w/sF6x9IaVhaEnlEoxjmaJvokkuNuCRHQAK
vIZQmQKCvDXzfcoQq4QbLYMfnx0Fr5O4HBSz0hOsDp88TWbQG8bTczqRmEJ+OYqT
g5kHhxLku6HdCG0AJEw20cKB/sjdkSP02vD8ZT52Qo2Y7k1bPDE=
=7/1x
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
