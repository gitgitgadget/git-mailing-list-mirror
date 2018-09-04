Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6F91F404
	for <e@80x24.org>; Tue,  4 Sep 2018 01:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIDGPF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 02:15:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39407 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDGPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 02:15:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so2348544qtk.6
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3J5n0jroOFQMhH86WIO8IcCIlINHV1TMI9P4sTXdmfo=;
        b=Ey2XP3NmP4k8A5SASI+03crO6uN7Oi/p2HQsJShf+IwYf0w3BM8Z9t5CZEjPj3EsK0
         8YzZ16VLlCUxsyC3Z2TzbOc82+D5MvKedWNqf2iKEfrJqgP4HWCkmnzJEqe+26kyt+rl
         GUfs80n2+qkbXEyLKcwCsx/LDoeEEOxD9FfpB5qz4EZKIzke5fmJnmpxPlkzFwfBZLPs
         hU7YWFY8zs0mON70xW0Qp6V7Yx0zFszt9NrnJkNwqdSR6k/65e/FCjmlO5MbE6gwPXYV
         JeReDhnMtgHhTaX1M/hv1NctExRuacwmMbXaP/Ui5c80IgOvsnOKUA3T7j5ha/rzhkDc
         Zi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3J5n0jroOFQMhH86WIO8IcCIlINHV1TMI9P4sTXdmfo=;
        b=sow5/xztu021qAYCRihPicx6eOFo34uF6b6ZvxFvTOpS0Ob+L8gAJ7b60cpAX/k1X7
         6/RSn96ooZX99yoFU9DpH0NuJ3DeovT812nWyEmsA5jbeD9mrN0z8ZCHtepU02e2YdmT
         Q1cpCoQ8ouS9DwkVAJHekhgJOG5b8Ew/GQbdsmrV2EHwSSJ5h0S94kgh+OftVSQYv9ra
         mhzIRuZYbB4KeX+8Kbpq9oyVAMQynUuVWy6FQsDMHObVhT7JMAT+NnPIQ/WcFrYrxu1c
         gW3pY6pXiyninukcfmE+oom/cu72c0j0TuLwzP9SioEF1YEkfG0ELMXkizuv+m8Z1Q0d
         rc+w==
X-Gm-Message-State: APzg51A4Zr9jaUl7N4ChzJwJiQUyavuuNEWpnX5As84WEE0P9sZQtybQ
        uO9/7XghKy4TGgBc7izMo8yX6H7C/Ce1thzgYBU=
X-Google-Smtp-Source: ANB0VdaQ7M5ORZf6ARb4ptMgr0xG1nP3pS/tIXSuJzYVtMWWgMFgPAIHkcd/dt6ZbVjvW0GC/49nW8SIu4/oTA2m66s=
X-Received: by 2002:aed:2704:: with SMTP id n4-v6mr27640785qtd.252.1536025938559;
 Mon, 03 Sep 2018 18:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180823210056.27489-1-jn.avila@free.fr>
In-Reply-To: <20180823210056.27489-1-jn.avila@free.fr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 4 Sep 2018 09:52:07 +0800
Message-ID: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
Subject: Re: [PATCH] i18n: fix mistakes in translated strings
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> =E4=BA=8E2018=E5=B9=B48=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:02=E5=86=99=E9=81=93=EF=BC=
=9A
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2bcc70fdfe..b56028ba9d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -542,7 +542,7 @@ static void runcommand_in_submodule_cb(const struct c=
ache_entry *list_item,
>                 argv_array_pushv(&cpr.args, info->argv);
>
>                 if (run_command(&cpr))
> -                       die(_("run_command returned non-zero status while=
"
> +                       die(_("run_command returned non-zero status while=
 "
>                                 "recursing in the nested submodules of %s=
\n."),

Any specific reason to put a period after newline?
And there is another mistake just above this one:

    "run_command returned non-zero status for %s\n."

--=20
Jiang Xin
