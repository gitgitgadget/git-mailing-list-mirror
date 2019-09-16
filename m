Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CC41F463
	for <e@80x24.org>; Mon, 16 Sep 2019 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfIPSmP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 14:42:15 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:39374 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfIPSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 14:42:15 -0400
Received: by mail-pg1-f170.google.com with SMTP id u17so490781pgi.6
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u9iBlmMC1RVFIRI7X2jxwNgxo3mwZX4dUo5QqD/tI5A=;
        b=vPUrHs0itdtv5Mk85nQ4vRHSUYZ5RC+EoezUEDzjehVUQW70pMviXRJlcHEPLUwbC1
         2GhK38e5DvQhPi7UVpxh1vjsZhndzrKvIvpw93t/PV+7kVxOMHMfL896MtakKWPB3wuT
         ACQfRfct3TesgZMjf13b5yL8gtV11LBn/QH51mymSUzhrxYiZmVZHA+EUAfg4Hw+1bn+
         ze/iZ2Y06fML83OkF/rau+aZ6DXbq7H548zYJe4UzjsV0Ov3OBerSA5gbC5yr5DWO1OT
         glfpJ075z90VTg+6E0kruUY4yKgvoelN4s9llUnK76F+exGHdODZgsI/vkjPIsIFMvxV
         4SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9iBlmMC1RVFIRI7X2jxwNgxo3mwZX4dUo5QqD/tI5A=;
        b=N6mR6Ig7yzKYypR5T00EiTCPmAFScS+AfZDEZp+RyiZQ7XhQX6Uy5gC94pt/Sbym6B
         xJZFzqf3KorRUiqzdHr2Cfqs/kHYiEHWxeyEoXTuKK9YywS4HAVsQ5X/RZndTUsRwniX
         TWBW/avvytsHqF/u5C3g0M+eXEspCE0eyZlA5RKkV7xg33YJYBWwI4GmFze4+GbSsKm9
         B5dvZ/+JW7edzs3I7iawfvQe/e8hX3roIePDAUBv4qg+qiu77suHlzWlTudTayTDsXcW
         KShUDqcVgChcJfvAOxyZOWaQUwDuSH9Gdl7NtvLFTnlQyFRFy9177EMoWyPweuJaGk8T
         3pjQ==
X-Gm-Message-State: APjAAAVhUwUX8gTAtz59fknHpMlGsZrmmUjs83KmyWFMhks/dfnf7kGU
        L2dO5UXsqjLNnsi3jhz2D7fOkDD5o9w9ig==
X-Google-Smtp-Source: APXvYqw6G/7lt76p10/PyA3H+JfJHi2J+b5iHT4iz+r4k8kUSUhD2ZhJpY8XBRMSUH6UezwQ2VaHMA==
X-Received: by 2002:a17:90a:fa0c:: with SMTP id cm12mr586292pjb.137.1568659333693;
        Mon, 16 Sep 2019 11:42:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 185sm39689507pfd.125.2019.09.16.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:42:12 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:42:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190916184208.GB17913@google.com>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913205148.GA8799@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 04:51:49PM -0400, Jeff King wrote:
> On Fri, Sep 13, 2019 at 01:03:17PM -0700, Jonathan Tan wrote:
> 
> > > Do we have interested mentors for the next round of Outreachy?
> > > 
> > > The deadline for Git to apply to the program is September 5th. The
> > > deadline for mentors to have submitted project descriptions is September
> > > 24th. Intern applications would start on October 1st.
> > > 
> > > If there are mentors who want to participate, I can handle the project
> > > application and can start asking around for funding.
> > 
> > I probably should have replied earlier, but if Git has applied to the
> > program, feel free to include me as a mentor.
> 
> Great!  See my followup here:
> 
>   https://public-inbox.org/git/20190904194114.GA31398@sigill.intra.peff.net/
> 
> Prospective mentors need to sign up on that site, and should propose a
> project they'd be willing to mentor.
> 
> > There was a discussion about mentors/co-mentors possibly working in a
> > part of a codebase that they are not familiar with [1] - firstly, I
> > think that's possible and even likely for most of us. :-) If any
> > question arises, maybe it would be sufficient for the mentors to just
> > help formulate the question (or pose the question themselves) to the
> > mailing list. If "[Outreachy]" appears in the subject, I'll make it a
> > higher priority for myself to answer those.
> 
> I do think it's OK for mentors to not be intimately familiar with the
> part of the code that is being touched, as long as the project is simple
> enough that they can pick up the technical details easily as-needed. A
> lot of what mentors will help mentees with is the overall process (both
> Git-specific parts, but also more general development issues). But I
> think the proposed projects do need to be feasible.
> 
> I'm happy to discuss possible projects if anybody has an idea but isn't
> sure how to develop it into a proposal.

Hi Peff,

Jonathan Tan, Jonathan Nieder, Josh Steadmon and I met on Friday to talk
about projects and we came up with a trimmed list; not sure what more
needs to be done to make them into fully-fledged proposals.

For starter microprojects, we came up with:

 - cleanup a test script (although we need to identify particularly
   which ones and what counts as "clean")
 - moving doc from documentation/technical/api-* to comments in the
   appropriate header instead
 - teach a command which currently handles its own argv how to use
   parse-options instead
 - add a user.timezone option which Git can use if present rather than
   checking system local time

For the longer projects, we came up with a few more:

 - find places where we can pass in the_repository as arg instead of
   using global the_repository
 - convert sh/pl commands to C, including:
   - git-submodules.sh
   - git-bisect.sh
   - rebase --preserve-merges
   - add -i
   (We were afraid this might be too boring, though.)
 - reduce/eliminate use of fetch_if_missing global
 - create a better difftool/mergetool for format of choice (this one
   ends up existing outside of the Git codebase, but still may be pretty
   adjacent and big impact)
 - training wheels/intro/tutorial mode? (We thought it may be useful to
   make available a very basic "I just want to make a single PR and not
   learn graph theory" mode, toggled by config switch)
 - "did you mean?" for common use cases, e.g. commit with a dirty
   working tree and no staged files - either offer a hint or offer a
   prompt to continue ("Stage changed files and commit? [Y/n]")
 - new `git partial-clone` command to interactively set a filter,
   configure other partial clone settings
 - add progress bars in various situations
 - add a TUI to deal more easily with the mailing list. Jonathan Tan has
   a strong idea of what this TUI would do... This one would also end up
   external but adjacent to the Git codebase.
 - try and make progress towards running many tests from a single test
   file in parallel - maybe this is too big, I'm not sure if we know how
   many of our tests are order-dependent within a file for now...

It might make sense to only focus on scoping the ones we feel most
interested in. We came up with a pretty big list because we had some
other programs in mind, so I suppose it's not necessary to develop all
of them for this program.

 - Emily
