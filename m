Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09181F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeKLVfw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:35:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:49029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbeKLVfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:35:52 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRB8F-1fuqSG1q2h-00UXTj; Mon, 12
 Nov 2018 12:42:47 +0100
Date:   Mon, 12 Nov 2018 12:42:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior
 where appropriate
In-Reply-To: <xmqq1s7r3pqy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811121235120.39@tvgsbejvaqbjf.bet>
References: <pull.72.git.gitgitgadget@gmail.com> <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com> <20181109101148.GB7410@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
 <xmqq1s7r3pqy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:f5RoP11gAGaRnvc+UfBcJYs/7X/GcsHjiDoOqZAxvlosOVmIjVt
 SNh4HfQSTHG1tgsarF7XLSH1yLZbNx65ZOMQTQhshnj3OU+OL0paSpV7MIuMUiUy2QlYSoz
 4gbRJzSQUoFTrh2Rw1z5Q/z+jaC5NPvdb0AKBJ96IAILwCXSOsBWgVnHGWcGKnE0Mnh4Adn
 gr6XeA2TQprhHIRVXC3tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/Cr4140anzM=:ZGEqSQu8J+vvlCsOEEbHel
 Im4rPvLfbgDD8+JE9nxFsmNY8a59tfrnh7kPS+h2ZL/V8/EEUG28Si4CaZTY0yNZMOiDKxhRY
 zGa7X5aSF1Uki36CbpYk84J9hkrM5fEiRzOvC4EcYLdTTU73mrSQnoTbqRE3ZftFWpKRf/qh9
 wcCpLS8cwCllyy4wlA6hoPkrnfxCVgoMutyAT2aOZGtBlNjyAVPgyaHtRQCM0tIbaK/D/KCpa
 FKyxQH4iHveI2fewcjp4Hq/2aasVaBDtzVBrttOyN3w8Ljm05YljC0zDDbX1GjE/bqeJF1c9Q
 zkHeSiibQmPk8hG8HKp78FelArcZnQ/BlSJ7HucWVjhNG1Dn469Rpcf9A2Bd+EIgz2sls3gyN
 t6+HMYEs8WO7KLlv+WwSeqEEsD0ivlHN2Gbl9CtzEZPzxDrDmuxG4GIPEN/Qo7xg+u5hpCcYH
 znaL02yTGDI+79b01Le457ibJ73wBIqGUZRgtSXcFZxpLncc0wrpb/5k7LCyMGFRXAbHxnble
 VFaXDF5Oq9LS7+SpkrRC5mW2R824Dp9/CuLcSS5Q6r487HclR7iffuJf/nZGW2h279jxOzdtl
 K1VaTFiiGlCwQ1Fp2x46q/PqK+8z5CpuBBfotptaTsnJf4KAxyZpUhW5ETgcXGJtmSQUib1C2
 WPCQPmxwhamIwV6lx7lGsoYsS+RWIe0f+7+6MUGQXueANxqdgcocHcvFjIlXFJzEhoQDImuLQ
 RbeM60UzAXBxQEZi3sSBM9ji+LAZUSawsjQoFiZ0hpcbw1jvF5tTv+Fs59sN/1WA3l7aAeqvx
 LDQnNvWO7zFjGMi2Il6BFj7x6FHPGBHBc8pRiRlZLAsQL5gxgx/OL9cj08Cz8FgkTbHRQrSry
 Em6G5XezWqmJvu/IQchW2Qg/Mubf/YhkinF0ejPpwLnBI8EarsZmjVkplESQoxugOhHTHmwOn
 DmmAWJYyYjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >  static int reset_head(struct object_id *oid, const char *action,
> >> > -		      const char *switch_to_branch, int detach_head,
> >> > +		      const char *switch_to_branch,
> >> > +		      int detach_head, int reset_hard,
> >> 
> >> It might be worth switching to a single flag variable here. It would
> >> make calls like this:
> >> 
> >> > -	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
> >> > +	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
> >> >  	    NULL, msg.buf))
> >> 
> >> a little more self-documenting (if a little more verbose).
> >
> > I thought about that, but for just two flags? Well, let me try it and see
> > whether I like the result ;-)
> 
> My rule of thumb is that repeating three times is definitely when we
> should consolidate separate ones into a single flag word, and twice
> is a borderline.
> 
> For two-time repetition, it is often worth fixing when somebody
> notices it during the review, as that is a sign that repetition,
> even a minor one, disturbed a reader enough to point out.

That's my thought exactly, hence I looked into it. The end result is
actually easier to read, in particular the commit that re-introduces the
`reset --hard` behavior: it no longer touches *all* callsites of
`reset_head()` but only the relevant ones.

> On the other hand, for a file-scope static that is likely to stay as a
> non-API function but a local helper, it may not be worth it.

Oh, do you think that `reset_head()` is likely to stay as non-API
function? I found myself in the need of repeating this tedious
unpack_trees() dance quite a few times over the past two years, and it is
*always* daunting because the API is *that* unintuitive.

So I *do* hope that `reset_head()` will actually be moved to reset.[ch]
eventually, and callsites e.g. in `sequencer.c` will be converted from
calling `unpack_trees()` to calling `reset_head()` instead.

v2 on the way,
Dscho

> So I am OK either way, slightly in favor of fixing it while we
> remember.
> 
> 
> >> This one could actually turn into:
> >> 
> >>   ret = error(...);
> >>   goto leave_reset_head;
> >> 
> >> now. We don't have to worry about an uninitialized desc.buffer anymore
> >> (as I mentioned in the previous email), because "nr" would be 0.
> >> 
> >> It doesn't save any lines, though (but maybe having a single
> >> cleanup/exit point would make things easier to read; I dunno).
> >
> > But you're right, of course. Consistency makes for easier-to-read code.
> 
> Yup, that does sound good.
> 
> Thanks.
> 
