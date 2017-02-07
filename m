Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4D41FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbdBGXMq (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 18:12:46 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35392 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbdBGXMo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 18:12:44 -0500
Received: by mail-oi0-f53.google.com with SMTP id j15so73868858oih.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=7L9qKSbpgJIbK5ucLvY4WduI1Oc3ldXpmXofzQHEKcM=;
        b=N5xRFW90EPiz6eRBU17BqzMzAaGwneTx31q5bHO/onp2iKCcLST34g9XxKNCwyIURU
         IphfLS/x6+tnCEKO1zZiS8lrOvSlz5ZPWUHYRBge3tmryM8oLgDlhFyuqH57k2oX1Bjg
         bdD6EBAO+pZx8Nhbu4Wbn6ZQMLi9i+g1tGiYHFXJ0daWKQq+LI2K2YDoMRxLJ4Ynl0ho
         Vi0/UFvCRaoUzAfBFFzVTxUOkHGhtvjOYFTslXPRySa2T+BVGZSfrR+mpYIADUBYKoaL
         hDNkLGNEzlQfn0Vh92rYE+NFtimWzl6wQF1xL0mK1M8eUgd+N0UF/6W3KZEu87lD1k9h
         r2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=7L9qKSbpgJIbK5ucLvY4WduI1Oc3ldXpmXofzQHEKcM=;
        b=Mua4itcvpiiDvl3V4GO9lrCedJJ3IEVQtrjHvUV7mm7Szi+rplg8k88VjG0UslRt8L
         o+CjqOM8MaMdWkTAOvnjAzQGqoM2PNVjw8Ov+9uI4nqMTT0utYHMcJQrxMqujvFBGtT7
         NVc3zXIvBVkeQwrVsZObnjdX0Z5UAj1cVONp83PrJfGEk4LlJ+rJe5do9iNQITx2O8Ch
         yRcjmhUHmubEpr7kSSOPDdDEhu+5Dq2kdsiEBUCqjDTmArfRS5KUGH7MJQrri4kEX1Zm
         skttXgwd7xKIMGT0j9IQv+X5BW89Kcjw3zyk4cTCVjGxlAz1he2K/f2sK6BCgymtUJSl
         qIbQ==
X-Gm-Message-State: AMke39nu3Hdn617TC7hzl9QyXdlbMMz4Zv36fwK8YZ1AeFpKBN40t9knFtjMZW+F7TzWyHz/eQEadXPhRVsSrg==
X-Received: by 10.202.237.139 with SMTP id l133mr9625058oih.55.1486509153471;
 Tue, 07 Feb 2017 15:12:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Tue, 7 Feb 2017 15:12:33 -0800 (PST)
In-Reply-To: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2017 15:12:33 -0800
X-Google-Sender-Auth: ZKF7OybTDe7fl4BAbrqA6z-EDp8
Message-ID: <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
Subject: Fwd: Possibly nicer pathspec syntax?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Duh, I sent this just to Junio initially due to a brainfart. Here
goes the list also ]

Most of the time when I use pathspecs, I just use the bog-standard
normal ones, and everything works wonderfully.

But then occasionally I want to exclude a directory (usually
"drivers/"), and it all works fine, but the syntax for that is just
really cumbersome.

That's due to two issues:

 - the magic characters seem to have been chosen to be annoying on purpose

 - there's an extra "you can't exclude things without having positive
patterns" check

and both of those are rather nasty.

So to explain where I come from, during releases I do things like this:

    git diff -M --dirstat=2,cumulative v4.10-rc6..v4.10-rc7

and this is literaly why that "dirstat" diff exists - I find this very
useful for a project like the kernel that has a good hierarchical
directory structure. So the whole dirstat option came about from my
statistics gathering (see more explanations in my original commit
7df7c019c ("Add "--dirstat" for some directory statistics").

However, what often happens for the kernel is that a few big
subsystems end up dominating the discussion (usually drivers and
architecture), and then you want to drill down into everything else to
get that part. Long ago, that used to be painful, and I did things
like

    git diff -M --dirstat ... -- $(ls | egrep -v '(drivers)|(arch)')

which works, and gives me the dirstat for stuff that isn't arch or
driver updates.

However, git actually added exclude patterns, and I don't need to do
that crazy thing with shell expansion any more. Now I can do this
crazy thing with git natively instead:

    git diff -M --dirstat .. -- ':!drivers' ':!arch' .

but honestly, the git native interface really isn't much simpler than
what I used to do.

Is there really any reason for requiring the '.'?

[ Clarification from original message, since Junio asked: I didn't
actually want the semantics of '.' at all, since in a subdirectory it
limits to the current subdirectory. So I'd suggest that in the absense
of any positive pattern, there is simply no filtering at all, so
whenever I say '.' as a pattern, I really meant ":(top)." which is
even more of a cumbersom syntax that the current model really
encourages. Crazy. Since I tend to always work in the top directory,
the two are the same for me ]

And did we really have to pick such annoying characters that we need
the shell escaping?

(I never use the other ones with long forms, but they have the same
issue: parenthesis need escaping too, so you have to write them as

    ':(exclude,icase)drivers'

and you have to remember that a final colon is *not* allowed, and they
still need the escaping).

It really isn't all that wonderful to use from the command line.

In revisions, we use "^" for negation, partly exactly because '!' is
such a nasty character for shell users. With exclusion being the only
case I particularly use, I'd like that for pathspecs too, but maybe
others use icase etc?

IOW, what I'd like to do is just

    git diff -M --dirstat .. ^drivers ^arch

without needing the ugly quoting, and without needing the pointless
positive 'match everything else' marker.

Or even just allowing ^ in addition to ! for negation, and otherwise
keeping the current syntax.

[ Clarification from original message, since Junio asked: yes, this
suggestion still assumes the "don't need to specify the positive
pattern", so you could just do

    git diff :^drivers

  to avoid the drivers directory ]

Comments? Other ideas?

This is certainly not a high priority, but I hit it once again when
doing the 4.10-rc7 statistics, which is why I bring up the
discussion..

                 Linus
