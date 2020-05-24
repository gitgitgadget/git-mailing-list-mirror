Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD737C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 13:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C252071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N8drx46s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390756AbgEYNRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 09:17:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:51115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388756AbgEYNRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 09:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590412624;
        bh=Ba47RRhrnV/5PRZeL0fIlBmu9P6Y5x9xEMLrrwhKS/Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N8drx46s+I6ptpLdkn7XW1L/Li56DjvHa6fiX5pktBJ9Oj9XmLYsQS1gS3igVa/EF
         DYyAAq+iYIOXzt71ooyZDx2Ii29UDpu6h+K8Gb508jBRduAAKdxRETu5zSr/Dg9ImZ
         WdrI7/Xfg+mPNdXXFaYHF92GV47EeXZovNUkOtY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.52]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1inbit2JRL-00yOli; Mon, 25
 May 2020 15:17:04 +0200
Date:   Mon, 25 May 2020 01:00:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] hook: add --porcelain to list command
In-Reply-To: <20200521185414.43760-5-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2005250053080.56@tvgsbejvaqbjf.bet>
References: <20200521185414.43760-1-emilyshaffer@google.com> <20200521185414.43760-5-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NgoiUTmO8oWpwh71eBpGSOjXEg3CDNPrx3FpOqH2BovRg3nAcyH
 MMXSUBFJr0xZYeg2A2EOVlmKeboRBFe087zM985b0Hja0AREZZ3xizaHWJyzVp0HQTYXVOg
 KqteItRN4kp2OEozxX4Qcf963TvGWnrfbBaJ2XfUQCHKYtOODix9KG5kPzeCYMx5JLQf0l6
 +QFqBGCkgdwVv9wkRsdcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KYJmDYCTveU=:+X8fn6glH8iWxMDKXQsl4L
 cModJwZnyoDdC8noxi7GR5uYCMoFIzFLxEeLSOIS60ndmdzLZSaFv7WxCgcDbhhmVWYlv8HLf
 0IunK1c8R51vs7xFjKOIng7JJeGu74E2PBrstN7Nyfgm9FC/necu67WIAE77qn1xTmuBDVzFI
 SI6mP6EFrwvKFJH3utJPfTMDBP3vd/4J1D8+yrnuhJqk4JZdgyZTo4eYKblz/eQ6qwo96rDY2
 qsmStGU3c3UinsVP0IYIXNuNpPw1dlQdg9CgYJRTdP+N0logoStHaD8OtGI4B9iyJM8xxkyV3
 +E5dSgaX8ed+QW7qUQ6DPzSMWjfjpXabwbs5RCeOQULfpmyG2CfxPHRFEKck018JASMtSJKKf
 yN9WTPyFnOfybwK4rEuuT0cmL6q3C18NzF19YOmpSViypbcTi4Zc6GF3IaauLtBi/3TuXPwqL
 5/WXhKFCV9xJQgLwVlLJszO9+9VKVisV97hkFqxakkdI7QONoPoIun3n6hwzkobXnOPtjqYk6
 L1S+MJijGN3PUcqeZLG2LTKNpF7Rmh6yBZ5KEsD4Cfk8j7xGhZSLFm+tIpFXqmh0YA1WRvGQO
 qcbgqjox8GiVWjeztlY2w6IjdX2CYn0DGKceiYjeI0vtVm/Vc8BgHNgqSq6tGDos46EmESTTi
 blEmgbkaVNEYe8R2ICsLYuyvt35qgCNYvvaeLrU/o1oWVf0Owms5GFoClbgFJPQXvs9u+bdvu
 e6jAORpqsjjklp+CyOASfQKlfxrRabcHO5rAacJCQ5rpf38XEgo0HfRmtRgp40yY4RiRvQ4pc
 1gwqhINsCCCjCk5ZXGI9YmV75OtsuS6ip8eEgWCprzWBe2GGQik7Kl2J8bUKOJjuq9OsqTWsV
 9R6GjLsNQy27pCsRYTGDSSww3JZnoJKfqgoAeKFCMik0idREXBMYdKDUd5Rbn682PhiZ1IqYy
 96YX/Q1P37KJmil0EY/P5CsJtWtp3FEhFWuXywvhBvXjTrPzg3zman35hrfeBonlnyrEluB1x
 vDmAaDyeEox5FGxOzvwtOGxZx1i6KA8b6ZK9Of25FNUp1E6n4ufkSuWbrsGfiS8MDxVi75Idx
 iBr8ZxBSfyurh5ILSnj9WR0NAqQesGKrTYq1x2KH/fHrJaoCuevYN5x54kCD4gCFRmGrVP94d
 eQH7sVVyGzM4c0RWkjgONBMqBcq11Xu6hO38PfQ463nkZk4gEMhBgE4YTul//R0yicMYVhCDG
 oy0FPSsEYYUibMDQz
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 21 May 2020, Emily Shaffer wrote:

> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.=
sh
> index 4e46d7dd4e..3296d8af45 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -55,4 +55,15 @@ test_expect_success 'git hook list reorders on duplic=
ate commands' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'git hook list --porcelain prints just the command'=
 '
> +	cat >expected <<-\EOF &&
> +	/path/ghi
> +	/path/abc
> +	/path/def
> +	EOF
> +
> +	git hook list --porcelain pre-commit >actual &&
> +	test_cmp expected actual
> +'

As you surely found out from the GitHub workflow running in your fork,
this does not work on Windows. I need this (and strongly suggest you
squash that into your patch):

=2D- snipsnap --
=46rom 97e3dfa6155785363c881ce2dcaf4f5ddead83ed Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 25 May 2020 15:04:24 +0200
Subject: [PATCH] fixup??? hook: add --porcelain to list command

This is required to let the test pass on Windows, where Git reports
Windows-style absolute paths and has no idea about the pseudo Unix
absolute paths that the Bash knows about.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t1360-config-based-hooks.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index c862655fd4d9..fce7335e97b9 100755
=2D-- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -65,10 +65,10 @@ test_expect_success 'git hook list reorders on duplica=
te commands' '
 '

 test_expect_success 'git hook list --porcelain prints just the command' '
-	cat >expected <<-EOF &&
-	$ROOT/path/ghi
-	$ROOT/path/abc
-	$ROOT/path/def
+	cat >expected <<-\EOF &&
+	/path/ghi
+	/path/abc
+	/path/def
 	EOF

 	git hook list --porcelain pre-commit >actual &&
=2D-
2.27.0.rc1.windows.1

