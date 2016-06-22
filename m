Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A53220189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbcFVVKK (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:10:10 -0400
Received: from kitenet.net ([66.228.36.95]:59316 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbcFVVKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:10:05 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Pv48g4eq;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466629798; bh=35ZfiO1syFxmkcVq/J3RAfwo9VI1PHgshdMF/H+5dvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pv48g4eqLTpxCX6eiuiVrueXk4nMSMp7S17nnYI3uZxr8XisUha8FD95n38hOlhWg
	 oauiZn+s1/Jt5NVFIC45UbaByhybvZmybd8WRjeqQ5YNoHATc2PKn6I+hQpGckDIZy
	 ZfwDfddYjJYiSYGNBSzWR4m0SdXw55uZTNDmyHBE=
Date:	Wed, 22 Jun 2016 17:09:58 -0400
From:	Joey Hess <id@joeyh.name>
To:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
Message-ID: <20160622210958.GA24618@kitenet.net>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <18617acb-bcdb-607d-007e-552dabd352cb@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <18617acb-bcdb-607d-007e-552dabd352cb@web.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Torsten B=F6gershausen wrote:
> There is a conflict in pu:
> "jh/clean-smudge-annex" does not work together with "tb/convert-peek-in-i=
ndex"
>=20
> (And currently pu didn't compile)

I'm sending a v4 of jh/clean-smudge-annex that is rebased on top of
tb/convert-peek-in-index to fix this.

> (I will hopefully be able to do a separate review of the smudge/clean pat=
ch)

Would be appreciated. It'll be 2 weeks until I can work on this any more.

> (And joeyh@joeyh.name is not reachable from web.de)

I'd like to fix whatever's broken; you could send details out of band to
joeyhess@gmail.com

--=20
see shy jo

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2r+pckQ2SIlEuPHAQKOOBAAoIud0JuoVBoo24GLb1rx306OAJnGI073
C4kR6kExINvN/Cp5YDQUY39RW+C+7YedZ0fgEBwIJun7WvRkioCaX65UeBnkz0Zo
biurYMXx3g3z6rLWYzWD+UDXY82zdz/m3LO7PDs7Q7AbgyRZuq8XYBD1Rw2f0rw9
3ZiXeB5OneKiUerOTug9L8cfxj0Yz1GF/r3Jc8P44JcgwEAnRWpJDG2d+GvCtfEl
uFtAT34dYF1PcHtTqF6lL4wNttQVTNizTWsDO0EdzS4+MCr2RfJAN0iHKoIjDPuF
/Mf1eI1kgwt8eM+k5JeYvibGXehfPV+ficVVwP6KtQ25WaEKIElvxxbnXmX+E3AG
uryI7VMIyu8g0vdKQCUK+IBjMysjAehdC/8bojl0mCMQDVCl0LCDLzvlsox0qBtZ
1mriAJgQX+pR6r9qYkAgJDycxZIlXlKcSkXcZcz/u+BErNHpxdo5+z/s1zP0sSUr
Gf4O6yyMnAN1TvSCb97R3GwbvtpsZHPFVcTbTpoZyn74TnqEvEOGK6d7XK7JR9Ct
omukChbXQI+4VEjqB3moLD4JFoyPBGZERIau46UkD4k2Zx97dAtU5ftlz3Igf5/G
ny83kjX7eQ1bvfbdoT1YBDbAVDVdyz1qswX/pIKxcRh59rP13MWlybCYs3dhKBOq
F4bwz2JaTY8=
=CrDr
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
