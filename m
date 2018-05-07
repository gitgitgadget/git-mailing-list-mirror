Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB21200B9
	for <e@80x24.org>; Mon,  7 May 2018 05:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeEGFkR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 01:40:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:58825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeEGFkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 01:40:16 -0400
Received: from [172.20.102.139] ([70.60.96.235]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOfcU-1fIK1q1fd8-0063z1; Mon, 07
 May 2018 07:40:04 +0200
Date:   Mon, 7 May 2018 01:39:46 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <xmqqr2moqlw8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805062355190.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet> <xmqqr2moqlw8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7XZfTOrNRX5axwzbdfkfl8psSeduqP9TcCxl8L5qa63Swmf3o1m
 aJDF5O0GGLjhndvERepTQkoREssvy9TO/9og0yrjtebF1n7fWaF/MM8/XWfaZrFuEZ34oIA
 Mm2Jb8FTSzziD0UKNkDHJRCZypciQWuvdJMOgm6QtMEulnES89xKjKlPcrJyAWjbTMGvsSY
 taBIDLByaQs/6cmSlXypw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qToJafCfMK8=:U0vrK5LGGxt86IGAx72DZ7
 bdJ0L1HXjofbttlRtZKgtfBsEpOS3pLpKNcXOtb9nuadAD/GH96SMX1JOvOGgEYfhjeZIVTei
 Yn3Y4Dz0ZKFLWRyeUy+0g2NZXX5LhCXS5BiRdTdLaj6t89sOeBjJtVJrl1gsU30akosqfJeyx
 ikfxJ9CGP8RQSkRSxE3yn9izqWS1aziNZNPqGZEWe8kXRvqsT8uf7VOphrmYfRAYTIRE+RQSN
 b0MkFcJ1qWzet/UP+ojWm3dQ0o5wQOFyQvaL6UAsJCrarL45h6ZUZd0JbS/J9IwuiAM6/PjK7
 zbLuJ+lL6szty17AZVZuwFVcPUItkrXafhEMjus/4Po0RRL3sCxSf81+dehSDR3j7x5ZqYqqT
 0eF2vvmQRLMdJymX88Gt5wc5lduarF6O4YTmZ8OFyTF/LlplwLtqcw/bBeqfn3jMIDRT0Qrlc
 gC46aC4q2aT6X5lCHLVney5tCHfSSmKbko3sWRXG3yH8pArgyI8zU4Rduu3/qlbOJ0kCvNQpV
 rRrpNHBBq+ziUFCa1XAIBCW02F1QeqlmnBbZYChbcGWUQCKackEZ3OJurS44b74qUxEFTzHHn
 kQRuprfyeBHBO8xqSbzNGSNqR1Ce/tUWEhyFSagZQENc7r1j9IwC8200sjnFwwuYdXKQBsElU
 waVMysFdHlGHMk4mFv4AL4RI6nLqKkNyHfr3JcrAAtmb+on6wM9wBik+6I0OZFrpxWIRoZc7O
 ni0gu4iUJlRz+G7L1ACz//07cnHFl6V0BPW4BL/pQk3msnlqhU06I1gChj+NJcEQgigEVpdtX
 BQsaAtT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> If tbdiff were "Thomas's branch diff", I would call this jbdiff ;-)
> >> but I think the 't' in there stands for "topic", not "Thomas's".
> >> 
> >> How about "git topic-diff"?
> >
> > Or `git topic-branch-diff`?
> 
> Yeah something along that line, which is about comparing each step
> in two iterations of a single topic.  It would be wonderful if it
> also supported a short-hand
> 
> 	$ git tbdiff --reflog 1.day.ago js/branch-diff
> 
> that turned into:
> 
> 	$ git tbdiff js/branch-diff..js/branch-diff@{1.day.ago} \
> 			js/branch-diff@{1.day.ago}..js/branch-diff

Or even easier: `git tbdiff js/branch-diff@{1.day.ago}...js/branch-diff`.

> That compares "what was on the topic a day ago" with "what is new on
> the topic since that time", which is exactly what an individual
> contributor wants when reviewing how the topic was polished, I would
> say.

It would be easy to introduce, but I am wary about its usefulness.
Unless you re-generate the branch from patches (which I guess you do a
lot, but I don't), you are likely to compare incomplete patch series: say,
when you call `git rebase -i` to reword 05/18's commit message, your
command will only compare 05--18 of the patch series.

Worse, if js/branch-diff needs to be uprooted (e.g. because it now depends
on some different patch, or because it already depended on a separate
patch series that was now updated), your `git branch --diff` call will
compare more than just my patches: it will assume that those dependencies
are part of the patch series, because they changed, too.

> [Footnote]
> 
> A variant I often use when accepting a rerolled series is
> 
> 	$ git checkout js/branch-diff
> 	$ git checkout master...
> 	$ git am ./+js-branch-diff-v2
> 	$ git tbdiff ..@{-1} @{-1}..
> 
> so this is not only for individual contributors but also helps
> integrators.

Yes, and I also pointed out (twice) that it will help interested parties
follow what I do with my merging-rebases in Git for Windows.

Ciao,
Dscho
