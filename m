Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66F41F45F
	for <e@80x24.org>; Tue,  7 May 2019 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfEGTFH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 15:05:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfEGTFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 15:05:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so8776609pgl.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E310Hu9exGdGNqQf9l6r46rm74DAS/rHBg2atApzGPw=;
        b=pjkyYbwdYbXinC6yUZoIxUiuBmvPYkbVXcgYhqLMQa6V4uhDhhpa5xxfodifwAzURN
         4yV3hhiQgxFwAR9Ksh7TqwB4aamUQH93rm/bYZr+QtzKJ4Y9Yi7DQJMMuMWxNFb7dHmx
         JhkPkDZRThZqDQJLMDBqOluffZJr5IaS7kSG5OP1oiQ1N709tZq4y2besG3nz8iMk9Hi
         XgrvG7zW5hjgHkiLJo1h3Poia7Hid8nrEZZMZaUXczAgSZDx5/lHPygeH6/zzfRsgE7j
         +I+ViluRIihZYWLO49NBVVvNod81K4EqGPFMH+BmZq1m6kehI/CGIrbLIdjCJQOunykb
         0fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E310Hu9exGdGNqQf9l6r46rm74DAS/rHBg2atApzGPw=;
        b=rZ4dt0L8aGf9lmx3IkS4Nn/7BjsisLo7KI3cofU/sliRIGPQ4zV2crjgY+Ej1Qz1Aq
         N13vGdcg5QmGcD3SApKlXOt+zkAT6oPgcoGGuWZHM8LH5BjbqbS7awZc/X5ivdV6GYAj
         3nt2B2ykXeDHOhbEjw/91PufJ+Ih04Ks/woBfv7Z6HyW9J6aR8Sbqz/B5MO8pBUCCsQk
         FX/ef3fEz5i+teQwUuN95KAggK1FuT7Tm+Jo1BCVAplAz+YpiG+Daz5h2rgwbzVmHDHY
         Qub4M9Y1WbOZVQLpdymyiBlXfcZ/NIVvwSNani5b0M8iFiWP8ATO6kq+z4cO/TFm9zND
         Km0Q==
X-Gm-Message-State: APjAAAWNf8JlRvcMYKS3pFvs6wvWUqQYLUdkWkij/uKUOGz3FtazpPHd
        6bLVCm/j+rCOW4lH8SegrZozzw==
X-Google-Smtp-Source: APXvYqz5M/lz3QWM0AaAt3wATmsvVqK+a4ASl5N9u01cc/SpebrponciE1tvwpycuyCqxxWsfa5DUA==
X-Received: by 2002:a63:4562:: with SMTP id u34mr1369297pgk.354.1557255905820;
        Tue, 07 May 2019 12:05:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id w190sm22816756pfb.101.2019.05.07.12.05.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 12:05:04 -0700 (PDT)
Date:   Tue, 7 May 2019 12:05:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
Message-ID: <20190507190500.GC220818@google.com>
References: <20190419165709.123502-1-emilyshaffer@google.com>
 <20190423193410.101803-1-emilyshaffer@google.com>
 <CABURp0rE23SCxB4VD0-kVWp6OfS7-4O6biyD7zMqSUQvR_RZxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABURp0rE23SCxB4VD0-kVWp6OfS7-4O6biyD7zMqSUQvR_RZxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 07:11:04PM -0700, Phil Hord wrote:
> On Tue, Apr 23, 2019 at 12:35 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > This tutorial covers how to add a new command to Git and, in the
> > process, everything from cloning git/git to getting reviewed on the
> > mailing list. It's meant for new contributors to go through
> > interactively, learning the techniques generally used by the git/git
> > development community.
> >
> 
> Thanks for working on this.  It's very nicely done.

:)

> > +Check it out! You've got a command! Nice work! Let's commit this.
> > +
> > +----
> > +$ git add Makefile builtin.h builtin/psuh.c git.c
> > +$ git commit -s
> > +----
> > +
> > +You will be presented with your editor in order to write a commit message. Start
> > +the commit with a 50-column or less subject line, including the name of the
> > +component you're working on. Remember to be explicit and provide the "Why" of
> 
> This part sounds a little ambiguous to me, as I'm expected to include
> the "Why" in my 50-column subject line.  I don't want to go overboard,
> but maybe direct them further to
> 
>     After this, insert a blank line (always required) and then some
> text describing
>     your change.  Remember to be explicit and ...
> 

Done. I agree it's ambiguous about how much is supposed to go into the
subject versus the body, so I've hopefully clarified by explaining that
the body "should provide the bulk of the context".

