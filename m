Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8571FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeARVWk (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:22:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:49541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752062AbeARVWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:22:39 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvUwp-1elbQo467v-010akB; Thu, 18
 Jan 2018 22:22:34 +0100
Date:   Thu, 18 Jan 2018 22:22:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
In-Reply-To: <CA+P7+xrLrU=s4EgPYs7HP4JRBj1fW2YJNUEpswJENBxHAvz5LQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801182214350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de> <CA+P7+xrLrU=s4EgPYs7HP4JRBj1fW2YJNUEpswJENBxHAvz5LQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qU3UXtsRb8HEwp+BH/68X1MZSt+WvK5UGsG4NT08b5b/ANem+rB
 npucXNiibvGi+Wr3I15EtH7aMeZnoMkK4il5hXrMt9r8GR9zGNo4U9xv0zY2axiPsklQEkP
 p5fU+81WKwSfwDPclVdnttIb2AmLtTHz6N/b1DhIppAkygTlQp6PY0Jw6Ayq+srRN2sbHjH
 e+U0D01nwvp4aEu/8B3Ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yy1MXSGevnA=:pDeOMWPN55Pap7P049Ttfq
 QowO+9+3Es9OwU1FEFyIVrMeCX2Huk93KIY+DDojaWez7mm1uh8Qh3vJvkWAen50J3OkSwWb+
 oZo8jVWnwFcHm36q1NfVaG14MTI503mhLjJfCCty6dx3IKuU3l7PDePd5PVZVE6azcXCa4yHI
 iXOlAa6D2Qe5tKvjwtVqzvcB5Le9/fYZuX2ieHwvjS9PXr7MRUz4Gvwuw45w57XRvDTpXmEHk
 7rR1noqSz9qWQ6W5vzBDRPdJGbq4cl/q4jR3faEaB2uGdf6pXXpPmU+AyltPsl6d/k9eq5PKQ
 9mPQ9e0Fg5kSBvfMrVNZGyBB47PMW1px72/ATbm2TqAyiem6Rbzlf88mIlJ0Yb3yY3W9HbhX0
 /QVaU6bvdRUbbCAZzUyXB7UZ1V3qQlXxNzjN1fFOQ/1/K7xaTmydV0Kv/cRjVtSwDGPrR78pw
 Ysw6/VLVeyZNcFzBL2VI2KytwtYRhHziCXgkuXy2lD7g+QFKma1U7NR9GrnLtWXaiJXNGSQns
 gtnf4zyFzDRnWs/+dSlmgpvLaGfA6M45kQN6PlaP850naFc0fi5D/lqUuPs7tq+uVpp+ZNqRx
 ODlGOvTRogCyDjQrZwR4Xwa70w86XwWB2Kh+YJVY4enUx211WzuuMZ9MylvkjnUPYc3eOUfS+
 OG11JlLxKH3x4Gqmyl/TiLaHifLNV9ov8Xv0pMKTOQQB6aRslSLMXnJhZM1/a2pZjJo56ANsG
 XyM01V6xjL0KcV1Y6XaC49nrZTv42XbQbrgfMpsrH6AYdPB9KnRhcxJtNmFlxN6kUABuoSoZA
 4VwZSCznjSjhBvNWwuvfIpASP5Ra54xLezRbNQ08itx/mcpaHs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 18 Jan 2018, Jacob Keller wrote:

> On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This patch is part of the effort to reimplement `--preserve-merges` with
> > a substantially improved design, a design that has been developed in the
> > Git for Windows project to maintain the dozens of Windows-specific patch
> > series on top of upstream Git.
> >
> > The previous patch implemented the `label`, `bud` and `reset` commands
> > to label commits and to reset to a labeled commits. This patch adds the
> > `merge` command, with the following syntax:
> >
> >         merge <commit> <rev> <oneline>
> >
> > The <commit> parameter in this instance is the *original* merge commit,
> > whose author and message will be used for the to-be-created merge
> > commit.
> >
> > The <rev> parameter refers to the (possibly rewritten) revision to
> > merge. Let's see an example of a todo list:
> >
> >         label onto
> >
> >         # Branch abc
> >         bud
> >         pick deadbeef Hello, world!
> >         label abc
> >
> >         bud
> >         pick cafecafe And now for something completely different
> >         merge baaabaaa abc Merge the branch 'abc' into master
> >
> > To support creating *new* merges, i.e. without copying the commit
> > message from an existing commit, use the special value `-` as <commit>
> > parameter (in which case the text after the <rev> parameter is used as
> > commit message):
> >
> >         merge - abc This will be the actual commit message of the merge
> >
> > This comes in handy when splitting a branch into two or more branches.
> >
> 
> Would it be possible to open the editor with the supplied text when
> there's no commit?  The text after <rev> must be oneline only..

I actually want to avoid that because my main use case is fire-and-forget,
i.e. I want to edit only the todo list and then (barring any merge
conflicts) I do not want to edit anything anymore.

But I guess we could special-case the thing where `-` is specified as
"merge commit message provider" and an empty oneline is provided?

> It's difficult to reword merges because of the nature of rebase
> interactive, you can't just re-run the rebase command and use
> "reword".
> 
> I suppose you could cheat by putting in an "edit" command that let you
> create an empty commit with a message...

Or you could "cheat" by adding `exec git commit --amend`...

Seriously again, I have no good idea how to provide an equivalent to the
`reword` verb that would work on merge commits...

Anyone?

Ciao,
Dscho
