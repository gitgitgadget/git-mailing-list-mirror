Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB5B1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeAQNmU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 08:42:20 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:44040 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeAQNmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 08:42:18 -0500
Received: from [209.37.255.2] (port=18332 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ebnyq-00056R-VT; Wed, 17 Jan 2018 08:42:17 -0500
Date:   Wed, 17 Jan 2018 05:42:14 -0800 (PST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: misleading "man git-worktree", is last "add" argument necessarily
 a "branch"?
In-Reply-To: <CACsJy8A0BcdqwkDDd0Fx_8DDCgJc6gZaXkcYqysdv8BH1nvibQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1801170541570.17204@localhost.localdomain>
References: <alpine.LFD.2.21.1801170455380.16166@localhost.localdomain> <CACsJy8A0BcdqwkDDd0Fx_8DDCgJc6gZaXkcYqysdv8BH1nvibQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 17 Jan 2018, Duy Nguyen wrote:

> On Wed, Jan 17, 2018 at 7:58 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   perusing "git worktree", and man page reads:
> >
> >   SYNOPSIS
> >        git worktree add [-f] [--detach] [--checkout] [--lock]   \
> >                         [-b <new-branch>] <path> [<branch>]
> >                                                  ^^^^^^^^^^
> >
> > however, can't that last optional argument be any arbitrary commit,
> > not just a "branch"?
>
> It's been changed to commit-ish about two months ago in c4738aedc0
> (worktree: add can be created from any commit-ish - 2017-11-26)

  guess i better update my repo, thanks.

rday
