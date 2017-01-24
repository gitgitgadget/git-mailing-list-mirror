Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C876220A17
	for <e@80x24.org>; Tue, 24 Jan 2017 01:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdAXBRQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 20:17:16 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:33070 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751113AbdAXBRQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Jan 2017 20:17:16 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0712B280AD;
        Tue, 24 Jan 2017 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485220634;
        bh=ibVcHEwxEKw+q0yaLZ3VJ9UGvUxKhLm5Gc5lxpp5Vyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EB+xFcYLV7rKViwj0n06dd3/mCb3tjury5hvaey6LxsCUbJNcKSlEXt7zNoRkUomz
         kZwzf8KrfPfJr7CeURyvhY2cz9SSnktGoRI3H5nPuh3AIxrOXYIAnUXVRTvBc6EAPM
         N7kGTZri0ya37MIJNqbUOM51t9jCEbu/+lxnZkwOsYe5TkKKgnYk+ZEGG+IleHdaMH
         YxrW6JL7ljk09xZd6BLBWloRFHAEDvab+21ddxJxYUEZW+kwovKARZqfVBjCyMvv2n
         2iDAI5piZ41jph0p94ODjFWq8s6r0UYRyls/0JtsxxRVDeF5xoeNNYDnAtdv3giFE4
         8z5QUiK39F+cZB0JBcRxcTstUzE+/odg+qgyquEHK3/zPfFjIv9NUcH/zBNamidQEX
         pRCf11AbjIgvqPZ62mDu7Igm0ezCzJ9tFtHANtqUwjQaKh1ZhuXzOlLQvi1b8YC9ez
         135hF+amv2T1xf/CO4lwopHaNPzNT37E03f7wQ9gp+oQZZMMDkd
Date:   Tue, 24 Jan 2017 01:17:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, sbeller@google.com
Subject: Re: [PATCH 3/3] git-prompt.sh: fix for submodule 'dirty' indicator
Message-ID: <20170124011708.qlq7aenmdfg6wosv@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Fuchs <email@benjaminfuchs.de>, git@vger.kernel.org,
        szeder.dev@gmail.com, sbeller@google.com
References: <1485113421-22264-1-git-send-email-email@benjaminfuchs.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fbkuvxym5n3gbdn"
Content-Disposition: inline
In-Reply-To: <1485113421-22264-1-git-send-email-email@benjaminfuchs.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7fbkuvxym5n3gbdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2017 at 08:30:21PM +0100, Benjamin Fuchs wrote:
> Fixing wrong git diff line.

This patch says 3/3, but I don't see 1 and 2.  Also, this description
doesn't tell me what the problem is, or why this fix is useful.  Such
information helps us down the line when looking at the history, and it
also helps reviewers determine whether your change makes sense.

Right now I can only guess that there's an issue with spaces or slashes
somehow.  You might want to take a look at
Documentation/SubmittingPatches, especially point 2.

> ---
>  contrib/completion/git-prompt.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-pr=
ompt.sh
> index c44b9a2..43b28e9 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -306,9 +306,9 @@ __git_ps1_submodule ()
>  	local submodule_name=3D"$(basename "$git_dir")"
>  	if [ "$submodule_name" !=3D ".git" ] && [ "$submodule_name" !=3D "." ];=
 then
>  		local parent_top=3D"${git_dir%.git*}"
> -		local submodule_top=3D"${git_dir#*modules}"
> +		local submodule_top=3D"${git_dir#*modules/}"
>  		local status=3D""
> -		git diff -C "$parent_top" --no-ext-diff --ignore-submodules=3Ddirty --=
quiet -- "$submodule_top" 2>/dev/null || status=3D"+"
> +		git -C "$parent_top" diff --no-ext-diff --ignore-submodules=3Ddirty --=
quiet -- "$submodule_top" 2>/dev/null || status=3D"+"
>  		printf "$status$submodule_name:"
>  	fi
>  }
> @@ -544,7 +544,7 @@ __git_ps1 ()
> =20
>  	local sub=3D""
>  	if [ -n "${GIT_PS1_SHOWSUBMODULE}" ]; then
> -		sub=3D"$(__git_ps1_submodule $g)"
> +		sub=3D"$(__git_ps1_submodule "$g")"
>  	fi
> =20
>  	local f=3D"$w$i$s$u"
> --=20
> 2.7.4
>=20

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7fbkuvxym5n3gbdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliGqxQACgkQv1NdgR9S
9otzqhAAsu5CwVQCibdJTru82ifYjEXl3I3JZIvSuVuHhRaXjveoLg6pfSo9fzrF
rXa5BjMdEWk/cuZ0yx+drJN/n/01oln/igxFUClmrqc0EWSq6F4I6mWeO3Jaxk0w
37FIpt4/IoZAe5BEdJNAWKv5FP3uzrCBYaG5y0ZpuehMJVID/LVjr0/FMp+tXKmK
c/Rl06snT+J3u4trzBzUWGsFGUZOm7ocK1wOIshxAUTT92ca1svsDrRKzmUhmro1
9GLMRDn62bJuf3GZ6Z7spqWr7OrIQeiPYK4XvGUcZzKa3jndk1YTFHUNj4TQugGb
6ZnKF/M3XjV6CRs5VLUDNXart/BvPPXtRGB/RMTIKJhsUNt+qjMrPJl8o7irNkyK
50ho6jWf4tdw17Io6HVi8cz7ou0xXPl/q8/3d4ic77ytxDKY9+1miZN0y/bOV2QP
eLT1CX0ZguKo8LgLvjzLvLiZg2Y/gqB+Ea22EbYjWu0YdPKVIehPqP0XRnVeo8Zu
7smdgvd7mji0oDxYWiHmZOQFzmkKl7im80NvOX5ZUsoWmYVGHRxOM1/bsha5u+mD
dx+k8rHpoqDsJJTJ418azEpg/QCmPWwThR18E2Ky8TPc+3noASYBxBeGS1b34Kn6
Wwk6UFCdA/fR8pt74q+zSWCTa5Bsvdc3Eah66B+iFUu/SHa/4OU=
=dZVJ
-----END PGP SIGNATURE-----

--7fbkuvxym5n3gbdn--
