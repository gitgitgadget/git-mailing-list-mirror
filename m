Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57A81F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJXQWh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:22:37 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:40409 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJXQWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:22:36 -0400
Received: by mail-pg1-f175.google.com with SMTP id o14-v6so1942866pgv.7
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UIvddT36kRdJcz/vFPY8pjGGoGALJln3OIwGyzYQPRo=;
        b=OpN2QNcHYBahT5/hCJ+OgDxbDriR8JbFAWUqSLf3qaTf8eaITXH2dAW2jh88nvVL8k
         2yAjbs0fOr0OP4NKlLJ9jYqtOjxBiv7dnos2PLXvfx0GN7pcY4JUDADl5Ai4e0tYVsR7
         w4ueDf5zO7lnBKVT854lnI1ABWs5JJ2dtAjCAxUlE637bWvaQQUgY0PK6LoQLaoedc8W
         lhHcFWTf9LRjgHpDx30re3IPj2SmgyeIAdYYRNW7J0c5hwb/56rzqa3b9AJgjZVSC+p4
         O0RUJfgRFJi8St8p4P9lValOc32Eus/gASn3ImMXjOjNZnSkqBoIYYDh/6i4b4WX8G9D
         6dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UIvddT36kRdJcz/vFPY8pjGGoGALJln3OIwGyzYQPRo=;
        b=A3E3Ay2Lc/b88CnT2Z9CFAcp6XHMSgP0yGeKejpM/hwAjvPZVyDDImyO31EXywhEKG
         ZUPD/QjACyZm1CQmz+dRfuoaiR1uXwxMagWlPeSDPmSM4UqwGbegr6DEs7ipjZvWIme+
         coWNQ06LnuEWZx+Qi4DPCuJZ6ZWtw4IYcYFbo0CP9a9JgVwl6xUWKIsutecXCxJtJ+jT
         wZ5j6cXbuR10GQrD0KcLtbqPjY019PxsG+Rrjg9QdRAHGvI0InoAC/2QFx2P3qWJqQR9
         zgO1yOuhEQ8wmO5WHGTzUrC0nOhQp9ZGFjLjQ5qKdHaydvHBjI5KIkPmHoBfiZWAyd0L
         RFrw==
X-Gm-Message-State: AGRZ1gIybHeZ0/+uWDL6XbfxJXVL4DgUDQc9XvkIdTtsiMnDcqnrG3X8
        KL6VVTZgLiTP/sQRd8yioUY=
X-Google-Smtp-Source: AJdET5cYTWdY0yJk8uHkZCLGw/4QrobUsrGatqBSUkEmIJFk1hhm/pN1zI0HqoczEM0+tKNDzaDOoA==
X-Received: by 2002:a65:45c9:: with SMTP id m9-v6mr1547004pgr.212.1540367736766;
        Wed, 24 Oct 2018 00:55:36 -0700 (PDT)
Received: from gmail.com ([2605:e000:90ab:1300:acd3:6fc6:a240:6a91])
        by smtp.gmail.com with ESMTPSA id v84-v6sm7878101pfk.12.2018.10.24.00.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 00:55:35 -0700 (PDT)
Date:   Wed, 24 Oct 2018 00:55:33 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, git@sfconservancy.org
Subject: Re: Git trademark status and policy
Message-ID: <20181024075533.GA11043@gmail.com>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
 <20180916101520.GC18517@gmail.com>
 <20180917032101.GD22024@sigill.intra.peff.net>
 <CAP8UFD2cC7VMu7Zp9NaXj4x0BMBPZ5CJ6prwEv+s24SuNG=7JA@mail.gmail.com>
 <20180918182222.GA24448@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180918182222.GA24448@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 02:22:22PM -0400, Jeff King wrote:
> On Mon, Sep 17, 2018 at 11:25:31AM +0200, Christian Couder wrote:
> 
> > > (Also, to be clear, this is all _only_ about "Git Cola". The "git-cola"
> > > command is explicitly OK in the policy because that's how commands
> > > work).
> > 
> > I agree about "git-cola" though I wonder about "git-dag" as this is
> > another command used by the project that is more generic. For example
> > I could imagine that, if we wanted to provide a shortcut for `git log
> > --graph --decorate --oneline`, we might want to use `git dag`.
> > 
> > I guess we can still recommend to change it if possible, though we can
> > also acknowledge that, as our recommendation comes very late (too
> > late?), it is just a "weak" recommendation.
> 
> Yeah, I agree with you, though I think it is a separate issue. "git-dag"
> is explicitly OK in the trademark policy, and they are not using "Git
> Dag" in any recognizable way.
> 
> So I think there is no trademark issue, but "git-dag" is probably just
> not a great idea in general, because the namespace is open and it is
> likely to get stomped by some other project. Or git itself. Or it may
> even be annoying for users who have a "git dag" alias (on-disk commands
> always override aliases).
> 
> So I think we should generally recommend against such generic names
> during the naming phase. At this point, I'm not sure the pain of
> changing now is any less than the pain of changing later if and when
> there's a conflict.
> 
> I think I'm actually violently agreeing with you, but I wanted to make
> it clear. :) (And everything else in your email seemed sensible, too).
> 
> -Peff


Thanks for the recommendation.  I'm open to changing the name in a
future major release.  For users that already use the short "dag" name,
we can transition over to something else if it's relatively short and
sweet.

Maybe a better name would be "git-kcola" (a nod to gitk), or "git-vdag"
for "visual DAG"?  Any sugs?  I'm terrible at naming things, but I do
refrain from using additional "git-*" names beyond these two for the
project.  I kinda like "vdag" since it's easy to type, and nearby the
existing "dag" name.

There's also one more script, but it's never installed in the users's
$PATH and is more of an internal implementation detail.  Git Cola
includes a GIT_SEQUENCE_EDITOR-compatible "git-xbase" command that
provides a visual interactive rebase feature.  That command should
probably be renamed to "cola-git-seq-editor" to make that clearer, and
also to open up the possibility of installing it in bin/ in the future
since it is useful on its own.

The rationale for two commands is that worktree diff+commit and history
inspection are our two primary use-cases.  Everything else is provided
as a sub-command, "git cola rebase", "git cola stash", etc. so there's
not much pressure to add more top-level names, just these two.

Thoughts?
-- 
David
