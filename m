Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01C81F597
	for <e@80x24.org>; Wed, 25 Jul 2018 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeGZAKU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 20:10:20 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45741 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbeGZAKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 20:10:20 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so3643518ybg.12
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQO4Mj25R0ezQPtGFNRgT9IwyT/64R/2sPQTkx6it40=;
        b=QqeEK/b9SZ+e/xv8O1DEB5ELRxIHqjg36fJAlbrOA6kU+mOOXvK7YI1VDiD/5rOI/N
         qNMKZq3yIBxPh6FNM5AULZwfBFx2E8GFcYHWqjh5nDGmBdGADBG+DsRH5Tx+psHvR2w5
         P96T5VcepYrUKsrFR8+J82X2Oq5NFuTtKbPCXOROoM99wcw2OCTqpET9UGqrwkIHKbvv
         A4WfmTvESHcx5p33LvBX6qkXuC99FQJujk0mefNiSiAXUozoveFP8/MThiQrUHbxls6c
         Vq64OKiIAqfpRPC8Gu7ORsaTcdh+yOlOvna6WAnGK++rV8+MpXSrgV+s3gBncmj80NRK
         c7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQO4Mj25R0ezQPtGFNRgT9IwyT/64R/2sPQTkx6it40=;
        b=Zqs3OMEmOOTVE9zxgmPRYQlD9m+WFTisewP8D2DJzivRbOz7+IiRcZyycKNn+WuUZG
         hlV2TNAoU5e+Ex4rEHgeq1e+iDB/SL/5QuEIRBknA2eNAKB5+lt9mkticuNye4qJWE+h
         LZHnHqLH4oIHWpTlnIKarD1thN9YypT38RzdYCfShhgqlWhn8VIcXnBFr7GHjPV3qam/
         BB/j3GtLfv0XOAdnD0BuXlfdqSAGE6c2VQfRNhjfHJ0xSLyXuytGFIRkhTfeRczL8PFn
         vfXU6nXyGC2Qz8U5EONEyG9EVt0wW2oVBbwX1wwhASHY2OYTIt5YCy4UH9lx21sDwhzS
         WOOw==
X-Gm-Message-State: AOUpUlGQLpnjE8kZNlS9gToiH8Ock1+2lyVdMa5nqY3wFJEYop7S+bK4
        ifyEJHeJrS94yDONQy4wU+1zDRgYcJ+KMoyVe+/W0r++JdtoQQ==
X-Google-Smtp-Source: AAOMgpdtFw+hqwhRIXZUfHubfsbVcXD/viKamIdeuj4+jYN83kdJtPX9Z1B4Tfk1ElFx18BWSeKvR0WGfL+yxTuPW1Y=
X-Received: by 2002:a25:dc47:: with SMTP id y68-v6mr12078161ybe.515.1532559388063;
 Wed, 25 Jul 2018 15:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jul 2018 15:56:17 -0700
Message-ID: <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 3:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> Many topics have moved to 'master' and 'next' from 'next' to 'pu'
> respectively.
>
> You can find the changes described here in the integration branches
> of the repositories listed at

(using an alias to fetch all using protocol v2)
Fetching o
From https://github.com/gitster/git
 - [deleted]                 (none)     -> origin/ab/fetch-tags-noclobber
 - [deleted]                 (none)     -> origin/nd/use-the-index-compat-less
 - [deleted]                 (none)     -> origin/sb/diff-color-move
remote: Counting objects: 830, done.
remote: Compressing objects: 100% (379/379), done.
remote: Total 830 (delta 404), reused 777 (delta 404), pack-reused 47
Receiving objects: 100% (830/830), 470.12 KiB | 9.04 MiB/s, done.
Resolving deltas: 100% (404/404), completed with 58 local objects.
fatal: Couldn't find remote ref refs/notes/amlog
error: Could not fetch o
...
(goes and pastes this into the email, what if I try again?)

$ git -c protocol.version=0 fetch --all
Fetching o
From https://github.com/gitster/git
 * [new branch]              ab/newhash-is-sha256       ->
origin/ab/newhash-is-sha256
 + 6da893ab657...729b3925ed9 bb/make-developer-pedantic ->
origin/bb/make-developer-pedantic  (forced update)
 * [new branch]              bb/redecl-enum-fix         ->
origin/bb/redecl-enum-fix
 * [new branch]              es/diff-color-move-fix     ->
