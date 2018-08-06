Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93197208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 13:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeHFPYD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 11:24:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:46771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbeHFPYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 11:24:03 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5Ve-1fm7721ed4-003xEO; Mon, 06
 Aug 2018 15:14:54 +0200
Date:   Mon, 6 Aug 2018 15:14:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] line-log: convert an assertion to a full BUG()
 call
In-Reply-To: <CAPig+cRrC2mf1uuQ1C4Ue4OMZQbgcxXbJ9AXs0y6RSnUrcm7Dg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808061510260.71@tvgsbejvaqbjf.bet>
References: <pull.15.git.gitgitgadget@gmail.com> <faf35214f0f339b792a30a3bd013056217d9a2c1.1533421101.git.gitgitgadget@gmail.com> <CAPig+cRrC2mf1uuQ1C4Ue4OMZQbgcxXbJ9AXs0y6RSnUrcm7Dg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sNyTiiS7ul7BkAvS6laS5YgjVOLGB0tyOeGadM0HwSqOd5v0Wd9
 oGlvwXaZZtrDoTl2QZR1PFHEcq7S7qTPz4CnKFSYmEXCrrFXZh/1nQaKMrXk4NPEx0NfWeE
 J/7OQuokUj957qe0wOhNNuL7trdX5h60WI6fga0yimEP3URNoX8WCrCubSGPeftUS4sGowP
 9OJEAfiVpB37Wc6Y4VwDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KTh5oVdOjmU=:drGGeeBqNQ9lV/dHAK25jE
 IL7K+vd1zgY0AwTf8Z1jKS4/NwEMk5Y1QsDpt5SGZrsabUJJebYttlZYM9JKRlaVkcIXGOoL/
 28ne40I+M89RTHb+kE18TPedUhxffIPu1Y5x4ZHnpFdqYLOKpkFq0gbQCkYDLiuc9MvLhsIup
 O16k9JCrnRpi3LenB+WCVgSzHufnVIATsYjLdPsz6J4cidPouGPnieRWR/WoQS+OClQrkxttL
 bFAd6BmPfSAh2McByu8wE7cJfkMgPbvVm5ewmWvsOxOwVjPiJqeDeI+Al/AjDGPx2xMFA2MxX
 rCkArWuEV7Ss9LJbiY7abaVMmUn+hEBdXgHLaHx+ou0A1AMkKSDUFPb5TgIiV8Lc7H98YueHW
 IAyrD/jJMJrsGiFEEkR1Jc46el+w5l8XdbMaqHVHNx8hR00IWsGhNVz1kPxGuQcD/Rf/18yGC
 8x2FNi6Q5zvOVTZD/dqF2DBM195fAesUXjloTd6k6lnly7E/MoS1mYj9sEfXwTe1TOJxNYIqI
 DbbglRl0aAtuNuqy1BLeCJK0UZL9X6eh4hNYn69q81vJHp5vmlA76mwiEH1+TBm+TK8YDhcsv
 Ufrm7F8pUSHfttaob/4+qXs748GcM7TejwLwu3oklb1qNC9sfYEuCoALJ6R9VtdEoCNasckOz
 jkjaGtQaqvatJVisSM933mB/+mDmHZnGvaq4E3evu9lR5qBPztYwE5qcuH4pJHLF1mYMgZEbm
 bfPKPjlHqFXL7xfi2qGRZGVssdxtIjiHd+NUiCXAlDtMERityyJeijcdwboLwmzftCUExcY5D
 wu1di2l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 5 Aug 2018, Eric Sunshine wrote:

> On Sat, Aug 4, 2018 at 6:18 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The assertion in question really indicates a bug, when triggered, so we
> > might just as well use the sanctioned method to report it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/line-log.c b/line-log.c
> > @@ -72,7 +72,9 @@ void range_set_append(struct range_set *rs, long a, long b)
> > -       assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
> > +       if (rs->nr > 0 && rs->ranges[rs->nr-1].end > a)
> > +               BUG("append %ld-%ld, after %ld-%ld?!?", a, b,
> > +                   rs->ranges[rs->nr-1].start, rs->ranges[rs->nr-1].end);
> 
> Although this appears to be a faithful translation of the assert() to
> BUG(), as mentioned by Andrei in his review of 3/4, the existing
> assert() seems to have an off-by-1 error, which means that the "> a"
> here really ought to be ">= a".

I think Andrei's assessment is wrong. The code could not test for that
earlier, as it did allow ranges to become "abutting" in the process, by
failing to merge them. So the invariant you talked about is more of an
invariant for the initial state.

My 3/4 would make that invariant heeded throughout the process.

I am still keen on keeping the invariants straight *without* resorting to
dirty tricks like calling sort_and_merge. Calling that function would just
make it easier for bugs to hide in this code.

> Given that this file is full of assert()'s, it doesn't necessarily
> make sense to convert only this one, so perhaps the patch should be
> dropped (since I'm guessing you don't want to convert the rest of
> them).

Sure, there are 18 of them, and you're right, I lack the time to convert
them.

Ciao,
Dscho
