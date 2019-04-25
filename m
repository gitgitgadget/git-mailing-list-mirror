Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D8B1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 14:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDYOum (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 10:50:42 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45854 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYOul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 10:50:41 -0400
Received: by mail-vs1-f67.google.com with SMTP id o10so12642114vsp.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVWK28OlyQo49f1JCfrSBSVTRnM4rQXRZ2U/KLICCD4=;
        b=uS5rZjpBGhVvi9XN38Y71oapftI2BG8Ew0iKFfInN3c15a4ckJlrL8AGDUiccokIkx
         NvPIxu7tWotewYieqqk6oVXnQyEAEPYAwJP5sqQ5xUpT4bxhO4kSdgaj7jsUKbMslVsz
         yFCHQHyDRKkTBzC05vR7NF7INsehP7+00qpdhfZ3rPUT2aICgFqlmgPx8bukmTusEyBd
         RVkFCximLHpwG6mhLz9ML25gOwy7i430xVgKsJjMSk2YZX8JEs2ie3EI5s+m1YLQ3yHv
         LMLUa4bcQP1FUWZsFTItOuMUc5S1EowiFksGKEZNLDhcguup6YEXo8Et9wDjJTMPBJBq
         wgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVWK28OlyQo49f1JCfrSBSVTRnM4rQXRZ2U/KLICCD4=;
        b=nAbmkSAaieNpc2mjb5KYC9pvzuhTH8nYQcG/Sv889GOUWZZ4X5XryARyOlNguqU4CD
         HEBqBCviIupFGUs0+HQj8VhAuyzkgAGvtOg4+FyEbuPBSC46DOaPF0epMKbaqEZqOo6z
         zP6XuHxueFU9pYZAT5bqlQiFbOkej4pViVmI/ttcCPAUxV+FXtqjJ28H/WB1DR1k1p2+
         wMDT8U2YHcwNVgUddpw1ZG4TkkVZWYzGHxA6l9cf6xaSnCIHjdAwu6ToEA5aHSferWBt
         8inwQMj3FXbh+jPC8mgHCOtHDay5N4W+PfxRI4hsQWQgdJm34OoSB0DGo6UG5NlQarjR
         pwhw==
X-Gm-Message-State: APjAAAW3p4zWkXDZfldc0eZmH+Y676ewDJi9v0O4dzaujfTP37TQ3HVn
        +t6pG8FYhuA0FRmdHeh4PU7XjDIkYFJlcerMxxc=
X-Google-Smtp-Source: APXvYqwqXtV4/3kjlD8wjRlv2GnoQ+3TUC/HcxDOROEcJrmvpW2UaXTdta1LNWxJbvO0ZinG28Y4DeRmYw3r/NAmTqI=
X-Received: by 2002:a67:f416:: with SMTP id p22mr21939920vsn.175.1556203840466;
 Thu, 25 Apr 2019 07:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Apr 2019 08:50:28 -0600
Message-ID: <CABPp-BHbCKx61w7MFoNTFUORVD53OFAbkoqi04KRZG1C_sVtxw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 7:16 AM Junio C Hamano <gitster@pobox.com> wrote
> * en/unicode-in-refnames (2019-04-24) 1 commit
>  - Honor core.precomposeUnicode in more places
>
>  The names of the refs stored as filesystem entities may become
>  different from what the end-user expects, just like files in the
>  working tree gets "renamed", on a filesystem like HFS+.  Work it
>  around by paying attemption to the core.precomposeUnicode
>  configuration.
>
>  Looked sensible.  Ready for next?

Almost.  Torsten pointed out that I left some commentary in the commit
message that I should remove.  I'll send a v2 with it excised.

Also, s/it around/around it/ and s/attemption/attention/ in your summary?

> * nd/switch-and-restore (2019-04-12) 43 commits
>  - help: move git-diff and git-reset to different groups
>  - rm: add --staged as alias for --cached
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
>
>  Two new commands "git switch" and "git restore" are introduced to
>  split "checking out a branch to work on advancing its history" and
>  "checking out paths out of the index and/or a tree-ish to work on
>  advancing the current history" out of the single "git checkout"
>  command.
>
>  The "switch" part seems more or less ready for testing.  Perhaps
>  we should split this back into two topics and merge it to 'next'.
>  cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
>  cf. <20190411131218.19195-1-pclouds@gmail.com> (restore v2)

Splitting apart and advancing "switch" makes sense to me.  I'm behind
on stuff but really need to take a look at the new restore series;
I'll try to get to that soon.
