Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B9F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932831AbeFUOsh (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:48:37 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33800 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeFUOsg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:48:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id i205-v6so3190726oib.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QziBkUOUHc73CVmFoD3drm2EfJ8jpUbjWpFvQJD/zEg=;
        b=rswWp+Ts1qFvN6cTjM0Gwx9k5oWUvFldvPoI/eG/f0+9ctuf4Nkg+wQYznIed4X48K
         X227kSIVpw3F1R/DiN9Evd3mrMWJM5WO5FA6w+QUlg0BTresi6XxcDlSUWRj4mxuLYwL
         3hwokLhOFxjMel33OEIOSyQlbFA43ASbvk6XGx6thMzQK8O7iLpNYQBD+MYx9EBohf8V
         7LbdYWqyroXeujfh6R5Gtivy3IWop3hSaR0K012qbj8RYQ9pGTpbe4MSyr1ADH82q4OW
         f7MR/mE93/0gyM/KcSuOrJMbdBcTlg+8sgPvnkSLca5UhlVQEgYS6BCxBTgBUdTOvGUG
         9dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QziBkUOUHc73CVmFoD3drm2EfJ8jpUbjWpFvQJD/zEg=;
        b=t/qWdj1JITb57tdmpvXoIEbsRVGCMLn2X00FDOBCbahvzdrPgWkGA2YX/Db9bAMyvl
         EDWbNpG0ZrPs+8LzbDIb++x6Y+FstsMmHZxvOSHT7xaIVlULmN7b3yrXKgZkfr4SjERG
         F9km/9nT/7MT1gu8iVl1lh5bZfCVxaaKG1byjii9tHTqsrQi2xpiAuSygECvUwghlnSU
         RbGxB+JTPTHT3Xfv5IOszVeiRy1DDELUpSCsDwPjeGaDNZYYKrMWNtZtj/SuCQMmDp4k
         yYoePbM+At5eCKO/3SaEOIvJ2sMpnDFu+cFy/jhvfYnT1G50EcEGL8afWj5zGlxUKc5v
         qXsw==
X-Gm-Message-State: APt69E1NZ03DzR6XEb9OuSyKqeBqauEPfbDmoEk+T4Xg7QvexN41XPj2
        eHd7PDY+K6ekKKwbtGfLVPg4CUH0AuO18Psv+Pg=
X-Google-Smtp-Source: ADUXVKJK/Ig7Nd7J7kYE1ekdap75yZNLgngg6vRmgM1Va2tgYpKpt6Q5uAvjroo9MeRE9z0rki0Ziw5/gRC+h2yC86s=
X-Received: by 2002:aca:ed53:: with SMTP id l80-v6mr15243912oih.281.1529592516261;
 Thu, 21 Jun 2018 07:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180621142742.28575-1-hertzog@debian.org> <20180621142742.28575-3-hertzog@debian.org>
In-Reply-To: <20180621142742.28575-3-hertzog@debian.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Jun 2018 16:48:09 +0200
Message-ID: <CACsJy8DcXo3HURwZXbvGYjrJpfku+RXESP=ErLzYj3NhNabRTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] i18n: bisect: mark two supplementary strings for translation
To:     Raphael Hertzog <hertzog@debian.org>
Cc:     Git Mailing List <git@vger.kernel.org>, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 4:39 PM Rapha=C3=ABl Hertzog <hertzog@debian.org> w=
rote:
>
> The whole bisect procedure is translated but the last message
> that the user will see in the process is not translated. Let's fix this.

Nice. There's another string in bisect_common() that should also be
translated: "revision walk setup failed". Maybe you can mark it too?
It's very unlikely to show up, and since it's already marked for
translation in other files, it will not add extra work on translators.

>
> Signed-off-by: Rapha=C3=ABl Hertzog <hertzog@debian.org>
> ---
>  bisect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index a579b5088..8edc7a7a6 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -658,8 +658,8 @@ static void exit_if_skipped_commits(struct commit_lis=
t *tried,
>         if (!tried)
>                 return;
>
> -       printf("There are only 'skip'ped commits left to test.\n"
> -              "The first %s commit could be any of:\n", term_bad);
> +       printf(_("There are only 'skip'ped commits left to test.\n"
> +                "The first %s commit could be any of:\n"), term_bad);
>
>         for ( ; tried; tried =3D tried->next)
>                 printf("%s\n", oid_to_hex(&tried->item->object.oid));
> @@ -984,7 +984,7 @@ int bisect_next_all(const char *prefix, int no_checko=
ut)
>
>         if (!oidcmp(bisect_rev, current_bad_oid)) {
>                 exit_if_skipped_commits(tried, current_bad_oid);
> -               printf("%s is the first %s commit\n", oid_to_hex(bisect_r=
ev),
> +               printf(_("%s is the first %s commit\n"), oid_to_hex(bisec=
t_rev),
>                         term_bad);
>                 show_diff_tree(prefix, revs.commits->item);
>                 /* This means the bisection process succeeded. */
> --
> 2.18.0.rc2
>


--=20
Duy
