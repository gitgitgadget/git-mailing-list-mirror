Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278AE2070C
	for <e@80x24.org>; Tue,  5 Jul 2016 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbcGEVQR (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 17:16:17 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34904 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcGEVQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 17:16:16 -0400
Received: by mail-yw0-f175.google.com with SMTP id l125so72291933ywb.2
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 14:16:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ACFX5IAQ2rQZ/L1Gdp4qQqnd42Xacm6i1zv3LgRJr4g=;
        b=HD1H0wEW+dF/FOp2egZ7RXnBWiPiuITtgduxN5tgaeOyhNmr2K7NGOLnh7GizkiQyK
         5TSarU0f6a/Mtk2rowysBnW+oGA0AGhoR6U5IoIPbYgBSJ5BAgtfrIdrP99DtNl817Kt
         UInQog9VeLFw3Tp5jvNeLbMNDOXKlSKZchMW+IoWWW2ahQXockQoDhs0huXWCCcL1Kr3
         pcABA3pWBlg9ABaFVlAIu/lxpaaUVeJZ09xwTlOjgnoyILsaiLnjQ3XgnOF5JI3uF+kE
         hHopBjwxLVwBTTzdfNmIV9Iq6btGdlSL+bd/TDwoiWAl/lfIck8UAKxIUPOkg4fTdlh5
         ZSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ACFX5IAQ2rQZ/L1Gdp4qQqnd42Xacm6i1zv3LgRJr4g=;
        b=kPGeOV3OQzvh6J+JPujdaJcdRacrd3I9rAQoybXozGjMjNnTG8Jo454ppMocOQWW7L
         2b6r0ar9lpiX0F98S/gxzhGopvNu82+fLEge0tjhr/zX9yUpEpke6CHVZWCbMUfqbtnb
         GUepfc0aFWQ0vy78w5yEi83H54NLaN23Nv/MU1YK6a8WjiNf7BxokAuQMO3Kit5TfiWt
         H1/5rlMHc8XyMOm+wbljGufkJbhyslHREbfcygoS7N1rbGtxo2cBaVoxWku22og02TX3
         Bn3jigUZ77ldi1SlLfrtu4YqkrpZDkSDztrpQZfJzv0QcvNi0azaqJJ1v7qcgVDB6Yj7
         TwcA==
X-Gm-Message-State: ALyK8tJMe1ZGf4ceiognglXdVpIiDIJF1taPihlLMBMZgAH9C8vDyJ0LTC358pGkWrvSDaCwSMGbZqYjyZA8VQ==
X-Received: by 10.13.245.132 with SMTP id e126mr12824303ywf.258.1467753375051;
 Tue, 05 Jul 2016 14:16:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.34.133 with HTTP; Tue, 5 Jul 2016 14:15:55 -0700 (PDT)
In-Reply-To: <20160705204447.GB14496@sigill.intra.peff.net>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net> <20160705204447.GB14496@sigill.intra.peff.net>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 5 Jul 2016 14:15:55 -0700
Message-ID: <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 5, 2016 at 1:44 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 05, 2016 at 04:28:20PM -0400, Jeff King wrote:
>
>> I wonder if parse_options_concat should simply allocate a new list
>> (after computing the total required size). I guess this is the only
>> caller, though, so perhaps it's not the end of the world. In the
>> meantime, your patch is certainly an improvement.
>
> Something like the patch below.
>
> I admit this isn't buggy _now_, so this is potentially just churn. It
> does make further patches look nicer, though (they don't have to add
> apparently meaningless OPT_END() slots).
>
> -- >8 --
> Subject: [PATCH] parse_options: allocate a new array when concatenating
>
> In exactly one callers (builtin/revert.c), we build up the
> options list dynamically from multiple arrays. We do so by
> manually inserting "filler" entries into one array, and then
> copying the other array into the allocated space.
>
> This is tedious and error-prone, as you have to adjust the
> filler any time the second array is modified (although we do
> at least check and die() when the counts do not match up).
>
> Instead, let's just allocate a new array.

This seems much preferable to me.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/revert.c   | 13 ++++---------
>  parse-options-cb.c | 29 +++++++++++++++++------------
>  parse-options.h    |  2 +-
>  3 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 56a2c36..4e69380 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -76,7 +76,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>         const char * const * usage_str = revert_or_cherry_pick_usage(opts);
>         const char *me = action_name(opts);
>         int cmd = 0;
> -       struct option options[] = {
> +       struct option base_options[] = {
>                 OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
>                 OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
>                 OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
> @@ -91,13 +91,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>                         N_("option for merge strategy"), option_parse_x),
>                 { OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>                   N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> -               OPT_END(),
> -               OPT_END(),
> -               OPT_END(),
> -               OPT_END(),
> -               OPT_END(),
> -               OPT_END(),
> +               OPT_END()
>         };
> +       struct option *options = base_options;
>
>         if (opts->action == REPLAY_PICK) {
>                 struct option cp_extra[] = {
> @@ -108,8 +104,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>                         OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
>                         OPT_END(),
>                 };
> -               if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> -                       die(_("program error"));
> +               options = parse_options_concat(options, cp_extra);
>         }
>
>         argc = parse_options(argc, argv, NULL, options, usage_str,
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 239898d..2d87520 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -117,19 +117,24 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
>         return 0;
>  }
>
> -int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
> +struct option *parse_options_concat(struct option *a, struct option *b)
>  {
> -       int i, j;
> -
> -       for (i = 0; i < dst_size; i++)
> -               if (dst[i].type == OPTION_END)
> -                       break;
> -       for (j = 0; i < dst_size; i++, j++) {
> -               dst[i] = src[j];
> -               if (src[j].type == OPTION_END)
> -                       return 0;
> -       }
> -       return -1;
> +       struct option *ret;
> +       size_t i, a_len = 0, b_len = 0;
> +
> +       for (i = 0; a[i].type != OPTION_END; i++)
> +               a_len++;
> +       for (i = 0; b[i].type != OPTION_END; i++)
> +               b_len++;
> +
> +       ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
> +       for (i = 0; i < a_len; i++)
> +               ret[i] = a[i];
> +       for (i = 0; i < b_len; i++)
> +               ret[a_len + i] = b[i];
> +       ret[a_len + b_len] = b[b_len]; /* final OPTION_END */
> +
> +       return ret;
>  }
>
>  int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
> diff --git a/parse-options.h b/parse-options.h
> index ea4af92..78f8384 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -215,7 +215,7 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
>
>  extern int parse_options_end(struct parse_opt_ctx_t *ctx);
>
> -extern int parse_options_concat(struct option *dst, size_t, struct option *src);
> +extern struct option *parse_options_concat(struct option *a, struct option *b);
>
>  /*----- some often used options -----*/
>  extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
> --
> 2.9.0.320.gd3e6182
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
