Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4350A1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbdKKNSB (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 08:18:01 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:48013 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdKKNSA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 08:18:00 -0500
Received: by mail-io0-f179.google.com with SMTP id h70so16239514ioi.4
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u8uZNaRmSyHhGQ0lLsFrzmss1UMECJclH/SqjAxgEts=;
        b=eEnYsviPU/F2HMZ4zQauzjjOz1j+N4ULSIyGGSu6QmGpgAIbteXhsQPpytbZTRH3yq
         6c59VPW2VA+v8w09qv8y1U1MasL75opkexGCeXh4adVu2Np/TASYlY0SHxbzaOUJH9sx
         KLtK0QA6+hwL1CEkjWzq7J4GoYpJ3IihQpN80X8sE/WdduYjCT45dKC+YYX8hEpxyE0U
         qB8H7WMj/SdUiJIWJkTJ50A8CRUJh7LvlGLZjZYF1fiRSpbvFC+fsFb8Ucpkkgww9+Y/
         oJZQJgibrTooW+PNY+m7kwwLc1z+dp02ylScxVdRgHp819jwqjT+cwyxcteOBrJg2tOF
         rLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u8uZNaRmSyHhGQ0lLsFrzmss1UMECJclH/SqjAxgEts=;
        b=N+51nJZUoKyscgbO0rF0v8GXiEIHh19er/BCJ2a3xeEFdT6Z+V3Q0KvAY1l1qQiLCS
         GYj53Izp60TY4aAZCorZYbn8KPZ03HLoOUt2W48682zAcSm7j7PM916uR3Lb4OCwACji
         RsgIpFvK52eTwy44dEb8Lq7v8NKAAN9QVbxZgYGA4OPNdiQhW1LN2tP1NdITPON7j3qE
         vkJdLgWDXPzcsqGk7Rchi0m5VWkAv/hMKXaiFiH3OOHtCpXX23waSNYhqjFOLpu+5PNt
         G1lO6J9okRfQNvKBDXwuPFHGWg/ctBE0WFJUu8iM1SQVuUzaYMy9hRD7H2d0MEVUoaFy
         ngKg==
X-Gm-Message-State: AJaThX5oa01wilTuixvOk2Bque0MR9NSeaGGfxZOj9sTxFR26AIhbbKR
        QXng1owUkXiGfOXYScqO5wvxF0QCuAlU8F8zyuA=
X-Google-Smtp-Source: AGs4zMZO7ua7V1umeI7HoDEp38EEmjjNv/7SKjsK0v2flt+YF1tu8XknUltDxDuqCdMH2kLu2BYotJGahIyX9VGprz4=
X-Received: by 10.107.111.14 with SMTP id k14mr3622964ioc.282.1510406279593;
 Sat, 11 Nov 2017 05:17:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 11 Nov 2017 05:17:59 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711110528410.4314@localhost.localdomain>
References: <alpine.LFD.2.21.1711110528410.4314@localhost.localdomain>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 11 Nov 2017 14:17:59 +0100
Message-ID: <CAP8UFD2n18AauZbTWo9s3kaYJfMtCdYFTBS-RbyeemVGGpisGA@mail.gmail.com>
Subject: Re: [PATCH v2] bisect: mention "view" as an alternative to "visualize"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 11:31 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
> Tweak a number of files to mention "view" as an alternative to
> "visualize".

Good idea.

> @@ -196,15 +196,14 @@ of `git bisect good` and `git bisect bad` to mark commits.
>  Bisect visualize
>  ~~~~~~~~~~~~~~~~

Maybe while at it the section title could be changed to "Bisect visualize/view".

> -To see the currently remaining suspects in 'gitk', issue the following
> -command during the bisection process:
> +To see the currently remaining suspects in 'gitk', issue either of the
> +following equivalent commands during the bisection process:
>
>  ------------
>  $ git bisect visualize
> +$ git bisect view
>  ------------
>
> -`view` may also be used as a synonym for `visualize`.

I don't like very much the above changes. They don't make it clear
that there is no difference between using "view" and using
"visualize".

>  If the `DISPLAY` environment variable is not set, 'git log' is used
>  instead.  You can also give command-line options such as `-p` and
>  `--stat`.
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 3a03e63eb..55ec58986 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -538,10 +538,11 @@ Note that the version which `git bisect` checks out for you at each
>  point is just a suggestion, and you're free to try a different
>  version if you think it would be a good idea.  For example,
>  occasionally you may land on a commit that broke something unrelated;
> -run
> +run either of the equivalent commands
>
>  -------------------------------------------------
>  $ git bisect visualize
> +$ git bisect view
>  -------------------------------------------------

This is the user manual where we want to restrict the amount of
information we give, so I am not a big fan of the above change.

I think the other changes after the above are good though.

Thanks,
Christian
