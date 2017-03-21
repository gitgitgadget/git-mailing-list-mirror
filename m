Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C162095B
	for <e@80x24.org>; Tue, 21 Mar 2017 17:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbdCURMV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:12:21 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57751 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757637AbdCURLC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:11:02 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v2LH7YI19123;
        Tue, 21 Mar 2017 18:07:34 +0100
Date:   Tue, 21 Mar 2017 18:07:34 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick --message?
Message-ID: <20170321170734.GI28331@inner.h.apk.li>
References: <20170321160520.GA15550@inner.h.apk.li> <20170321170005.35ryjh4pr3jvvmx3@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321170005.35ryjh4pr3jvvmx3@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Mar 2017 13:00:05 +0000, Jeff King wrote:
...
> > I have an slightly unusual usecase for cherry-pick:
> > I want to modify the commit message that is used in the process,
> > e.g. do an d/^PROP:/ on it, but unfortunately -m does something
> > else here.
> > 
...
> 
> There's "cherry-pick --edit".

Yes, but. I'm in a toolchain, not a user. I'm a command that let
the user cherry-pick specific things, and I need to edit out the things
that made the original commit eligible to be picked in the first place.

Can't quite rely on the tool's user to do that. :-(

I'm not familiar with the plumbing to know where to look there.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
