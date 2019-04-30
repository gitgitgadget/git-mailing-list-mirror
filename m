Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362A91F453
	for <e@80x24.org>; Tue, 30 Apr 2019 03:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfD3DMU (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 23:12:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46162 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfD3DMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 23:12:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so11282458ljk.13
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sB9NiW2ja0DTb+ZIl02y0wuszyBibD7T4ZAHda5D+6E=;
        b=QtRwFnbMXiJ2oRqkgQIF7rSyjUiFu7ZiJfIrGzNFyB231S6CabVD5ETutg13Qx9W6Q
         Idmwqj9ggGRnYbznByN/u9u9eK3N5x3Nvg3evfsA7nZvZ/mKSHqh7ThML9szShg0gKVk
         6LGH2oaI2lD4LFAKQoSv7CJ7LH5mM7L12yJDBuVW3Ka8zphpQeoK9JB3yvgoe2U7Visp
         yT+uWK/oo55vVemehvInFm139X3uTH0Lan52O6t9XPcHzXBPSnMDcbsbY0Ciyc5NHxoR
         /WumO+mS/tVhyziylK5DAg6U7JvnaFmNz88q2IiCshdknyRxgy1IfMn+v9aaCVqDvpWO
         FeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sB9NiW2ja0DTb+ZIl02y0wuszyBibD7T4ZAHda5D+6E=;
        b=bfM+gt/LU46zDWHj0I3LE4RzrTM7Ik13BzOQsJIb3QKXCdxq3YfyE7RgpW7BM89CS5
         +sTBp64zy13if6t18D7n7XlK1whjEboYO3gIx54RrYcpRvu/2RAgEGEwjxNbC7WvRwEu
         KLsCpUkNpskEDs6gCKSEWf0+Y+1rZNKwon/XHQNGtLdUtBVJ8r+NSvuTsJFKAeMalpG5
         NyigEDTcUBEzYAD6veIXF/Buq7x4gtv6RZwTgUo4Ip2zEEYpTs3iRR0rdES1Jq6d4CJB
         FGvssj9v4kiy68wKXValEIHpKB4zfn5RGk+A98STLSBGfQNTagROWCu+3w4n4fUGGLqc
         u/Ig==
X-Gm-Message-State: APjAAAXESj9c8aXicj+SOIDezbUCGaJFJTj9e6E2jM7en+pa3HqGHA6+
        us3kVKb/8l4sX2IkF7mP7zBdAvEPLtXZvnRQxv2SvZFr
X-Google-Smtp-Source: APXvYqzS522elCB0E6nsDfXM5pDCqoFvcCvZz+/2XxZiJ2Rh7yMTaF0kOYLWHVCH59ZDAD96QsrHNi3FraTFUou4R18=
X-Received: by 2002:a2e:498:: with SMTP id a24mr6306908ljf.34.1556593937627;
 Mon, 29 Apr 2019 20:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091837.50290-1-johnlinp@gmail.com>
In-Reply-To: <20190423091837.50290-1-johnlinp@gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 29 Apr 2019 20:12:05 -0700
Message-ID: <CABURp0rSTT=8biNhBvsGP4fdEHBT4B5beVKsm=Mdp7Ei8Dw72w@mail.gmail.com>
Subject: Re: [PATCH] status: add an empty line when there is no hint
To:     John Lin <johnlinp@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You should probably add some test that demonstrates what your change
intends to do.  For that matter, though, your test already breaks at
least two tests in t7508-status.sh:

not ok 14 - status (advice.statusHints false)
not ok 23 - status -uno (advice.statusHints false)

Phil

On Tue, Apr 23, 2019 at 2:21 AM John Lin <johnlinp@gmail.com> wrote:
>
> When typing "git status", there is an empty line between
> the "Changes not staged for commit:" block and the list
> of changed files. However, when typing "git commit" with
> no files added, there are no empty lines between them.
>
> This patch adds empty lines in the above case and some
> similar cases.
>
> Signed-off-by: John Lin <johnlinp@gmail.com>
> ---
>  wt-status.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 445a36204a..0766e3ee12 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -175,7 +175,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
>         }
>
>         if (!s->hints)
> -               return;
> +               goto conclude;
>         if (s->whence != FROM_COMMIT)
>                 ;
>         else if (!s->is_initial)
> @@ -193,6 +193,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
>         } else {
>                 status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
>         }
> +conclude:
>         status_printf_ln(s, c, "%s", "");
>  }
>
> @@ -202,13 +203,14 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
>
>         status_printf_ln(s, c, _("Changes to be committed:"));
>         if (!s->hints)
> -               return;
> +               goto conclude;
>         if (s->whence != FROM_COMMIT)
>                 ; /* NEEDSWORK: use "git reset --unresolve"??? */
>         else if (!s->is_initial)
>                 status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
>         else
>                 status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
> +conclude:
>         status_printf_ln(s, c, "%s", "");
>  }
>
> @@ -220,7 +222,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
>
>         status_printf_ln(s, c, _("Changes not staged for commit:"));
>         if (!s->hints)
> -               return;
> +               goto conclude;
>         if (!has_deleted)
>                 status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
>         else
> @@ -228,6 +230,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
>         status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
>         if (has_dirty_submodules)
>                 status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
> +conclude:
>         status_printf_ln(s, c, "%s", "");
>  }
>
> @@ -238,8 +241,9 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
>         const char *c = color(WT_STATUS_HEADER, s);
>         status_printf_ln(s, c, "%s:", what);
>         if (!s->hints)
> -               return;
> +               goto conclude;
>         status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
> +conclude:
>         status_printf_ln(s, c, "%s", "");
>  }
>
> --
> 2.21.0
>
