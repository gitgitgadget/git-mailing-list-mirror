Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12B61F453
	for <e@80x24.org>; Mon, 11 Feb 2019 08:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBKIJZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 03:09:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45972 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKIJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 03:09:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so11090588qtr.12
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 00:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ueUf7Ug/x3KPZkSnBAlww9m4UnLPPvDGK0LPGh6Kus8=;
        b=Q2RAkkwN3Is1xXdUxNuGpoDJPhs4RjXb6xuh5FQlMulc9bFRD/ZNARQ8D4Lde+xQy+
         NaV05V/AXifRxTUtlPSeijSj7TS2zQtk90/4iWnln45kTQzTF4iVSgYObVzHLtwpTa09
         i32ik19+KqNmua7DyAlwlxErN7KLbCGe41bChM/erKVu8U+lSD1QKWypYl5SerLlob8G
         hWwKYmrB39nh3CcIj+1QJn4zuF/fKj2D1cr5ltSTkg9dtlBcUpJnVPyHRdGjkgqJtCgv
         Rpt41NHVjLYsP0F5ywNWj0B7EqUL0HulKjUFqvANSz/FpcAfHNt8mXQ7er5ItJpkxNaJ
         CZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ueUf7Ug/x3KPZkSnBAlww9m4UnLPPvDGK0LPGh6Kus8=;
        b=jaeR7ZcrzqNupR2tmEGkL5D81mQEcm68TKa9Dhl3hO5RYcmGBKwUkCrN+JtYFarywt
         jWCRWtuQ0sOtYA5V+bS+TIQj9kYmt5/KTQ9AGzaIHAJPK8A+9eTnxNGylQrEJ6TlceSx
         OAMpGnOBJgI178ihEb9rlrmlY9rSAkxOF/5s2ya5BfO1aCSfCvVtFAoVWVl74hQkiSsu
         AdNkWfazPjdE0390DJ4PJdmfGQq30chDfVjvZ4IwAjw0zNwjblR5e8aoqkPPVEeHWGvZ
         rtgPWGsvQIKl2n6zoz6bdGNFKFAj3AHkrTeU7nSUw/hgu5fZe+vjmG+yhncY6BEYDDkn
         IKiQ==
X-Gm-Message-State: AHQUAuYtRCM9saLhR2sHTv3JjayIf8KZnldTz0nmk7Eleqpzsi3vfsnI
        4VwXOgLVPbrGCXqdACpUqs72OzE+FLSjWIUAvfZZqTgUTZ0=
X-Google-Smtp-Source: AHgI3IaC9BufQuPNtj4Xj0OM5sQEmjvaQkAg9Agaqefq03RqFpq6JU5ZyX8GzVg032ERuDVG3/biIvqW3NxTWmvy+VU=
X-Received: by 2002:a0c:fb4d:: with SMTP id b13mr10568861qvq.26.1549872564085;
 Mon, 11 Feb 2019 00:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20190209213044.29539-1-jn.avila@free.fr> <20190211064453.5205-1-jn.avila@free.fr>
In-Reply-To: <20190211064453.5205-1-jn.avila@free.fr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 11 Feb 2019 16:09:12 +0800
Message-ID: <CANYiYbHoNV+6yi6a75oh2nPpihsqEu0Fq+8R_G6O+XOD5JogoQ@mail.gmail.com>
Subject: Re: [PATCH] Fix typos in translatable strings for v2.21.0
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> =E4=BA=8E2019=E5=B9=B42=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:48=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/bisect--helper.c | 4 ++--
>  builtin/fetch.c          | 2 +-
>  builtin/rebase.c         | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

This re-roll is v2 (forgot suffix v2 in subject), and LGTM.
Difference between v1 and v2:

     -              die(_("--reschedule-failed-exec requires an
interactive rebase"));
    -+              die(_("%s requires an interactive rebase",
"--reschedule-failed-exec"));
    ++              die(_("%s requires an interactive rebase"),
"--reschedule-failed-exec");

>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c1cff32661..e7325fe37f 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -173,7 +173,7 @@ static int bisect_reset(const char *commit)
>                         argv_array_clear(&argv);
>                         return error(_("could not check out original"
>                                        " HEAD '%s'. Try 'git bisect"
> -                                      "reset <commit>'."), branch.buf);
> +                                      " reset <commit>'."), branch.buf);

fixed typo: git bisectreset -> git bisect reset

>                 }
>                 argv_array_clear(&argv);
>         }
> @@ -646,7 +646,7 @@ int cmd_bisect__helper(int argc, const char **argv, c=
onst char *prefix)
>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out t=
he current commit")),
>                 OPT_BOOL(0, "no-log", &nolog,
> -                        N_("no log for BISECT_WRITE ")),
> +                        N_("no log for BISECT_WRITE")),

strip trailing writespace.

>                 OPT_END()
>         };
>         struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =
=3D NULL };
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5a09fe24cd..b620fd54b4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1480,7 +1480,7 @@ static inline void fetch_one_setup_partial(struct r=
emote *remote)
>         if (strcmp(remote->name, repository_format_partial_clone)) {
>                 if (filter_options.choice)
>                         die(_("--filter can only be used with the remote =
"
> -                             "configured in extensions.partialclone"));
> +                             "configured in extensions.partialClone"));

Use camelcase for config variable name.

>                 return;
>         }
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 96efd40901..7c7bc13e91 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1434,7 +1434,7 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>         }
>
>         if (options.reschedule_failed_exec && !is_interactive(&options))
> -               die(_("--reschedule-failed-exec requires an interactive r=
ebase"));
> +               die(_("%s requires an interactive rebase"), "--reschedule=
-failed-exec");

Reuse l10n string ("%s requires an interactive rebase") defined in
builtin/rebase.c:121:

        case REBASE_AM:
                die(_("%s requires an interactive rebase"), option);

>
>         if (options.git_am_opts.argc) {
>                 /* all am options except -q are compatible only with --am=
 */
> --
> 2.21.0.rc0
>
