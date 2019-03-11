Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6349320248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCKQAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:00:34 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:50839 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKQAd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:00:33 -0400
Received: by mail-it1-f176.google.com with SMTP id m137so8093892ita.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dSNuZb1/ljO4yJZ4LXGJdbQjozOL1TLwGNf3UBDfF88=;
        b=CZMMgKMsIy7hLlLY+mw3+PDYzG+mtPzgJR8eR3FfLx/BJ8TXS67FBCZUCjrnIu5f6j
         AFGBmbZBYhAzcdcp5JBZwD2inAluDggdJlQSGz3AlaHPZRUyurpyu9cRgb9ozGKz/k1L
         NvkY5oxz5k9RPaHU2sCQf+nk+ibucvNLpqwn8NCRv2iSZvPOuoZjOZXA2pbOGWLYHCqm
         srFl6B0nv+P/lkMG0OrGG25/Tc9SohdENBk3zO1/Xj2uIfM2MIFaULkZrhnQIS/IvWE2
         pgvmtzNq6/9VSpHxc6E/2YuhOPBcwIue4N/sK4GeJWharlZo3HXJ56M5rRDz2JWRJrPY
         QqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dSNuZb1/ljO4yJZ4LXGJdbQjozOL1TLwGNf3UBDfF88=;
        b=ozwz5ZjGAADZ9/OD0uJEIaRiAlOUOhe8lJgibRS4IEujX1VSbXrMYp8rO50dLWHPRD
         HtvoZFozkrRusBRX8B+rsz61AiKVWkIgmsiDUkQcTOzX6j9zt/q/MLOW6Yh/8uFR0gQp
         KdWh26n9y4AZHyIKq0FwoP2CYfEGE0CQzQKnOSN/tD+c+cabTZtJsEKvlPTI+K706DGm
         ipzbou618i3OIK4EayUyU41uhnfTiexJ4HB10mRQk2vaUOfi9EnbtBkoZuum5GXXPc4B
         vSGaRPTdsDgMpmzTv9rA9EFvuZLvflton5he3xtYUJ8GdnFbPLTYEku+YHQc51T7jrgL
         YJHw==
X-Gm-Message-State: APjAAAXyk4W5R1Dq9CEQzjIJ4+0gO4ZygbGqJSgIPHc6iDF/fMu3huP0
        1AqPXb2UpC1PJswIgPnqOWHjRMfhBKTnCNCCEJAAlUBz
X-Google-Smtp-Source: APXvYqzsWyx21IiSsWbGYDuqElXTcTdpkgZsDwzjoBsm68mUdd3NJ6HPhbYl9jX3PDA8jhwlIkHiAXYIppDO4E/w39I=
X-Received: by 2002:a24:4202:: with SMTP id i2mr239275itb.85.1552320031615;
 Mon, 11 Mar 2019 09:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAN=4vMp1+=hmdRiuC1Y-4w2iKbSuwgAi54ozDzK2dGwn7J=QUQ@mail.gmail.com>
In-Reply-To: <CAN=4vMp1+=hmdRiuC1Y-4w2iKbSuwgAi54ozDzK2dGwn7J=QUQ@mail.gmail.com>
From:   Roman Perepelitsa <roman.perepelitsa@gmail.com>
Date:   Mon, 11 Mar 2019 17:00:20 +0100
Message-ID: <CAN=4vMpN2UrZvJSedCyP=oh7aXTj5hWg9Yq6tfdTxMd895Rpxg@mail.gmail.com>
Subject: Re: Refresh index without discard_index + repo_read_index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the end I managed to patch diffing code in libgit2
(git_diff_tree_to_index and git_diff_index_to_workdir) to make it
about 4x faster. It's now faster than `git status`, so good enough for
me.

I'm still curious whether it's possible to refresh index in git (not
libgit2), so please chime if if you know.

Roman.

On Sat, Mar 9, 2019 at 8:59 PM Roman Perepelitsa
<roman.perepelitsa@gmail.com> wrote:
>
> I=E2=80=99m writing a program that reads stdin in a loop and prints the
> equivalent of `git status` whenever it reads a character. It always
> prints its results for the same repository, the same pathspec, etc.
> The input characters have no effect on the output, only the sate of
> the repository does.
> I=E2=80=99m hoping that I can make it produce results faster than a bash
> script that literally calls `git status` in a loop. I=E2=80=99m thinking =
that
> maybe I can keep some caches around so that I don=E2=80=99t have to redo =
all
> the work on every iteration that git status does.
>
> What I cannot figure out is how to refresh the index so that it picks
> up all the changes that might have happened to the repository and
> workdir since the last iteration. Here=E2=80=99s what I have:
>
> ```c
> #include <stdio.h>
> #include <string.h>
>
> #define USE_THE_INDEX_COMPATIBILITY_MACROS
> #include "cache.h"
> #include "wt-status.h"
> #include "pathspec.h"
> #include "repository.h"
>
> int cmd_multi_status(int argc, const char** argv, const char* prefix) {
>   struct pathspec pathspec;
>   memset(&pathspec, 0, sizeof(pathspec));
>   repo_read_index(the_repository);
>   while (getchar() !=3D EOF) {
>     refresh_index(&the_index,
>                   REFRESH_QUIET | REFRESH_UNMERGED | REFRESH_REALLY,
>                   &pathspec, NULL, NULL);
>     int uncommitted =3D has_uncommitted_changes(the_repository, 1);
>     int unstaged =3D has_unstaged_changes(the_repository, 1);
>     int untracked =3D has_untracked(the_repository);  // I added this to
> wt-status.h
>     printf("%d %d %d\n", uncommitted, unstaged, untracked);
>   }
>   return 0;
> }
> ```
>
> This produces correct results on the first iteration but then it
> doesn=E2=80=99t pick up all changes. I=E2=80=99ve hacked some code in pre=
load-index.c
> and cache.c so that it picks up more changes but I still cannot detect
> when an unstaged file becomes uncommitted or the other way around.
>
> Any pointers would be greatly appreciated.
>
> Roman.
>
> P.S.
>
> I have working code that uses libgit2. Updating the index with
> `git_index_read(index, 0)` works as expected and is indeed faster than
> discarding the index and starting from scratch. But it's still slower
> than `git status` on large repositories, especially with many ignored
> files.
