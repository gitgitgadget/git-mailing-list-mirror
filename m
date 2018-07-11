Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114EC1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbeGKRKQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:10:16 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40438 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbeGKRKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:10:16 -0400
Received: by mail-ua0-f194.google.com with SMTP id p22-v6so6073041uao.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CU+o6pqlLVey1NIyReRwq6VhNCCPfmSERS6iVtdIlwY=;
        b=kDfFndXlKqeNcDN0zhZjCRzbTSffdQf+uqN33kyk3x96W5t3kYUEXY6KyxA+A9mksh
         ZMJYezA0sLx7yW6vKwjd6Bo44ikq7xpdvjJ+yn8OPT4kQbdwUYnHN1r4TMawSMXdE9y+
         ItW9ir3vWT67Xo0eZk6uYraxCfD7/Vi6GR9d37Cv/JAqjGFyb6JSHmHamsSfQjJGsTRT
         gR2s+BSI0CFGIlLAGcQIfUi3tSsy2FfSzFzgzR5HFJhdBpL7D0+9gIfPaDx4DWZi90JB
         bh/riheQbDiaTUKOwA6ajT79+hqeTvcUSG9a43eoeuElsEySAhCPkTzvOqM53by5Ed5X
         cmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CU+o6pqlLVey1NIyReRwq6VhNCCPfmSERS6iVtdIlwY=;
        b=fRoY05NZ6Wd/xtiSSCRuKzo7lfMvWzEmp1v8Y4Vy2uKToRtASvU++HlqeBGqcAM6FW
         0gOS0UG39PJZouskpYwC+63aHBT2+y+iS67a13SPnfICuIJNN1rjBlTXA2YVcRsijEJh
         1I7xBdajvro1+THRi3N3yS/GujTVwp5IqPc1iBakd+9rynks7nqJLt3fuzFEstjjk9ld
         eRdzgrbrwtX/ji+YfGU44TCJznsTJlMqy+MqVR8BhVkBwyxeUeZo7Efk7NTDoBLei57R
         FAIQ9IL+cQgILpQ7sxKGc9gxG4J4xv6urFPpq0Y29PY6/gvDV8H6HFFwLa44RA9Db42p
         zgGw==
X-Gm-Message-State: APt69E2wI8QPdDFBMwGtEHuKxYB50Y7JaHWFKZVutuRosbFerFhKIWtg
        vu+oVKJ6+hqeNhtlNRsfaTIE+/ssuicuMltgf40=
X-Google-Smtp-Source: AAOMgpdP1H4GRdPBptABSqDe9hPO0azmPlGRyjooFOxKuPj8vKp+vOAs5UOaWhG+1TS8FEpcIcIBPA1NI3lla55b9QE=
X-Received: by 2002:ab0:4f26:: with SMTP id n38-v6mr4836776uah.29.1531328700928;
 Wed, 11 Jul 2018 10:05:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:05:00
 -0700 (PDT)
In-Reply-To: <20cd1b914e74c8f45e5cc9ed82d83eee1463cd91.1531312689.git.gitgitgadget@gmail.com>
References: <pull.8.git.gitgitgadget@gmail.com> <20cd1b914e74c8f45e5cc9ed82d83eee1463cd91.1531312689.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jul 2018 10:05:00 -0700
Message-ID: <CABPp-BFMKnTMYTd3mK69wZ7__TZTwoF9NmX+RXwyqgUj7NJ0Kw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rebase --rebase-merges: adjust man page for octopus support
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Mar 9, 2018 at 8:36 AM, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Now that we support octopus merges in the `--rebase-merges` mode,
> we should give users who actually read the manuals a chance to know
> about this fact.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-rebase.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0e20a66e7..c4bcd24bb 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -879,8 +879,8 @@ rescheduled immediately, with a helpful message how to edit the todo list
>  (this typically happens when a `reset` command was inserted into the todo
>  list manually and contains a typo).
>
> -The `merge` command will merge the specified revision into whatever is
> -HEAD at that time. With `-C <original-commit>`, the commit message of
> +The `merge` command will merge the specified revision(s) into whatever
> +is HEAD at that time. With `-C <original-commit>`, the commit message of
>  the specified merge commit will be used. When the `-C` is changed to
>  a lower-case `-c`, the message will be opened in an editor after a
>  successful merge so that the user can edit the message.
> @@ -889,7 +889,8 @@ If a `merge` command fails for any reason other than merge conflicts (i.e.
>  when the merge operation did not even start), it is rescheduled immediately.
>
>  At this time, the `merge` command will *always* use the `recursive`
> -merge strategy, with no way to choose a different one. To work around
> +merge strategy for regular merges, and `octopus` for octopus merges,
> +strategy, with no way to choose a different one. To work around

The "...merges, strategy, with..." looks like an incomplete edit.
Perhaps "...and `octopus` strategy for octopus merges, with no way..."
?

>  this, an `exec` command can be used to call `git merge` explicitly,
>  using the fact that the labels are worktree-local refs (the ref
>  `refs/rewritten/onto` would correspond to the label `onto`, for example).
> --
> gitgitgadget
