Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33D41FAE2
	for <e@80x24.org>; Mon, 12 Mar 2018 10:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCLKTk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 06:19:40 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:36452 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbeCLKTj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 06:19:39 -0400
Received: by mail-pl0-f45.google.com with SMTP id 61-v6so9056650plf.3
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1T3lFn7pkUCXFNaDz1lCrgRX/0qvwzmPvxd7PJYtXCw=;
        b=Cn+2wmsP2MwZfBW8+CnvXPtwYvPPXnZOQ5BqpfsKX969bFdsL4dkTCCNf85QhwvVK5
         bOJ2gifCOL/jOHfvswE0lYa0u2uHRfH8jYX1kzI18mEPpHJnRR2XgJjl4Sw44qe5T8gd
         eSf7YsULJEgP0R/TfCSg3s2np3Sk+LYjHyBcTNV80GWqbgwSEOMhYVUfwgAG+vV1oA5N
         s1IkU5pgoLfCNaODJifZYvrSuNarqDmatDSmb4v+MX9CSFRjaIY024gwcOxi5NvCcUNN
         VOICEUI1knFVt50u4JOLgULC8h0oOAjvu2deltbhK3yvZjlsKuhZNBwpUhjVHo1l2s/x
         oulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1T3lFn7pkUCXFNaDz1lCrgRX/0qvwzmPvxd7PJYtXCw=;
        b=ItA9GPkiX+87ZiBTgCH5PU6ZwtmHPaVbaOtZE4UQ98O9Ymq1xm6UBHErRN8IiZ8Eeh
         o/eJ3OX7lv0rPWCVZUsO71V+093VOyABOzgWoi4020B3VyOBKTc5fkqE8Doj7lBUvdxs
         nJeFC+io56UPkKW8umuza1wPEJt5NbV6SGOlEXwT5q7slDmOIdeKWJi274rInJYUQKpP
         h4JpwmAuCOiZFzaYIx0xpHqSmS1TjZWDgEtKDnGUKdTDIRwI7Kyn7MmOIfpwL2QIgw0o
         MWPvz/LRF2qcVMiHYh9JHn6iSbRHW3UErYxpjaFxqVlRNAUSonQrputhdCGnNo2Bi434
         oHvw==
X-Gm-Message-State: AElRT7EpqJN0/3lQFhFgjFM2rvXJDD77YFBieA76ezasc4+kLw727CPl
        Df2g7xaxrVQ0hz+neMlmMH4=
X-Google-Smtp-Source: AG47ELtLNHtwiRXrcq0ice/PjyDUPTZ8sNUMQB6SnLWAmExln/yJnlfs1CU74w+WTdBtVSM/3zUDyw==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9-v6mr6759225pli.173.1520849978999;
        Mon, 12 Mar 2018 03:19:38 -0700 (PDT)
Received: from remr90p0m5f.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id x1sm16620126pfk.144.2018.03.12.03.19.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Mar 2018 03:19:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180305200400.3769-1-sidm1999@gmail.com>
Date:   Mon, 12 Mar 2018 11:19:35 +0100
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89AEA176-2D3F-4271-958E-1C6BCC944842@gmail.com>
References: <20180305200400.3769-1-sidm1999@gmail.com>
To:     SiddharthaMishra <sidm1999@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

That looks interesting but I agree with Dscho that we should not limit
this to master/maint.

I assume you did run this on TravisCI already? Can you share a link?
I assume you did find errors? Can we fix them or are there too many?
If there are existing errors, how do we define a "successful" build?

Thanks for working on this,
Lars

> On 05 Mar 2018, at 21:04, SiddharthaMishra <sidm1999@gmail.com> wrote:
>=20
> Added a job to run clang static code analysis on the master and maint =
branch
>=20
> Signed-off-by: SiddharthaMishra <sidm1999@gmail.com>
> ---
> .travis.yml               | 17 ++++++++++++++++-
> ci/run-static-analysis.sh |  9 ++++++++-
> 2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 4684b3f4f..9b891d182 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -48,7 +48,7 @@ matrix:
>       before_install:
>       before_script:
>       script: ci/run-linux32-docker.sh
> -    - env: jobname=3DStaticAnalysis
> +    - env: jobname=3DCocciStaticAnalysis
>       os: linux
>       compiler:
>       addons:
> @@ -59,6 +59,21 @@ matrix:
>       before_script:
>       script: ci/run-static-analysis.sh
>       after_failure:
> +    - if: branch IN (master, maint)
> +      env: jobname=3DClangStaticAnalysis
> +      os: linux
> +      compiler:
> +      add_ons:
> +        apt:
> +          sources:
> +          - ubuntu-toolchain-r-test
> +          - llvm-toolchain-trusty
> +          packages:
> +          - clang
> +      before_install:
> +      before_script:
> +      script: ci/run-static-analysis.sh
> +      after_failure:
>     - env: jobname=3DDocumentation
>       os: linux
>       compiler:
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index fe4ee4e06..6ae032f54 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -5,6 +5,13 @@
>=20
> . ${0%/*}/lib-travisci.sh
>=20
> -make coccicheck
> +case "$jobname" in
> +ClangStaticAnalysis)
> +	scan-build -analyze-headers --status-bugs make
> +	;;
> +CocciStaticAnalysis)
> +	make coccicheck
> +	;;
> +esac
>=20
> save_good_tree
> --=20
> 2.16.2.248.ge2408a6f7.dirty
>=20

