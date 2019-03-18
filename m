Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EF520248
	for <e@80x24.org>; Mon, 18 Mar 2019 17:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCRRLr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Mar 2019 13:11:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfCRRLr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 13:11:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE6FFAC8E;
        Mon, 18 Mar 2019 17:11:45 +0000 (UTC)
Date:   Mon, 18 Mar 2019 18:11:44 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecating git diff ..; dealing with other ranges
Message-ID: <20190318181144.02dea38f@kitsune.suse.cz>
In-Reply-To: <CABPp-BHMi=RTWAVjuORdTWY3ijp4EKhy2QAH0=WrviCiotJtyw@mail.gmail.com>
References: <20190311093751.GA31092@archbookpro.localdomain>
        <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>
        <87va0orop4.fsf@igel.home>
        <87wol3bydp.fsf@evledraar.gmail.com>
        <CABPp-BHMi=RTWAVjuORdTWY3ijp4EKhy2QAH0=WrviCiotJtyw@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Mar 2019 10:07:08 -0700
Elijah Newren <newren@gmail.com> wrote:

> On Tue, Mar 12, 2019 at 2:01 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > On Tue, Mar 12 2019, Andreas Schwab wrote:  
> > > On Mär 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
> > >  
> > >> I however think it may be worth making sure that our docs do not
> > >> encourage "diff A..B" and teach "diff A B" when comparing two
> > >> endpoints.  That can be done without changing anything in the code.  
> > >
> > > The nice thing about "diff A..B" is that you can c&p the output from the
> > > fetch run without the need to edit it.  
> >
> > Not to shoot down this effort, just to add another similar thing I do
> > regularly for ff-branches:
> >
> >  1. Copy/paste A..B fetch output
> >  2. git log A..B
> >  3. ^log^diff
> >
> > I.e. I just need to tell my terminal to re-run the same "log" command
> > with "diff" instead of "log".
> >
> > Of course as covered in the linked thread it doesn't work for some
> > (non-ff) cases, and I'll sometimes end up cursing it and swapping around
> > ".." for "..." with log/diff.  
> 
> Doesn't this somewhat imply that although you use diff A..B here for
> convenience, that it's actually wrong since what you really want is
> A...B?  Or said another way, the end goal of deprecating "diff "A..B"
> then later reinstating "diff A..B" to mean the same thing as "diff
> A...B" would actually be better even for your usecase?

I usually mean diff A..B in this case.

Thanks

Michal
