Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDAE1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 09:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406059AbfFLJIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 05:08:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44694 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390115AbfFLJIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 05:08:12 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so12323116iob.11
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hm3NF3lGzhvVT4bEMpvaTy9P8n8Nas8zdjvbYc35Yj8=;
        b=iY+fsXSDkNoihuIGxKfD4gtosrZH6UzL5yHHgsR0S90uqQo0rP1hZ7A4y49WjyYUCv
         h9FHGnzfAa106voH49TQ03OWITdPQkIsvx/0vQ9wTIbf+GlJupcjTOfFpUOdC59yh/zs
         CgPlJcbShiBJE0vmTqAVatruBRHBGE7EZo22V9AZjp3pnZHTrLUeMyz1akv8Wa1xHCTD
         JOJbJPognQYjJhlIuRMBxcC4QiEwDNnTIImqoVSh1hUaMUsxnjQnpOa1O8G2FJBU6bb3
         JH7pw2VLFHSuRAKwwO4A6Ql/g458uhukn1GTypl8VRTgevuHuqMFjyBnA0MRTrI5DzU+
         hURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hm3NF3lGzhvVT4bEMpvaTy9P8n8Nas8zdjvbYc35Yj8=;
        b=gPSOwgrGc/CljwbPaTc/xAOGU1m/yHA2QcQ+vwLEDBa3Fe9LmPzQpjdRzDGxAdHu10
         wtnxySl8FY/b4UbPPQwaDBpI7rcEAFF7xWpcc53MFdym746ePY6piZBCFfdcPbwxRA64
         sMWt2QdqU20UIjRtzcMxmcl49PzmABiVYGaMtdPm/TRr2qugKAXPS+mrFpAZPpSms13Q
         gxwJ5diUVHR9gmw7pEd8NaV9wqadf4yOh3nggpR3UMdF2sJ7ztrKhauBl7cTS/K4vUHK
         f2JYbzF6tO41bk+QifRO1UQ9zvVzkzFoOZPEoqnXLkDRK585vYiu8Qwct8QpZK5Jmg2N
         /gKg==
X-Gm-Message-State: APjAAAXeAkVhYY7gdDqNJTqGy/e2ZXB+I0gjjD6ybxVnBc5GCMQmwE+G
        mC81+9FFO5wDP8oYGWP/sNSVZ/Np7hL5F1RV832A8Q==
X-Google-Smtp-Source: APXvYqzzSio9ZehdfNu1Vyz1hHtbxLBcq3VxuLVrKzVCUSpBleu64CPRAYNa+hdjUgBV2ATKQzh0VKDWjMhkLu66Ti4=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr46095791ioq.282.1560330491570;
 Wed, 12 Jun 2019 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqimtiqyey.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimtiqyey.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Jun 2019 16:07:45 +0700
Message-ID: <CACsJy8CRwvRhxT7OBWn8f716=xX93gD-jho_gE09c5aGe=Vskg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2019, #02; Thu, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 7, 2019 at 3:19 AM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/switch-and-restore (2019-05-07) 43 commits
>  - Declare both git-switch and git-restore experimental
>  - help: move git-diff and git-reset to different groups
>  - doc: promote "git restore"
>  - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
>  - completion: support restore
>  - t: add tests for restore
>  - restore: support --patch
>  - restore: replace --force with --ignore-unmerged
>  - restore: default to --source=HEAD when only --staged is specified
>  - restore: reject invalid combinations with --staged
>  - restore: add --worktree and --staged
>  - checkout: factor out worktree checkout code
>  - restore: disable overlay mode by default
>  - restore: make pathspec mandatory
>  - restore: take tree-ish from --source option instead
>  - checkout: split part of it to new command 'restore'
>  - doc: promote "git switch"
>  - completion: support switch
>  - t: add tests for switch
>  - switch: make --orphan switch to an empty tree
>  - switch: reject if some operation is in progress
>  - switch: no worktree status unless real branch switch happens
>  - switch: implicit dwim, use --no-guess to disable it
>  - switch: add short option for --detach
>  - switch: only allow explicit detached HEAD
>  - switch: reject "do nothing" case
>  - switch: stop accepting pathspec
>  - switch: remove -l
>  - switch: add --discard-changes
>  - switch: better names for -b and -B
>  - checkout: split part of it to new command 'switch'
>  - checkout: split options[] array in three pieces
>  - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
>  - checkout: make "opts" in cmd_checkout() a pointer
>  - checkout: factor out some code in parse_branchname_arg()
>  - checkout: keep most #include sorted
>  - checkout: inform the user when removing branch state
>  - checkout: advice how to get out of detached HEAD mode
>  - t: rename t2014-switch.sh to t2014-checkout-switch.sh
>  - git-checkout.txt: fix monospace typeset
>  - doc: document --overwrite-ignore
>  - git-checkout.txt: fix one syntax line
>  - git-checkout.txt: spell out --no-option
>  (this branch is used by jl/status-reduce-vertical-blank.)
>
>  Two new commands "git switch" and "git restore" are introduced to
>  split "checking out a branch to work on advancing its history" and
>  "checking out paths out of the index and/or a tree-ish to work on
>  advancing the current history" out of the single "git checkout"
>  command.

It's probably ok to move both switch and restore to 'next' more more
testing. I've been using both for months. I had to switch back to
git-checkout one time (because of submodule stuff) and it felt weird.
So they're probably good enough, overall.

I do have two or three small refinement patches (for both switch and
restore), but I'm still hung up on handling "git restore *.c" (with
shell's expanding *.c). I think I know what should be a good
compromise now, just need some more time to code it up.

>  cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
>  cf. <20190425094600.15673-1-pclouds@gmail.com> (restore v3)
--
Duy
