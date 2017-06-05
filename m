Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F33E1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 23:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdFEXLG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:11:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50130 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751274AbdFEXLF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Jun 2017 19:11:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1D255280AD;
        Mon,  5 Jun 2017 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1496704264;
        bh=Wp4eRZuycYnDlMz021oAgbkaV6zCnn7CJSLIKyaeGgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTnldBWBCegon6X5YfJoRy6Bsw9nIqDU79sv8gfs4hAyLHSQ+mcOVOeKeP1Rq2BwZ
         Nnpr01cUYutiAPNf5RTQC4bs6pM2qpYM+f9EDiNAaZzwJJsvSQlM4UQPRIhMW0QH49
         7hPnVWKVuXYar6IcdHxyFqbi/RP3qkA+62eQPVt5EOoLj7KFhccXYGpyHGBcue0RsJ
         bHa3nqUe+V27o4Q+L+2sFuZBFNxYW8SrYna9SyLjRx9VddcEEj7ZQqF0XFNMuVhC+k
         PvzkVSl4iP2SvpvGUJhdMXDmyY9PZck0bo0sl0ASDNXdCNpIJSb3LeAw736htUEyYW
         V0sVxF2MI37kBAwAjmmMSq0KlPkvVy1uYgSCf49oBy9os9urjdklgSHPpLcswHWeWY
         KX/lnpjWCOgCivI0HABHv29vQE83zzZD/d+g5yrIPssu2Z99E2q2K4fM8MpCbJA+pp
         HeiQi1fAa5oqgRsdqqoycT94cCFrbB8n2Yg1F9Orc58FjfsyIXw
Date:   Mon, 5 Jun 2017 23:10:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What does this output of git supposed to mean ?
Message-ID: <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <1496671452.4809.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mdblgkxjgrgwrajw"
Content-Disposition: inline
In-Reply-To: <1496671452.4809.2.camel@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mdblgkxjgrgwrajw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 07:34:12PM +0530, Kaartic Sivaraam wrote:
> Hello all,
>=20
> I noticed a weird output by git when trying to run 'git status' on a
> newly initialized git repository. It prints the following,
>=20
> > On branch master
> >=20
> > Initial commit
> >=20
> > nothing to commit (create/copy files and use "git add" to track)
>=20
>=20
> What's that "Initial commit" supposed to mean?

It just means that it will be the first commit in the repository.  It's
a helpful reminder that some operations (such as git log) won't work as
expected.  In addition, many people want to commit certain files (such
as .gitignore) in their initial commit, and this may jog their memory.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mdblgkxjgrgwrajw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlk15QIACgkQv1NdgR9S
9ot4tRAAneXkQukYqxLsneZZ1gNfY9O73GsD785KjuqpTlBIzZGJLaauRMvaMEoO
oDVF+/DU7Qgosy8yVunw68nwQZaKgx10ZTHm3bOQLjIKctfJ2Mhsr4/venv5duoA
teuYhzvSCm1Fn78JNAJBCUIrVW0V1IgRx+naaCw047WkkAIxPnuR37XvRu5bPUbe
dIS323jO26la8Nz9yKLOcAfJh49Dyqc2wtoSiWWjXkxdTBexmS2EnuckvPwPNytE
3crw0Pcs/YgmgLRhgo1qsrXkquACzAuCWaQbHgHDe+mQ3rbjwHFiWWD53rTf43HA
QgsVjoajlfYBDVbSN4HipEN+xQhg5QabIf87Rc3HT0p7Id8TM/FJONKOf6o41uNG
jkBisXl81GnVvgeeYtnDnwTNJn3if8G4thfxCPdJm4JPrbbzBpoxvaqp0RHJrbyC
8xS1ehrZHGTnJVvpZALTCsNMj3b4RQjnuS/0zUlNypx60ktdTpvtDfXS8glQTjmj
+cmXJlodOfPkuZA0lolYcF49q27uHdybr7LPJlB57HAARVOTpVDsqeHECfb0Kfsd
/b6svNIMnrA9eC5Aq7kYrOETFv3rUbHYSgbUA1R2kLLGrZA+ZtBXdYWmRZvudZwU
TgsxxNcB2UcjnlEpywzNGP9Zv2Oy3QmYqVLa1O0WP8Yh8i/3gxo=
=+TIJ
-----END PGP SIGNATURE-----

--mdblgkxjgrgwrajw--
