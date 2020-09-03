Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B136C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3D20767
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KVNE6q/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgICKTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:19:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:40803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgICKTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 06:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599128384;
        bh=hTFR658Z7wU1gdKxdlggpqmFQlRm7OS+AjBN5HlnHrE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KVNE6q/54bcaWF9/3bqXuvH8eUC+tmh81g8jUUcwDggXJDC7S/UvHrPGTmD+OtLV7
         ylR//NCuUTigcoMKKNlRKKN8V2EFO3exroegIRKvhHrpqWmQFbuJs4fQsHPrkkE8CO
         SyTm+aMbGR7AOoJBEmdw2ePsMi7aAj6zYSpRVGsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([213.196.212.246]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1kvfoe1WTY-00i9ko; Thu, 03
 Sep 2020 12:19:44 +0200
Date:   Thu, 3 Sep 2020 03:55:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] vcbuild: fix batch file name in README
In-Reply-To: <20200903000236.GC4035286@google.com>
Message-ID: <nycvar.QRO.7.76.6.2009030353500.56@tvgsbejvaqbjf.bet>
References: <pull.721.git.1599077900986.gitgitgadget@gmail.com> <20200903000236.GC4035286@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wIYz6E0Kz5I4h6WKC7mCtzQoKYrVXTW4IXnH9hf/MFsCQQYi1kV
 BSGccK4LxTGWf9AR3smKquKunWlPquWNUH6YQqs1GxFtznM8zPh1/mCqP8giHDDDswp3Q8T
 wO3wGB8gDC7NsI99wO5hnKIZLNOQjg3M+xY9jbq/1KQ9IXnoSYG81epy4qm0z007OQIvu80
 vcne8Hb/bXDOi+s2jJ0Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jLmq9hyAaN4=:qE4/1Yof1FRPGGzsdSG3ul
 5ltmINC9tOO1sgymh7eZu72iIMEowrEQmRf94ScxWbgpsWWc9HyM+d+RYb4+nNIK+R/09eLz3
 QLghlH3PjRA6XZg6MHJSgsPI8PW0yumn9DFGEg/rOuDJqd6a0xQG9KvkFDtqn8G2aPdPexLGY
 rmgSPKFEWxWGy0CCjaKuUR32G9Ses679cw63iwi004rUnj8tfcPo5mCuMWgsBY71/l7djcNja
 LeL2gVfmFjeu0ABZII3QFUgBLhNMZffseKsI4/gVpJAPbH+ma2EEb0/6B3upIVzw4sILvMwKx
 cyQchG3iDIWTIDI/Rkfl3itQsEZyxCgW+aARHTGGYKqvjiYbMC2ClubGMmnkbs7z6/uvdiZ9/
 zLJLjMOUJroG7cF7TvpfZzjbAqpYtvjT6C+uAh6D7ePR0zpQChF3ruUfPPaFbbgwaK1Oa3AyT
 f5WUlSFyGocMVihzJ/D4Mhvie8CF1m02fUxCdso8OL6kTilDR66SO1JgWVBIh3AQxz+ClvGk8
 Qpqf8UuXe87XPMXh4aZhf3IMXjtlLr2hCTeP1/JpYv9H3TzcAlZSAvg97JOC/iGCDeltMnqS4
 tTQiEUxm4qRA3nxIItkPUzPy9jKyIFhcalzKMDwvY14Dbauzbff5UA47Cj0GbjKxFPYBKm4e+
 9iH0LQovhW/ocrhsjTeIAD/dB8nRfEEvFv/dkrVoE4b82yrMonZeowqATNwwzAQ7oOeM32Hdx
 4wjZvS4Q/ja4RbWeNHBmONnR13Ck8YxbEMTvWBA+3OudLO4yMGLYvCno8gWOwMcmq+Yown42E
 IRtr0OL0vYZeho160sPvAI0ax2QnoyTCkfaEEgq2bZPXkIUY2ezklVnQW1/RaIKo30gG8zkVT
 zH9K53H5Jn2rQgflvnXNhcO3RC8KmSSquQ1oR426upW25scr7b0Q+9DWk1OTGHsZogylKY5Un
 IknorLZ5tC618E8s4b7E3aJu0zcAO92yF4n3Ismp9KYvQsVuhyv/xbD3HOhtSCau9BeTBknKk
 WeXFWN/7YqerNQ4SWD2ENkIwcR/nvVbLUfb2w3YTuDFXxzRyhPorxhnRZG7YDQ6kyt08CQAHO
 nFdE6X/3C1l/NLttizOp81TUgRmXTol2IPRsUC9zfDLHJuOjBOi3iJmgMQ29O+XuBNNd8x52j
 rhhTeQ5reVV/YAKHjoNo3fMBV1kv/F4lRlaEWasYZj6SqgsJFh7kM8ZsO3Xpgq+h1au7fOtWK
 3/qwVj5nyCuH5vhiqXhcBI/sNj40LG3H/dgzrSA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 2 Sep 2020, Jonathan Nieder wrote:

> (cc-ing Jeff Hostetler, vcbuild expert)
> Orgad Shaneh wrote:
>
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> > ---
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-721%=
2Forgads%2Fvcbuild-readme-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-721/org=
ads/vcbuild-readme-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/721
> >
> >  compat/vcbuild/README | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Makes sense.  This discrepancy is already present in the initial
> contribution dce7d295514 (msvc: support building Git using MS Visual
> C++, 2019-06-25), so it's probably from documentation going out of
> date between review rounds.

Not in _public_ review rounds, as even the first version I sent did not
have that `.bat` file anymore:
https://github.com/gitgitgadget/git/tree/pr-149/dscho/msvc-v1/compat/vcbui=
ld

FWIW the old name was a hold-over from the time when we tried to use NuGet
packages (and I think this is the first time I mentioned this on this here
mailing list), which we were able to abandon in favor of using `vcpkg`.

Ciao,
Dscho

>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> > diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> > index 42292e7c09..51fb083dbb 100644
> > --- a/compat/vcbuild/README
> > +++ b/compat/vcbuild/README
> > @@ -26,8 +26,8 @@ The Steps to Build Git with VS2015 or VS2017 from th=
e command line.
> >     Use ONE of the following forms which should match how you want to
> >     compile git.exe.
> >
> > -   $ ./compat/vcbuild/vcpkg_copy_packages.bat debug
> > -   $ ./compat/vcbuild/vcpkg_copy_packages.bat release
> > +   $ ./compat/vcbuild/vcpkg_copy_dlls.bat debug
> > +   $ ./compat/vcbuild/vcpkg_copy_dlls.bat release
> >
> >  3. Build git using MSVC from an SDK bash window using one of the
> >     following commands:
> >
> > base-commit: e19713638985533ce461db072b49112da5bd2042
> > --
> > gitgitgadget
>
