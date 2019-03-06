Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A1020248
	for <e@80x24.org>; Wed,  6 Mar 2019 20:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCFUWP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 15:22:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34140 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFUWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 15:22:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so9511374pfn.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/tetHfrfBh6gyaj4Z6FzZauWEZRvxgokPznI0+PMZA=;
        b=Owfth7/5d7iVOBg4uzhSkcEVaJAkMwowcMxrN8Bh4VLyFljc9loZJARzgxR2J6mnaW
         MJd8HwBXKWDX8RM+E4Owsb7L/J91vdZT9W3Q7fPNLoFO0+4bhg/zicjo+p0p0bjX+fds
         Hqz50nuy14CD6eZY32UlRKOzz7QJLqBz7/8QzeGXFjYa7hFcpnyILkXbZVUxeNT1KvE/
         mOZ4RZZhqBm/wkGuNYXaDvxDE9my68CdKOMtuZM45YRVepL+hOkCXbegqW493dDSz5F8
         Wwdkz/fmEG0OOwfLiBHVjgs9ANV2RjY1jMRc0jy0ThguVRRda2gI+SG1Q1SpMsdx8IWo
         0J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/tetHfrfBh6gyaj4Z6FzZauWEZRvxgokPznI0+PMZA=;
        b=me4U42dzl/QwawLM2bU5rZJSbN86dF58GmkH9ByqZm9cBXWB4OjFNmLJOdBf9rbdBQ
         C97ycHHETaNLYP9hj3HyW/H7RjoTTV/VPtkj619/UNpw+WgNl3o8XvNIbuKNi3EqZt18
         Lk5KtaO8y0isSnGWCZo1ptamoUthZEZQaMU9ctTh4Qb0EezByWDF5vstjpPHRrFjOjiQ
         gHDh8wlcBobrXIbZyoPHXxunT7i8prvyOpFvrVQ5+CprBVk69i1wwQtIx83I3T2yzVDn
         KVyRsbv6vHuKXxBx9htcjuGjJCqx476n3v+eyRenRG/YiOrEE27jspro/22ktTjA5igB
         UmTw==
X-Gm-Message-State: APjAAAWlCKOniel1Q3B51jqWmQcWDWwCKuwF3hPms6iyL8ntoSk0pL3F
        qFZ3zGegz9Vh5YxsGGz1HKeQaCGh6rejf1nN8dg=
X-Google-Smtp-Source: APXvYqxlxDTf/8V1p/bH/LCBgXrQz3czfJsLSXl13EM3nraOS1bOPQkia8Gkd7gjp75dvonwxozDLTfOMnskhVkWHhA=
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr8732688plk.105.1551903733363;
 Wed, 06 Mar 2019 12:22:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551868745.git.liu.denton@gmail.com> <f8bc322cc5727d9cf45037f4231f88956f07b7f3.1551868745.git.liu.denton@gmail.com>
In-Reply-To: <f8bc322cc5727d9cf45037f4231f88956f07b7f3.1551868745.git.liu.denton@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 6 Mar 2019 21:22:01 +0100
Message-ID: <CAN0heSqTCQaTgWq4+-dxP0DFjtL=syq_W=T0cb66-2YPB4Tc-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-clean.txt: specify core.excludesFile variable is used
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 6 Mar 2019 at 12:17, Denton Liu <liu.denton@gmail.com> wrote:
>
> In the git-clean documentation, -x and -e documented .gitignore,
> $GIT_DIR/info/excludes but neglected to mention the file pointed to by
> core.excludesFile.

Nit: I suppose it doesn't so much document it, as mention it. So

  In the git-clean documentation, we mention .gitignore and
  $GIT_DIR/info/excludes, but neglect to mention the file pointed to by
  core.excludesFile.

perhaps.

> Explicitly mention that variable so that the list is exhaustive.

>  -e <pattern>::
>  --exclude=<pattern>::
> -       In addition to those found in .gitignore (per directory) and
> -       $GIT_DIR/info/exclude, also consider these patterns to be in the
> +       In addition to those found in .gitignore (per directory),
> +       $GIT_DIR/info/exclude, and the `core.excludesFile` variable, also
> +       consider these patterns to be in the
>         set of the ignore rules in effect.

The commit message correctly phrases it as "the file pointed to by",
whereas this could give the impression that the config variable is
supposed to provide patterns, not a filename. But if the choice is
between creating a longer, more language-lawyer-correct phrasing and a
shorter one that everyone will understand, I'll choose the latter any
day.

But on the topic of preferring shorter, I sort of wonder if we really
need to provide all of those filenames here. The point we're trying to
make is that we consider another source. So something like this would be
just as technically correct, I think:

  Use the given exclude pattern in addition to those found in .gitignore
  and similar files (see linkgit:gitignore[5]).

This also places the interesting (IMHO) part of the sentence at the
front, rather than at the end.

From gitignore(5), I get the impression that patterns provided using
`--exclude` take precedence over those found in those files we're
listing. Whether or not that is the case here might perhaps be more
interesting than the exact list of files. Does that make sense?

>  -x::
>         Don't use the standard ignore rules read from .gitignore (per
> -       directory) and $GIT_DIR/info/exclude, but do still use the ignore
> +       directory), $GIT_DIR/info/exclude, and the `core.excludesFile`
> +       variable, but do still use the ignore
>         rules given with `-e` options.  This allows removing all untracked
>         files, including build products.  This can be used (possibly in
>         conjunction with 'git reset') to create a pristine

Nit: Not new in this patch, but I think you could add a few `backticks`
while you're here to render things like `.gitignore` and
`$GIT_DIR/info/exclude/` in monospace.

Martin
