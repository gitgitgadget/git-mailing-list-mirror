Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB7F1F4B7
	for <e@80x24.org>; Fri, 23 Aug 2019 03:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404022AbfHWDBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 23:01:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43572 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfHWDBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 23:01:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9DC561F461;
        Fri, 23 Aug 2019 03:00:59 +0000 (UTC)
Date:   Fri, 23 Aug 2019 03:00:59 +0000
From:   Eric Wong <e@80x24.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
Message-ID: <20190823030059.47ftwfne6y436e5j@dcvr>
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
 <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> wrote:
>   * Remove git-filter-branch from git.git.  Mention in the release
> notes where people can go to get it.[1]
> 
> filter-branch is not merely a slow or difficult-to-use tool, it's one
> that *fosters* mistakes by making it hard to get things right in
> several different ways.  Granted, people exercise extra caution using
> filter-branch because they know they need to, but there are so many
> gotchas that they're likely to accidentally mess something up.  Those
> mess-ups are not always discovered immediately, and by then it's
> nearly cast into stone (rewriting being something you want to do very
> rarely).

Is it possible to turn git-filter-branch into a fast, compatible,
and (maybe) safe wrapper for git-filter-repo?  That would "fix"
filter-branch and (if done carefully) not break existing uses.

It could also spew warnings to recommend safer switches.

Stability is a major reason I use git, the Linux kernel,
and why I distrust+avoid desktop/GUI software.  Removing
"unsafe" features, even with good intentions, inevitably leads
to frustrated users.
