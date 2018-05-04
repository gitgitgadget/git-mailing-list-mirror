Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570151F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEDHPu (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:15:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:48425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDHPt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:15:49 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFR2O-1f93Qg3bVs-00EQei; Fri, 04
 May 2018 09:15:43 +0200
Date:   Fri, 4 May 2018 09:15:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 05/18] branch-diff: also show the diff between patches
In-Reply-To: <CAPig+cQc-FXyZv=61GO7-6apu_avA-DhPkqJLC_1a5hKmq=bZg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805040904430.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <141e5b63e4511c13380216fad9b8601d2bc6051e.1525361419.git.johannes.schindelin@gmx.de> <CAPig+cQc-FXyZv=61GO7-6apu_avA-DhPkqJLC_1a5hKmq=bZg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yJY3qDEMDHvUMino25rJ+Iwz6Xg5KKq0whrXn4q5lWBYmaSnhzg
 liOLh5IzqkObia6Zx1/0GkpglnUtiR684axO0MhfWe+kpHZpHB06EWWZyQEkkazki9qwZCQ
 oH0R6RKbPxrILZKpt9UWnnHu/yYwhhMJCnA4xEF8PlW0HiaJbhSkEqFCu39F7S+LnMtqZiN
 DtMvBPQ6K6D5l5Alyypjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YKiU2UIomRE=:9A4KVnr1J0lAxNLAq5D3Fe
 qTEfNipPt3NBQTN9XH/PCXOCg6L215pLAAIN0RU4l4qeUb8/7gTnGe/vBgmFZxgOV7G+FUcFZ
 G1dWQVo6Qu6F9fKovkeVPhw3aq/A4+gK/ZmR3LHY9s5zl8VQWKRie8DOAqGjxcCdnUAKu0+Cd
 ikAs3LyLJBwgC+O5cYaI+osOhSvGRXrjy4k1vIsQpmEYr/8YfNTDNRLuSu1NO+WPRjNYMUMgW
 pxQxIRQLOYhLrDqSkLRj6rmxcbmwBN/9h0ASwlPz3IwpzI5c3xQ++D72fobDOce7c5hQBEdhN
 pSVwNG2unf0m/7Xm2p8fu+ss2crgGV8Tt8hH1sLuXtQQvHpPAL1AYeWRrXrEqe7uiOVp4dGvr
 EX+J24vsru0UBHWS/HZC9aLVbIItPaF4k+tryA1uSY0wcz8a9mKpeLi+SP7kjW1BxzCmi6Ckr
 JZFPFcdViZeNKs/lIsPb9PKtqNglueALUGqu7AZ+Cp4C9nclQtfV3bhDKo0CJZAo96MNxyZE1
 wfV43rDbjoZmAk3W7l+0MtsmkGw4R37rXb3TMIr5lu7tO7rU7f8xgcC8RSC4exXUSBEAy9jUq
 0LKiouHGZ9dK7MKSO/SLF6zWZBdYEwE+J1Y5myOIx4SQp8l3ZB4YfXoQsE6ebE7syYFFdRitT
 BqCRiB5qFNtKWj/fMIr2WbOgZAvOyo/NJMcbCMZsr83jOJFYJH2hFKzg7VDM8vAdew02uZTS/
 7vyaB/sEJNgdYHv74pZKnEzQBffR3HrVhQPFXKkRx9jh+2xsUdVyUFYc1S607+WAvqQ4e/j6K
 oqCQMvW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 3 May 2018, Eric Sunshine wrote:

> On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Just like tbdiff, we now show the diff between matching patches. This is
> > a "diff of two diffs", so it can be a bit daunting to read for the
> > beginnger.
> 
> s/beginnger/beginner/
> 
> > This brings branch-diff closer to be feature-complete with regard to
> 
> s/be feature-complete/feature parity/

Yes.

> > diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> > @@ -319,24 +348,37 @@ static void output(struct string_list *a, struct string_list *b)
> >  int cmd_branch_diff(int argc, const char **argv, const char *prefix)
> >  {
> > -       int no_patches = 0;
> > +       struct diff_options diffopt = { 0 };
> >         double creation_weight = 0.6;
> >         struct option options[] = {
> > -               OPT_BOOL(0, "no-patches", &no_patches,
> > -                        N_("short format (no diffs)")),
> 
> This was added in 2/18 but never used...
> 
> > +               OPT_SET_INT(0, "no-patches", &diffopt.output_format,
> > +                           N_("short format (no diffs)"),
> > +                           DIFF_FORMAT_NO_OUTPUT),
> 
> ... and is then replaced in its entirety by this. Perhaps just drop
> the original --no-patches from 2/18 and let it be introduced for the
> first time here?

Sure. I actually started out by parsing even the --color option, but had
stripped that out in a rebase -i run, in favor of using diff_parse_opt()
later. I should really do the same here, too.

Thanks,
Dscho
