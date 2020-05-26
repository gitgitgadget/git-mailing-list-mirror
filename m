Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE70C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135CC20700
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TBKc3mTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEZX7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 19:59:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38902 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgEZX7K (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 May 2020 19:59:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D755260482;
        Tue, 26 May 2020 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590537519;
        bh=8/BejdtwA/rh4F8qnLXQBbMGkembU7SW8Qja/QFHrsw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TBKc3mTzgcRDpsNvb0oXOu20Jr1t7AhkTrq3kIaUy0ncEk1ye2MDTRskTC3dw8ukD
         UTmbTP9bSOTv4bpgIef1xvzv3igcXZIaLMc0UoQv3Pzs2evEa+HOSQUQlAH0N1d4Jr
         YrYCuaO/NRiNKSN3ZoU2zda9SqSGU4dyUw1cWDKm4Vq2U3sFwpQ+UpSIb+kdRW7AMQ
         tpml+1YEI8eKdBSdSeb5vcuXoeLjkglUFfVV37zTU/qhI6LngarN4hVj8FQjBgVgMB
         ZEL6EsGYkeeFLwylkCbm3ei8Lt3dPEA/GgWDFsVDbJ7JkNAtQtD4f8F5G4GF1fFQge
         GsGJjjvlpZMiigtYUrugUeOfSvYe1VabMHub67pdPO7NtPSULveg9l5IB/cj5wQ5GX
         dbD1caNq8fJ1T5Zz1en4sO4npBUUnELP3TH3TSgHYGv1pAmaAWmyURnlszmKby1iG3
         M9Ft7S1wEnawvtvfGLlqAnJeeX+cX0uMSe713P1mJ7FNNSfMTNJ
Date:   Tue, 26 May 2020 23:58:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
Message-ID: <20200526235834.GG1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FLPM4o+7JoHGki3m"
Content-Disposition: inline
In-Reply-To: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-26 at 19:13:17, Marco Trevisan via GitGitGadget wrote:
> From: =3D?UTF-8?q?Marco=3D20Trevisan=3D20=3D28Trevi=3DC3=3DB1o=3D29?=3D <=
mail@3v1n0.net>
>=20
> When clearing the builtin operations on re-sourcing in the ZSH case we
> can use the native ${parameters} associative array keys values to get
> the currently `__gitcomp_builtin_*` operations using pattern matching
> instead of using sed.
>=20
> As also stated in commit 94408dc7, introducing this change the usage of
> sed has some overhead implications, while ZSH can do this check just
> using its native syntax.
>=20
> Signed-off-by: Marco Trevisan (Trevi=C3=B1o) <mail@3v1n0.net>
> ---
>     completion: Use native ZSH array pattern matching
>    =20
>     When clearing the builtin operations on re-sourcing in the ZSH case we
>     can use the native ${parameters} associative array keys values to get
>     the currently __gitcomp_builtin_* operations using pattern matching
>     instead of using sed.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-645%2F3=
v1n0%2Fzsh-native-operation-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-645/3v1n0/=
zsh-native-operation-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/645
>=20
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 70ad04e1b2a..ad6934a3864 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -373,7 +373,7 @@ __gitcomp ()
>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
>  if [[ -n ${ZSH_VERSION-} ]]; then
> -	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\=
)=3D.*/\1/p') 2>/dev/null
> +	unset ${(M)${(k)parameters[@]}:#__gitcomp_builtin_*} 2>/dev/null
>  else
>  	unset $(compgen -v __gitcomp_builtin_)
>  fi

This file is necessarily used by both bash and zsh.  Does bash
(including the bash 3 used on macOS) happen to continue to work with
this syntax?

We've had cases in the past where despite some code running under shell
A, shell B, which also parsed file, choked on the data because it
had to parse it even though it didn't execute it.

If so, and this works there, can you mention that in your commit message
for future readers?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FLPM4o+7JoHGki3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXs2tKgAKCRB8DEliiIei
gczSAQDKHldIX3y4ut5qCAJ+W57gYfLttEmNlgVzDYJYWMkJ6QD+PIIm+xh9HxGw
8rv7sUKxfxvDY9JXh1/lgK2hSaQXmwM=
=+cXs
-----END PGP SIGNATURE-----

--FLPM4o+7JoHGki3m--
