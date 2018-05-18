Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D53D1F51C
	for <e@80x24.org>; Fri, 18 May 2018 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeERU0H (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 16:26:07 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:53398 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeERU0G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 16:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a2VGSFySQ+YwDs5Gk7ey9V0UoLEAHZUUgdULyVWPqME=; b=QPd+gLG5wu5Pgt1Jl5TbVP+xv
        kTWVTIk6YSGPjB8nK7ajor+An153qOmbzjYpfxMFaVpE/GmRI+KyANulV5bwuvwmGfrFjah1sHlGX
        drXE/k/46of34qUMqudBYMd/WlD22TilMnYlgXbIH9HGc6gLWTE8kwp18RRGIqGeDiGvCEgDnCR/3
        VeokRy2hIzQcGbbrXNfXZghjO56+FACcAiw1QIEFgyZTbGaFoGPUZnBXUSPgAldPpdlosOnD6gK5b
        WwDpdEecu5ibhIcDrK7iaCs64Lg9eD/dtJytiweBQGc+p4C7EnzueCLWMgxWKjTVlG3gqTt7vJ0gS
        h3yAinwNA==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:39776 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fJlwx-00GwES-GT; Fri, 18 May 2018 16:26:04 -0400
Date:   Fri, 18 May 2018 16:24:35 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Sybille Peters <sypets@gmx.de>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
In-Reply-To: <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de>
Message-ID: <alpine.LFD.2.21.1805181544240.18185@localhost.localdomain>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain> <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com> <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain> <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
 <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 May 2018, Sybille Peters wrote:

> My 2c on this:
>
> 1) "If the --keep-index option is used, all changes already added to
>    the index are left intact" (manpage git stash)
>
> That appears to be correct and clear
>
>
> 2) "$ git stash push --keep-index # save *all other* changes to the
>    stash"  (manpage git stash)
>
> That is either not correct or misleading. "All other" implies in my
> opinion all changes except the ones that were already added. *"All
> changes including already staged changes"* might be a better choice.
>
> Please also see open question on StackOverflow:
>
> https://stackoverflow.com/questions/50242489/how-to-ignore-added-hunks-in-git-stash-p/

  hilariously, that SO piece refers to an issue posted to github here:

https://github.com/progit/progit2/issues/822

which was, in fact, posted by me. :-) in any event, let me summarize a
couple things here.

  when i first read up on git stash, it was just that section in the
man page that threw me, and once i figured out how it worked, i
thought of how *i* would have explained it, and it would have gone
like this (assuming i do, in fact, now understand it correctly, which
is by no means guaranteed).

  first, when you do "git stash push", what *always* happens is that
what is stashed is, in two parts, changes in the working directory,
and what is staged in the index. clearly, the staged changes are a
subset of the overall working directory changes, but what's important
is that the stash contains *all* of those changes and, more
importantly, distinguishes between the two categories. that's the
crucial part -- what is stashed (regardless of "--keep-index" or not)
is:

  1) staged changes
  2) unstaged changes

can we agree on that? the only difference made by "--keep-index" is
that the staged changes, in addition to being stashed, are left in the
index. but that makes no difference to what is stashed, do i have that
right?

  now, when popping (or applying), what is popped are all of the
changes in the stash, back into the working directory. period. that
always happens, correct? the only difference introduced by "--index"
is that the pop/apply *also* tries to restage what was staged before.

  is all of the above correct? if it had been explained that way, i
wouldn't have spent several confused hours trying to figure out why i
wasn't getting the results i was expecting.

rday

