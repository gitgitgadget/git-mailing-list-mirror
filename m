Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8143C201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757804AbdELWWc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:22:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33678 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754977AbdELWWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:22:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so8781520wrc.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8AzUt5xAQbCfoa4Md6CxbUFCJLPE+qIil8psTD8cdgU=;
        b=f9I9wAVgfLwOeMqYgg4X7wf4F/wrZ7BCTFlt3/G16npAOeMFVv9qwFLyxMdWIO/MDP
         Q57XtSsAOAQO33sGilgzNvMyjcUkfjaxrLfoWBrG5E2KYj/zbuXV6wD/SFVl3itBf2gC
         lVMRI+HpQHu3KyNojBhJy69m/oxarrtYJ50YOvgh2oBWVra8s4lbLkk9OfIXOscrzBMo
         cmM1tWTuoaUWA+1C0ohdnC8GPPHPgzIS7rjbn4+4hJxU0Q19zDufRPifVEWbWu+dwg1C
         MFLuqxSAU57JrBIcfElsmJ4gDIKw2H6ZX/f7cjiH6QyrxraLRLKtjVrTULOZ/IObgvvy
         UarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8AzUt5xAQbCfoa4Md6CxbUFCJLPE+qIil8psTD8cdgU=;
        b=pMu++cffNi2jbZVHaOTZZXhBODwwGODEiTY70qjYK1nv1joSPRxhOEARwyVZvzr32u
         NR2BOvd8ZPp2FqyIu8BfiSf3c5Uh4RRamqfZglIT/fPMzWoKoy7j5Icsx2ZQEAJGb0In
         Liqp2axgW2+zQUjQqMxOOZUhHfs5GflbnLcUwjklL0bY10rxuoXrXpoTcihJt7Z2MfxC
         WqOg4Sm93d4tte/jXjG0JbR2gu+nzvpam2MoTNDQb0IUS4rjSTSvHKh2h5NgK1XTH3ou
         GHPR2OzjqY70ne+LiKCqC4hDKGHtKmodeKYEqxZruKIxUqpklSNhsBhoTv8Lrrre4+Y2
         3DEQ==
X-Gm-Message-State: AODbwcDgo98V2OXKR9e4kawQOvs2aHdzknMA7IkAKarBXhEOoY1/rQ4K
        wQX6tQV0FrSvUoMlNCM3Lo4jZB95L9yE
X-Received: by 10.223.138.139 with SMTP id y11mr4904463wry.22.1494627749668;
 Fri, 12 May 2017 15:22:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.100.213 with HTTP; Fri, 12 May 2017 15:22:09 -0700 (PDT)
In-Reply-To: <20170512221221.406645-1-sandals@crustytoothpaste.net>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net> <20170512221221.406645-1-sandals@crustytoothpaste.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 12 May 2017 16:22:09 -0600
Message-ID: <CAMMLpeSOesfJPtoj4vGK1iQB+YDRge8TYy2fnL94brheRU3dYA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-12 16:12 GMT-06:00 brian m. carlson <sandals@crustytoothpaste.net>:
> The recent change that introduced autodecorating of refs accidentally
> broke the ability of users to set log.decorate = false to override it.
> When the git_log_config was traversed a second time with an option other
> than log.decorate, the decoration style would be set to the automatic
> style, even if the user had already overridden it.  Instead of setting
> the option in config parsing, set it in init_log_defaults instead.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/log.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index b3b10cc1e..ec3258368 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -110,6 +110,8 @@ static void init_log_defaults(void)
>  {
>         init_grep_defaults();
>         init_diff_ui_defaults();
> +
> +       decoration_style = auto_decoration_style();
>  }
>
>  static void cmd_log_init_defaults(struct rev_info *rev)
> @@ -410,8 +412,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
>                 if (decoration_style < 0)
>                         decoration_style = 0; /* maybe warn? */
>                 return 0;
> -       } else {
> -               decoration_style = auto_decoration_style();
>         }
>         if (!strcmp(var, "log.showroot")) {
>                 default_show_root = git_config_bool(var, value);

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
