Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474DC433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C48C61288
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 17:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhDYRSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 13:18:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhDYRSc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 13:18:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F070F6044F;
        Sun, 25 Apr 2021 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619371042;
        bh=eq8+4TB9DUhhBqglAfNm/3j7Kv4vohxByx/kcHWktS0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PZlI1rcK7cgJ+ny7EG+2FOBHep9hYTeFlQpPNxRsYsGqZG/OLyLeXjejsAunG1LQA
         auIkB3Coj1n9FGp8wi6a4n9lSZJVLrZGwI2mhpxTuGJ4HFm0ybRcI/D0t7nrf66S1x
         2BISKHIeghKu/CZJfw85qmYv7Ki7QOlh0NzIurBuaBcaIU7KJT32ERJ1eenNJDeZ1Y
         Ga7/ou2lkFfjKBL8e1EMtytZogE7D7oHsRyeCzx4X6NLdGEbBIeBzxWwvcIk5yDhG3
         qT0h8qIxZ3wsuEhjYBH0S4nSirsie3609fS/Nbla14wvXa7zljvHdhlYt5CW47/xN4
         X6rQG4wmI6/4QO5yEBtZRfjBes2oTKYTpDhONumlhaW/BBVMOKHA3cEE6BmA8Wf9qj
         KTRU0vDAEIFA3EtqncpgEP6hA5yEvJZJIpmVL+Xi2ZJk0KmVheR7gQNhKWoEUyQ0Tz
         pjQKOavTpI04PDeVAJ78OoEz1cgygsJxOjR0lu6cZDqxWsosR4w
Date:   Sun, 25 Apr 2021 17:17:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [feature suggestion] Improve stash descriptions
Message-ID: <YIWkHBfb4g68Oxr3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
References: <ff84d047-c0ae-86d1-c210-b2b777fd8184@rawbw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="05F4f2pbzEYq+Zrs"
Content-Disposition: inline
In-Reply-To: <ff84d047-c0ae-86d1-c210-b2b777fd8184@rawbw.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--05F4f2pbzEYq+Zrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-23 at 21:16:38, Yuri wrote:
> My current stash looks like this:
>=20
> $ git stash list
> stash@{0}: WIP on main: 12c63aaa3b13 www/yt-dlp: Update 2021.04.11 ->
> 2021.04.22 Reported by: portscout
> stash@{1}: WIP on main: 140f08246898 devel/py-PeachPy: Update g20180225 ->
> 0.0.1
> stash@{2}: WIP on main: d42e82e4a336 security/hs-cryptol: Update 2.10.0 ->
> 2.11.0
> stash@{3}: WIP on main: 62851ab415cd dns/subfinder: Update 2.4.6 -> 2.4.7
> stash@{4}: WIP on main: 4eec712dfdae math/gretl: Correct PKGNAME to be
> 2021a, not 2021.a to reflect how Gretl is versioned.
> stash@{5}: WIP on main: 725e4e9a07f0 devel/py-fypp: Update 3.0 -> 3.1
> stash@{6}: WIP on main: 200eb286c368 misc/py-orange3-educational: Update
> 0.1.8 -> 0.4.0
> stash@{7}: WIP on main: 364ab57861e2 misc/urh: Update 2.9.1 -> 2.9.2
> stash@{8}: WIP on main: 52c6d02708d0 science/py-nilearn: Update 0.7.0 ->
> 0.7.1
> stash@{9}: WIP on main: a9d5d9e05bbf New port: biology/seqkit:
> Cross-platform and ultrafast toolkit for FASTA/Q file manipulation
> stash@{10}: WIP on main: ffa307fb4dc3 games/iqpuzzle: Update 1.2.2 -> 1.2=
=2E3
> stash@{11}: WIP on main: 195f2e27fd72 math/py-libpoly: Update 0.1.8 -> 0.=
1.9
> stash@{12}: WIP on main: 4c2cc95952a6 graphics/mesa-devel: update to
> 21.0.b.4390
> stash@{13}: WIP on main: 4c2cc95952a6 graphics/mesa-devel: update to
> 21.0.b.4390
> stash@{14}: On main: audio/tuxguitar -- .
> stash@{15}: On main: math/[py-]python-igraph
>=20
> None of the above descriptions are relevant to actual items, for example:
>=20
> $ git stash show stash@{2}
> =C2=A0devel/google-perftools/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0devel/google-perftools/distinfo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0devel/google-perftools/files/patch-Makefile.am=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0devel/google-perftools/files/patch-src_stacktrace.cc | 11 +++++++++=
++
> =C2=A0devel/google-perftools/pkg-plist=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 ++++++------
> =C2=A05 files changed, 23 insertions(+), 12 deletions(-)
>=20
> - description mentions cryptol but actual items are related to perftools.

Right.  The format here is "WIP on BRANCH: REVISION DESCRIPTION", where
REVISION and DESCRIPTION correspond to the latest commit on the branch.

I agree that in many situations this is an unhelpful message, which is
why git stash push takes a --message argument so you can specify a
different message.  That, of course, does require that you use it, and
I will admit that even I don't always do that, sometimes much to the
dismay of later me.

> In case all changes are grouped in one ditectory, like in my case, git
> should append this directory name to description:
>=20
> > stash@{2}: WIP on main: d42e82e4a336 security/hs-cryptol: Update 2.10.0=
 ->
> 2.11.0, all changes are in devel/google-perftools
>=20
>=20
> In many cases it is possible to do so.
>=20
> In case many directories are affected it could say "changes are in
> path1/dir1, path2/dir2, etc."

This is unfortunately not going to be very efficient to compute in
certain cases, such as with large working trees where there are many
changes.  So while it would improve the automated stash message, it
might also make stashing much slower on large repositories.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--05F4f2pbzEYq+Zrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIWkGwAKCRB8DEliiIei
gfsfAQCel4i+yhqLW0/6L2E+AqqAFFAjHZl0JjhYVZOE4y0wsAD+IOY1wXPOlYwZ
YSyNi8al1N4rBo50g2htILaT+aK/1gU=
=0jiv
-----END PGP SIGNATURE-----

--05F4f2pbzEYq+Zrs--
