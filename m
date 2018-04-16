Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B091F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeDPQT6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:19:58 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:53466 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeDPQT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EwYia6Cfws0sUNBn+pMDSJkrybU0lGWkETzdkUiQH6I=; b=sFJocxhNyXMNZDjCRntuGel3N
        oS/YxUtIf7adtcmFQs4mMg4LWkXXThEl/mPfP7IKdz39HBX/YeEi6U5yDxjgGI7TEUX01n1uBLzXO
        UhhVZAD7FrX9A3gF7DirGCafFri3qySIjq08AenbWeN7Bxh7aSrWCVSFG6YR21IzUi9rj0z1BKEfQ
        zZPP92VdzLFLYHy8Tt/swpdyGd+2rb/cKQToQcQvoQL7ZP6ZtsauK3kEH2BXwPLDWcep203G/2CVo
        Q0D51W9YSzB3glFqqcGkyO/p60rclHldklUuJatkSxYBSCmfk2ALyvBs0T5/5pzAah9UIDOVLBuFq
        uDVr0D29w==;
Received: from [128.107.241.178] (port=23771 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1f86rC-0007zl-2Y; Mon, 16 Apr 2018 12:19:55 -0400
Date:   Mon, 16 Apr 2018 09:19:50 -0700 (PDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git remote set-url" seems
 confusing/contradictory
In-Reply-To: <87y3hn5drx.fsf@linux-m68k.org>
Message-ID: <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain> <87y3hn5drx.fsf@linux-m68k.org>
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

On Mon, 16 Apr 2018, Andreas Schwab wrote:

> On Apr 16 2018, "Robert P. J. Day" <rpjday@crashcourse.ca> wrote:
>
> > i don't understand how you can clearly set the fetch and push URLs
> > of a remote independently, while the man page nonetheless insists
> > that "even though they can be set differently, must still refer to
> > the same place". how can they be set differently yet still must
> > refer to the same place?
>
> They could be using different transport methods.  For example, for
> fetching the unauthenticated git: method could be used, but for
> pushing an authenticated method like ssh: is usually needed.

  ok, point taken, but does that mean the two must actually refer to
the same "place"? it seems that i'm perfectly free to use this command
to set the push and fetch URLs to totally different locations.

rday
