Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B6B1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeFCIN7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:13:59 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:39586 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCIN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:13:58 -0400
Received: by mail-yb0-f177.google.com with SMTP id m137-v6so7781240ybm.6
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UHlaZ6azjVAMIylWtteqhUGbsRoaTytLXwdxLs7X4Ek=;
        b=UlNf4lUpYB+v6qnPwMmuJ9IfAIJUjgLA+2edOOqVCN7GMxj2nauQMQGrLUWLlKTahD
         vEpFRlHeBKi66IrhfOa5R3xWZ9wrVxE+9v3M5yefMckRvO15zJMRmPalGOXVWPJNUyTj
         OVOGMcW1LB8pwgV6ZO8bWWBJ7Q9tHI4ew0wuiQ5E9KH8xpfbItpYVWhniRBg+lPyDQQZ
         ukVxJXz9xSuBUBWShM3rKcgKSMOgrvUz3jdPgfIlO/bsbH2iA4QZskjqL0PBzFQCpa2f
         49oI3/4mkRicDs0slqlRgINCEKDXPR6ye6I1d/d/eSKP+B8Db2JEj5PAg6jqqa160znD
         Yjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UHlaZ6azjVAMIylWtteqhUGbsRoaTytLXwdxLs7X4Ek=;
        b=OCgCZItyY+RIm616856CYm4284vX628Un9SkHztojmggfkJCke+klkMMx/jnsuqG/C
         2/LtX5LGBWNlQIPfvJ9BVqal6RMiMqoyuffsFrI97Bt6Ca+y2+Kay5GwTwOehMhVH4Mm
         3os8xXGa1xI9lkf8v9De+pDZkZrzvN90mtfQ0zdEfs80JHE5p5tSbE9H5qBETB4aNbK+
         1G2VKOGboVy2HhGlWe33YE5N6Z5HEWrS/7Sy3pvCpE3urbDhDf0cYRzmRA51xUbIfSZH
         eU/8j2KGlz9S4Zdqm6pSlrXR9u4MdaZkuifRk6CRUQ4BSYwYuBzeu6ou99H+9shk2MHx
         eSnw==
X-Gm-Message-State: ALKqPwff+InBfcT0j2PGyR9YWYDDre8P2DuIhJs32H3qHLuN9dL2ozic
        0mq7xkBfoMAhxdo5z41FW8NkhQIYnpB9P/tN6zo=
X-Google-Smtp-Source: ADUXVKJaMmEzTZDarPr8civaMXxlpByP/lBNrdwMIzxWtKxjJ5gIp+J0Xe453bIyZGmbgh/Ag2B/cUCuMl7iEQdkrMw=
X-Received: by 2002:a25:9789:: with SMTP id i9-v6mr9032349ybo.497.1528013637660;
 Sun, 03 Jun 2018 01:13:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:13:57 -0700 (PDT)
In-Reply-To: <20180602043241.9941-21-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-21-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:13:57 -0400
X-Google-Sender-Auth: 5FY3JXIOMmtZkc8y1T19MpTBzwg
Message-ID: <CAPig+cSmbxUiy6q-xAkxqjpcmSE0QqeCbBri8kghopf=_ZUnoA@mail.gmail.com>
Subject: Re: [PATCH 20/22] sha1-file.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/sha1-file.c b/sha1-file.c
> @@ -71,17 +71,17 @@ static void git_hash_sha1_final(unsigned char *hash, =
git_hash_ctx *ctx)
>  static void git_hash_unknown_init(git_hash_ctx *ctx)
>  {
> -       die("trying to init unknown hash");
> +       die(_("trying to init unknown hash"));
>  }
>
>  static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data,=
 size_t len)
>  {
> -       die("trying to update unknown hash");
> +       die(_("trying to update unknown hash"));
>  }
>
>  static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ct=
x)
>  {
> -       die("trying to finalize unknown hash");
> +       die(_("trying to finalize unknown hash"));
>  }

The above three are indicative of programmer error, aren't they? If
so, they ought not be translated (and perhaps changed to BUG at some
point).

>  const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] =3D {
> @@ -378,8 +378,8 @@ static int alt_odb_usable(struct raw_object_store *o,
>
>         /* Detect cases where alternate disappeared */
>         if (!is_directory(path->buf)) {
> -               error("object directory %s does not exist; "
> -                     "check .git/objects/info/alternates.",
> +               error(_("object directory %s does not exist; "
> +                       "check .git/objects/info/alternates."),

Perhaps drop the trailing period as you did in other cases.

>                       path->buf);
>                 return 0;
>         }
