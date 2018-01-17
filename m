Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C471D1F404
	for <e@80x24.org>; Wed, 17 Jan 2018 00:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeAQAv7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 19:51:59 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42799 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeAQAv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 19:51:58 -0500
Received: by mail-vk0-f66.google.com with SMTP id t4so10535886vkb.9
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 16:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/KYIHHu5+eUY3fLfDuqxTj24IFUUffS0yKJ0D2V5v4=;
        b=NMlvXJeWbijXDnS3Aa+v8wVftYPm/mF1uU+bku5ABAGmbw3vtfB6s52+eH3fqOu1cc
         O+VPnczg1NETNZuQcWe7DwQ+xhiZSJaRKWO2Qv0eC5WqCFk/rbQCvatZ6bVjW4yHTX6j
         lSqYV3gy6HuUmA9Sdt44i4P6Fu4FGLRQdbc0LDniB8mxTJYDfa4WD9ty3PtvHLHa6/pA
         coctiDDiNVCVz9FAt65E2e8+vj2UO4BqfJPU63d/bkZ6wwcXLJfHSVwZTVHedBQw+dU7
         8h1KqcuJaYyBFFGnmUvzsCgEsJG+5CZK0TKRNJITyNIL0MCZNryCAStTn3KfwowE6Hm6
         l1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/KYIHHu5+eUY3fLfDuqxTj24IFUUffS0yKJ0D2V5v4=;
        b=hk1tl3dOfH191o7L5vehA5exDpCiJLE6+oNd8pueSn/sW1PBq9T+kWzuz9hzPZXJzp
         1ECl2HtMBUdMk1ZyGvBGvB1ZUE4dOu7Qnbn1JrroFWbq+RYI3t0sUkAVaFUvg7kzJib2
         l4T1yhajI8poI47XlE58Iqj1aJiuO6zbzL28ioS6Y3ByzOE6EycItspXP3VtF1RPNxtR
         EmYePqCwgDIPBNyJkNc/HRaalwvR9GFiMOULit4EZ70jIbDJ4VvJrdQpJJcM6EZ2UZEt
         xHLxMDgQGRS2K+0AQAqcumxVAn3r3ue5vnQ5u9IMvLm5zZHSs33CVDcygvPonI8COrYE
         wgjA==
X-Gm-Message-State: AKwxytfTULyffSExjcfe7ZN7dIQLxltwL5QUhMYcdx4xn+FiZTf/JSJ8
        ZAVCaIL3znEs4Z5t0ZHpBZwaY34gu01NGzCwE/U=
X-Google-Smtp-Source: ACJfBouWIniIZvnuNaODvJAU5QaA6Ncx/ITQZabkkitWA8+am7ArMHZSfJPAEQvA60pEzWDB7AqG57Zmewv7tS3oqUg=
X-Received: by 10.31.60.69 with SMTP id j66mr779804vka.155.1516150317398; Tue,
 16 Jan 2018 16:51:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.10.140 with HTTP; Tue, 16 Jan 2018 16:51:56 -0800 (PST)
In-Reply-To: <20180116103700.4505-1-pclouds@gmail.com>
References: <20180116103700.4505-1-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 17 Jan 2018 01:51:56 +0100
Message-ID: <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 11:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> I noticed --recurse-submodules was missing from git-grep complete
> list. Then I found a couple more should be on the list as well and
> many more in future may face the same faith. Perhaps this helps remedy
> this situation?
>
> This lets us extract certain information from git commands and feed it
> directly to git-completion.bash. Now long options by default will
> be complete-able (which also means it's the reviewer's and coder's
> responsibility to add "no complete" flag appropriately) but I think
> the number of new dangerous options will be much fewer than
> completeable ones.
>
> This is not really a new idea. Python has argcomplete that does more
> or less the same thing.

This has come up before for Git as well, see:

  https://public-inbox.org/git/1334140165-24958-1-git-send-email-bebarino@g=
mail.com/T/#u

I see that your approach solves one of the shortcomings of those older
patches, namely it makes possible to omit dangerous options from
completion.  Great.

I also see that you want to invoke git in a subshell every time the user
attempts to complete an --option.  Not so great, at least for Windows
users.  That older thread contains a few ideas about how to do it only
once by lazy-initializing a variable for each command to hold its
options.


> This is just a proof of concept. More commands should be converted of
> course if it's a good thing to do.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
>   parse-options: support --git-completion-helper
>   git-completion: use --git-completion-helper
>
>  builtin/grep.c                         | 13 +++++++-----
>  contrib/completion/git-completion.bash | 16 +--------------
>  parse-options.c                        | 37 ++++++++++++++++++++++++++++=
++++++
>  parse-options.h                        | 14 ++++++++-----
>  4 files changed, 55 insertions(+), 25 deletions(-)
>
> --
> 2.15.1.600.g899a5f85c6
>
