Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4973211B4
	for <e@80x24.org>; Thu, 29 Nov 2018 16:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeK3DU5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 22:20:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:52789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbeK3DU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 22:20:57 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LorB9-1h99i51M9T-00gt0c; Thu, 29
 Nov 2018 17:14:58 +0100
Date:   Thu, 29 Nov 2018 17:14:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
In-Reply-To: <23552.2773.538601.372248@chiark.greenend.org.uk>
Message-ID: <nycvar.QRO.7.76.6.1811291713030.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com> <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com> <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com> <20181128043154.GA34163@google.com>
 <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1811291516540.41@tvgsbejvaqbjf.bet> <23551.63504.876084.449440@chiark.greenend.org.uk> <nycvar.QRO.7.76.6.1811291638400.41@tvgsbejvaqbjf.bet>
 <23552.2773.538601.372248@chiark.greenend.org.uk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4fpCP/bpfUwPdHC+tuWUzBgFHCkfuxOLaxEEZmqhpfVEFu9Ihwo
 +D2cbdsYJ7+dptaBRNSPnG7Dg5u8Gu+ggTbxD2FDXxXUg2S6w3i0qmOn1hZfUNUkgJF05eS
 u26/VdVoAydQHZpr9CFzCQWTip1K2rQt9oUN3t18OtNK6ii6YrGDAAUb6VG8+tWA2E3zRfA
 poVnFkGHYD4rpT38NULpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gyu5nIhMXJ4=:K/GT3bmFtFF7yg2fVZn4kk
 OucxFhf6oPy7ojAHuvepv2tyTVraG0ZqwaffmBSpsSkjwT95ckXgmvhIaSf3qhXBlkgmDjch+
 Esfqw5LiJLTEyaT9e4uRT8o/quBiAbKD/5bBjNfYPOujGKyaU0E1tXusUPRMY7wlNrIryZ1p7
 1IkxfSaIT5ZcZouITjlMaDHdFKliWQcMCA286EGI8K8cDUeNmWfX3euK1g+bL0DeyIKmQoSMF
 ERaIkFE4JXyJG/vK6F7hkSgLNjvP+6V4xhgjGfbTRypLXzwASvmZZq+NhOhcqMFpSL0BAE6fb
 C9Pcd9EuX94FgrXaYK5Kb4LPqYmiGiXTB6g+J5kER7RaeXdOS8ge0VQr5yrDuUzFzoGZlCDbr
 rpkwlB0dt7MAiGwR4xrrM+jsolX4dkW9rboTQMVniQvVswm1CsDHkuIIQ4vvE5hYPAZSSNDZI
 Dab59Sj5H2zdIr7yoYMQMQsnrhdwLIRkrja+eAlsBc61gSG0FG5LUhzoStrugtXNu6CAz8wh5
 z4HACjcK6uzcLtb5kxv3JN9ZD1B9mDHFAVm0aQKxHirYonjy20Rx8q8VsbZb3U/ZvT/qOdhY/
 nwavfAQCmh2/vTDLyJ4oiWc8mkTOuvxgc0tgc/JvexCyKh6fvxEgg02C9/G9mIJvZbMf+uGxN
 Hk6je2uQOu4meQG8f5lkR5C59QXxgc6D99qrJjTu3AaDUP1UOv+B9fIstc022wSZYLlLVf8MT
 7LrEvO9H6tH03JttGFjvtV3IwPkDUt2EGgTpnHYaDMUEsDqbKno6fiV/JSqeuYsJpw9Qi5Nrm
 lYhbhi5ecwxHa7hAKFwtYNnPHsaoTwBkmUe8YjnYFK0/RWoO9DLH2bz54kYsxp0btrKnUtF6h
 cW02r9EgiRH7h3mHlq8X72l5nHn8Wf+pqQVJ6c0FGMD1UpunzVDZWpvh9+8BQQ4KAhBGgSLMB
 jgtqBNEOf/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ian,

On Thu, 29 Nov 2018, Ian Jackson wrote:

> Johannes Schindelin writes ("Re: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)"):
> > >  In a successful run with older git I get a reflog like this:
> > > 
> > >    4833d74 HEAD@{0}: rebase finished: returning to refs/heads/with-preexisting
> > >    4833d74 HEAD@{1}: debrebase new-upstream 2.1-1: rebase: Add another new upstream file
> > >    cabd5ec HEAD@{2}: debrebase new-upstream 2.1-1: rebase: Edit the .c file
> > >    0b362ce HEAD@{3}: debrebase new-upstream 2.1-1: rebase: Add a new upstream file
> > >    29653e5 HEAD@{4}: debrebase new-upstream 2.1-1: rebase: checkout 29653e5a17bee4ac23a68bba3e12bc1f52858ac3
> > >    85e0c46 HEAD@{5}: debrebase: launder for new upstream
> ...
> > >  This breaks the test because my test suite is checking that I set
> > >  GIT_REFLOG_ACTION appropriately.
> > > 
> > >  If you want I can provide a minimal test case but this should suffice
> > >  to see the bug I hope...
> > 
> > This should be plenty for me to get going. Thank you!
> 
> Happy hunting.

I'll have to take a (lengthy) dinner break now, but this is what I have so
far: a regression test that verifies the breakage (see the
`fix-reflog-action` branch at https://github.com/dscho/git). I'll continue
after dinner and am confident that this bug will be fixed within the next
four hours.

> While you're looking at this, I observe that the fact that the `rebase
> finished' message also does not honour GIT_REFLOG_ACTION appears to be
> a pre-existing bug.

I noticed that, too, but at this point I am only fixing regressions. We
can try to fix this long-standing bug in the v2.20 cycle.

Ciao,
Johannes

> (In general one often can't rely on GIT_REFLOG_ACTION still being set
> because the rebase might have been interrupted and restarted, which I
> think is why my test case looks for it in the initial `checkout'
> message.)
> 
> Regards,
> Ian.
> 
> -- 
> Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.
> 
> If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
> a private address which bypasses my fierce spamfilter.
> 
