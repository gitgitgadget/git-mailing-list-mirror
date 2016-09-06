Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB0620705
	for <e@80x24.org>; Tue,  6 Sep 2016 01:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbcIFBSN (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 21:18:13 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36476 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbcIFBSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 21:18:12 -0400
Received: by mail-yb0-f196.google.com with SMTP id o63so1201099ybb.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 18:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CBwnfzEjGzZVxA8hXUsIS/WWB9iFKsj0qaxteskJeNA=;
        b=LNkmP7jZ400bEHIUffE9mnVbqxAsJIpAz6FyOF8J8IY2G6u/bQZ2b9dHs+/jKMVuQ1
         y5qpUzfxTp+XzWd+GpPzkOyC7ZZOH2VrpIgg5P0fQg2eyZnDKdZz/tioQ0RfXvoixcE5
         pBmTpl4wBNBBnoIkyRHtvRucrHBNWnMnvxJqxvWo7VLh/jyNGmdip65k/VOB8F6ivjmp
         MooFkbr0J0fh6Cqek6gEJBmGe3uPEBS+t+4BlG8MLBfEjf3yAWKlY8A3DiMqfi+6xwiY
         Qpy+vSyX2Umv7Rywy75HYW8aAzmc614RlqxkubVZVXZsaZqgiidsAm8TVkBsDqKnx8++
         eI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CBwnfzEjGzZVxA8hXUsIS/WWB9iFKsj0qaxteskJeNA=;
        b=fwdyZ2rfda6jhzgZ/5pcasuACmGyXj39EBLG02a5W19NRE8GWbg1/fM7TqsqltkTtC
         4srhF0mFY7C7Ki8YNKA86wHZcDvquLmAqPaBZUZ8AGqgI0P6pHGMx73wDnRHCkCplLUH
         VfPED+lRlDrwrS2UXEZ9XffZwVnHAXWgH8K7xKFCTSEs7dxov2baxxLGNqK5Oixr+xDj
         Z+o95RVU2uBmgePdAbSojQfeLODy//1T80qvZ5FdS2khuqOaIynT8zkP0FtWoy5JXDuG
         rh5ZEini1bV/bPdgOb++/pyQDmkmhGGvqdOa6EeTCEw37Qc9tpRAWyv+xpCSSDP45QpB
         FJbQ==
X-Gm-Message-State: AE9vXwNomb5ojVAv9UpNf0+p4iMjzrwtIlLhfN6V4T07gH+vJbgHzd3GkAu9lw27BARccpzRHELTGpIli06Lvg==
X-Received: by 10.37.194.70 with SMTP id s67mr28986456ybf.51.1473124691629;
 Mon, 05 Sep 2016 18:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 5 Sep 2016 18:17:51 -0700 (PDT)
In-Reply-To: <20160904234237.10548-1-stefanbeller@gmail.com>
References: <20160904234237.10548-1-stefanbeller@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 5 Sep 2016 18:17:51 -0700
Message-ID: <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com>
Subject: Re: [PATCHv3] diff.c: emit moved lines with a different color
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 4, 2016 at 4:42 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
> When we color the diff, we'll mark moved lines with a different color.
>

Excellent idea. This is a very neat way to show extra information
without cluttering the diff output.

> This is achieved by doing a two passes over the diff. The first pass
> will inspect each line of the diff and store the removed lines and the
> added lines in its own hash map.
> The second pass will check for each added line if that is found in the
> set of removed lines. If so it will color the added line differently as
> with the new `moved-new` color mode. For each removed line we check the
> set of added lines and if found emit that with the new color `moved-old`.
>

Makes sense.

> When detecting the moved lines, we cannot just rely on a line being equal,
> but we need to take the context into account to detect when the moves were
> reordered as we do not want to color moved but per-mutated lines.
> To do that we use the hash of the preceding line.

Also makes sense.

>
> This patch was motivated by e.g. reviewing 3b0c4200 ("apply: move
> libified code from builtin/apply.c to apply.{c,h}", 2016-08-08)
>

Yes, this would be quite helpful.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0bcb679..f4f51c2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -980,8 +980,9 @@ color.diff.<slot>::
>         of `context` (context text - `plain` is a historical synonym),
>         `meta` (metainformation), `frag`
>         (hunk header), 'func' (function in hunk header), `old` (removed lines),
> -       `new` (added lines), `commit` (commit headers), or `whitespace`
> -       (highlighting whitespace errors).
> +       `new` (added lines), `commit` (commit headers), `whitespace`
> +       (highlighting whitespace errors), `moved-old` (removed lines that
> +       reappear), `moved-new` (added lines that were removed elsewhere).
>

I liked Junio's "Moved from" and "moved to" but I think moved old and
moved new are ok as well.

> @@ -287,6 +304,25 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>         return git_default_config(var, value, cb);
>  }
>
> +static int moved_entry_cmp(const struct moved_entry *a,
> +                          const struct moved_entry *b,
> +                          const void *unused)
> +{
> +       return strcmp(a->line, b->line) &&
> +              a->hash_prev_line == b->hash_prev_line;

So we're only comparing them if they match and have a matching
previous line? That seems pretty reasonable to reduce the cost of
computing exact copied sequences.

> +       if (ecbdata->opt->color_moved) {
> +               int h = memhash(line, len);
> +               hash_prev_removed = h;
> +               hash_prev_added = h;
> +       }
>  }

If I understand, this is to ensure that we don't keep re-hashing each
line right?

Thanks,
Jake
