Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16D920899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbdHQRoD (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:44:03 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33525 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdHQRoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:44:03 -0400
Received: by mail-yw0-f174.google.com with SMTP id p68so45455437ywg.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9pGLqJWV0dFW6Aw7SOACpk41wywznifuwZ/SvMCy4QE=;
        b=U1OYAKe6uNpjQrlKMN0VPdiIIjU4DHrWZ3keGCGgDMrcrolt3GYg4U2NrIIB/f2Ehe
         YG3Fm9CPCyFsnymamEYOQfnX5cutc+RPPrmBIvxbH0C9uF1zHHel9alB5UAf6BMecfnv
         LNjFaCnAQyHwD434hSq5MM9GwDB89l4CMxpaLywzG48C/oz+9qS1yjnbzyZh14f2mTnn
         cPoAzYEbhqPemn6+GYHCc33ExHt0ncSKapkZvry+u8a6YV9ozeT+55onNXe5S/PmQCLK
         JcSDJHGD9ooyRcH1GyqxjI2qAeJHo8SrSIxgDfPZsg4IrVcehEiPnTuJilq/jUMD6xyH
         L+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9pGLqJWV0dFW6Aw7SOACpk41wywznifuwZ/SvMCy4QE=;
        b=bFr1d43Bk9y9wKy0F7pfcX7CVmS0bjcYGscc6kNYA/NvPjgbHKBBTnNhSHfLtyVQ97
         U9mEqThZ0SEK4H0KUACw1RwCFbRAAziII74BIWA85t55nUdIllFzq+ldLmGYwP95Zfae
         eqRYiXX3my5Xs2SFB2TEaEkg61XsdSTZ54wckJXnqzNTd1OCLQdXVQgRvgtrVmADiSMf
         nF7hPa6w6vgWSRRnPfDdF3KxILWKTLZNmOU9FKpHAiHPDw99Tz4jKkd3iiP7V4me8mgH
         7dAWOjnrjl0Sr0RuTOLDN46hVCvjK7HLVM87tXFSh6pA/cnADnsTt9sqeHMUz44ShxN9
         GFLQ==
X-Gm-Message-State: AHYfb5jTYGaVi79md46DKs043UPW7kubp+wEyiJkyPRTQcNcNxmXbYWs
        vy+6Y6q7Y3zKDVIV/nh7jF8BMNC0BdVc
X-Received: by 10.37.51.7 with SMTP id z7mr5119803ybz.145.1502991842272; Thu,
 17 Aug 2017 10:44:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 10:44:01 -0700 (PDT)
In-Reply-To: <20170817103613.GB52233@book.hvoigt.net>
References: <20170817103613.GB52233@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 10:44:01 -0700
Message-ID: <CAGZ79kY2xc+-63m7upVLrEkHLVgL3hGtTKOKnJPjgReCO_Aj2g@mail.gmail.com>
Subject: Re: [PATCH] t5526: fix some broken && chains
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 3:36 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan

> ---
>  t/t5526-fetch-submodules.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index ce788e9..22a7358 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -193,7 +193,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
>         add_upstream_commit &&
>         (
>                 cd downstream &&
> -               git config fetch.recurseSubmodules true
> +               git config fetch.recurseSubmodules true &&
>                 git fetch >../actual.out 2>../actual.err
>         ) &&
>         test_must_be_empty actual.out &&
> @@ -218,7 +218,7 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
>         add_upstream_commit &&
>         (
>                 cd downstream &&
> -               git config fetch.recurseSubmodules true
> +               git config fetch.recurseSubmodules true &&
>                 git fetch --no-recurse-submodules >../actual.out 2>../actual.err
>         ) &&
>         ! test -s actual.out &&
> @@ -232,7 +232,7 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
>                         cd submodule &&
>                         git config --unset fetch.recurseSubmodules
>                 ) &&
> -               git config --unset fetch.recurseSubmodules
> +               git config --unset fetch.recurseSubmodules &&
>                 git fetch >../actual.out 2>../actual.err
>         ) &&
>         ! test -s actual.out &&
> @@ -312,7 +312,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
>                 ) &&
>                 head1=$(git rev-parse --short HEAD^) &&
>                 git add subdir/deepsubmodule &&
> -               git commit -m "new deepsubmodule"
> +               git commit -m "new deepsubmodule" &&
>                 head2=$(git rev-parse --short HEAD) &&
>                 echo "Fetching submodule submodule" > ../expect.err.sub &&
>                 echo "From $pwd/submodule" >> ../expect.err.sub &&
> --
> 2.0.0.274.g6b2cd91
>
