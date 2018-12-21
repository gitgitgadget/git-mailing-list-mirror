Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B901F405
	for <e@80x24.org>; Fri, 21 Dec 2018 05:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbeLUFYY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 00:24:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34290 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLUFYY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 00:24:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so4130253otk.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 21:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=im0onbRFbXUhHOE5WniJQCN+s84r9pvIEX1YJ+iJkyk=;
        b=X371CGssiuKn7B7n7D+xh7mlTR5axl0e02aoDGiVEUcEAWNoasrD6fDyjyrYqCvSYr
         SkvTz+157komC2MDFA/nZkhD49drIvtb/nYSZAluBjzoBt/0Ftj49MEgB0wYC7YjMb+b
         KR5CZFZ5HLzxkhyucaeF7/Vy4aSYwt/LAJmsrXh8YJXIJkaNIgzRMLU78RaFrY2VlAb0
         cf3lasjDez/bKjl/wA0pfQN6/NZaNLEQR8PInUQt/n9rMOUsod5AqpjDM7kbqYyH6cTA
         4NWn3fVSXosfOdvjlHo+/QIQ8/L3bw/QIoZUoFqxXKa+k3E4+bM+Z4bH7j7VzM067c5X
         LnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im0onbRFbXUhHOE5WniJQCN+s84r9pvIEX1YJ+iJkyk=;
        b=AnKqelrqZT9HkLTk9OQOyxa+9s3qkBL/duCBKgW7tqRrBmzJPGWw40dm/1qHND3gsx
         0YPciu1tjI2FfaxhaSSKxgKUlwcTAlPDRcWrl8Gu6okSteesr8vUNo1A04IDihKcrkSK
         IcZgbDA0mzmrrq8evhgv1xXog1446QWSktbDQ/pQXlEYZu1CJepDZvzanTzTEeqIKqpa
         xrCHkMT16zdbIFEspSHlXOhdUGPRoOYD0z0ACZp1Fm0dfM6rZIeEO9WYRR7q9QnjDzaa
         t0y3Q04K+DXHOflpjxAGw9py59yW2V5cfnefrjdc3Dqf3YOXSkl7Gcb9eydBtrVN41OD
         fUKg==
X-Gm-Message-State: AJcUuke32HVEmBYpxMK3L9mcU+Lb4Q09ZJMXgQsLw2AmAwA+uIn+L4jG
        B+HuGreQli43vVN3wwb+z50Lxj8Z+TzyMXBWoTXiUA==
X-Google-Smtp-Source: ALg8bN7T8URoP6E71XILM7JSdfQmd30gdlBgaoAn6B1pa94NRXLdNLInrgsiiNztI590DPXwZ60s3IDRxlgsROKcgvU=
X-Received: by 2002:a9d:738a:: with SMTP id j10mr712276otk.188.1545369861930;
 Thu, 20 Dec 2018 21:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20181219083305.2500-1-issac.trotts@gmail.com>
In-Reply-To: <20181219083305.2500-1-issac.trotts@gmail.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Thu, 20 Dec 2018 21:24:10 -0800
Message-ID: <CANdyxMyz3u+ajH0X7BPJBPBT0iepWhunA_VA+HEGFrurYghSWQ@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     git@vger.kernel.org
Cc:     Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, friendly ping. Is there still interest in merging this patch?

Thanks,
Issac

