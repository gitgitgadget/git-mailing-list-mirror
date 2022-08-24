Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A512C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 14:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiHXOkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbiHXOkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 10:40:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDF42ACE
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661352019;
        bh=uv936r4ZuBkDu92FC8MaUVKk5RxVR03E90XaPhXMREI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ost+zt09Oux6VjRAuvBe/PIJS314x0rYjzXzWyMFDXQdTIdQC5yNs1eaPUT/RoCYm
         s7d2GUb6mB+OpiYfHjYEsKrB+qRv2WeNuiVlcnWu61PzSv0v/OcXZUZ9tQYtHrnarC
         T2aNYLPm2W2ZtXX/ReAipjfXVTdHM2LCId3jWe8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1ofvia0eAl-00GFcM; Wed, 24
 Aug 2022 16:40:19 +0200
Date:   Wed, 24 Aug 2022 16:40:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
In-Reply-To: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
Message-ID: <r49psprs-4s48-p6q9-o3q9-37nnr3oq301o@tzk.qr>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-841434822-1661352020=:205"
X-Provags-ID: V03:K1:K9oDyZ+g6c1vKHIMrv41MNz/6I9f7cuHs1m9vYCMcDjaVsN5dld
 f6u6jTu9GTMo8ZGd2ouTLS8HnYRxOcVcguvnQE5D+amXYlDsDE4xx73TngYj7CtDxG8ooBW
 OxBQzMM9lytGJZs9CzWnKHQSX24g9qjwvauTN0wy+viUbvbXSJUWbZFK/uL/byIkp2u8lUj
 aNaKq0E0FexQoRigbIqHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7j1VEeTNYw=:T0qP3LUp5+rivn07RBV2bj
 bk1abd77HmxhIp6I/b+mWdBTIziCtz8lvW7JBiyqYgyWNjTqdfAZnoIDFaCRn+2of1Lr9DaGl
 cqnUe94j0m+n+G6cAiPUZA0Smeo/HFie8xNwYmngeN89C0HVvh8v9Y9/SDiheZ246is7qX1CA
 vF6R67rN4bEVGzLnRIgff+FruTSyj/UGZV1CsNi+Snc2++l+fZQls3NcZsP6LaebOuLb5DBO4
 z5eVT4Za9ggl0vx5K/3vTxiGuRm4SVD2BrPPoGFgcMEHgCJWomS/Jc/VMSYK93wH9Q1I+tULB
 kmnnWaxfRWCkbD84aSswRSGNsMIRtEMXjyHVJhuTemvg2moxG/nfFcuaNw9/GsbJ5Bsbg3Msk
 QDM9aSeD1qQxVa1Q79Qre3u3wQOUdmYgwXSgucHAK8jIQg4wKv/kt8PqeSAUCh2ylircKIZO+
 f/ljoxZVmTJZB39w9oRbGE7tcZFwxadV6jkGAamEX6VuE5xSZGtgIa9VFMcIdpRumWgJsXZc9
 eDANpTzOyY9ErHuUsHrS1qb5eR4nKFx6loWz92Fs8LRevTtE6VC2Vjhws9+1iuRu9iotQfhYc
 xAWogPKFsYQC7sD+OQhyjvfEiP1Ijp6zrBkmm0mItKvofCJrJiSN4BoxYZ4a+xgvggYfJ9dm8
 Mg510pRjwGKBpbZFhFzKrE5XlrtGuuDmTy0Mf0LFkGxS5B45pAshQxSOK9ptim3okwPx0tx6I
 8GVcL/1FTUeZizBzyXppaJ8MMk0ac5zmX/cYYPbpO+DwJbLmcPAUyPPrnRYbtQnJdH/CgRg8Q
 MpihgxdNHItbxHOyezcuh6Q6dAg2QWx+/xKOPNhjuKaVZopYWgZdvIeBjeUnQGljnCNKtKwKc
 wFx9/6K1VQ+uBcHTgKYG7y01fNFNk6JVIL9lP+/S38FVaB59RLRcTBNc9iyW94/5LcX+FUV7Z
 jbGXbZc5S9BDhMI85UMQ7Ksz7CNteW2wdk4cYqtve1bZwhmIW8VdTJa9xeIhQtEQP8bH7iEWX
 OcxKML5I/8taA6Nz+DhNd3tq8Cwn3LL7XqeB64gdRHid45uY6vn+MKfIuB0HlKOf6fpWmTh8J
 AvlF2Adm81fnbhXp9+BVKiTtwjk0Y02DHmoZswzx5wftKqLFWdX3S1cEA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-841434822-1661352020=:205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stolee,

On Tue, 23 Aug 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> GitHub Actions scheduled a brownout of Ubuntu 18.04, which canceled all
> runs of the 'static-analysis' job in our CI runs. Update to 22.04 to
> avoid this as the brownout later turns into a complete deprecation.
>
> The use of 18.04 was set in d051ed77ee6 (.github/workflows/main.yml: run
> static-analysis on bionic, 2021-02-08) due to the lack of Coccinelle
> being available on 20.04 (which continues today).

ACK!

>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     ci: update 'static-analysis' to Ubuntu 20.04
>
>     I noticed this while preparing my bundle URIs series. See an example
>     cancellation at [1]
>
>     [1]
>     https://github.com/gitgitgadget/git/runs/7954913465?check_suite_focu=
s=3Dtrue
>
>     I initially asked about this [2]. Thanks to Matthias A=C3=9Fhauer fo=
r
>     pointing out that 22.04 has Coccinelle available [3].
>
>     [2]
>     https://lore.kernel.org/git/eb8779bc-fc41-f601-05f2-024e6bf3f316@git=
hub.com/
>     [3]
>     https://github.com/gitgitgadget/git/pull/1334#issuecomment-122359765=
5

This can be verified also by looking at the successful `static-analysis`
run at
https://github.com/gitgitgadget/git/runs/7979368539?check_suite_focus=3Dtr=
ue
(which is part of the PR/CI runs at
https://github.com/gitgitgadget/git/pull/1334/checks).

Thanks,
Dscho

>
>     Thanks,
>
>      * Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1334%2=
Fderrickstolee%2Fstatic-analysis-ubuntu-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1334/derr=
ickstolee/static-analysis-ubuntu-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1334
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index cd1f52692a5..831f4df56c5 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -309,7 +309,7 @@ jobs:
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
>        jobname: StaticAnalysis
> -    runs-on: ubuntu-18.04
> +    runs-on: ubuntu-22.04
>      steps:
>      - uses: actions/checkout@v2
>      - run: ci/install-dependencies.sh
>
> base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
> --
> gitgitgadget
>

--8323328-841434822-1661352020=:205--
