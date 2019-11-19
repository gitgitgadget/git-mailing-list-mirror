Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1E31F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKSUlv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 15:41:51 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36994 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 15:41:51 -0500
Received: by mail-pg1-f201.google.com with SMTP id u8so4272956pgl.4
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H5SdLtX295MmicjQSfIlWZVd6xDLC+BANd8e5QgSzfQ=;
        b=Gu9kI62YRIl+iD6ah6BP/RGaHSC2rj5F6a4Jb76YqS658OUUIzCJulqGO6XLRlyycP
         2+is9cxAmkdbya5odDxSkFDQOjmeyQAAGH4DuzgX4EM13k73b5eSPEsEcW16yW9KTWY0
         NDniBFQPIpKoCYCSFJ1+Kga7lgk+N1a+EtQ7U0VBPh6DeparkMPIcEDoP8UOdJPul7v/
         TIh7owbOzkQtlkYPEFkHjjbpmBZ/ch+CkWCpi3Ku5X5HldDSJZF5zXjedKeDFDPBukVo
         /4W4hgJh1MQYKzOtCVYK7n+lmrs2T2IftotUtduuqHEDiG0GYwlTVZjOo6chIUkMsw+W
         jveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H5SdLtX295MmicjQSfIlWZVd6xDLC+BANd8e5QgSzfQ=;
        b=KXV2LVmB//BthFnbsE5EPwDJNva/E19GawA6HuCRHYwZSTUK9tgCbL+ZOdFTYKHv8X
         3UuIdC/HVdgzvoesNHoarAdxYE+0fyN3wiVi33s20C/y+OGrGS7kmWoe8tBWweDJ0ac2
         OIKK3sqB/Cpg6JpPpTyT0to6izkDGtbtD0IsHC2T5qHPPG/wUxKpShSeed1qXYZGNx/r
         +eagqIvaCzY9UrSAN/Tlx7JYjRdSmnK5LN53nGcYJoRP5uMiCs7yKpXmB3Z0S9G78KH/
         ouyakEE8EPOeoDhjMxv07SU6ZIrOG0RqKh4R7FMlViGyfGzJT8l75jRduGOI5mVSSb8U
         qdsg==
X-Gm-Message-State: APjAAAVVKNEyMMu15vpE6LClczGiR4UQgqU2GN3qJIyyh5Jn9t91CmB3
        XRuvahHk3UXCi4DaNqg07XbvCyWLynQTsap/k6wx
X-Google-Smtp-Source: APXvYqxm0PWiIZu97cCh52ojkqDa+Aoz4EKKc95Syv/77HQaUbsM6e1L3fju4JUMOL8bfF+iF94gExj6jnufIl3t0op3
X-Received: by 2002:a65:58cc:: with SMTP id e12mr7536083pgu.194.1574196110432;
 Tue, 19 Nov 2019 12:41:50 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:41:46 -0800
In-Reply-To: <3e616116-2f6f-acff-91b3-4aefc7e62653@gmail.com>
Message-Id: <20191119204146.168001-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <3e616116-2f6f-acff-91b3-4aefc7e62653@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: ag/sequencer-todo-updates , was Re: What's cooking in git.git
 (Nov 2019, #03; Tue, 19)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     alban.gruin@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org, phillip.wood123@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > * ag/sequencer-todo-updates (2019-10-28) 6 commits
> >  - SQUASH??? tentative leakfix
> >  - sequencer: directly call pick_commits() from complete_action()
> >  - rebase: fill `squash_onto' in get_replay_opts()
> >  - sequencer: move the code writing total_nr on the disk to a new function
> >  - sequencer: update `done_nr' when skipping commands in a todo list
> >  - sequencer: update `total_nr' when adding an item to a todo list
> > 
> >  Reduce unnecessary reading of state variables back from the disk
> >  during sequener operation.
> > 
> >  Is the leakfix patch at the tip the only thing that needs to
> >  prepare the topic ready for 'next'?
> > 
> 
> Yes, it is.

I took a look at this. Some comments:

- Commit message 1 refers to read_todo_list() which doesn't exist.
  Should it be read_populate_todo()?
- Commit 3's todo_list_write_total_nr() could just take an int instead
  of the full "struct todo_list *".

And overall, I wish that there was more descriptions of the code paths
involved, especially in commits 4 and 5. In commit 4, I can see that
run_rebase_interactive() calls get_replay_opts() then
sequencer_continue() (so sequencer_continue() receives whatever
get_replay_opts() outputs - and this commit adds the initialization of
"squash_onto" therein), which calls pick_commits() (which uses
"squash_onto"). I would have liked the commit message to verify that in
sequencer_continue(), before pick_commits(), "squash_onto" was never
written to, so it is crucial for get_replay_opts() to fill
"squash_onto".

And in commit 5, I noticed some analysis from Phillip Wood [1] but I
would have liked more details. For example,

>      - calls read_populate_opts() -- this is unnecessary as we're starting a
>        new rebase, so opts is fully populated

So complete_action() (the function modified in this commit) is called
only by do_interactive_rebase() (in builtin/rebase.c), which is only
called by run_rebase_interactive() (in builtin/rebase.c) when command is
ACTION_NONE, so indeed, we're starting a new rebase. But where the
options fully populated? I see that in do_interactive_rebase(), it is
initialized with get_replay_opts(), but that seems different from
read_populate_opts().

[1] https://public-inbox.org/git/212cdc0d-8cf3-9172-d405-39b3868e6ca4@gmail.com/

Having said all that, I'm not opposed to this being in "next" (except
that the commit message 1 probably should be updated), since it seems to
me that the analysis has already been done, and is merely unwritten.
