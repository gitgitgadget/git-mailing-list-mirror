Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F7C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4EF20714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s3zSu/Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCWXZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:25:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60452 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbgCWXZ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Mar 2020 19:25:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 96D3E6077B;
        Mon, 23 Mar 2020 23:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585005924;
        bh=8jM81NsNC0PCzNM6KEhQ+U5/0EhauyjtN3mIapbZCBc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s3zSu/GgLxwqCgAKpnEAtQuL8mroPs3Aqy3ek52fy04RVgJEJJJefeuN7MvlDohyu
         4b1A+VUmcCIf/2OSGYSUJrKXjtXxIJKkYpDypJWwI17V7lK1DAf4AQUU4Hz0z5SyN9
         9WCuh4peVN0ctAceS/0XRrBdQKDVt2xGZezt/Ubw6s/DtcAfTcqoVs/SIJGFDGZEOE
         H12i4k5pDLJQbOBA2BiYSokRx3LBEjGSHNpIuB6/xypKag1h6tTgFFNEtfS239k6PI
         tPgQ/IhxVrTEvdVUbqQFcX7V3L2kWbZfJgXoFc1OWgvEkrXXEt7i02LY8NIz2C/2O5
         h+pw2ezD7xrZBY8nLw2AU3b5Euanb6/PDIrdtwO82Y9xhlB3kVuW4Cp3U9X9HsaqFE
         yuZtpu3uDCqYyw/1OQLn+Muf6Gu/PMGBaf0XJHd7/k/Zurl3kLelzC9C9E8jdIQKeR
         RQXrPfvhnPThtuT+9sxpjtQM42UaDqpUKKN+qZXj7QK6METIEUQ
Date:   Mon, 23 Mar 2020 23:25:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] import-tars: ignore the global PAX header
Message-ID: <20200323232520.GE6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-23 at 13:08:44, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> Git's own `git archive` inserts that header, but it often gets into the
> way of `import-tars.perl` e.g. when a prefix was specified (for example
> via `--prefix=3Dmy-project-1.0.0/`, or when downloading a `.tar.gz` from
> GitHub releases): this prefix _should_ be stripped.
>=20
> Let's just skip it.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Ignore the global PAX header in import-tars.perl
>    =20
>     This problem came up in Pacman-related work, where PKGBUILD definitio=
ns
>     would reference the tarballs downloaded from GitHub, and patches would
>     be applied on top. To work on those patches efficiently (e.g. when an
>     upgrade to a new version of the project no longer lets those patches
>     apply), I need to be able to import those tarballs into playground
>     worktrees and work on them. I like to use=20
>     contrib/fast-import/import-tars.perl for that purpose, but it really
>     needs to strip the prefix, otherwise it is too tedious to work with i=
t.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-577%2Fd=
scho%2Fimport-tars-skip-pax-header-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-577/dscho/=
import-tars-skip-pax-header-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/577
>=20
>  contrib/fast-import/import-tars.perl | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/i=
mport-tars.perl
> index e800d9f5c9c..d50ce26d5d9 100755
> --- a/contrib/fast-import/import-tars.perl
> +++ b/contrib/fast-import/import-tars.perl
> @@ -139,6 +139,8 @@
>  			print FI "\n";
>  		}
> =20
> +		next if ($typeflag eq 'g'); # ignore global header
> +

In general, it isn't safe to do this.  A pax global header contains
attributes that may live in a normal extended header at a lower
priority.  So it is valid, for example, to write an mtime field in the
global header that applies to the entire archive and overrides the
ustar header block (and is overridden by a normal extended header).

I think we need a different solution for this case.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnlFYAAKCRB8DEliiIei
gfbXAQDObmXlpdFGibe9w051r+Irw/k3VGeRbZ6WxXZ7GY0EVAD/ULQ6HR0b7I3E
8/JlFXhVEqjL7Ou258QGhC6UKFirrgU=
=TkY6
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
