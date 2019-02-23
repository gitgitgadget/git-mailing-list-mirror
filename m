Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CEC20248
	for <e@80x24.org>; Sat, 23 Feb 2019 00:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfBWAXr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 19:23:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfBWAXr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 19:23:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D88A8603C6;
        Sat, 23 Feb 2019 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550881424;
        bh=EZ4YkA+R+E8koRzHEWlrLs2xCEZE19jCWdF0fSeEhp0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pPjrGq2K6h4UxdbLBlTlyzfISZwJ0mcCGVSvG70J3hniOZEV6keh42GTh2tIyACL/
         cfOm1g3oqkHTR1e4eydhATn5mCgx1aI9CJpX61swNrfk2qEOztsdgL0MV8rYIckUsH
         aWHy8BDSESr9qWWDy5ATZqTqEWayhBgWCm2XQoVS2HOa9uPa98hWJASfzYAcA/Utwi
         Oq952bk35uzqp1aT5d3u7DG3iK0DodbyFy0C287ZQpYj7i7NPorzM4p+oDn7+mGNFD
         5OkB9d7c8iEwffhlzFsLSCL/cnWczY7NZFIAvtzX7MLdcZWtm2VWim/U8A7CRnMl+7
         eG5m854UgHhq7lhv9ZPb0DmymJTBRUY64lGdhKlh3kvyZwLS9VJjFPSJu+TfWWXC2p
         6kPV3+NWdvfEzHRiz9C7JAjCAVqVDEs9WEQT3Tj02egNx9uM0u/TjiD2T9Y4Qs0pYv
         pLjxh4nmS2uy07ddB2JQ8RJFO9msjVp1ELUo3/75Gdyd4yd/4UE
Date:   Sat, 23 Feb 2019 00:23:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Celestino, Federico" <Celestino@xcmg-erc.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: .gitignore alleged bug
Message-ID: <20190223002339.GA601925@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Celestino, Federico" <Celestino@xcmg-erc.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <b23df617fddf45389406da2360dceb63@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <b23df617fddf45389406da2360dceb63@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 03:39:53PM +0000, Celestino, Federico wrote:
> Dear Support Team,
>=20
> I am facing a serious issue with .gitignore (see attachment).
>=20
> The problem is that the folder contents of 04 - Software/SW Code/STM32/Li=
b/Drivers/CMSIS/Device/ are ignored because of a suspected misinterpretatio=
n of .gitignore.
>=20
> Here are some results that you could find useful:
>=20
> $ git clean -ndX
> Would remove 04 - Software/SW Code/STM32/Lib/Drivers/CMSIS/Device/
>=20
> $ git check-ignore -v "04 - Software/SW Code/STM32/Lib/Drivers/CMSIS/Devi=
ce/"
> 04 - Software/SW Code/STM32/Lib/Drivers/CMSIS/.gitignore:2:Device       0=
4 - Software/SW Code/STM32/Lib/Drivers/CMSIS/Device/
>=20
> Since in the path there is no '~' (tilde) character, it seems a bug to me.

It looks like you have a .gitignore file in the "CMSIS" directory that
contains the string "Device", which is why this directory is ignored. Is
that indeed the case?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxwkosACgkQv1NdgR9S
9osPgBAAhvTD4fNpFyvgDC/tkqgvaZWiel6dGAJcTpk7pxGQxcBquqvha/RyHpJ9
m8ahri3bAzu88VUFu2xJzNkSnkWK8vzHxFnp5SbTVhvwRndknT3rFD3YQqafRY5y
WK+YSJqmoKR5r5x1rDCFEW2KH4E45LPVEeHWuwVEWw8dHz6PUAo+zK3p8qCJvLUq
Of37+P3uwpmjSQXGIZ7wS51PjL8Tcj8tOFpXt2LFTNCRL7K0uaOXQYbRO1dlrI2D
syUd/DSGChXlhe9RrxkwZgpedGvMvEh5mSrkmDR6TnVVIbjSR31PucRjOJNEFh/1
4CHJ9tZdcPoxXfqNy2dYAVdSbk+TDph4gUfShh+tYQWI5PZKS/fFERBpoO9xvX+e
P029AezUwnH8e3TEpcBMRihEPZQD1bLMwIUnCtEvE9NRZwdZ/xBO1pFEHb+lz7YM
3DSROavxOJF+TdeqHtV4RB3J0nTdawNCobbWv1CqH0GsHsBUGQwUU6Z8C0rv6ww3
ij4Ql9BMagh9nW0aNA3OEQhsb1k2quS3m04y8RxsleV8+LRvHAa8xMX0TzRnG1hr
3t6NqHPSMBekd8H9dtWxgeqDCmJS9N+4rYqf0gYwmyT2ZrACrczXl3UkoKTC4/q0
hs5R/rESf/w9pzM11Z8E/Pz0S2rrJwdmMV+Icea962rfRuICJLQ=
=CJq2
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
