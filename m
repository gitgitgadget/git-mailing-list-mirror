Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0791FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdEaSkD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:40:03 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33324 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdEaSkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:40:01 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so14809765pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9ZXtGAHn8YUlsoc/Qa2lqN90+lzkN/BEkZVpeTyrkac=;
        b=OlGBBuu/ttmC6vol+OtYgb59e7eEje3XLiZTGTTJVilXZPvwUjVlTUPfwD8IDoj7Tg
         eDXUyn2qZvFMCo3gjnYUAnXDYc0JQbFZVUZBKHdPKtZdbQXEHIXFg9NdVvq3zZ886bUC
         vRnX646nXzPF5iYduBmNoEMRZVHBpc2yysgyAS6yc0U47QjlzZjmVaEzs9LnGBTIOZVR
         10ITW9qN9MU+SAiO+77YWRCEPiwOiv9VVy+hhn9Ca4WGwOKWFuA4FbzdYRUXFfnRrdFH
         i124DuHU727gp5sIl+xkeVH+1ONBdKLKCt8b7Z7kQZguFYbsFl7OQoTo6AJTJ8gDqvax
         iMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9ZXtGAHn8YUlsoc/Qa2lqN90+lzkN/BEkZVpeTyrkac=;
        b=JtSqjjTqNrJ0Xnoei2eUEUSHOtMnYfTE/1/SodyN354m+Qn8MxT+Ugf7gUDVjFgO1X
         fX9YfhQXtWnrLaAwxNIaZlQfXRVmuK2bZM5rFNepMVgjYWD0inQW9r2Ror1XjkLAqI7z
         kcCqkCFEfFOiVK778FljxiimrHHCRX4zIunstKzffryoe8NwWhQQdQzIQNbh2bnJ6JtQ
         csVAOTYVWa4Gf49ynznbE7yq7Z4jdaX8EhJw6IgeFDjBTVMyspF/9MWksFNSK8E8cNth
         Y6DmzZj1MSZMIIK36Fyw/SNWacHaCO+eEWifsdygdBJZQ0mALTvaQNgkQFwZi2wvcob4
         Il4A==
X-Gm-Message-State: AODbwcCFFOC5ZAsbPl50Mt0bjTUG8JEiURKIaSxpEapQLgdxQye3x2v/
        u7Z01B8URIA6J8QqdW2Qg/SUSUfF9y03BKo=
X-Received: by 10.84.231.206 with SMTP id g14mr90119231pln.12.1496256001057;
 Wed, 31 May 2017 11:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 11:40:00 -0700 (PDT)
In-Reply-To: <20170531150427.7820-2-kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com> <20170531150427.7820-2-kewillf@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 11:40:00 -0700
Message-ID: <CAGZ79kYVN4JHq273-AWhpFVbOQR=qU6AfPT8O16N+9siacXvqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] format-patch: have progress option while generating patches
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 8:04 AM, Kevin Willford <kcwillford@gmail.com> wrote:
> When generating patches for the rebase command if the user does
> not realize the branch they are rebasing onto is thousands of
> commits different there is no progress indication after initial
> rewinding message.
>
> This patch allows a progress option to be passed to format-patch
> so that the user can be informed the progress of generating the
> patch.  This option will then be used by the rebase command when
> calling format-patch.

After reading the code, I was looking for some explanation
on the underlying assumptions, such as:

  The progress meter as presented in this patch assumes the thousands of
  patches to have a fine granularity as well as assuming to require all the
  same amount of work/time for each, such that a steady progress bar
  is achieved.

  We do not want to estimate the time for each patch based e.g.
  on their size or number of touched files (or parents) as that is too
  expensive for just a progress meter.


>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  Documentation/git-format-patch.txt |  8 ++++++++
>  builtin/log.c                      | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index c890328b02..ee5f99f606 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -23,6 +23,7 @@ SYNOPSIS
>                    [(--reroll-count|-v) <n>]
>                    [--to=<email>] [--cc=<email>]
>                    [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
> +                  [--progress]
>                    [<common diff options>]
>                    [ <since> | <revision range> ]
>
> @@ -260,6 +261,7 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  -q::
>  --quiet::
>         Do not print the names of the generated files to standard output.
> +       Progress is not reported to the standard error stream.
>
>  --no-binary::
>         Do not output contents of changes in binary files, instead
> @@ -283,6 +285,12 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>         range are always formatted as creation patches, independently
>         of this flag.
>
> +--progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless -q
> +       is specified. This flag forces progress status even if the
> +       standard error stream is not directed to a terminal.
> +
>  CONFIGURATION
>  -------------
>  You can specify extra mail header lines to be added to each message,
> diff --git a/builtin/log.c b/builtin/log.c
> index 631fbc984f..02c50431b6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -26,6 +26,7 @@
>  #include "version.h"
>  #include "mailmap.h"
>  #include "gpg-interface.h"
> +#include "progress.h"
>
>  /* Set a default date-time format for git log ("log.date" config variable) */
>  static const char *default_date_mode = NULL;
> @@ -1409,6 +1410,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>         char *branch_name = NULL;
>         char *base_commit = NULL;
>         struct base_tree_info bases;
> +       int show_progress = 0;
> +       struct progress *progress = NULL;
>
>         const struct option builtin_format_patch_options[] = {
>                 { OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
> @@ -1480,6 +1483,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 OPT_FILENAME(0, "signature-file", &signature_file,
>                                 N_("add a signature from a file")),
>                 OPT__QUIET(&quiet, N_("don't print the patch filenames")),
> +               OPT_BOOL(0, "progress", &show_progress,
> +                        N_("show progress")),
>                 OPT_END()
>         };
>
> @@ -1739,8 +1744,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 start_number--;
>         }
>         rev.add_signoff = do_signoff;
> +
> +       if (show_progress && !quiet)
> +               progress = start_progress(_("Generating patch"), total);
>         while (0 <= --nr) {
>                 int shown;
> +               display_progress(progress, total - nr);
>                 commit = list[nr];
>                 rev.nr = total - nr + (start_number - 1);
>                 /* Make the second and subsequent mails replies to the first */
> @@ -1805,6 +1814,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 if (!use_stdout)
>                         fclose(rev.diffopt.file);
>         }
> +       stop_progress(&progress);
>         free(list);
>         free(branch_name);
>         string_list_clear(&extra_to, 0);
> --
> 2.13.0.92.g73a4ce6a77
>
