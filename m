Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D1A20248
	for <e@80x24.org>; Fri, 12 Apr 2019 17:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLRWU (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 13:22:20 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:33770 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLRWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 13:22:20 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id E2E58340E8E
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 17:22:19 +0000 (UTC)
Received: (qmail 16076 invoked by uid 10000); 12 Apr 2019 17:22:15 -0000
Date:   Fri, 12 Apr 2019 17:22:15 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, robbat2@gentoo.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule foreach: fix "<command> --quiet" not being
 respected
Message-ID: <robbat2-20190412T172121-535310801Z@orbis-terrarum.net>
References: <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
 <20190412100819.24863-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lg8eXa+brxrbjAbR"
Content-Disposition: inline
In-Reply-To: <20190412100819.24863-1-pclouds@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Lg8eXa+brxrbjAbR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 05:08:19PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> @@ -2096,7 +2096,7 @@ static int absorb_git_dirs(int argc, const char **a=
rgv, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper embed-git-dir [<path>...]"),
> +		N_("git submodule--helper asorb-git-dirs [<options>] [<path>...]"),
Nit typo here: s/asorb/absorb/

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--Lg8eXa+brxrbjAbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlywyUVfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsRPdg//bgsisqv6CklTMJm/G29u/7/rNA5SfSTB7jfmHepnoi9YdVcNDVZ0AFvh
0png/0ZMW+VBUUHshMg54rEMIGdNHUxqFd6twUgT1QO5u+t0QmyiFCwpxFYEtZZz
Kqj1dZWlz3vTO9foFgQlzw6Il3n9/TQ6RMPa1JndeDMMbFC8QMR8b7J2X91exJkA
Ed/ECoAY4gI+3PTZSP7oX3iEiz23qePtHR9TYu5roDwyjNJlRNy9vvs1jloiL3ad
C5ZM7PdvtkuhqRtC6EWn0Xhyv5nueBZiuJxIooAVw55CuGaLWBhvug0kQJYYTEig
YyyompdIXqDD8Me5bqWnkyaG7VFTvRMZxahI/b+5ygFpObkmhHhIGokBJyuuh01H
ZbnNI63TXCwGVfCeXvZaYeDuXZIGrQBARMGLqKYgcrQHDkfj4oI9GCaOj3BVPgED
1pNdj2lLpLz6oaNM/NKH78DHZCTWId/3cVABwVXMRTOFrQBJuhW1Z/xn6u8JtPde
YDsq0E8RGqgoe/4AIcA97iKUjIq6ullB+FKa4WRvEQpRxMBKHzCqvDE2N6jbxHp1
uc6aP/XYkq8OwKwDs5IEJ/d8zw9fLDdz/HOqcgqWjJMso5iC7BtvHP177f18jhbL
PlvtEuy/oBARG1N6/R+yqoDEzGyAZVDgDneKS8d3J11KRu+gXq0=
=3fL1
-----END PGP SIGNATURE-----

--Lg8eXa+brxrbjAbR--