On Wed, Dec 19, 2018 at 12:33 AM <issac.trotts@gmail.com> wrote:
>
> From: Issac Trotts <issac.trotts@gmail.com>
>
> Make it possible to write for example
>
>         git log --format="%H,%S"
>
> where the %S at the end is a new placeholder that prints out the ref
> (tag/branch) for each commit.
>
> Using %d might seem like an alternative but it only shows the ref for the last
> commit in the branch.
>
> Signed-off-by: Issac Trotts <issactrotts@google.com>
>
> ---
>
> This change is based on a question from Stack Overflow:
> https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
> ---
>  Documentation/pretty-formats.txt |  2 ++
>  builtin/log.c                    |  2 +-
>  log-tree.c                       |  1 +
>  pretty.c                         | 15 ++++++++++
>  pretty.h                         |  1 +
>  t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
>  6 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 417b638cd..de6953108 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -134,6 +134,8 @@ The placeholders are:
>  - '%cI': committer date, strict ISO 8601 format
>  - '%d': ref names, like the --decorate option of linkgit:git-log[1]
>  - '%D': ref names without the " (", ")" wrapping.
> +- '%S': ref name given on the command line by which the commit was reached
> +  (like `git log --source`), only works with `git log`
>  - '%e': encoding
>  - '%s': subject
>  - '%f': sanitized subject line, suitable for a filename
> diff --git a/builtin/log.c b/builtin/log.c
> index e8e51068b..be3025657 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>             rev->diffopt.filter || rev->diffopt.flags.follow_renames)
>                 rev->always_show_header = 0;
>
> -       if (source) {
> +       if (source || (rev->pretty_given && (rev->commit_format == CMIT_FMT_USERFORMAT) && w.source)) {
>                 init_revision_sources(&revision_sources);
>                 rev->sources = &revision_sources;
>         }
> diff --git a/log-tree.c b/log-tree.c
> index 10680c139..3cb14256e 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -700,6 +700,7 @@ void show_log(struct rev_info *opt)
>         ctx.color = opt->diffopt.use_color;
>         ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
>         ctx.output_encoding = get_log_output_encoding();
> +       ctx.rev = opt;
>         if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
>                 ctx.from_ident = &opt->from_ident;
>         if (opt->graph)
> diff --git a/pretty.c b/pretty.c
> index b83a3ecd2..258e86e9c 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1084,6 +1084,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>         struct commit_list *p;
>         const char *arg;
>         int ch;
> +       char **slot;
>
>         /* these are independent of the commit */
>         switch (placeholder[0]) {
> @@ -1194,6 +1195,17 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>                 load_ref_decorations(NULL, DECORATE_SHORT_REFS);
>                 format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
>                 return 1;
> +       case 'S':               /* tag/branch like --source */
> +               if (c->pretty_ctx->rev->sources == NULL) {
> +                       return 0;
> +               }
> +               slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> +               if (slot && *slot) {
> +                       strbuf_addstr(sb, *slot);
> +                       return 1;
> +               } else {
> +                       die(_("failed to get info for %%S"));
> +               }
>         case 'g':               /* reflog info */
>                 switch(placeholder[1]) {
>                 case 'd':       /* reflog selector */
> @@ -1498,6 +1510,9 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
>         case 'N':
>                 w->notes = 1;
>                 break;
> +       case 'S':
> +               w->source = 1;
> +               break;
>         }
>         return 0;
>  }
> diff --git a/pretty.h b/pretty.h
> index 7359d318a..87ca5dfcb 100644
> --- a/pretty.h
> +++ b/pretty.h
> @@ -60,6 +60,7 @@ static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
>
>  struct userformat_want {
>         unsigned notes:1;
> +       unsigned source:1;
>  };
>
>  /* Set the flag "w->notes" if there is placeholder %N in "fmt". */
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 978a8a66f..7df8c3d4e 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -621,4 +621,54 @@ test_expect_success 'trailer parsing not fooled by --- line' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'set up %S tests' '
> +       git checkout --orphan source-a &&
> +       test_commit one &&
> +       test_commit two &&
> +       git checkout -b source-b HEAD^ &&
> +       test_commit three
> +'
> +
> +test_expect_success 'log --format=%S paints branch names' '
> +       cat >expect <<-\EOF &&
> +       source-b
> +       source-a
> +       source-b
> +       EOF
> +       git log --format=%S source-a source-b >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'log --format=%S paints tag names' '
> +       git tag -m tagged source-tag &&
> +       cat >expect <<-\EOF &&
> +       source-tag
> +       source-a
> +       source-tag
> +       EOF
> +       git log --format=%S source-tag source-a >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'log --format=%S paints symmetric ranges' '
> +       cat >expect <<-\EOF &&
> +       source-b
> +       source-a
> +       EOF
> +       git log --format=%S source-a...source-b >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '%S in git log --format works with other placeholders (part 1)' '
> +       git log --format="source-b %h" source-b >expect &&
> +       git log --format="%S %h" source-b >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '%S in git log --format works with other placeholders (part 2)' '
> +       git log --format="%h source-b" source-b >expect &&
> +       git log --format="%h %S" source-b >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.19.1
>