> > +----
> > +$ make all doc
> > +$ man Documentation/git-psuh.1
> > +----
> > +
> > +or
> > +
> > +----
> > +$ make -C Documentation/git-psuh.1
> 
> There's an unwanted slash here. This should be `make -C Documentation
> git-psuh.1`.

Done, thanks. Nice catch.

> > +=== Overview of Testing Structure
> > +
> > +The tests in Git live in `t/` and are named with a 4-decimal digit, according to
> 
> This doesn't parse.  How about this?
> 
>     named with a 4-decimal digit number using the schema shown in ...
> 

I think we've both managed to miss that I've swapped "decimal" and
"digit" by accident. :) How about "named with a 4-digit decimal number
using the schema"?

Very pleased that you caught this, since all the once-overs in the world
from the cooked-brain author and the cooked-brain second- or tenth-pass
reviewers wouldn't have caught this mistake. Thanks!

> > +== Sending Patches via GitGitGadget
> > +
> > +One option for sending patches is to follow a typical pull request workflow and
> > +send your patches out via GitGitGadget. GitGitGadget is a tool created by
> > +Johannes Schindelin to make life as a Git contributor easier for those used to
> > +the GitHub PR workflow. It allows contributors to open pull requests against its
> > +mirror of the Git project, and does some magic to turn the PR into a set of
> > +emails and sent them out for you. It also runs the Git continuous integration
> 
> nit: "send" them out for you.

Done, thanks.

> 
> > +suite for you. It's documented at http://gitgitgadget.github.io.
> > +
> > +=== Forking git/git on GitHub
> > +
> > +Before you can send your patch off to be reviewed using GitGitGadget, you will
> > +need to fork the Git project and upload your changes. First thing - make sure
> > +you have a GitHub account.
> > +
> > +Head to the https://github.com/git/git[GitHub mirror] and look for the Fork
> > +button. Place your fork wherever you deem appropriate and create it.
> > +
> > +=== Uploading To Your Own Fork
> 
> I noticed some of your titles Use Capital Initials and others do not.
> I suppose either is fine, but consistency is appreciated.
>

Nice catch. I've gone through and fixed up the titles throughout; as a
result I also caught a missed monospace.

> > +=== Sending Your Patches
> > +
> > +Now that your CI is passing and someone has granted you permission to use
> > +GitGitGadget with the `/allow` command,  sending out for review is as simple as
> 
> nit: extra space before "sending"
> 
Done.

> > +Next, go look at your pull request against GitGitGadget; you should see the CI
> > +has been  kicked off again. Now while the CI is running is a good time for you
> 
> nit: extra spaces before "kicked"
> 
Done.

> > +Make sure you retain the ``[PATCH 0/X]'' part; that's what indicates to the Git
> > +community that this email is the beginning of a review, and many reviewers
> > +filter their email for this type of flag.
> > +
> > +You'll need to add some extra
> 
> Early line break on this line.
> 

Done.

> > +Now send the emails again, paying close attention to which messages you pass in
> > +to the command:
> > +
> > +----
> > +$ git send-email --to=target@example.com
> > +                --in-reply-to=<foo.12345.author@example.com>
> 
> You probably need quotes around this message-id argument to avoid the
> shell interpreting it as redirection.
> 

Indeed. And it looks like I also missed, here and above, specifying the
actual patch files to mail. Whoops... :)

> > +----
> > +
> > +=== Bonus Chapter: One-Patch Changes
> > +
> > +In some cases, your very small change may consist of only one patch. When that
> > +happens, you only need to send one email. Your commit message should already be
> > +meaningful and explain the at a high level the purpose (what is happening and
> 
> typo: "explain at a high level"
> 

Done.

> > +If the topic has already been merged to `next`, rather than modifying your
> > +patches with `git rebase -i`, you should make further changes incrementally -
> > +that is, with another commit, based on top of of the maintainer's topic branch
> 
> typo: "of of"
> 

Done.

> > +as detailed in https://github.com/gitster/git. Your work is still in the same
> > +topic but is now incremental, rather than a wholesale rewrite of the topic
> > +branch.
> > +
> > +The topic branches in the maintainer's GitHub are mirrored in GitGitGadget, so
> > +if you're sending your reviews out that way, you should be sure to open your PR
> > +against the appropriate GitGitGadget/Git branch.
> > +
> > +If you're using `git
> > +send-email`, you can use it the same way as before, but you should generate your
> 
> Early line break on this line inside the `git send-email` command.
> 

Done.

Thanks very much for the thorough review, Phil! I appreciate it!
