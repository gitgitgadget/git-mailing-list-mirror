Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78A61F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYNwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 09:52:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:53772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726633AbeJYNwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 09:52:33 -0400
Received: (qmail 22291 invoked by uid 109); 25 Oct 2018 05:21:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 05:21:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13547 invoked by uid 111); 25 Oct 2018 05:20:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 01:20:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 01:21:27 -0400
Date:   Thu, 25 Oct 2018 01:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, git@sfconservancy.org
Subject: Re: Git trademark status and policy
Message-ID: <20181025052127.GA11460@sigill.intra.peff.net>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
 <20180916101520.GC18517@gmail.com>
 <20180917032101.GD22024@sigill.intra.peff.net>
 <CAP8UFD2cC7VMu7Zp9NaXj4x0BMBPZ5CJ6prwEv+s24SuNG=7JA@mail.gmail.com>
 <20180918182222.GA24448@sigill.intra.peff.net>
 <20181024075533.GA11043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181024075533.GA11043@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 12:55:33AM -0700, David Aguilar wrote:

> > So I think we should generally recommend against such generic names
> > during the naming phase. At this point, I'm not sure the pain of
> > changing now is any less than the pain of changing later if and when
> > there's a conflict.
> [...]
> 
> Thanks for the recommendation.  I'm open to changing the name in a
> future major release.  For users that already use the short "dag" name,
> we can transition over to something else if it's relatively short and
> sweet.

Going from my paragraph above, I think it is probably OK to just leave
it for now (unless you prefer to use a major version boundary to do the
change rather than later possibly having to deal with it on a shorter
timeframe).

I have no real opinion on a replacement name. :)

> There's also one more script, but it's never installed in the users's
> $PATH and is more of an internal implementation detail.  Git Cola
> includes a GIT_SEQUENCE_EDITOR-compatible "git-xbase" command that
> provides a visual interactive rebase feature.  That command should
> probably be renamed to "cola-git-seq-editor" to make that clearer, and
> also to open up the possibility of installing it in bin/ in the future
> since it is useful on its own.

Yeah, agreed. If it's not in the PATH, then it doesn't need to be git-*
at all, does it?

> The rationale for two commands is that worktree diff+commit and history
> inspection are our two primary use-cases.  Everything else is provided
> as a sub-command, "git cola rebase", "git cola stash", etc. so there's
> not much pressure to add more top-level names, just these two.

Makes sense.

> Thoughts?

Everything you said seems pretty reasonable to me. Thanks for being
conscientious about the naming issues.

-Peff
