Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DFB208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbeHGQvj (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:51:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33607 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389514AbeHGQvj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:51:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so7958791pgv.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i96/0FUigWvz9C2exrq5YJHOIPOgC5uyiWJDg46orJ0=;
        b=CotV9AdZrH1J8w1QCNxlrmjSJxMmq9auPhStFBU8gA12q6PuJldJ+27ypv9gndP+IY
         EMLlHVy5uoZ7OtJ6pbvMZne9WnrsF4f80CRqfKWlSxQyHhS4U/GhWdfxXf9SMaxurqkF
         1W7ljh3B4HdjiCE4MuW6o+O02IhUvij4R5919FMINm9OC1CYR7V7dmuJ5SbclCrQkfCH
         cODCdUG/5/SdQ55n3WhQfw88S+HGMdJvja1gpCISKivi8xYYkjTmDhbpc11mNa6T87ZB
         mthkzP488h+FpmJXkSTFA8nK+kVCwJyeo+OIbrFoe6zzGwOcX0RheWdSivPgTYe9ir3c
         m5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i96/0FUigWvz9C2exrq5YJHOIPOgC5uyiWJDg46orJ0=;
        b=CXZ8y/Xn6C+CUVoAi8Q6op+t0VVKBTkzYPY7LvE1KYvEf/Osdlq7Ln/PCE64K8b9Jv
         5+522ET7YdKOxVVYHkaN3iPijuu0XtnsuOLJn/YAaxwO+pRGk/z2dbqL/2EHuxj9/F7t
         0NZeEdJswWUHPkx9MDMBZPUGjvJceALiJzO4uL530ODftWZAy7loEiwcJD/zrZXvuHC/
         ILFD7OSirq7Ve+iP11MP0isY1GXcODSZ58WtJkxaBL790GDJ1WCoZwjcTCCJwfF0Dm4y
         f6A+W4xJM5yJWaeL5+EkhU8QALE45S3t64VrjuXqwa4xhyvimEPcBT9tn2GrDoPWRIOd
         Q/ZQ==
X-Gm-Message-State: AOUpUlFa3og1iQSN5+iOsii05IYtNJFu20njVCNnBagj7Tz4FYxvZsOV
        eXLaYMjJoRnCHltwbYnf+j1M1B0ROFTtgwAC66FZo9Mm
X-Google-Smtp-Source: AAOMgpf9H+RuqdYOwhJyzZDELpDImPqmgReAAuFrS7RYxnfKGoNhpnoVuUtxw8vTSyhD4QAHYXqd6ah437e8qSvkY9Q=
X-Received: by 2002:a63:4c21:: with SMTP id z33-v6mr19125190pga.383.1533652622018;
 Tue, 07 Aug 2018 07:37:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3541:0:0:0:0 with HTTP; Tue, 7 Aug 2018 07:37:01
 -0700 (PDT)
In-Reply-To: <20180807132113.118297-1-gitter.spiros@gmail.com>
References: <20180807132113.118297-1-gitter.spiros@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 7 Aug 2018 16:37:01 +0200
Message-ID: <CAN0heSrsHNnZoMFF+v+Fc_Ketk3fnQsnM=BuYVwkT5DPRjHsLw@mail.gmail.com>
Subject: Re: [PATCH] worktree: add --quiet option
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elia

On 7 August 2018 at 15:21, Elia Pinto <gitter.spiros@gmail.com> wrote:
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

Grepping through Documentation/, it is clear that we sometimes have a
blank line here, sometimes not. I'm not sure what to make of that.

> +-q::
> +--quiet::
> +       With 'add', suppress feedback messages.
>  -f::

But I do think that for consistency, we'd prefer a blank line before `-f::`.

Both the commit message and this documentation makes me wonder if this
focuses on "add" because it's the only subcommand where `--quiet` makes
sense, conceptually, or because this is where you happen to need it
personally, or due to some other $reason. Could you say something more
about this?

I'm not a worktree power-user, so please forgive my ignorance...

> @@ -315,6 +316,9 @@ static int add_worktree(const char *path, const char *refname,
>                 cp.argv = NULL;
>                 argv_array_clear(&cp.args);
>                 argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               if (opts->quiet)
> +                       argv_array_push(&cp.args, "--quiet");
> +               printf("%s\n","soo qia");

This last line looks like debug cruft.

> @@ -437,6 +441,7 @@ static int add(int ac, const char **av, const char *prefix)
>                 OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
>                 OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
>                 OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
> +               OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),

This matches other users. Good.

I did some simple testing and this appears to be quite quiet, modulo
the "soo qia" that I already mentioned. Could you add a test to
demonstrate the quietness and to keep it from regressing? Something like
`git worktree add ../foo >out && test_must_be_empty out" in e.g.,
t2025-worktree-add.sh might do the trick (capture stderr as well?).

Hope this helps
Martin
