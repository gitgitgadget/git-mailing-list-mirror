Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924EAC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF192070A
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 19:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tTHYHnR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgAZTpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:45:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgAZTpB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jan 2020 14:45:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1D8D960734;
        Sun, 26 Jan 2020 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580067900;
        bh=yYYQ3Aw2Ch27hgbyjNYqyFDgdQLq/Xr+NSpTItkJjrc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tTHYHnR0lfdJaSVAHs0WmglOiy9SD050JngAbbzFjdHzOI7ZuwKMmU4nphXSn/oiJ
         vZwZz66K8TKhe7kPEBbiXyRaG220/Dv6hYT2idieBQehdn3Q63PRLiB3jnLwsjTAEe
         LcwDLojwafUhIOws3VE26TgdwKprCRKhHRVXtUCjRUqoN1MMZqeVvJTlQJR2t+zEPR
         MHHvaN/5MYzbgBgPHKNVub8K9gEjLfHvF8ct7gEAmzIB7co+dVxcQmSfL4wZ17/Sh1
         4HXizpPiGR22UuIJjLYFyN33uODOVZxXUm6ufZ4I1HqWOb5fhE6Hf3eur+OatTEf6X
         A74pk4ZRtrBj4C+ok9/PHm/S4Hrn68uoOxSEba5Wmny3Urwld8QjxQFoRrOP12mnCu
         yRV7YLIQuT6Cb9LNfVFE7DQosphWGnzf39DImJUCrDTGu4S4CKhv9Yu/06Ym0fO7iK
         RLyv/haQbh2Y5d43n8OMZo4m9QkSBZo3Ux6erKBCT5xsw8WLSqQ
Date:   Sun, 26 Jan 2020 19:44:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
Message-ID: <20200126194456.GE4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johan Herland <johan@herland.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-4-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26 at 11:15:52, Johannes Schindelin wrote:
> I would rather see this tested, still, and reducing the number of notes
> that are retained from 50 to 20 before testing that the fanout has been
> reduced to 0 seems to do the trick. Therefore, I would love to submit this
> for squashing:
>=20
> -- snip --
> diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
> index 3520402bb81..39b12c9902c 100755
> --- a/t/t3305-notes-fanout.sh
> +++ b/t/t3305-notes-fanout.sh
> @@ -43,7 +43,7 @@ test_expect_success 'many notes created with git-notes =
triggers fanout' '
>  '
>=20
>  test_expect_success 'deleting most notes with git-notes' '
> -	num_notes=3D250 &&
> +	num_notes=3D280 &&
>  	i=3D0 &&
>  	git rev-list HEAD |
>  	while test $i -lt $num_notes && read sha1
> @@ -56,8 +56,8 @@ test_expect_success 'deleting most notes with git-notes=
' '
>  '
>=20
>  test_expect_success 'most notes deleted correctly with git-notes' '
> -	git log HEAD~250 | grep "^    " > output &&
> -	i=3D50 &&
> +	git log HEAD~280 | grep "^    " > output &&
> +	i=3D20 &&
>  	while test $i -gt 0
>  	do
>  		echo "    commit #$i" &&
> @@ -67,7 +67,7 @@ test_expect_success 'most notes deleted correctly with =
git-notes' '
>  	test_cmp expect output
>  '
>=20
> -test_expect_success SHA1 'deleting most notes triggers fanout consolidat=
ion' '
> +test_expect_success 'deleting most notes triggers fanout consolidation' '
>  	# Expect entire notes tree to have a fanout =3D=3D 0
>  	git ls-tree -r --name-only refs/notes/commits |
>  	while read path
> -- snap --

Sure, that's a fine solution instead.  I'll squash that in and update
the commit message.  I'll CC you for your sign-off once I've done that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4t7DgACgkQv1NdgR9S
9os9JRAAqGqo6LCq9SjH5zUTBCM0YkBklMwbq929DuCMZUOF4bUzwSqBpqujI3ww
82DEw4MkrPXMARF89k7yhl65sjAYrGYgkpDewkgcBLH2m+yWZ9mzqLjXbT6xrqsh
t4hRvCkLJBLuIf13ORyP8mP7nBF5NGj5qHfjtTVRitIhrB9yOlQ5UdGqnDarhfg7
MUlRivlmT9GRHhwRPWBi001ZIKnBN5AfIZGeGpeK40bc0yR8FALUgXbd+477hTza
YnNWJUbHEQPeW2QUvIUqIs8ySr8x18uSL2MICXpp1f1AJPvvbfZKqducQBIpbBpl
iNWEalMOzpEt8py3SPf/qbg80f6FQhPghsX+MZQ02q2Rq0ukCS/KFH24Ru5hD0bK
FLqaGQ15qjoKBvSQ4kwERj2PU5qYQOFJ8QulOqpxFcG+ZInm/m4uYJ2i1X0UWqRN
0h7jFPG9bkyoaKOaMoC0b5i4H1sbtxCNqIj6+DY/XGUjLwDFCNAjpUzgkDXKXU6c
vJuH8N8lfbBjupII7cFTh1QHWMP0YMMUpyx3B7XDrto/1o5txAyS/wUKbZiVIDZQ
1BWtqo3yB50ROCE74YwecyFmwfQjU/a4iECBSpWVNvR6WAS6Z+zfdYMJgQIbzqn4
hCcdrUtiOLbolhl6rElSzBMUAAGMgZI6E0vGDTvaeqnB5ejpP+U=
=Z7hh
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
