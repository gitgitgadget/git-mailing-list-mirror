Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396E3208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 15:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbeHGRpY (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 13:45:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34729 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbeHGRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 13:45:24 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so14346128ioj.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3e23H3dDUshW6smhDAG/a7mR1qtzyv9KRNmsOAzztO4=;
        b=ghwYmZfnbVIXQ/fv7Qcf38lmDpP3ztmRZqvyDIehmuuS3cJ8W8qtT/LKm6vF2VIL7L
         MEVdxGBPjOapRpI2uepWnI76QWWZRirLO0K/oyCjAzxbusz7khsFfZc6kF5BR+MendI8
         t6gbWIDoimiOJ2onFbgO14ZC50kA8toyYO5HSGsTESXAMS8py9kyIX6W5HpD6zvqvkmk
         XZXbCQHouj7kVI8OyANOTCD/mZN46Euglc2WjnUpFUoMiFMYXfb4qFpbbYf7rNYNffcm
         lLLCrzAIsvLREGaDIHHL9xOt7Cikn2tODCfC8GWPApdZrpFKvJkANjkph9t7LUL6jPcU
         gZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3e23H3dDUshW6smhDAG/a7mR1qtzyv9KRNmsOAzztO4=;
        b=COxl6LCFznWTAqRz2tw/RvtF8KHtwghhRpewTTziQ4AP+64YbeFzzV2DWVH3lR6/EL
         MgfoOvwtc/cAmG/BzXKgv/TRN/gWYlIiT3l9POgjz9pJl4Kkrxnwp5KKCwgcnkq/ThMq
         DlbS0MPMwlTozcNHQNfQsKjLOiSMiRbXuYH72xQqFDKmSEC5UjNXLF+ymI22tNNHtmyM
         i01CVZsOoYSxMQCFWewfNntxWcyIvIItcGgGFbMoiIOW77QeYUVzu3o5b8MCGssQHKxU
         dzrYigXywDK9W5c9AZYsste6aCq1ZseVdU+J2jzfXJZbH2K8idvBMd9lBK2DGG4H19BX
         jgUQ==
X-Gm-Message-State: AOUpUlFKppoIgV7GI2+/45Al1TaX/HZXl3OjWXiNEI/4eNPRpeFyb6MS
        18WQiJlJPn9GOQywlsdHIBksx/E7TRTTR/GoWzsSog==
X-Google-Smtp-Source: AA+uWPy4ajFzbUj0g3pVpHyXrF90e8AEV5rhZwJ9c5JkkXnE7feH8HzTCo4wRLDd2o2nZTyIsFtE8UjxHP12VU9pbmg=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr4701988iod.118.1533655832566;
 Tue, 07 Aug 2018 08:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180807132113.118297-1-gitter.spiros@gmail.com>
In-Reply-To: <20180807132113.118297-1-gitter.spiros@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 Aug 2018 17:30:04 +0200
Message-ID: <CACsJy8A=zp7nFBuWyfeP4UFf3KSsiaor3m0mtgVnhcEYHSw4HA@mail.gmail.com>
Subject: Re: [PATCH] worktree: add --quiet option
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 3:27 PM Elia Pinto <gitter.spiros@gmail.com> wrote:
>
> Add the '--quiet' option to git worktree add,
> as for the other git commands.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  Documentation/git-worktree.txt |  4 +++-
>  builtin/worktree.c             | 11 +++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 9c26be40f..508cde55c 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -115,7 +115,9 @@ Unlock a working tree, allowing it to be pruned, moved or deleted.
>
>  OPTIONS
>  -------
> -
> +-q::
> +--quiet::
> +       With 'add', suppress feedback messages.

Should we update the synopsis as well?

> @@ -315,6 +316,9 @@ static int add_worktree(const char *path, const char *refname,

Before here we run either update-ref or symbolic-ref. update-ref does
not have --quiet so it's fine, no need to add another option there
(until it shows something when used with "worktree add --quiet") but
symbolic-ref seems to support -q. Should we pass -q to it?

>                 cp.argv = NULL;
>                 argv_array_clear(&cp.args);
>                 argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               if (opts->quiet)
> +                       argv_array_push(&cp.args, "--quiet");
> +               printf("%s\n","soo qia");
>                 cp.env = child_env.argv;
>                 ret = run_command(&cp);
>                 if (ret)
> @@ -437,6 +441,7 @@ static int add(int ac, const char **av, const char *prefix)
>                 OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
>                 OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
>                 OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
> +               OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),

git grep OPT__QUIET shows that we have plenty different messages to
describe --quiet. But yeah "support progress reporting" seems close
enough in this context.

>                 OPT_PASSTHRU(0, "track", &opt_track, NULL,
>                              N_("set up tracking mode (see git-branch(1))"),
>                              PARSE_OPT_NOARG | PARSE_OPT_OPTARG),

The rest looks good.
-- 
Duy
