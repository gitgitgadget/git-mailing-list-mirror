Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2DCC20248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfCUOgf (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:36:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:35497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUOgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553178988;
        bh=keStAwKuNrdfRe4Qtje0pZvduEEVja935Al4ClebLPM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZnZ9OcoT9DXychPK5GHZeAcvrsHX/pR4dR/S8AFLmP/3BP2US+DYer2faC60Vgt4v
         uLfWfKK5SIgMd4xwIC6eGvcD7t+8Hz8etJXYAyED7cwDMdZoZ//ayjU0EX6bwMMWwn
         QhCd3nqhuqAsJyFOb9OglhP1lKrMmRGHIMukhKJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXq3L-1hTJHA3i7j-00Wr5C; Thu, 21
 Mar 2019 15:36:28 +0100
Date:   Thu, 21 Mar 2019 15:36:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix fsmonitor after discard_index()
In-Reply-To: <87ef74a1dv.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903211532140.41@tvgsbejvaqbjf.bet>
References: <pull.165.git.gitgitgadget@gmail.com> <87ef74a1dv.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-994732517-1553178987=:41"
X-Provags-ID: V03:K1:0YRMBH3sl/iMETIfMfUlj/TSUcctAw9t7v+8yuxwCJ+C1MYW6p9
 y9dvggPazLImu6hb58kIdxGlJafnbdJvsYsVaxw6efEHDj8VWiwJnbSRL6REOdd6Gpk/PI2
 Fl93s7QwxUGeLATf2EX8pxVgzh93xBB7E+ACf6fpHlnCPRPnnTwx3n2qaoNlRnWvdtCT2PZ
 22AKfcB/oMvKlzBEiv8WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KTsE2pMecsw=:jQ4WJlnVaHt3LtamU07vHx
 tdpXt4FeKtT6rghuIMwunSjJsP9wvjXXIaNNCl5JFIDop0wWD06N392jWWHb3Og+hHsE8jExa
 AWo/zKwoyxh5hz+KNG6lu9OZIL5H+D2WoE15goammUQseworEIGo4MOG51VkxqzkoOvM4WJBS
 Gbgkxt7tgyQ03zdIPuNKrlASyW6HqPmFRFMD2HYBEL2aIVuxxTtIEZojJCm8R2sJlMTPI6WSS
 UNVL7AdRsBWqc0kNqV5oA6VHZapoWT7B66XGUD2gx1O0biFwYOVdhVBCuild3A/KW7Va38EDC
 s3TVCV0ef1ViKhzCOPjAFz3K1FNHRofvCi9uWfpzo9TB7xDtkj2Z6BrlvXj/fpBGLpGn3dgJQ
 WNJaGU2Jk9IbMAOaQR2KjfPZx2kthZUdPkopGJiRGQagl4GOo1uMT109lDVFKgDX2klFQBvfJ
 sqquhMlIECfLp817iuR2UBMI2NFaZQtUTNEkoVHpqf8C3brfVDWbO7q8N8wSo+5ACkHkbnF4r
 gFO7AjThI+4FZGTNkciSZ/ONjdvdEW6bqeWyOVo0PJP8CCNearBr/x06OtPTEhcBy4O0+VkhL
 t/ARyad2HOkdTJKjXYYDDMRf3PGK9FDd/lVqoJgHtcFySil3KqT5VQrYgXx3119NMbb+6UnTN
 M9wxQ+J+0x6h/HbqqXUQ/EICvuwE3l/zXnQtVI/6tx8SPsJdkCVS6gxjYMkGXBLuEc1t55xud
 kFVRvvtd+02QApRLypv5x+SjmEtKpTJViPeMkioOx66rIUSMNgyGCTMWfIBTlm8tl2iSC3jxB
 6NlUwdjHyU7LV5dXOm4edPEi1CqFzuy+eHABkPPRfJs1VAgJ8jMmM+0vAun23MhAN8Rl8jILG
 PHQouCNN3rBnNTDGCtTU0UCVP9JBeE5W7A+CokW3dC8lVk1NqMbdqRVfG5weUPySbqRCR4fie
 +tZ0g5aBn1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-994732517-1553178987=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 18 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sat, Mar 16 2019, Johannes Schindelin via GitGitGadget wrote:
>
> > It was reported by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > [https://public-inbox.org/git/nycvar.QRO.7.76.6.1903142058130.41@tvgsb=
ejvaqbjf.bet/T/#mb8718fe52e4721dacd3b143a09187ff9090ef4e3]
> > that there were problems with the fsmonitor feature in conjunction wit=
h the
> > newly built-in git stash/git rebase.
> >
> > The culprit really is that the fsmonitor flag that says whether it was
> > queried already was not re-set after discard_index() was called by mis=
take.
> >
> > This fixes that, and apparently also other long-standing fsmonitor iss=
ues.
>
> I've added this to my internal build & now the test suite passes in the
> fsmonitor mode without any test skipping.

Awesome.

> > (Note that there is still a flakiness around t7519
> > [https://github.com/git-for-windows/git/pull/2127#pullrequestreview-21=
5010574]
> > where it tries to make sure that the fsmonitor hook can prevent unnece=
ssary
> > lstat() calls, but that seems to be unrelated to this here bug.)
>
> FWIW Since February 1st, 2018 I've run my builds on CentOS [67] through
> an GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all test and have never
> encountered this flakyness, and I built pretty much on every "next"
> push-out.
>
> The fix sounds good, just one data point on the rarity of the race in
> practice. I hadn't noticed this being flaky.

That makes me think that my bug fix may bring this racy problem to the
light of day. After all, now we will query the fsmonitor a lot more times
than before, and in quicker succession (because there are no slow shell
commands running in between fsmonitor calls, i.e. the test suite).

I guess I will see more of that now, and maybe eventually the pain in my
notification mails will be high enough that I'll allocate time to
investigate.

Thank you for your feedback, though!
Dscho

--8323328-994732517-1553178987=:41--
