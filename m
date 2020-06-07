Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4D0C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541AC206F6
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kW3/k2/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFGQ0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:26:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39100 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgFGQ0g (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Jun 2020 12:26:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 97BA260756;
        Sun,  7 Jun 2020 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591547164;
        bh=2Zt3G7aa5B+xznlf+qJezXEvPBLzwBPJqWfympr+vFo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kW3/k2/2HWoLEff5AsSoYEoJjmZ1POanbTVN9ObQGcCYFfBtfOpMsUKprGRnkKRid
         Sxc+svu3LOXSG2oq806K+klDdgGxrbVXOlWhPZgwf+yqSg9djef0KJjBoDHgPptTmY
         XXWhQgbGehAVuqWfxkw3k//rb1ZSIBTH+xSH9sDxWrFWMrnH1sBfmqnyUEJtaotjUD
         lZ5elyCpeR3BWRl+c2OXIETOB5FFdoOnS66SDtEt8pU0VEspIh507QIyTWPGLRE5WJ
         DtWkulaVOpweTrYz2kNsgitopN9N0cmRO5qhlw9i067Cfwn3eNTQYV87neEkaMtBFh
         pbYvJhma1A+3/qYV4i4VV9kfHu5mfUa+44x9IaBbk95IwcAVGCECeNQsUsTZEoFFjW
         /4LYVc6SrJ5vWsB0rNS9Zy+29UQgWju0/v9/extt40Uk0yzFjo4L8+zm03r4Cmwnx3
         2t7VcCioDyHNr+HzrHCqxLfO3ckiDf6lMXteH/NlmZL9EDkpptp
Date:   Sun, 7 Jun 2020 16:25:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Lin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH] Recommend "git gc --auto" instead of "git prune"
Message-ID: <20200607162556.GJ6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Lin <johnlinp@gmail.com>
References: <pull.651.git.1591546715913.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Content-Disposition: inline
In-Reply-To: <pull.651.git.1591546715913.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-07 at 16:18:35, John Lin via GitGitGadget wrote:
> From: John Lin <johnlinp@gmail.com>
>=20
> Signed-off-by: John Lin <johnlinp@gmail.com>
> ---
>     Recommend "git gc --auto" instead of "git prune"
>    =20
>     Fix according to #642.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-651%2Fj=
ohnlinp%2Ffix-git-gc-warning-message-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-651/johnli=
np/fix-git-gc-warning-message-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/651
>=20
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8e0b9cf41b3..3833a3de332 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
> =20
>  	if (auto_gc && too_many_loose_objects())
>  		warning(_("There are too many unreachable loose objects; "
> -			"run 'git prune' to remove them."));
> +			"run 'git gc --auto' to remove them."));

I'm not sure this is correct.  If we have just expelled a large number
of objects from a pack into loose objects because they're no longer
referenced, it's possible we may trigger another git gc --auto on the
next time we run a command.  If so, no amount of git gc --auto is going
to help here; you really have to run git prune.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXt0VFAAKCRB8DEliiIei
gR2VAP0fAkY8OsQt8P9qTLd385RiwnXxQbXExfyu49KJhSMLxQD+MUYsuGDMRqbO
AQIfNMTpUWZudIxLA0JUXanNconniAY=
=CIhe
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--
