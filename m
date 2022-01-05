Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C5C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiAEQXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:23:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:54569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbiAEQW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641399774;
        bh=vraCIjM7nNK1W/ylX1C0TGacVHiBsGsAxSNMJKvCyL8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ldAwedCgDelEtBcS2TvoWF7/51aDeB5K8yY0b3Joi6NjPgnoyixbh7NSKI5Gs0kMK
         GhOBcNgr5lcce+tnFsgaaMNG06Dmw0YHLPxekfJFM43EhLc5Ry+8sBiqVhxQMsrvel
         4KhF8QVQe4JDeCXEfLLFcFDHKszYSgbvIy7wGreM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1mBgv90vnN-00xwYY; Wed, 05
 Jan 2022 17:22:54 +0100
Date:   Wed, 5 Jan 2022 17:22:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH] t/README: fix typo
In-Reply-To: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201051701120.7076@tvgsbejvaqbjf.bet>
References: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6eKyWx3OVNcjT+gTcrXHI698CuZwRbpbiYyqxuX8JMN92LigMyW
 OMOgiSuhl7MytD70daxjv0dNPToKtgzjhPN2qufL4oV7CXT1j7i7IzCaqGaUkUsBKAdNKOM
 v8ZBGYrtO+5C5s4tSvXwg7I7GhhvrutAuM333wMLjZ0nJsLhuXqVF+TYskrzxAFtnM6fdQF
 SQz+Gy4xl7Zgt4dZiUlcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+z3dwmbfxnw=:Ede/79qelEInKW2C3fIYnC
 oulRTiqs1jRTLyRHOmlXWFLqu/uuBwuxPmvUPeKFnl/6femy7Yy+y4r1BrrDygnRdJwL4qHMl
 4FQ4EGOVDVK9sKUqKvf5blmr/3lDrNKYfATPmIDacLTm9YF07F9BiXtGPvDbiaUxozaAbAzaP
 EBowZSoAnvrOpXOHJat73l5AA7W47bVdSYJPK6jUDJ+UGcI8vkgc67b273KEUvyIZwxd95iwf
 +vphztJp0kjzDE+TsIQ8pxgFC5Hzaf+dA0jzrDcrJjKmFIuHgOTJGSDwgspU9lZDEeBdOaLlv
 jrfsMQVSQbUy3xI8WBP4zASR3rQqgegO3egiFgg3+2l4FBvZPJYAME/NzO7gnEhEfELb5J8PJ
 zDKg8daA/Vq3+0ulx4OTzU/NXWxMlP3e0Y+4r+jLWG2UagSjo8a30EvT/iecd+qjecpVMnIjt
 WNbboeyJkJLuoIb1Ucpmy2Gh87Wh/HB72f0PNGbqck3FE/2MXtnX1y7wqvU85q8auQ51fKsuG
 RL9pHXiuftlQF/aU7icJZSDI0dMEd/25+u93AZ3JvjqT+sut8XQvf5JqJPp39Te74maybSuMS
 VidXied+tQ9OMWHT3i3DTjdZ1lm+8SuR9EMgHzmJqVqcfmxy2c+ymDxFXRokXr9YG6bCmcRm4
 OLHDEpxjF3CkZd6rftMOJsDTIigIPltF8NoFNCPPWZ0T0Z4HllJpbn7yBH271L/gCqV2arr2z
 O+LzNkK+WZrK0NQ7oF+erbiY4TQgajkhnR1zF6cIUnoUo4LbWU159++MZtEiQ+q+rXKyP+xXc
 0zSwuBTYLWaLJpcw1ZTMb6cEAKoqBJmO/WFkNP5J+sE4in0JS5OSgcr2LtsA/JGj84KAJFVvS
 GOakNhZADYNbR+7qxbf8ko5g/PKDhgWbGTDsEaroKMSa5c/eNudsk7DoyRURHoG218uHyXYv7
 rixxBGZTwKQoAifdPURREPie0qL8U7yzOMn83MB2hjmpzVwS7CYfn9a5hdMJMsY/7naV0oZ2N
 26vHbTKhdezLEw1MpKCKXWFnomGwuoyRM65zqzU32+TjN0lFoPtAcN/8jJiPR1nyXg4+ZJmY5
 wA/ArNjbbQERzE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

On Tue, 4 Jan 2022, Marc Strapetz via GitGitGadget wrote:

> From: Marc Strapetz <marc.strapetz@syntevo.com>
>
> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
> ---
>     t/README: fix typo
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1110%2=
Fmstrap%2Ffeature%2FREADME-typo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1110/mstr=
ap/feature/README-typo-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1110
>
>  t/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/README b/t/README
> index 2353a4c5e13..f48e0542cdc 100644
> --- a/t/README
> +++ b/t/README
> @@ -466,7 +466,7 @@ explicitly providing repositories when accessing sub=
module objects is
>  complete or needs to be abandoned for whatever reason (in which case th=
e
>  migrated codepaths still retain their performance benefits).
>
> -GIT_TEST_REQUIRE_PREREQ=3D<list> allows specifying a space speparated l=
ist of
> +GIT_TEST_REQUIRE_PREREQ=3D<list> allows specifying a space separated li=
st of

Good find!

I'm curious, how did you find it? If it was a spell checker, did it also
find the "dotsh" typo in the same file (it should be "dots", I think)?

Ciao,
Dscho

>  prereqs that are required to succeed. If a prereq in this list is trigg=
ered by
>  a test and then fails then the whole test run will abort. This can help=
 to make
>  sure the expected tests are executed and not silently skipped when thei=
r
>
> base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
> --
> gitgitgadget
>
