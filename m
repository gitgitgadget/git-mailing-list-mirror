Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DADA1F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeEDHYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:24:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:41199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEDHYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:24:15 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYfJW-1etAbY29tC-00VRKW; Fri, 04
 May 2018 09:24:10 +0200
Date:   Fri, 4 May 2018 09:24:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <xmqq1sest2m1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805040923570.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <xmqq1sest2m1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VWP8kDOibpiVLm+kcM7fKv0ZsMckAMJexmOKHLRFm/7+M3pZg2H
 Sb+vRUYOAM1bu8KuMlwrzRzEKIUjMhpA9KXveUAxtPh2w/lQx872Ha81gbzsqcjMGIcLoXC
 U1cD4CyKXeM08w8yPJW8wx/i5OM1RIfKUwumwu+5sr9zZz7MbgXRZ5a+zZPn8XIv/UfcE56
 Vwspsi8H2eKcdCYcpN5cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sEJFZRqw29E=:QdumpcibuetX9H0m/KvoaE
 P4nLcaDpEwQb4EciRji954bOIthAU4oQgr0Nf8AG9hKiVG+g2x51NkRVfNehKfVryOU9D8EuK
 Ja0IwKogmqfXOoN41w9UM2nPIHiz8hi9ovqGWoeeWCsZHFgbA5BfEtblMXdXEi+hZXhIy9UiU
 PJlQUeAno9bN/69/UtRqZWCtWNy6mTuhIQyNY2hXaYWsU20ai0u3dgf2k2K5tuN0KRMg5YSXh
 bSOONJ+fDUqJtxXB+Kq7doqYokB4eXT79V0/EBRYLXXz95qGnsgHWBqjHnqlbaWNHCKgINf85
 0TmmsDFYRijbd/YBL5MwWLzwv/BWBhE06Ga5Xx1jBWwoc7UzrWFSHdHp44jcWQ7ePImAIg/wM
 68qq+fjbME4N/gaS0bnm++2EM0rQVac50jTCZlBFTiVEAZvgBF4MrCWBI68aGAvQFbUVeFv1B
 QM7L59PuKxuuK7u2/k4MYS/JteWWqUQSiPb36AvSvaYlgF0otH6Q5m/O/49fQbh6Mz1BWcr4s
 RfyPwgH7l0SJg35Uv4l0o4nIA96u1k9ubclaBcGoUdWWHHpMKLulSDiovzOF4zTzYbjPdDkiX
 /MUby0HElNd5DFGeAQn8sNbuJM8BbDEokrLfBLOCt+qitqFbvG3RL1Pg9mLjE/VoqMSmhjNGR
 1oB3FWyXIqLZrzCswCMOmZWFyTQCRc5P+llmRzFeMLzniqWYluolyxvRc4AurLge/sV1eWoC+
 s5aSf6mLdYxkX6sKZjMRH0uAs6ceeP3o7X/SVkbwlTK7Ex05KAR4LGtt4zijz+k5LfRkk8Y8E
 5zEv6vD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Johannes Schindelin (17):
> >   Add a function to solve least-cost assignment problems
> >   Add a new builtin: branch-diff
> >   branch-diff: first rudimentary implementation
> >   branch-diff: improve the order of the shown commits
> >   branch-diff: also show the diff between patches
> >   branch-diff: right-trim commit messages
> >   branch-diff: indent the diffs just like tbdiff
> >   branch-diff: suppress the diff headers
> >   branch-diff: adjust the output of the commit pairs
> >   branch-diff: do not show "function names" in hunk headers
> >   branch-diff: use color for the commit pairs
> >   color: provide inverted colors, too
> >   diff: add an internal option to dual-color diffs of diffs
> >   branch-diff: offer to dual-color the diffs
> >   branch-diff --dual-color: work around bogus white-space warning
> >   branch-diff: add a man page
> >   completion: support branch-diff
> >
> > Thomas Rast (1):
> >   branch-diff: add tests
> 
> Lovely.  
> 
> I often have to criticize a series whose later half consists of many
> follow-up patches with "don't do 'oops, the previous was wrong'",
> but the follow-up patches in this series are not such corrections.
> The organization of the series to outline the basic and core idea
> first in the minimum form and then to build on it to improve an
> aspect of the command one step at a time is very helpful to guide
> the readers where the author of the series wants them to go.

Thanks! *beams*

Ciao,
Dscho
