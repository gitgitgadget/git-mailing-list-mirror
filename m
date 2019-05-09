Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DA71F45F
	for <e@80x24.org>; Thu,  9 May 2019 13:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEINob (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 09:44:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45846 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEINob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 09:44:31 -0400
Received: by mail-io1-f67.google.com with SMTP id b3so1599136iob.12
        for <git@vger.kernel.org>; Thu, 09 May 2019 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yS9K2rK9tAwumJOvArkfJh2TJsjMAeSPSX2wgGT6v5w=;
        b=CCi2K/9dh2A9DmEu2JOZFXOAf+mcufiQseEN/CJzQPkCshZXYVJAaL+oNYp0ObFP5Q
         R2+98R1ZLwWelfKF/GokMLWTjh/UND+Jn84JJvN/xvVW6OU5s269W7kFGmlMCNpb1jTF
         6nGTklWy5Dk91wDHoQrgUqhpzByToVeBRQD92mSNqx2pm1KmnC8ulz9kI/ZB5ZNs8WgG
         9jrHpEzi0WpW6upTLue6ElvqMze0cJuMNBIbpfRqqmZ6AHcdTuv+1F8uSgbanTvylfKo
         NFc6YeR/XA5sWRY4b/RoFASj8pVtgyrNUrCgp8H+mmiENIV6ch5+j0l8NqA7yejB+901
         wmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS9K2rK9tAwumJOvArkfJh2TJsjMAeSPSX2wgGT6v5w=;
        b=rmh2xg5u2W9G8ecmIjb4P6tz9AHwhpRG91FF3cD2Gqc73mZHSu8vldRt+wmLIXra8Q
         tmXw7KvRunr7izrq7h+eWMo+aZElVbIH7wKEjDT+DUs5P+aMZaVRvp2KT/LTVYTX5Y8B
         IZTjKLRjdIOzMhAvAn1OUFgG1auOeGtt3N73FU2k39e8Wb3/8F40iNnqMwcQLqiNXmqR
         2P5gtsVvTsbVAKZRWxqYjwMiwvb8cEdW6U4qMBfKX2fbUX+E9FRUpUP3gBju1Wrmcm25
         8BYPOHpzSTaK5Kz566LdvbuxKcxQFfYmTlUbbeVZzwHJzKTLI6WQYQ4L9pSp9fvCFQpn
         8Mfg==
X-Gm-Message-State: APjAAAWgxFTXy8o8KICuy3VOd/J2n7IdjdS6a+DryVwwTKVWIN6TJK92
        AuPD/IGMQw8/Imk1m9FjAI35cNhZT6jpi24vWrDEHg==
X-Google-Smtp-Source: APXvYqxd7eM5OUT75qLgpxR2pPWwAkGAaeE51ZeNvXMVgYyfNrSunHpVB9L3H70GdYYXeg3iNbJSfqyoyP6vIiLhZq4=
X-Received: by 2002:a6b:ef12:: with SMTP id k18mr2243776ioh.236.1557409469921;
 Thu, 09 May 2019 06:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 May 2019 20:44:03 +0700
Message-ID: <CACsJy8Ar8rCOhkXv6QUfEiOLOepfU6KNr34K7qFaQiMcgQCmLQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2019, #01; Thu, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 9, 2019 at 12:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * nd/merge-quit (2019-05-07) 2 commits
>  - merge: add --quit
>  - merge: remove drop_save() in favor of remove_merge_branch_state()
>
>  "git merge" learned "--quit" option that cleans up the in-progress
>  merge while leaving the working tree and the index still in a mess.
>
>  Hmph, why is this a good idea?

The first reason is consistency, besides bisect, all other in-progress
commands have both --abort and --quit.

The second is because it's an escape hatch suggestion in git-switch.
And this goes back to the first reason because git-checkout will just
let you switch and do stuff. If you forget about the merge, at some
point continue the merge won't even make sense.

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
>  cf. <20190425094600.15673-1-pclouds@gmail.com> (restore v3)

No opinon here.

I do have three small patches to refine git-switch. But I think we can
do it on top. Probably best that way anyway to keep the justification
for the changes in commit message.

git-restore works quite nicely for me, by my opinion in this area does
not count. Besides Emily's usability issue with shell wildcard
expansion, intent-to-add support is still not there. And Phillip might
want to change --discard-changes behavior. That's all that's left.
-- 
Duy
