Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065E7208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 20:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeG2ViK (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 17:38:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39422 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbeG2ViK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Jul 2018 17:38:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 20CEC6073B;
        Sun, 29 Jul 2018 20:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532894789;
        bh=yzCJv9q8iSOcUIVceD+FCMMXtomC/V2DsharODOQ8go=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cU+L0F6ZgUBNdFWiWxmO+oMUHiGv8lNfLr4fLpY5Emk7ypT5JS36Jx8hDhW8GhgLt
         GSeO1/+j8EHrpvgyIN3pbzbS8h6VJgluR8jyqxzZ7Gj+nCTV9QACb8iBJj6P639oOJ
         sApJQ9OtzuGVbpWFItP4ImU/1JeoYYGlszLulPApajK86mIAx90AGt0Y7ZFb/zugkA
         1jpAACUxOc5fzy3CTmwlq+4yS7li15T12rofZLO+IllKuhFn0XYbpTV2qJlB7Hx9io
         kHOa190goGLAHFQ5JumaE25SIItW8XEwPUM5BHxrhk60K5Ud3A46M8SQGe+jGftvy/
         HfNRubARnkAB0w8IHwD+Hrx/I0WdMMsK7rQuuehj43ro8In3wxXiIWNwy+p4ifHr1Y
         8YxfWG37d41xLx+cvxI1JFazU2RS9zb0wnmfGe1sbz+eOzuBv+zCdHA+B8AaorNeoo
         Sv/VU+nE3139tqsISC/dFoCCQ3J5pJN6o6+Jp/1/10xV39cVSuX
Date:   Sun, 29 Jul 2018 20:06:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael <aixtools@felt.demon.nl>
Cc:     git@vger.kernel.org
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
Message-ID: <20180729200623.GF945730@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael <aixtools@felt.demon.nl>, git@vger.kernel.org
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2018 at 09:48:43PM +0200, Michael wrote:
> On 29/07/2018 21:27, brian m. carlson wrote:
> > Well, that explains it.  I would recommend submitting a patch to
> > https://github.com/cr-marcstevens/sha1collisiondetection, and the we can
> > pull in the updated submodule with that fix.
> Not sure I am smart enough to do that. I'll have to download, build, and =
see
> what it says.

The issue is that somewhere in lib/sha1.c, you need to cause
SHA1DC_BIGENDIAN to be set.  That means you need to figure out what
compiler macro might indicate that.  I can tell you that a POWER- or
PowerPC-specific one is going to be a bad choice unless it includes the
endianness, since those chips come in little-endian versions as well.

_AIX might be a fine choice if you know that it only ever runs on
big-endian chips.

> > In the mean time, you could build using OpenSSL or the block SHA-1
> > implementation, and switch back once things are in a good state.  I do
> > recommend using SHA1DC for things long term, though, as attacks on SHA-1
> > are only going to get better.
> Any suggestions on where/how to do this?
>=20
> root@x066:[/data/prj/aixtools/git/git-2.13.2]./configure --help | grep -i
> sha
> =C2=A0 --sharedstatedir=3DDIR=C2=A0=C2=A0=C2=A0 modifiable architecture-i=
ndependent data
> [PREFIX/com]
> =C2=A0 --datarootdir=3DDIR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read-only =
arch.-independent data root
> [PREFIX/share]
>=20
> root@x066:[/data/prj/aixtools/git/git-2.13.2]./configure --help | grep ssl
> =C2=A0 --with-openssl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 use OpenSSL library (default is YES)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ARG can be prefix for openssl library and headers

If you're using configure, you can use --with-openssl, or
--with-openssl=3DPREFIX if your OpenSSL isn't in the standard location but
is instead in PREFIX.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlteHj8ACgkQv1NdgR9S
9ovhCRAA0IYYkk7CRfOo+36FLvnKoE3cuumyxQyYufuAZCr/KJVtw6keYEr3NcMe
0A/P5sOD4pQQPwtwtl8x416WkAaAjiEv36o+kcB+TRyvtzEyMD1O1BXvhAXG4Vv6
K/j59bc1LHUcCXkznVwOkso7uJKvC1AxgmiOPrlxetAWUgS2R1sBcWeR1R7Jh8hq
xza37+eyoALKhPgXBi5URfNB5TJHdqm9kKTpv2PL6DFOWVmWpE8QREeFMzxXSSDo
ocHs69yd/qBehCQ6VT71/Vz38peN2fnAXtRepnfy5iWD017Y9TKFvZbwMK48nXfR
3AXB72VGzyNc0YmiQEEFPdKvz8DVUfJMLrhOTphz61o14GATy9pFvsffOkmFC4Vk
bezwEA7oS2CpmogbyAywflSUkddBOpRju8EgDDuQdqNId5jpSgcjrl9GAlHjNvTb
xEMqe6QBWWnqzT2vaomnnob9Gop5gj2nmttoBIXZYjPD2BYqFhYGhj3dbmotP60M
zVm5GFSH6SH3wowODcnLQLF5XK6TA2Ldvr25fIxM2BIYQm9lPqUcY67Vj4QQSYCs
w9AeZsZApB66ipnmqZeKX9lKKRXOwSW37JBt5c+88OADnnMS3nAQY/AuGDXHnUyP
q60LUhlp873tCdlbPyvu+pMtXwJE2JcjpdIFvwIRzQKJbLFuMCo=
=4UnU
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
