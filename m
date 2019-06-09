Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD711F462
	for <e@80x24.org>; Sun,  9 Jun 2019 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfFIUNM (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 16:13:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37516 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbfFIUNM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 16:13:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A46960446;
        Sun,  9 Jun 2019 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560111190;
        bh=wol3NLa9DrbkeZ6ED0cSsfqnNjmCG8eQUL04U3E3+m4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y+xOKboavZDh3wGZYkXjs/Yot64u0EhLKTuI2ZT/SGAbRFKgPYBI6pe7Xhgff5j1m
         qMW4PPoqY7SepUybUFD6LCdKl57y37wQEZ9dMmYq37KYBMIya8etRzA/NHtI0AWJ7e
         Iwan9QPHdnQcM2EdkSnb1Ot0Ge9pHOdOgLxS8zTlRb9EXb4dms5MlaRg7SpQN3Jik/
         yQNCixviKqwzAtQGWUWsPRzGiUB+Cef0fbmY3KKW76t7fFDXoEjYP3UHGBT9F/Iz77
         Dx+h3w/KgZmk3te1/5p+iLvE7juTAp/iCAK8x2TFVz1s7ZSQEdfh3qhYsZgQ3dAnZx
         exxYIfs0ZBYIzb352ayM0LWU04VSkT7G5yKbNdHpdv7dR47ADlG5GRLM89CnOem992
         +Dpsaf80pOFpUOh8sft3rWzxS7Le1BO8kU/JGo7sB7TshAKb3PVtaE6twlwDFGW7yb
         aUgCFe+J8LXuqNiT7/qdvWd5VRpaJoq64xk2pe9+vOSPk0tmVbn
Date:   Sun, 9 Jun 2019 20:13:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t0001: fix on case-insensitive filesystems
Message-ID: <20190609201302.GX8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.151.git.gitgitgadget@gmail.com>
 <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwJ6bIT+r2BZUD+c"
Content-Disposition: inline
In-Reply-To: <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jwJ6bIT+r2BZUD+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-08 at 14:43:43, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 42a263cada..f54a69e2d9 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -307,10 +307,20 @@ test_expect_success 'init prefers command line to G=
IT_DIR' '
>  	test_path_is_missing otherdir/refs
>  '
> =20
> +downcase_on_case_insensitive_fs () {
> +	test false =3D "$(git config --get core.filemode)" || return 0
> +	for f

TIL that =E2=80=9Cfor f=E2=80=9D is equivalent to =E2=80=9Cfor f in "$@"=E2=
=80=9D. Thanks for teaching
me something new.

> +	do
> +		tr A-Z a-z <"$f" >"$f".downcased &&
> +		mv -f "$f".downcased "$f" || return 1
> +	done
> +}
> +
>  test_expect_success 'init with separate gitdir' '
>  	rm -rf newdir &&
>  	git init --separate-git-dir realgitdir newdir &&
>  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> +	downcase_on_case_insensitive_fs expected newdir/.git &&

I wonder if there's maybe a simpler way. If we canonicalize paths when
writing them to the gitdir file, then writing "$(pwd -P)" on the line
above should produce the right result.

Now, technically, POSIX doesn't require case canonicalization of the
path with "pwd -P", but then again, POSIX doesn't permit
case-insensitive file systems, and we know the behavior on macOS uses
bash, which does the right thing in this case because it calls
realpath(3). I've tested that it also does the right thing on Linux when
the worktree containing the Git checkout is in a path with symlinks.

I don't know how that works on Windows, but if it does, it might be
simpler.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--jwJ6bIT+r2BZUD+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlz9aE4ACgkQv1NdgR9S
9osJGw//ZhWiHmDn7oHDls6uWJnCqaOji64Du85RooZ0s7hRrvknosonD8SIpctE
OAG2eTpkpF/uBMKPgPKlTlpvy2nVm1Go/lri/mcF92w4NG13HijmDmeF/6qT59qI
zEDBxYQCxKKOOSCwOJlDDQh8vi/FvqpHCwZ4Oz1hVJQ6tgTOMJUlzCrScXEekVCd
NwfxhHzUqY4W35SfspRgJ8ihO8s31ij+yj8lZXLWy8JDXp+0FZWv3JVF1Som0fvo
QCIs8E73fFekxMf27JXWupZNJmbap9dF2jTdn5uijsLVYihgKn7JNoeJYe+hLW4K
G/ZZ/vpV7tcacIoBXwX8kUZkM4Pr4qYRxP5H2av1bYgRYs1vNHPmPzlBkCLmDi8W
mnnkeyL1PrfSTNHgP321mJPGkENPyFVkIpptfYyYdzzmkeVicU0EgH6F5FCnbOVp
gogz1UwWG2bO3ddbPcLfDkHTR8EbmTGm4XO1ahilaCiJVbxYn+p79Pa207mUxelS
yf96tc75IJzU5bdHqUcpsOELVBMriV+24/S6/8w2mxFwJ41xr/578bg0M/jHiWTw
5pBiZaTiFbsX3synbUkUUeiE7lTsE+oHFQuL/yy3/XmV4lA5oQfOY1Ao00rjBHpp
TI7J7WauLl6L6HnTyKUqCFd2XRw/EHkznj7+Kms3AmcI2cR/rqg=
=sGnf
-----END PGP SIGNATURE-----

--jwJ6bIT+r2BZUD+c--