origin/es/diff-color-move-fix
 + 165e30f8529...d63a0b5e393 es/format-patch-rangediff  ->
origin/es/format-patch-rangediff  (forced update)
 + 1ac17a46fab...bb4a134ae84 jch                        -> origin/jch
(forced update)
 * [new branch]              jh/structured-logging      ->
origin/jh/structured-logging
 + 816325b2109...c255a588bcd js/range-diff              ->
origin/js/range-diff  (forced update)
   b7bd9486b05..ffc6fa0e396  master                     -> origin/master
   5c9ce644c39..a71716f1ade  next                       -> origin/next
 + 8a589a4fc91...838143aa5c0 pu                         -> origin/pu
(forced update)
 + 0041456f5f1...16d09ff91a2 refs/notes/amlog           ->
refs/notes/amlog  (forced update)
Fetching googlesource
...


> * jh/structured-logging (2018-07-25) 25 commits
[...]
>  - structured-logging: design document
>  (this branch uses jh/json-writer.)
>
>  X-Gah.

I am not sure what to make of this comment?
Does it need review or is the design/intent to be
discussed?


> [Cooking]
[...]
> * sb/submodule-update-in-c (2018-07-18) 6 commits
>  - submodule--helper: introduce new update-module-mode helper
>  - builtin/submodule--helper: factor out method to update a single submodule
>  - builtin/submodule--helper: store update_clone information in a struct
>  - builtin/submodule--helper: factor out submodule updating
>  - git-submodule.sh: rename unused variables
>  - git-submodule.sh: align error reporting for update mode to use path
>
>  "git submodule update" is getting rewritten piece-by-piece into C.
>
>  It seems to pass its own self-tests standalone, but seems to break
>  horribly when merged to 'pu'.

I need to redo this, please eject from pu if that is easier for us.

> * ag/rebase-i-in-c (2018-07-10) 13 commits
[...]
>
>  Piecemeal rewrite of the remaining "rebase -i" machinery in C.
>
>  A reroll (which is rumored to be quite good) exists, but hasn't
>  been picked up yet.

Forgot to state so on either the mailing list (or Github or IRC),
but I read the tip of the reroll and I think it is good.

> * sb/object-store-lookup (2018-06-29) 33 commits
[...]
>
>  Will merge to 'master'.

Finally. Hooray! I am currently writing its successor in a
"less confrontational (but needing more work)"-kind-of way,
which converts the ref store to take repository objects.

Given this series (and how it was done/reviewed and yet
caused so much trouble), I'd like to spark a discussion on
how the community wants to see large scale refactorings
and eventually document it.

> * js/range-diff (2018-07-25) 21 commits
[...]
>  (this branch is used by es/format-patch-rangediff.)
>
>  "git tbdiff" that lets us compare individual patches in two
>  iterations of a topic has been rewritten and made into a built-in
>  command.
>
>  Undecided.
>
>  Many "The feature is useful" comments without much real review; we
>  know the feature is great as this mimicks tbdiff already so that is
>  not news.

It has also seen reviews regarding its non-coloring side in previous rounds,
which I think is mature by now. I suggested to submit the range-diff
without coloring on IRC, but it was not quite well received as colors
were seen as "the main benefit of range-diff" by DScho.
(http://colabti.org/irclogger/irclogger_log/git-devel?date=2018-07-25#l72)

>  I've squashed an obvious documentation fix in before rebasing the
>  other topic that depends on it.  I _think_ we would probably be
>  better off to _disable_ whitespace-error coloring altogether when
>  showing diff-of-diff, and get rid of the workaround that only is
>  applicable to the context lines of the outer diff (unless we first
>  define how whitespace errors in diff-of-diff should be colored and
>  implement it correctly, that is, but after seeing these two
>  attempts, it seems that is harder than it is worth).

I think the current coloring is good enough to ship, but it still has
errors around corners, for example introduction of new files,
having lines in the inner diff as:

     diff --git a/Makefile b/Makefile
     --- a/Makefile
     +++ b/Makefile

will be colored white/red/green (in that order), but in the outer diff
these are all "context", but as these specific context lines happen
to start with +/- we color them.
If we want to be perfect, we rather need to parse&understand
the inner diff on a more detailed level, but I would argue to leave
that to a later stage for another volunteer to step in and cleanup.
