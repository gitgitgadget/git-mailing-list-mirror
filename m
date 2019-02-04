Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B811F453
	for <e@80x24.org>; Mon,  4 Feb 2019 19:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfBDTaa (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 14:30:30 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:44026 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfBDTa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 14:30:29 -0500
Received: by mail-vs1-f45.google.com with SMTP id x1so656093vsc.10
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ceujLWG7/F5a4P+rRMV7h5/4zzTEtfJ0r/DYXaN77pE=;
        b=i3m5CL7nocEiNaCpbbFQ3HMffX9S00bjd20Sy3Bn6CKeM8DgBHG1srP4e2WlY9OZXR
         9OmYVpcLlqgNhzNPPkstVsxLpsLkt6jyM1klYYcMTiQNyljwOJWp5+eFBw0MIlXMZUUT
         om52KuxcAhfZwqqOflKsZMNQcmCrnVhMrsBls50UblFT81+XPPhrTfE57PbJl53I6c+T
         v2J3Na1FeLbZnaNUJm14C9coVBglx0nFJMZy1/IGslWJvntJLNXDoH+LbCVI2sNm2ex3
         F2aTsx+O/jQPvWTVPYIqzS/T3jvtJ02MbmIQ50o6l9xGjfEqtJkb9Eg7Vy7H9SNvA6fg
         AxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ceujLWG7/F5a4P+rRMV7h5/4zzTEtfJ0r/DYXaN77pE=;
        b=mbFrP6yJXE0ckV0A6ocluCTkFjRb0VkGQGHC8GVCfnkDtn6ETZx6RKQUHbZ/4onG0C
         IuyBvmrKfpv910iCPf58WgHohNo/f1e0U3o5TAfjj52EIFDl2AbyhZqHOgtCQMyKL0gX
         +hKsG0pPKeRS8gjeTQ9qxT0Wi4lloqLcWlcK32YGPlibzoMRgyhG1RBVUbVmb8cMTd+i
         JZASAnIVgPpmihl6Wti+gzHuHmEt2zDn0NLRYu0BzTpEEtXGhB2w/T12WfoJghDwN+x8
         HhQIRkKTazeBZacSseW3TH1m7y46S7lcbiBgBeWpdMxUePTryP8n1vR50EJPBivrVUGU
         JDVw==
X-Gm-Message-State: AHQUAuauStXYiQngaT5WOE3aEPdrRTw6rDdo1YWjRWuJLrf1appglDdg
        9vULp3LlxS/D7bL8968fycerHKQPNIgsfUGa1CY=
X-Google-Smtp-Source: AHgI3IYPtyyFtK9FsA0LJF76PCpKrxW1pK0TZD5F43wWfuubd0nF2mNAnkahLdcm9SOM1LwaSs7WsCHu+00MmFLGhTg=
X-Received: by 2002:a67:f696:: with SMTP id n22mr466748vso.175.1549308628125;
 Mon, 04 Feb 2019 11:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20190122075027.GA29441@sigill.intra.peff.net> <20190130230702.GA25423@sigill.intra.peff.net>
 <86va22qsj1.fsf@gmail.com>
In-Reply-To: <86va22qsj1.fsf@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Feb 2019 11:30:09 -0800
Message-ID: <CABPp-BGfSRy-NT+f39gSumD9haYZPAnpNPY-VnanioCbdYFoEQ@mail.gmail.com>
Subject: Re: Contributor Summit Topics and Logistics
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On Sat, Feb 2, 2019 at 4:39 AM Jakub Narebski <jnareb@gmail.com> wrote:
> I have noticed a little 'recording' indicator; would recorded session
> (video or audio only) be made available at some point in time?  Did
> anyone take minutes, or take notes (for example of the Summit agenda
> created at the start of the meeting -- when the audio was muted)?  I
> would be very interested in your impressions.

I took some notes.  I'm not sure how useful they'll be given that they
were meant just for my own memory (my company said I either had to
give a talk at the conference or come back and give a talk to my
coworkers about the conference in order for them to pay for it, so I'm
doing the latter).  But, I'll provide them here in case they're useful
to anyone.

Discussion points:
  * Fetch response CDN offloading (Jonathan Tan)
    * allows resumable cloning
    * does load balancing
    * gets the static part of history (e.g. until a week ago) from CDN, and
      last bits from "main" server
    * questions about whether to do multiple bits offloaded (e.g. almost
      full clone, only stuff from last month, etc.); can server keep track of
      manifest and direct client to necessary subset of pack on a CDN?
  * A review of "Big"
    * references, history, wide-checkout, deep-checkout, lots to gc, etc.
    * newer stuff: partial clones, worktrees, commit-graph
    * plan to do a breakout session later
  * NewHash
    * sha1 -> sha256
    * have sha256 repo locally talking to a server using sha1?
    * as of yesterday, binary that can create either sha1 or sha256 repos
    * will be using fixed length listing of shas in packfile; if given sha1
      is fourth in list, then the corresponding sha256 will be fourth
    * next: interoperation; fetch & push coming up next
    * done a fair amount of work so moving to a new hash in the future with
      a different length should be much less work
    * no automatic translation of commit messages, but maintenance of
      dual-mapping of hashes
    * (Comments on sha1dc & its performance)
    * Submodules is the biggest issue right now
  * Poll: prove vs. jumbled output
    * some people didn't set up prove; some attempts to avoid perl on windows
    * nearly everyone using prove; could switch to it as the default
  * Poll: where should Git Merge be next year?
    * will bring up on list, but Canada is at least an option
    * North America is more likely to get Junio to come
    * I tried to push for North America...
  * Using mailmap by default in git log?
    * People change names for lots of reasons (including
transliteration differences)
    * Keep an option to not use mailmap
    * People generally positive on the idea
  <Lunch>
  * fetch response sideband-all
    * sidebands for progress messages and errors
    * sideband currently limited to when sending packfile
    * proposal: expand sideband for whole response, not just packfile.
    * particularly useful given ideas to do CDN
    * also needed for keep-alive messages
    * this will be a negotiated new capability (can't do it backward-compatibly)
  * protocol v2 for push
    * ref advertisement the main issue
    * would like to be able to modify the commit message (?!?)
      * rebase-on-push
      * reformat-on-push
    * discussion of how to split messages up into sub-commands
    * a way to retry pushes without re-pushing everything (e.g. someone else
      updated the branch, you then re-merged or rebased locally and want to
      push again, meaning the server already has _most_ the objects but just
      needs a few new ones)
  * partial clones
    * doing work to have multiple remotes (also ties in to CDN usage)
    * still very tied to having a server around to request additional objects
    * we need to have a way to keep upload-pack open and do multiple requests
    * has some ability to filter trees, but we need them for now for index
      * Matthew Devore doing some work in this area right now, but it appears
        to be based on depth rather than width?
    * connection with sparse checkout is kind of hacky right now
    * there are reachability enforcement issues in V2, which becomes even more
      of an issue with partial clones (now need to worry about blobs not just
      commits)
    * in a partial clone world, server can't gc
    * sidenote: dumb http support
      * no major hosting provider supports it
      * some people like it due to resumability (e.g. Joey Hess & git annex)
      * cgit provides dumb http support natively
    * questions I had in area: getting list of initial files of interest...
                               gluing together with sparse checkout
                               partial indexes
  <break; talked with Michael H. & Thomas G.: filter-repo, checkout overlay>
  * breakouts: merge, GSoc, structured logging, windows big files; I
was in "merge"
    * merge-recursive rewrite
      * questions and basic explanation of how the algorithm works
      * want incremental updates on merge-recursive rewrite
      * make merge-recursive code part of libgit.a ?
      * people are very happy about idea to not touch the working tree
    * make rebase --merge the default
      * use performance tests to see how well it compares (p3400-rebase.sh)
      * may later also reimplement the am-specific flags on top of interactive
    * make use of best merge bases in more places (e.g. git diff A...B uses a
      suboptimal one)
    * rebase --rebase-merges:
      * doing a five-way merge rewriting xdiff to handle five instead of three
        file versions
      * M merges A & B
      * M' should like like a merge of A' and B', but really involved in a
        five way merge of A', A, M, B, B' -- and that is necessary in order
        to get evil merge represented
  * overview of "Big"
    * git-sizer (funny: git-lab asks users to run it and return results; github
      runs it for user and shows them the results)
    * large blobs, partial clones
    * partial or hierarchical indexes
  * CI
    * Dscho has a lot of machinery built up around Azure Pipelines
    * PRs to github.com:gitgitgadget/git will automatically be built on
      Windows, MacOS X, and linux
    * Interest in getting emails for failures that their topic branch
      caused (note: get topic author from tip commit author if not Junio)
    * This may be able to move to github.com:git/git after Dscho's patches
      merge down

Stuff that had been mentioned but we didn't get to:
state-of-the-union, commit-graph, evolve (we had the developer of the
feature in mercurial present, but not the folks who had worked on the
feature in git), git filter-repo, maybe a few others I'm forgetting.
