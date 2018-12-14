Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A1620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeLNAvK (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 19:51:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbeLNAvJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Dec 2018 19:51:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:34d2:59b6:3b53:e993])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 420EA60129;
        Fri, 14 Dec 2018 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1544748666;
        bh=jc24KYCbTc5hZyoPLG5vdMB0SFw0YJBL8JmBFf3B6FY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ouk77uf2MvoDFNQBxH1tgcU7JRT1SogQmL6BtxAuV1BQ4ZNYciZL4lh7rQAjOAcdq
         gSHuwEYAWZYkvY6YPcZoy5v2TjONUuOgcVHS5QnHqz7dlaZmxMGTG8s/4Ry/IFMHYp
         0x0TqWtbOurK1UqR347mKRTpylRqoGraHSPrtcWjB7/GRZYgGm+IV8ZR+K3fMdBV72
         YkaKr+IDoNCvOYHRsxjVwOTjp/lqGzUrkQfo/ucpxETaUVmz1B8NjEyq5y50YPjREb
         vN8dAe7xXuHMVVFEbLIHmnWTCTJUpsSqpW2Z5ykI1Za3tz+kLs5PBrW/xa7Xwbx4ZT
         +YMebbiq5LwBYT6RzFdttZ3hNOwfKS1zMbMFG/7Lu3mgEZQvctc7CwzdEgxZ5dZ7Lu
         DmkHPUshN/qmmj5jtqd6pS6lSl21liCQxRetxuWOO+mjzYXRoxRqOaRqiMZJtZLxuc
         EG7T9P911Oa2f4orASsSpQlpfY7klitIwDU7ZKVDKZBH5Xlxd/B
Date:   Fri, 14 Dec 2018 00:51:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] .gitattributes: ensure t/oid-info/* has eol=lf
Message-ID: <20181214005101.GT890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.98.git.gitgitgadget@gmail.com>
 <pull.98.v2.git.gitgitgadget@gmail.com>
 <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qy9NDBoEzxL7V3MP"
Content-Disposition: inline
In-Reply-To: <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qy9NDBoEzxL7V3MP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 10:14:53AM -0800, Derrick Stolee via GitGitGadget w=
rote:
> From: Derrick Stolee <dstolee@microsoft.com>
>=20
> The new test_oid machinery in the test library requires reading
> some information from t/oid-info/hash-info and t/oid-info/oid.
> The shell logic that reads from these files is sensitive to CRLF
> line endings, causing a problem when the test suite is run on a
> Windows machine that converts LF to CRLF.
>=20
> Exclude the files in this folder from this conversion.
>=20
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.gitattributes b/.gitattributes
> index acf853e029..3738cea7eb 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -13,3 +13,4 @@
>  /Documentation/gitk.txt conflict-marker-size=3D32
>  /Documentation/user-manual.txt conflict-marker-size=3D32
>  /t/t????-*.sh conflict-marker-size=3D32
> +/t/oid-info/* eol=3Dlf

Yeah, this seems like a sensible thing to do. I assumed the shell on
Windows would read data as text files, not as binary files. It's kinda
hard for me as a non-Windows user to predict what will need CRLF endings
and what will need LF endings with Git on Windows.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qy9NDBoEzxL7V3MP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwS/nUACgkQv1NdgR9S
9ov+8g/+LrcM6sNu2OvqSTSXrordfRKH4enFcVlU/WMKiFIf1vqfxeDhj8RpCEzF
Mw1bqJqDLfqTvGXf2zP4lULgGxtTqTbK/yOXUksQwBLzoPoWzoqJQ4x4m5spwCUZ
CD2btzz5ncD13fy/bfSAOrTH8ZqEY9hdDpG5iGLNTXRBLc4rtrC8gLNVV7qxGL8H
RNAy2cnQ6lENsLw+k7k3Ocde0DnhAokfrZlLumghttBzPtkPIDiZvL6Qeg85e8/5
ZTBntgq06ZHo0+cWFgNnWG+0g2wowggAyfmU60BH6K9Pk0jX0uTq2leSM92Zu1ag
hHj+eYjHY804DQcU4/xXG+V3agIPk04p8ufhvFjw8GXUiB4ezu6McY/8wZkMhiS8
8Cnmg36Yk9nXc+WPVhCJBJVGTAjsFD+kRXLGduLriErSov7hRJM0HtFv6hauqUVo
XDM+DSAbb1kgQcDrnz6Va+YX9Qv0LrD1YbBSvEfJ0X+dK1q2H08/bAvTtFw+y5Pi
eqXx8s9Oyr6RX4druinVzzRBXP/gCitp7s6z1JSW076UlPb66k4TJLpRA1Dhiunn
CC1sUuMZCAuMLme8c6ggVNQbqXTXSQwheg0on2cSVXhq0j+hQKKjl1NgNLfQ46Ng
0lfv3+GSpG0BI7eauN0zvQonNEmZiWTqZE4wIqASwBg42XVIobM=
=wzTs
-----END PGP SIGNATURE-----

--qy9NDBoEzxL7V3MP--
