Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49FD1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfJKW0T (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:26:19 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:32932 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbfJKW0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:26:18 -0400
Received: by mail-vk1-f194.google.com with SMTP id s21so2470432vkm.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2w9pzp5UGXzT86xmjGtkgrug5s61ye9xMN+ikDkTZPA=;
        b=SvMU+W3C4dldK+vyzpOj8G3oqI9MWMNAA9A8wddvpWrz5FUwy4ZHGHrpqwCy00alIS
         hJSVGDoBN7kzCqhDaFea439FgDQ2RKz7BkpMimoKkeyuGoP7lf7C1TSgyHG/qWfxxc/c
         u9+3cp6tGlP3oKWqZWUL97eljGX88szI0A3Fz5vLtmyKsX0uFV2aix33kK/ygf5qygno
         0V/p3Vg3ex+8+M89WV7ZoNhqFNBp6J9ieO9jIbqmCnz+0BGNS2OJsvy79iFjaJiFFQq1
         ehqdO0DvPjq+lR0T7xU6uiXT4xU8/QZurz73rGNsQwrXCvAXPgn6TZu8cr2wK0C4GksY
         vwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2w9pzp5UGXzT86xmjGtkgrug5s61ye9xMN+ikDkTZPA=;
        b=XsCB6qftFSRcpWdzCcG8ze1rgjOAbvNtzNh5GoVHU1nHuiEY/cOc7Ei68RxNaJ1j2i
         SSygL+1pYjY6EsrycNScSrBB/ZW14QT/Y0SOSz9hpM3KCce3n/1edLPxbToqTJ0r4+z7
         f1MGemTacc/o3utn4gEl+GjM6W3MrUVsO+Kr5MpMU8FjHURNEPhmWPH11ukqD6rXGxg4
         ixU2/ueVQxvpEiE+BoRiAlLaZdxLje2HV6f/RfYzuHpR/uJxs4nRhRUHhJ4m82txgWNl
         dW9yp9yODgihHWhgNyNYvxu5nKUkybGEzOvZsUim5Ur5KO6pmWF1TgMUG5ozXwecFbmD
         pNiw==
X-Gm-Message-State: APjAAAWl7M5mohrTtHs73IqHR9b6MQ1+ew40jQreRL07+PxSsVlAOjio
        5/GW6M5FGa1O4eSjfNsTbEjhSd8b+OrJL/2PMX8=
X-Google-Smtp-Source: APXvYqz8cLJN2nESGYBdNHwdBQ8NRa3uAJUhcqpa8yjL5u7yoJW+kUZGbDYyg7rDWE1xOc0cZtVFao7rLh2P3NgaH54=
X-Received: by 2002:a1f:cac2:: with SMTP id a185mr9572012vkg.49.1570832775873;
 Fri, 11 Oct 2019 15:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <6ce1d60b38a249f8d9f85d1b1a1ed556aef2469e.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <6ce1d60b38a249f8d9f85d1b1a1ed556aef2469e.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:26:04 -0700
Message-ID: <CABPp-BFaSh6O+eMsZ_ghMNUXdwh5kh2P9JF9msQSgz_XG2fENA@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] sparse-checkout: 'set' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'git sparse-checkout set' subcommand takes a list of patterns
> as arguments and writes them to the sparse-checkout file. Then, it
> updates the working directory using 'git read-tree -mu HEAD'.
>
> The 'set' subcommand will replace the entire contents of the
> sparse-checkout file. The write_patterns_and_update() method is
> extracted from cmd_sparse_checkout() to make it easier to implement
> 'add' and/or 'remove' subcommands in the future.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |  5 ++++
>  builtin/sparse-checkout.c             | 35 ++++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh    | 19 +++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index e095c4a98b..f4bd951550 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -39,6 +39,11 @@ and sets the `core.sparseCheckout` setting in the worktree-specific config
>  file. This prevents the sparse-checkout feature from interfering with other
>  worktrees.
>
> +'set'::
> +       Write a set of patterns to the sparse-checkout file, as given as
> +       a list of arguments following the 'set' subcommand. Update the
> +       working directory to match the new patterns.
> +
>  SPARSE CHECKOUT
>  ----------------
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 3ecb7ac2e7..52d4f832f3 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -8,7 +8,7 @@
>  #include "strbuf.h"
>
>  static char const * const builtin_sparse_checkout_usage[] = {
> -       N_("git sparse-checkout [init|list]"),
> +       N_("git sparse-checkout [init|list|set] <options>"),
>         NULL
>  };
>
> @@ -140,6 +140,37 @@ static int sparse_checkout_init(int argc, const char **argv)
>         return update_working_directory();
>  }
>
> +static int write_patterns_and_update(struct pattern_list *pl)
> +{
> +       char *sparse_filename;
> +       FILE *fp;
> +
> +       sparse_filename = get_sparse_checkout_filename();
> +       fp = fopen(sparse_filename, "w");
> +       write_patterns_to_file(fp, pl);
> +       fclose(fp);
> +       free(sparse_filename);
> +
> +       return update_working_directory();
> +}
> +
> +static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> +{
> +       static const char *empty_base = "";
> +       int i;
> +       struct pattern_list pl;
> +       int result;
> +       memset(&pl, 0, sizeof(pl));
> +
> +       for (i = 1; i < argc; i++)
> +               add_pattern(argv[i], empty_base, 0, &pl, 0);
> +
> +       result = write_patterns_and_update(&pl);
> +
> +       clear_pattern_list(&pl);
> +       return result;
> +}
> +
>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  {
>         static struct option builtin_sparse_checkout_options[] = {
> @@ -162,6 +193,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>                         return sparse_checkout_list(argc, argv);
>                 if (!strcmp(argv[0], "init"))
>                         return sparse_checkout_init(argc, argv);
> +               if (!strcmp(argv[0], "set"))
> +                       return sparse_checkout_set(argc, argv, prefix);
>         }
>
>         usage_with_options(builtin_sparse_checkout_usage,
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index d4c145a3af..19e8673c6b 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -101,4 +101,23 @@ test_expect_success 'clone --sparse' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'set sparse-checkout using builtin' '
> +       git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
> +       cat >expect <<-EOF &&
> +               /*
> +               !/*/
> +               *folder*
> +       EOF
> +       git -C repo sparse-checkout list >actual &&
> +       test_cmp expect actual &&
> +       test_cmp expect repo/.git/info/sparse-checkout &&
> +       ls repo >dir  &&
> +       cat >expect <<-EOF &&
> +               a
> +               folder1
> +               folder2
> +       EOF
> +       test_cmp expect dir
> +'
> +
>  test_done
> --

Looks good, thanks for the fixes.  I'm still slightly worried about
folks not looking at the docs and calling sparse-checkout set without
calling init, and then being negatively surprised.  It's a minor
issue, but a warning might be helpful.
