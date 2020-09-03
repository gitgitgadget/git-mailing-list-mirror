Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F53C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3FA207EA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MEsOtA3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgICKGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:06:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:46937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICKGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 06:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599127603;
        bh=V40UBeS10vyBuVk4mHmZDBuVS/wJEFlBP/TSy3fS5ZI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MEsOtA3B2Y4LuxTEuod2qtDfHGxfVrUtZPmPP07q1iWk0M0lDF5kw+GrbXqyq8D3s
         fgQgkY5/z5j6CZBiiacO6VjbfGINUUsf0QiRVBpvt0coy1LVdoFISigmWT7+rK1/TZ
         s75Hx/Nlo4aHYo5S9ZcJ4+WvNoXGwQnl5O9OWXeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1k8FqB0CPk-00ThqI; Thu, 03
 Sep 2020 12:06:43 +0200
Date:   Thu, 3 Sep 2020 03:42:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] vcbuild: fix library name for expat with make MSVC=1
In-Reply-To: <pull.722.git.1599077798953.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009030341540.56@tvgsbejvaqbjf.bet>
References: <pull.722.git.1599077798953.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WeVDpwzv2ORyS2Yana9lJqYjlkN9PMt92mw1kZYOlNKwtSEkTSi
 r+6lg2G+9Qu0lH1kcN6hRkqBzZOtbkBWMhT8iuq0FrMlYZe2elR/JgbbBejz/tjtDkJOXrl
 Dxh7rmpALwpoqbezQH2aWbEPf8dO6RlvHhNI3nPlAq9V+Q5iU0pv37FgQUQWR+OeN0PVaIW
 arL9YCXTysgzTmSPeq35g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1HaoQ+fTWmg=:sVUiR+yCjQ/lGUpyTqIhz5
 ++HHkH/sy/HhBIVb5R4lDvJkxdmPzyFJXIuqsRo39poT9FeN3SPgboSe09hrvhgrih5729GHd
 jVhkHewolijiEF7e9lyT2Z3wYOqRq1jcpJ/JE6AAFifRJCjTEi3xsk/CBlvFR3458WfAIhK9W
 Yrfk1WBhsxqqkscICc0lZEyd00sJEolcU8IKR6x5dqlcZpcIVfdkuIQzhdSq9fnk2wrY5eXb6
 RvvcDVKZGNpha4UL1n/hVXLr2cYI2m3IbqRzQv2jgf56Meqa7WjcrXME35pI/B8nYoVT0Xi/B
 7B/SrmVoc8dIias+2gel1RhyOIpiVy+jLVmzkM/dEmqjWY9uiCDL4Oybwbk6wJlT5hcaFNIZD
 WZWntvPKnvp/roLzHGIEoYXhjl5eabfOfcCAOc+dKEcgRw7ldkHag4+aEc2z0559DroZhejhf
 ifda4ViKcG4lKOoWfWsf06iKsnNqqEYVvDC44W+cPgA+cX/9hXIcieOUsIbNStpg/j4BEnWoW
 fcMtokRvxhMyjpCihui6bl+86Ob3Q8VCCnn8l2hR5LvxD9BxhJthLxCK71JX9FcJl4I3pZtM9
 7reyceYXjBnF52jZkgBFMk/T58CnE03OuNaxypaWy5dlMEm79pyPTXetQYa2bRUeUqdg/kdgt
 CGb4HHWAzhHXKdZPtRbrNFIcwtQ7sDNEULPC//d8QRzN4Ggg8OFLytsZbVBhvpRAQtycnHWFg
 OjCqitl1dMNrk5JHExuSlQSLQKQjmH2djoz4u64oFxQlY7YRhgwblYJ7sRDprkvVnX5hNjZHP
 EucV4GfKf8BoRSw/a9hW4PEdgrLB9hMKTWDnQZMZHf1mFobMTRIWOb/Ju4rph2O82rfR5O5is
 a0XnWhePODdXrqyL5KrasdwMrrlyPgGWWFfnBSkNwGHygarFl7zcMBwvg3JwsTB1s2gE51OIO
 GVDyjhw667M3a4U7qCBMWJyiSnS4uv+w4p4R0gzndPTj9jtnL9NdKoPFR6kQDQcUeH4//KjRr
 QeTHE4Kc/gDOB1moblUyQryVCFzco7IBgZLzYv+eYXll2pmyKhH009Hgdrnhmf3cDzPLdrS8C
 j35/Q2RBITfnLQ5vHHy9fabC0L+A+ibLwfaA1EyMhTGDb3EpzsqaMKF/69eUQblk2sIfUYOkl
 wpgm47jJ54fGykW6lROyfGdsSBSb4ic6PxfLGKARGV7+j/ZIujj+POj1l5QOOZNk+eZ8c5ERc
 v38+NStuLHJZwCMcB8j4x4CHDXivTaYI/qf4BIQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Wed, 2 Sep 2020, Orgad Shaneh via GitGitGadget wrote:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     vcbuild: fix library name for expat with make MSVC=3D1
>
>     Signed-off-by: Orgad Shaneh orgads@gmail.com [orgads@gmail.com]

As can be seen at
https://dev.azure.com/git/git/_build/results?buildId=3D2065&view=3Dartifac=
ts&type=3DpublishedArtifacts,
this change is correct.

ACK.

Thank you,
Dscho

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-722%2F=
orgads%2Fvcbuild-expat-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-722/orgad=
s/vcbuild-expat-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/722
>
>  compat/vcbuild/scripts/clink.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/cl=
ink.pl
> index 61ad084a7b..df167d1e1a 100755
> --- a/compat/vcbuild/scripts/clink.pl
> +++ b/compat/vcbuild/scripts/clink.pl
> @@ -66,7 +66,7 @@
>  		}
>  		push(@args, $lib);
>  	} elsif ("$arg" eq "-lexpat") {
> -		push(@args, "expat.lib");
> +		push(@args, "libexpat.lib");
>  	} elsif ("$arg" =3D~ /^-L/ && "$arg" ne "-LTCG") {
>  		$arg =3D~ s/^-L/-LIBPATH:/;
>  		push(@lflags, $arg);
>
> base-commit: e19713638985533ce461db072b49112da5bd2042
> --
> gitgitgadget
>
