Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE7D200B9
	for <e@80x24.org>; Sun,  6 May 2018 12:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeEFMFK (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 08:05:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:33281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbeEFMFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 08:05:09 -0400
Received: from MININT-6BKU6QN ([81.92.17.130]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwqwS-1eHfTM3fh2-016PLi; Sun, 06
 May 2018 14:04:49 +0200
Date:   Sun, 6 May 2018 14:04:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <20180506003842.GT26695@zaya.teonanacatl.net>
Message-ID: <nycvar.QRO.7.76.6.1805061401260.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <20180506002532.GS26695@zaya.teonanacatl.net> <20180506003842.GT26695@zaya.teonanacatl.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NZGRR5tHNzz8YtQVJHwak+bnV5QONLdCNtxctlCZKxs0vw1ZAto
 CJ1kBk0l1uDqRjep5LGVXWMZIeDqxSDLKmHgAYX1p0j/0kqK8ihyQLkPZMHRmB+L4rZvg9p
 wU4UwEhWp82lSgSCY2m9eTKyTrnPxUPOvr6gLvkO8/ItzLo81+j8QqpLup7VoXcFAgWtPZy
 84a/34UYGHMv1zuY8p/+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WEGjB2MWGG4=:FFniRyDKHpFImtZz8DKkd3
 ZvnhCi4QF4NdJMBjzu/jEhdJeM6R0C1dV4Q6tpdDROjCveghEaKiMhkttFk7XBjeYGAxsxnu+
 1V+lXq/8CCGZ7wn3LYEFmfqo/f9qf5fzbDhTs73xjQvFdCu/0e6ejwVn3Jrwzs8jsKya2uqOm
 80uSk3r0T1P+WPtKcxT6Yl1CcoGopRhUImYj92WPXAh5DVqXH+HRtpgoOr1SI2AV26GRa2XE2
 lk4a75pJHArUDOv/GSo1MF2GF30LnG1nK//DveiF3Eo2ofqC45a2U0OQft8n9BcyCO5x7GbEg
 CGQ9OtXTKe8peeVkFZ/7oh6aLDqbwfxAlQDbvPGG8R2iI23LD2lP6b3cynAgM7/uiXWKbOUih
 E4ZxrxTfM1JB77p4mhvvtR+S4nfr1S7OThEqVwajWo8baLr3WK1DkLl5P6VDfNepkQtJSbh0w
 F+1OVMzQzwqadISkpvteJi3suo/eO6mzB6NIis/rMBjVpVtKqbP7YoU/Mu9hynbweLiX1iBqx
 /Y1eNzvrx5okJFSROVCbr44V4Qk3TkSyA4Vvip0EszbStwW1YJQDlev4KBfDflqdWBqyxUQM3
 0AeKDzyDPGwERzqSABSgab1O92TPue+7RnlQJ/j05elRXY7esY4sZCATtwC2jU7z0Lfx+7AjF
 BPK23JQ+UAMso7TsuMyOxTnoPfBdD6c+ubP3lWa0ahtHPqKPlDB7QKJPdXy3PaX2lrmrFswDb
 4Ovj1/ncgvL/nKLYNi2Fs4KsKHiMnUtvwwvQa6r/lrrNTzl+1cfRYLzvq+cdrrlzOnb3sILyD
 Z0b6HWn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Sat, 5 May 2018, Todd Zullinger wrote:

> I wrote:
> > Would it be possible and reasonable to teach 'git branch' to
> > call this as a subcommand, i.e. as 'git branch diff'?  Then
> > the completion wouldn't offer git branch-diff.
> 
> Of course right after I sent this, it occurred to me that
> 'git branch diff' would make mask the ability to create a
> branch named diff.  Using 'git branch --diff ...' wouldn't
> suffer that problem.

Yep, I immediately thought of --diff instead of diff when I read your
previous mail on that matter. And I like this idea!

Of course, it will complicate the code to set up the pager a bit (for
`branch-diff`, I could default to "on" all the time). But IIRC we recently
changed the --list cmdmode to set the pager to "auto", so I'll just copy
that.

> It does add a bit more overhead to the 'git branch' command,
> in terms of documentation and usage.  I'm not sure it's too
> much though.  The git-branch summary wouldn't change much:
> 
> -git-branch - List, create, or delete branches
> +git-branch - List, create, delete, or diff branches

Indeed.

Unless I hear objections, I will work on moving to `git branch --diff` (it
might take a while, though, I will be traveling for work this week).

Ciao,
Johannes
