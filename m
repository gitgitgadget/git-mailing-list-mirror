Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63E21F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeHTV2R (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:28:17 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:36607 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTV2R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:28:17 -0400
Received: by mail-yb0-f174.google.com with SMTP id d34-v6so4956498yba.3
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYEStHOExmlnHKkHq653YjRQ2jW2HpKX2qlekXuOZXk=;
        b=WF5YkNXVrwj+so2iksGe0BbWSbKtdfbfe2GRsPebKE8rgOfr8sDt564bzbzPq18UFy
         X+ANpe19QfLXCyJe9T87eGD80qJYojxEBrGFp61BTh5so2Xutzt8CxG4WwEttYOz6S+a
         8XQ94XWTwbmUY9cz6TJLwHVdlVSG3SVkQELjerl2xSQ8m6/JP12sOOQoR1+6qChuOfgX
         MvbpThX706zoBaPc9022QP0Fz8ahLA0oE9LDy/keidwCW3BOAeNz5M4GK03Q9c+Qw2Ms
         01silexlC+M6ZZzXXVJYXOS9pDLfJ8peXxJvM6y7pbtHONO/mPUBifDdXTkrs00/mpjw
         S0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYEStHOExmlnHKkHq653YjRQ2jW2HpKX2qlekXuOZXk=;
        b=FuTpARA/g6ye0CSuh0w1ptLew2lxMHzeCMhifIloAH0sJYeBvzPNWJrsSWxbjoRH7j
         Atuo3rY2ZmsxN2fBzU1MmzpeDjK9DFsphJ05xDI9kruF5TizdtSqJ9ol14mh8sIs37x6
         1w8GpFmb+l4dmhbnXsWOoM+ioUvDpBl7H3WmynuNZpnu1SzXQHDoDhWNrfLGnircVs7m
         VizcExrQuUHKxc3W1hZwn1qXXc7tSs9oxlV1WVjulybHEGiOreidjig1vv8d7gFJpSDg
         hULre+C5dlZP0G3S0SmCwe8Xe7Z2Ixjn19uNBm6nFKpgDMmCFoGYSnfvaMpDHyMnbSle
         4kew==
X-Gm-Message-State: AOUpUlFoFBe35aqzFXQL4ZqR1jmPAaUU+jGhOtiCMolTiz5+wCp69COD
        DlcHwZuHv9Jpm2L0Igd7N6GN7EhmYYiEMvqHunI83Q==
X-Google-Smtp-Source: AA+uWPw9/ZcH0ffJ8LINfTjGYdMRm6O9bFTj60HwOxIPdgPcVx4BRJKTOU7ldAX0giYbyKU2DwTHUstzSrOqJWXC6lg=
X-Received: by 2002:a25:aea2:: with SMTP id b34-v6mr21250603ybj.416.1534788696358;
 Mon, 20 Aug 2018 11:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 11:11:25 -0700
Message-ID: <CAGZ79kbQ5L39kdsfouPXJjJOm_Ni9TY5Qan7nHZE9VbcaEMyGA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 3:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Usually, I refrain from merging larger topics in 'next' down to
> 'master' when we get close to -rc0, but I am wondering if it is
> better to merge all of them to 'master', even the ones on the larger
> and possibly undercooked side, expecting that we collectively spend
> effort on hunting and fixing bugs in them during the pre-release
> freeze period.  If we were to go that route, I'd want everybody's
> buy-in and I'll promise to ignore any shiny new toys that appear on
> list that are not regression fixes to topics merged to 'master'
> since the end of the previous cycle to make sure people are not
> distracted.

Speaking of releases, linux for example has some releases that are
more stable than others, as most distros pick the same release for
their 'stable' release, whereas the regular and new releases are just
off of the latest release of linux.

Would a similar model be an interesting thought to entertain?

I guess I could buy into a few weeks of bug fixing.

> * nd/config-blame-sort (2018-08-06) 1 commit
[...]
> * nd/no-extern (2018-08-03) 12 commits
[...]

Thanks Duy for these two series!

I would have expected the no-extern series to
have a bit of merge conflicts similar to  sb/object-store-lookup
as it touches a lot of headers, but so far this looks like smooth sailing?

> * sb/submodule-cleanup (2018-08-16) 2 commits
>   (merged to 'next' on 2018-08-17 at ca9d8aaef4)
>  + builtin/submodule--helper: remove stray new line
>  + t7410: update to new style
>
>  A few preliminary minor clean-ups in the area around submodules.
>
>  Will merge to 'master'.

Oh, that is the prologue of
https://public-inbox.org/git/20180816023100.161626-1-sbeller@google.com/
which I will resend to build on top. Given your question to hunt more bugs,
I'd delay its resend until after the release.

>
> * ao/submodule-wo-gitmodules-checked-out (2018-08-14) 7 commits
>  - submodule: support reading .gitmodules even when it's not checked out
>  - t7506: clean up .gitmodules properly before setting up new scenario
>  - submodule: use the 'submodule--helper config' command
>  - submodule--helper: add a new 'config' subcommand
>  - t7411: be nicer to future tests and really clean things up
>  - submodule: factor out a config_set_in_gitmodules_file_gently function
>  - submodule: add a print_config_from_gitmodules() helper
>
>  The submodule support has been updated to read from the blob at
>  HEAD:.gitmodules when the .gitmodules file is missing from the
>  working tree.
>
>  I find the design a bit iffy in that our usual "missing in the
>  working tree?  let's use the latest blob" fallback is to take it
>  from the index, not from the HEAD.

I am not sure; why does it feel iffy?

> * bw/submodule-name-to-dir (2018-08-10) 2 commits
>  In modern repository layout, the real body of a cloned submodule
>  repository is held in .git/modules/ of the superproject, indexed by
>  the submodule name.  URLencode the submodule name before computing
>  the name of the directory to make sure they form a flat namespace.
>
>  Will merge to 'next'.

Cool! Is the discussion on top of it still going whether to use a
new config for special cases or how we distinguish between a/b/
and a%2fb as submodule names?

> * md/filter-trees (2018-08-16) 6 commits
>  - list-objects-filter: implement filter tree:0
>  - revision: mark non-user-given objects instead
>  - rev-list: handle missing tree objects properly
>  - list-objects: always parse trees gently
>  - list-objects: refactor to process_tree_contents
>  - list-objects: store common func args in struct
>
>  The "rev-list --filter" feature learned to exclude all trees via
>  "tree:0" filter.

I gave this a read and think it is good to go.

> * sb/config-write-fix (2018-08-08) 3 commits
>   (merged to 'next' on 2018-08-17 at 7d9c7ce81f)
>  + git-config: document accidental multi-line setting in deprecated syntax
>  + config: fix case sensitive subsection names on writing
>  + t1300: document current behavior of setting options
>
>  Recent update to "git config" broke updating variable in a
>  subsection, which has been corrected.
>
>  Will merge to 'master'.

Thanks!

>
>
> * sb/range-diff-colors (2018-08-14) 8 commits
>  - diff.c: rewrite emit_line_0 more understandably
>  - diff.c: omit check for line prefix in emit_line_0
>  - diff: use emit_line_0 once per line
>  - diff.c: add set_sign to emit_line_0
>  - diff.c: reorder arguments for emit_line_ws_markup
>  - diff.c: simplify caller of emit_line_0
>  - t3206: add color test for range-diff --dual-color
>  - test_decode_color: understand FAINT and ITALIC
>  (this branch uses js/range-diff; is tangled with es/format-patch-rangediff.)
>
>  The color output support for recently introduced "range-diff"
>  command got tweaked a bit.

No, this series doesn't tweak the colored range-diff.
This might be:

  Add more test coverage to colored range-diff and
  refactor the diff machinery to be more readable.
  The test coverage proves no user visible changes
  are made.

The tweaking comes in on top of this via
https://public-inbox.org/git/20180817204354.108625-1-sbeller@google.com/

Thanks,
Stefan
