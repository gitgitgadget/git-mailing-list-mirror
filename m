Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DA01F4C1
	for <e@80x24.org>; Mon, 21 Oct 2019 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfJUSx5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:53:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40129 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfJUSx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:53:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id 15so2999748pgt.7
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rAODEZ3EZo2IytbB6I5Wufgbq/JHWRUgiu7ktZmDobk=;
        b=Yk7n9Urrc+phQxkCHeST8URCtBuWGqZgZBVR3j2NhGJ2bq/yjGMPMzTvnoEHTiAExu
         13tBhvqQKQPKesMIbfvA78mcE/g9eHsZSU/f2TuSme+goyJlbevtmCj5llBMM/XVNJhh
         NCMP27ehIiOf6AfEkQMUdZsKCtlh4UjfPizyx5HWm2uhQKbkBac/G6wmbJmgCHJmjZFv
         cN4xXK2lgYhwh00beMWRXBvwcqLBX5GOMdlSyqgpwFDb4iJZt7nwbfq783Wu/XevGtsM
         dQEAaDc1GQS7J94l92qpNdrUh31+UsjSEpn9vFFJennNuG5/3VkbFWUt2UifE8peHawZ
         SKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rAODEZ3EZo2IytbB6I5Wufgbq/JHWRUgiu7ktZmDobk=;
        b=fYt/dmLU82cFbfz+hCIH2/vdUcMTq/y56PtzEo4jYDnuxTdRa/MMb1l1dlKrJOx1II
         9V/4wVHTIFy7wrcb3227bTdADnEIpBiwsytDLE7kom2/ZYdpOe1LjGGLOArPvprgHhIb
         NtMOwqCr/+uXTUq/NqoaqkpZvGUdlYUDTGSvXQl7HlnGJozK9cgl4VhvsZMjsVQUAkaZ
         URBjKQ0QQi4j8/QMxEARWCfpymGDsC6l70rlN7D5/0b/b20ZYQYIlz86hb7oqgy9K3p8
         YYIuaNkzOyHqrT9DiheXj/QVGzjQ1Iv5IolVcxb6Xi4YjeHc24nqEj9aDzTeJbqJSlAZ
         Adqg==
X-Gm-Message-State: APjAAAU1bLwgse3Udy1PJL2LaVXTOrFp+1t0L0HuJ8u680DsaJbL06AD
        q25ILIizj9y408Vpru36KHm6zCYx
X-Google-Smtp-Source: APXvYqyb5Jav288u/9Vx/xvLnyJSWNTYVF5m/WQwZJzwVMnSwiBPg0EtVezUp9z23HHktL3za6rFlQ==
X-Received: by 2002:a17:90a:2484:: with SMTP id i4mr30880405pje.117.1571684035664;
        Mon, 21 Oct 2019 11:53:55 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id 126sm15609256pgg.10.2019.10.21.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:53:54 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:53:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
Message-ID: <20191021185352.GA69085@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
 <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Mon, Oct 21, 2019 at 08:44:40PM +0200, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Fri, 18 Oct 2019, Junio C Hamano wrote:
> 
> > Denton Liu <liu.denton@gmail.com> writes:
> >
> > > There are many += lists in the Makefile and, over time, they have gotten
> > > slightly out of order, alphabetically. Alphabetically sort all += lists
> > > to bring them back in order.
> > > ...
> >
> > Hmm.  I like the general thrust, but ...
> >
> > >  LIB_OBJS += combine-diff.o
> > > -LIB_OBJS += commit.o
> > >  LIB_OBJS += commit-graph.o
> > >  LIB_OBJS += commit-reach.o
> > > +LIB_OBJS += commit.o
> >
> > ... I do not particularly see this change (there may be similar
> > ones) desirable.  I'd find it it be much more natural to sort
> > "commit-anything" after "commit", and that is true with or without
> > the common extension ".o" added to these entries.
> >
> > In short, flipping these entries because '.' sorts later than '-' is
> > making the result look "less sorted", at least to me.
> 
> The problem with this argument is that it disagrees with ASCII, as `-`
> has code 0x2d while `.` has code 0x2e, i.e. it is lexicographically
> _larger_.
> 
> So Denton's patch does the correct thing.

I actually agree with Junio on this one. Without the prefixes, "commit"
would go before "commit-graph" so I think it would make more sense to
order with the prefixes removed instead of taking the naive ordering by
just sorting each block.

Thanks,

Denton

> 
> Ciao,
> Dscho
