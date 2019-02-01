Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92DBC1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 08:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfBAIYs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 03:24:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51033 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBAIYs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 03:24:48 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so7987283iti.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 00:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KC/f1ekmrRXGBp2HQwi0vjMmh2RhDhZ74CUSz0qR2Js=;
        b=ahoheAwjdrK8A67UQkGiN4HtmxqWROBhI3ECdQGyRQDTqqyiw7cU5i9JBLdHqNT4zC
         VQ6rXpZ0lT/8xIrMzxImDi4kLS3i71VN4TXOHceHemyL2fGKOcLmHnExOwIyC1YkM6Zl
         YVYSrjMmHZOCzG83UX1Ugv4bSBB2c6FkfZcT7CBbZZb4n3Fvp4djoTcY6WUiO/4GMh08
         rIrGbI9JQxVOyiQAkJd/FP8LyZ+4aNSDzHEda+YbgdGgY9KrTvlVMMMmevVU6paPBakC
         SrAr2tDeMd8/wV3SQCa0OO8zOVQ5ZWP8OsFioXX9P0KiDxQ/Vco597wx4KC1DcJB8Whn
         oy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC/f1ekmrRXGBp2HQwi0vjMmh2RhDhZ74CUSz0qR2Js=;
        b=HnrkWR3Qq3cnv4pow0dlfPal2tm9VnoR54x1feR5G4m3r5PP0j8blPf3cAhuaN7gpw
         EsTuYRlobTZQEEtelFiJPB0TOEugRE49XOpZOHjmjycFysevuVc5r6N2tN87f68zNAsD
         urQWH+/9JhBGuQ42yBgkPIYDuFwyn+s5OKoUCgB/m91InRwqktplY8LbDNC9q3HXvzTq
         GDx7ib85H1qLI7V+0VKZ9f97jTCOny6WQfT2tYC6ImkWBxZcztIBukD1ST0gGhv5poIp
         AuHmYhQnfhAJEeUtkZ6xz0abaBWR02uwZiR+cpP11wEpK/tGV9GHeGTYVFgj3vAAWEq1
         Xq+g==
X-Gm-Message-State: AHQUAuZ1k/RcDLAF1HVJY1AM2nNa+RC6W8ugn6TTw/RUMnHxq6e7WCOX
        Q1ciOQJWTQnSDed43CJWCSlkjc/mETama/KE4mwrXw==
X-Google-Smtp-Source: AHgI3IYhEPuhRlfhi8ipilsgSCxwQpwnrU6iLAZtjH7MpyUepD0/abQ8xYRUMu2HvBEp3UG25hjQQ4ea7tOtIyjI5W0=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr810931itk.70.1549009487268;
 Fri, 01 Feb 2019 00:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20190131092349.11469-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1902010842010.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902010842010.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 1 Feb 2019 15:24:21 +0700
Message-ID: <CACsJy8B=7NsnnoSH1Bt_C-Nop95ky=rudHU3SOVERVudDD7Tfw@mail.gmail.com>
Subject: Re: [PATCH] help: align the longest command in the command listing
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:42 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > diff --git a/help.c b/help.c
> > index ff05fd22df..520c9080e8 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -85,7 +85,8 @@ static void print_command_list(const struct cmdname_help *cmds,
> >               if (cmds[i].category & mask) {
> >                       size_t len = strlen(cmds[i].name);
> >                       printf("   %s   ", cmds[i].name);
> > -                     mput_char(' ', longest > len ? longest - len : 1);
> > +                     if (longest > len)
> > +                             mput_char(' ', longest - len);
>
> Why not simply replace the `1` by `0`?

While it makes the diff shorter, I think it's a bit more confusing
(why add zero spaces?)
-- 
Duy
