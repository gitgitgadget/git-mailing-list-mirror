Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CF01F463
	for <e@80x24.org>; Sat, 14 Sep 2019 19:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfINTig (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 15:38:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58688 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729470AbfINTig (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Sep 2019 15:38:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d92:edb:bada:18ab])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 79A886042C;
        Sat, 14 Sep 2019 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568489911;
        bh=0fj1k6x6SQGkfxzWc2Pj1LieRYDQnkKZNgpr0+lQSBc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=J9taqdqCgMTNBSKi2DkxculPEJBEU3Xj4yT1ioE0dtcd9BFIFP73gxP2UynUZuWmw
         bVE2skV7yPBzd6iBBHrV+GQXVYqNVwoKvZCX7ir39KdnNH1c3+YrPF+72sYoEu026e
         6SL+y47Ku1eKxYD1m8jlFtWJVvqSfMy7ZLdq+OYB9d3n1Cipbz5BMcIKxBQx4XgsPW
         udlK2QtydjNOypdJd6wd/Xhq1fLlCzSnhLYmRw/BaLcbySIYuCgu3NU9+NbW3pdSOf
         FWYlA54bDYFXWqMS7D9U3m6q9wDNH8uqKptax6yUot5o55OiWSOG54xw4Gkvih7ICx
         TgcEDQzNPqi1e3AOHAlV8ALzkn0k7f0rsjgVNnUVjgZ5E1nFvMaUex+Zyi0stn/0jZ
         Uu58AUBqmmWXF6fAhM5SQkFZ0DvjklLoMQ21ZSfObwjAawcjn/J0KEJJi2oGSS26O3
         wKHczf6jV78B3ogIFtest34PIYD82DNWOBCeE0pV31ZvYbldO8T
Date:   Sat, 14 Sep 2019 19:38:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Audric GUERIN <audric.guerin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git versioning policy - PatchMyPC compatibility on Windows
Message-ID: <20190914193825.GS11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Audric GUERIN <audric.guerin@gmail.com>, git@vger.kernel.org
References: <c760038f-7c50-73df-5187-a186868c995b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0blaZc+aUkVqY8MO"
Content-Disposition: inline
In-Reply-To: <c760038f-7c50-73df-5187-a186868c995b@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0blaZc+aUkVqY8MO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-14 at 12:49:40, Audric GUERIN wrote:
> Hi,
>=20
> I use PatchMyPC to keep all my applications up to date on Windows but the=
re
> is one application that is never properly detected as up to date... and it
> is Git as you guessed.
>=20
> According to Justin Chalfant, Director of Engineering of PatchMyPC, Git
> version "number" / identifier is not "standard".
> https://patchmypc.com/forum/index.php?topic=3D3032.msg8211#msg8211
>=20
> PatchMyPC seems not to like that:
> Git version identifier =3D version number + platform specific identifier
>=20
> command "git version" currently returns:
> git version 2.23.0.windows.1

This is the version number of Git for Windows.  This is a version of Git
developed by the Git for Windows project which contains additional
patches designed to make it work better on Windows than standard Git
(although it will also work on other platforms as well).

The Git project itself doesn't provide binaries; various other people
(such as Linux distros and Git for Windows) provide binaries for their
particular platforms.

> git executables (like git-cmd.exe for instance) displays this "File versi=
on"
> on Windows:
> 2.23.0.1
>=20
> What are your thoughts? And can you answer to Justin Chalfant on PatchMyPC
> forum?

Since this is a custom build, you'd be better off reaching out to the
Git for Windows project at https://github.com/git-for-windows/git.  They
can help you figure out the best way forward.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0blaZc+aUkVqY8MO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl19QbAACgkQv1NdgR9S
9ovQcw/8CxZMdxQpSGU/TO9f5PHk4sAtrRNzuMPZKXpGe/q9tpuKL8eojwfLOEio
CQp31wuyTobdoucdcJzi0sTX+Lj9u+0+wEjFrEsb4nbmLlAR/mKcxsi0FT4HjuiD
+bgBzgxSOjcjXcm06oFoqD3yyKjsuE545oEHrSC2dXcsJmglSlKrCqsyNom/LYcZ
KFc/UsKt1NYgj13tii7yyQzB9mapBog7mFO4qvG5vcPuuJYHKfE/HmDmIroMEwzE
MtAA26UHu2CKGS0EFRELX4Ff8Y1RMtKCtUzU5Xuf4g95YArIdF0G1iFyDCH6WHUp
/3TxiWEfBMjX0I6H91vT9EPy/os5zE6XmTkqo5s1qWMr60L6hvIVmdXZ7JneOtks
NpP1ZDPaLQ8moC9Y5DybGgf1GIxUIKt78aio/L4THR95aaHBLXopCy8QVYv4EMHU
8gAcOC/Z4BZdKQfiXbMWOtDtlK/qxw8lr+ALx+RfX5zS09PTB5wFXXK4RB/NlKmW
J93Lz7BdzhM3elJ7tH0Zy4ubRBZH3+uYpfphtZsB7vLM1EGAy8RVazkxaMHN3c17
KlNNcflkGWo9wmiiJ2nefwFECiwjSkAY2SRhZbjSF99W/DqKimme1gURYkaC/cxO
JHlZ8koZlLxclM80+SZ9CRWbBs57CiDPgtlBwPPPbIDJjLaCfyg=
=HSty
-----END PGP SIGNATURE-----

--0blaZc+aUkVqY8MO--
