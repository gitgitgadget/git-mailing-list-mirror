Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B7C1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 18:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGYShY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 14:37:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:39043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGYShY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 14:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564079838;
        bh=5bue2ij9hon3z5Mf9M6c0p8D+iGKp6PiTdyvl9sQdkk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f0HwG9oJaddvfbCToNs8J/x3ocjZ5PM8YuaW6E3545gFauF7nk10lHMecWpJQCT55
         2dnZfGvS0pXNsYMz79BbMKxrU3d9+sThsE6LIk/o+NM37q7nKmJDtW9CCRXoeEUQaz
         LIWT5eZ1qz112T5yWmQuJGaYvQzy1IAP8uNaHA+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcSWg-1iIaWO2oOU-00jskp; Thu, 25
 Jul 2019 20:37:18 +0200
Date:   Thu, 25 Jul 2019 20:37:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] t3422: mark two test cases as requiring support for
 `--preserve-merges`
In-Reply-To: <xmqqpnlyoyh9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907252036070.21907@tvgsbejvaqbjf.bet>
References: <pull.296.git.gitgitgadget@gmail.com> <ed41e8d7abc93603063e9a99f628548608413d34.1564046191.git.gitgitgadget@gmail.com> <xmqq8ssmqe02.fsf@gitster-ct.c.googlers.com> <xmqqpnlyoyh9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bA3xi97625VTpmQwxq8PLdAetXfxJw8Ch978Xu5yARs2tDDlZS9
 J9KfrJaIhtte6UoSrEgu3UwNMhRcNN1fA0C0dhdKlktc5QaFeWTvsRtyWCwXOiwYo1XskUj
 +28olzA7rFWyWnenn9rAMPgS7EEy+Ee8zEktjrixYGYVn5uNB+WDVNVnUr7wJmM3IS9jzYG
 776TKQ5ijo3OLirzuas2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jhLoLwSu2Kw=:JE9lJHdHHURmqtZ144/2t1
 /04DNfzdz2BxCrz/WEfTviMdESgGuOmxIggForMUzTqes3cbLwWLf7w9vSTu6sQ4G0K2X+2Na
 7vPKrxp6NtE1zAfTTIikxuzyH04ZFan3Myiq+K66+y8CY2MR00Y8AjxbO0Qzb7oGL4JWgUevV
 lapx15u1GhXL1W+7z/2La5sGfmmAspW37FffLr0+E+36+6inWMak2MCuFzq8hpEC4sxsGxEnN
 lJsWA/qWGvPYi9kKKRt8kaXhb2GWFMSmD5wOHUnzWZCS8gpnq/BuS3M0gSO5IWrE4s3kFCAJa
 LGH2W9bs8BXW/22yaRUItqmovzefCIDJNMByhHGZ+pKiwaixNCCMU6rPTmoWLRgOS9RGaSufx
 KVcsEjzMCAwchwR6+DABn92Vl881/tW+j2JGoayakxrJcgw4wDBbCH409fpKvUAAb/JM7/UtE
 n4GtIieeFgvCklC20ejTuBFLdvwT0VRml5zh6AY1cVW8+ihQzC2zxPzlvxxrjKbbJIQlxyewS
 uH0MrKskTo8VXaLORg36kkuZsN4SIOYqq+gMLBTWk3alYjPTsCdikxhWxVsSXowKe4PJBXbZG
 HsYiQUXb9YgfPFxcbCcR1Cb0xW4HlL8P6FY5mjvN6xc7D+i5TqvEjKwgk1TNKkVImB1yLF/Rr
 T9mxMyLe/2C3Zc2YULaa9sYA0CACKZFJ3S10GLpBXOF2R0SRrqMldZ3ZPpq4jhYGJInPIGM3l
 MpGR7QDOliKpBGIPvpQhCWzQhYPLi2KM/TLb2gli+KGBjQQV40ROEW4hlhb7BHOnih5rFK+n+
 gXJExFEjNgGmO8sKxTRJLUUCjRlE9tKrnc8FCfP+EUHLnWag1f5Y9EYdQE7DSEapA8AAlfpaP
 P4onrwi7gwF9cqyWE3eKDzXTVBx+hDRc9QIvPwEHC8exB/9kDycKbfWPo22njvvlHmwIW3+qH
 Caa9TMPjjlxcwfES8fgAu8gIPyCGsO0KRW9RkBkfnFJ2dtGZO1fH5GgRWQI88Lw51pR13zeAC
 RDqbbljwZBPhJZ5Qh9C8yo1pRA6OXkCTIvR7x32+JZYVAJLPk6rJYg3+8v90vm3P0F/1jfLLj
 cM7l/u0urbHX+BukuA+4rVVmnnz377RgtPy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Jul 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> We started marking all of those test cases that require `git rebase -=
p`
> >> to work in the recent past, to allow for skipping them (because the
> >> `--preserve-merges` backend is already deprecated and will be removed=
 in
> >> one of the next major versions, so it is a bit pointless to test its
> >> functionality all the time).
> >>
> >> This patch marks two previously forgotten test cases with the `REBASE=
_P`
> >> prerequisite, to allow skipping them via setting the environment
> >> variable `GIT_TEST_SKIP_REBASE_P`.
> >>
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> ---
> >>  t/t3422-rebase-incompatible-options.sh | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Thanks.
>
> Wait.  What is the relationship between this one and the part that
> touches the same path in db4a3f26 ("tests: mark a couple more test
> cases as requiring `rebase -p`", 2019-05-28), which is reachable
> even from 'maint'?

Aha!

The difference is that the current patch series (in fact, all my
"deprecate/drop rebase -p" patch series) build on top of
js/rebase-cleanup.

So js/rebase-cleanup is based on something older than `maint`, eh?

Ciao,
Dscho
