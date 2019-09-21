Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD71F1F463
	for <e@80x24.org>; Sat, 21 Sep 2019 01:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfIUBrJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 21:47:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37433 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfIUBrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 21:47:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so5737759pfo.4
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hx4EpBhLUgEgtiwg7y6Mn+7y6PqvJSwt48sQ8pVliSk=;
        b=HKzf88IqviPv4AukNeAvG+skmj0EANgr6hyq20hGvioX6Ga1gT3x1ESdsmY1HVXjL1
         pxY+BwMFTtsbEa/BDR8DNYK/csAKQ6U6/W3uQllssWfDk+1itM8AgV81zPiJ4I5CyciB
         7mqFpkGqve35JlvW5oWFHjjoN02MsW/p60i7/V85YTYhPkFgrjTR4Xzlv36ANaTHA991
         Z2Kp8d8qRX2DcTxS6yk9PY37rO9SqJmmGR0cDAH2HOoG7GnLqblTvoIJDmsz780Tnfim
         V5nJDCQW/mby1lkr3r5hxjSzL7AGE800F6Ck6WIHShHP1jLWTep7MccC/cJ4Vq6teS5D
         f0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hx4EpBhLUgEgtiwg7y6Mn+7y6PqvJSwt48sQ8pVliSk=;
        b=Dabqr8xrKU0S+GeX5IF4wsQa7wCDYSjjmePlKexqO6LkzcKnaMK/cDtcnpdFUxQ3Zd
         D8YbfbbqTeos7MKvwTQ01QTw8na3aFq/IMXY2fbat5anRd/k9zP0iG6uF4oxdz0oeZFg
         CkCx7dqqX92gAEzjXzqbSibjcp/ZPwrK/P5KdXa3rZtZUUk64eUilB1nsxd27eCt7F3b
         2RIJN84pds/OPjTBbiSj9VrnQu3lc1vRHtwvmE1JcsldbTW+b2Q4mFUwHTR6k/E+72wx
         9VREW4BC9RH9J4UlFjelUcTi6cWUBtIJbmJ8gKpBtmsznZq762wH5mGvksedUtWUxC2z
         10hg==
X-Gm-Message-State: APjAAAVGd1g2RjWnHkX3yVOJtWcZDP7d6Z79hJhppyaL46PEZcmUqtzO
        m6SbjSIY8P3IphHJBF/EQjmuJg==
X-Google-Smtp-Source: APXvYqyyilz3qU7FuE4X0Rbh/OUTAhe54DnA6lyRvuwExVaxpYGZaplfd/bsCoRuaZCZtsHLqXaXuw==
X-Received: by 2002:aa7:85d0:: with SMTP id z16mr21106587pfn.206.1569030427841;
        Fri, 20 Sep 2019 18:47:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id n15sm3092996pgl.80.2019.09.20.18.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 18:47:06 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:47:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190921014701.GA191795@google.com>
References: <20190913205148.GA8799@sigill.intra.peff.net>
 <20190920170448.226942-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920170448.226942-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 10:04:48AM -0700, Jonathan Tan wrote:
> > Prospective mentors need to sign up on that site, and should propose a
> > project they'd be willing to mentor.
> 
> [snip]
> 
> > I'm happy to discuss possible projects if anybody has an idea but isn't
> > sure how to develop it into a proposal.
> 
> I'm new to Outreachy and programs like this, so does anyone have an
> opinion on my draft proposal below? It does not have any immediate
> user-facing benefit, but it does have a definite end point.

I'd appreciate similar opinion if anybody has it - and I'd also really
feel more comfortable with a co-mentor.

"""
"Did You Mean..?"

There are some situations where it's fairly clear what a user meant to
do, even though they did not do that thing correctly. For example, if a
user runs `git commit` with tracked, modified, unstaged files in their
worktree, but no staged files at all, it's fairly likely that they
simply forgot to add the files they wanted. In this case, the error
message is slightly obtuse:

$ git commit
On branch master
Changes not staged for commit:
	modified:   foo.txt

no changes added to commit


Since we have an idea of what the user _meant_ to do, we can offer
something more like:

$ git commit
On branch master
Changes not staged for commit:
	modified:   foo.txt

Stage listed changes and continue? [Y/n]

While the above case is a good starting place, other similar cases can
be added afterwards if time permits. These helper prompts should be
enabled/disabled via a config option so that people who are used to
their current workflow won't be impacted.
"""

Thanks in advance for feedback.

 - Emily
