Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917111F404
	for <e@80x24.org>; Tue, 16 Jan 2018 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbeAPS0F (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 13:26:05 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34875 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeAPS0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 13:26:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so10623126wme.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AiBcfJyP2DueXWX4dp8SFJBnEHbiIYq1scqlqqe4eXI=;
        b=HagHRRODEkwoQ6sSfzSpO4duJ+eOp2D4t0ykUcDgYHn9Qvc8hvvaNluGodSK7xLArg
         +KuJVe5DqxAgc5gcXAq4K2rBgGyZjZsu39s6Sqw4r0plCuJsgpzsvdYbyYzmnL3A3zkK
         2lsBRIoClZ37oaCgtFZOgXBdkYpgctCml7FY9QY6kzqa5eu2PLdSMgJbKPk9owE3OCXH
         qeF/dDibdswjsQ8xC+9Z+gsUEtzBRKUEDpI3ODZlRseXyp+E7AczQc/7mZA3ao5qkXQk
         2lrj3tFAkFgZ6UghWw0mABcxMVVrl3ZFOsMUUHCtIvpS9YDDO4TUwDy6EhYkuMowudtB
         Xv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AiBcfJyP2DueXWX4dp8SFJBnEHbiIYq1scqlqqe4eXI=;
        b=mDqAZ+TfIVbrLygE0egf9JEJizl6HPYTxVeQO6kvhy4VqqbJYssT9sNpb/uIiHYSmF
         4IBoPAfNrYUxkTeG/B9qVx8ys7pLlZzhnH+3nkYRNGgPyymwZRPsVLaWRsGWiZgX5cim
         9DvfSsw8t6NsiIosrpA08qu0U0pURBoEIwGKiee7Zva3qfh0ZJ4Dshhfba71xHQRlERM
         KHEGvIqXb8ZzZ6qriMzDQa2LGKlMoqtaNRiQ5dSTyRnxszAyVpyAjZFwt9aGiDYFivgH
         6Z2bmxbC5phGddA8eXv/NLvIKuvk7K3MCcD5F5EeGEsdmD43PtW2leULubKR0ZFWBXNF
         92qw==
X-Gm-Message-State: AKGB3mIaYt285nsgute2TCkNdo1W7E9LyrIVIiPKR0fftWW0w7Hbl4uC
        5ezE8zt32p/jw/QnmYig8loTKtAE0Dx6NY1jfrdq3w==
X-Google-Smtp-Source: ACJfBovWRRMXdwAnBd0NuYULcPC2SIBrzKUcoKtptb0kEGiDUsN5TcZt590aZypAxK7Y8vZ2QO3XaeXknAh1NC0fyMc=
X-Received: by 10.80.190.137 with SMTP id b9mr54176718edk.246.1516127163242;
 Tue, 16 Jan 2018 10:26:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Tue, 16 Jan 2018 10:25:42 -0800 (PST)
In-Reply-To: <20180116103700.4505-2-pclouds@gmail.com>
References: <20180116103700.4505-1-pclouds@gmail.com> <20180116103700.4505-2-pclouds@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 16 Jan 2018 10:25:42 -0800
Message-ID: <CA+P7+xohkxpoBHTVcD5i-=gT_evL5HKhCGLyV0LYyj8YdyLmqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: support --git-completion-helper
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 2:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This option is designed to be used by git-completion.bash. For many
> simple cases, what we do in there is usually
>
>     __gitcomp "lots of completion options"
>
> which has to be manually updated when a new user-visible option is
> added. With support from parse-options, we can write
>
>     __gitcomp "$(git command --git-completion-helper)"
>
> and get that list directly from the parser for free. Dangerous/Unpopular
> options could be hidden with the new "NO_GITCOMP" flag.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

Was this possibly avoided in the past due to being slower than simply
storing the list in the completion code itself?

I think this is a good idea myself.

Thanks,
Jake

> ---
>  parse-options.c | 37 +++++++++++++++++++++++++++++++++++++
>  parse-options.h |  6 ++++--
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index fca7159646..6c542f44cf 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -425,6 +425,35 @@ void parse_options_start(struct parse_opt_ctx_t *ctx=
,
>         parse_options_check(options);
>  }
>
> +static int show_gitcomp(struct parse_opt_ctx_t *ctx, const struct option=
 *opts)
> +{
> +       for (; opts->type !=3D OPTION_END; opts++) {
> +               const char *suffix;
> +
> +               if (!opts->long_name)
> +                       continue;
> +               if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NO_GITCOM=
P))
> +                       continue;
> +
> +               switch (opts->type) {
> +               case OPTION_GROUP:
> +                       continue;
> +               case OPTION_STRING:
> +               case OPTION_FILENAME:
> +               case OPTION_INTEGER:
> +               case OPTION_MAGNITUDE:
> +                       if (!(opts->flags & PARSE_OPT_OPTARG))
> +                               suffix =3D "=3D";
> +                       break;
> +               default:
> +                       suffix =3D "";
> +               }
> +               printf(" --%s%s", opts->long_name, suffix);
> +       }
> +       fputc('\n', stdout);
> +       exit(0);
> +}
> +
>  static int usage_with_options_internal(struct parse_opt_ctx_t *,
>                                        const char * const *,
>                                        const struct option *, int, int);
> @@ -434,6 +463,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>                        const char * const usagestr[])
>  {
>         int internal_help =3D !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
> +       int internal_gitcomp =3D !(ctx->flags & PARSE_OPT_NO_INTERNAL_GIT=
COMP);
>         int err =3D 0;
>
>         /* we must reset ->opt, unknown short option leave it dangling */
> @@ -455,6 +485,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>                 if (internal_help && ctx->total =3D=3D 1 && !strcmp(arg +=
 1, "h"))
>                         goto show_usage;
>
> +               /* lone --git-completion-helper is asked by git-completio=
n.bash */
> +               if (internal_gitcomp && ctx->total =3D=3D 1 &&
> +                   !strcmp(arg + 1, "-git-completion-helper"))
> +                       goto show_git_comp;
> +
>                 if (arg[1] !=3D '-') {
>                         ctx->opt =3D arg + 1;
>                         switch (parse_short_opt(ctx, options)) {
> @@ -521,6 +556,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>         err =3D 1;
>   show_usage:
>         return usage_with_options_internal(ctx, usagestr, options, 0, err=
);
> + show_git_comp:
> +       return show_gitcomp(ctx, options);
>  }
>
>  int parse_options_end(struct parse_opt_ctx_t *ctx)
> diff --git a/parse-options.h b/parse-options.h
> index af711227ae..8a3389b05b 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -27,7 +27,8 @@ enum parse_opt_flags {
>         PARSE_OPT_STOP_AT_NON_OPTION =3D 2,
>         PARSE_OPT_KEEP_ARGV0 =3D 4,
>         PARSE_OPT_KEEP_UNKNOWN =3D 8,
> -       PARSE_OPT_NO_INTERNAL_HELP =3D 16
> +       PARSE_OPT_NO_INTERNAL_HELP =3D 16,
> +       PARSE_OPT_NO_INTERNAL_GITCOMP =3D 32
>  };
>
>  enum parse_opt_option_flags {
> @@ -38,7 +39,8 @@ enum parse_opt_option_flags {
>         PARSE_OPT_LASTARG_DEFAULT =3D 16,
>         PARSE_OPT_NODASH =3D 32,
>         PARSE_OPT_LITERAL_ARGHELP =3D 64,
> -       PARSE_OPT_SHELL_EVAL =3D 256
> +       PARSE_OPT_SHELL_EVAL =3D 256,
> +       PARSE_OPT_NO_GITCOMP =3D 512
>  };
>
>  struct option;
> --
> 2.15.1.600.g899a5f85c6
>
