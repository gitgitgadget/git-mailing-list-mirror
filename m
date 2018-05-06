Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066C3200B9
	for <e@80x24.org>; Sun,  6 May 2018 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeEFUDM (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 16:03:12 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:42947 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeEFUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 16:03:12 -0400
Received: by mail-pg0-f47.google.com with SMTP id p9-v6so15827996pgc.9
        for <git@vger.kernel.org>; Sun, 06 May 2018 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Brm3eEQOvlXhKyptBoI3ldXCSutvwXpbget0NlthKdw=;
        b=FyZP9bpg+P4/nYc8orMs9kfXEH+4IjxXpOeBHOeWUt5siP7erIgyJEg3Mw8oq1oPgo
         eQDhqLsdB9ouisN7orBgcBswEvNZNrq3BMnu4Whkwr4MkGF8PQ4g/3OPkvKu1qgOOQD9
         E4MbUPHzTcS3i6SC7bwsMkliuB9IWCaE6ZBJuxufe/f3sSxNmjKL682/8jxqFv8nTzZM
         hHvLTWEqzzx7Pw4jGwE4h6GP+4y1w/F2nnS8JyJse92mujSCqqeWjg8YmDsKnZK5dBjB
         eBlzgLUYU/rdAR3XnaNE8gLcjqHR4v7uOv1DZY6+XKXCaqTlaAVn9MSmiWAiW2QbBts6
         trlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Brm3eEQOvlXhKyptBoI3ldXCSutvwXpbget0NlthKdw=;
        b=L435D5ZVe3xfTBCVyxe8qUFIZK5hnaUwVEYoKBeixgnIfj+hI1m9MSrVu1DSQG3Tks
         oTi/7++/XMZQ0rIyMN3W5nQtvX4MQFdv8c1BgrRuPKJksJ8PjVo+KPVZu2Cg29YN5FWn
         se6I0pOQNqNh6YPmbAdvvuNQIe76Q5kI+z7LAWLoRlMJW/1PjEQ6SdoZG5f48ycvijv0
         g8XWCfy5kBSiaNPl4sKKcgo6Na+MJQgRP9sdhJetMNcwv2Dy6cirbnI1JnjeW6nXrBgc
         Epi71/Pe1vvM3gpeNAce3KPKLeUgwfttnNSOM5gjybVF/zQfDBcE9VClPfp5VD4jA/pH
         egTQ==
X-Gm-Message-State: ALQs6tBN5zFwOvwPWcrOqBEaIaGBEPaNziylNH4WhM3xs7a7u167Iyqf
        Gwyy9jXB0xeVYj4xU9TgENKElab9x+Ro3VcgILo=
X-Google-Smtp-Source: AB8JxZp9FWRyQqxRgR8/gdc1sFW1rfgilRb8PGnWXgZIW6Gw6BLiNFpYXJeP6a4awrsrNrg0H0jFXZLbijhNiNKBijk=
X-Received: by 2002:a63:7b53:: with SMTP id k19-v6mr28364962pgn.146.1525636991468;
 Sun, 06 May 2018 13:03:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 6 May 2018 13:03:10 -0700 (PDT)
In-Reply-To: <20180507020348.31b473b4@kilabit.info>
References: <20180507020348.31b473b4@kilabit.info>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 6 May 2018 22:03:10 +0200
Message-ID: <CAN0heSooYuGkxP9u0Uuwu_TCEOd_pj20L05=bwwHynPOapej6g@mail.gmail.com>
Subject: Re: [bug] Multiline value should error if the next line is section
To:     Shulhan <ms@kilabit.info>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shulhan

Thank you for your report. I'm abbreviating a bit:

On 6 May 2018 at 21:03, Shulhan <ms@kilabit.info> wrote:
> [alias]
>         tree = --no-pager log --graph \
>                 -n 20 \
> [user]
>         name = Shulhan
>
> (2) Run `git config -f git.config -l`
>
> The command print the following output,
>
> alias.tree=--no-pager log --graph -n 20 [user]
> alias.name=Shulhan

Small mistake, big consequences. :-)

This behavior looks correct to me, though. It seems very hard to me to
second-guess what the user meant. For example, what if that third line
contained a "="? Like:

[alias]
        huh = !dd \
              bs=1024 ...

Should Git guess that the backslash on the second line was a mistake?
Or maybe not, because alias.bs = "1024 ..." would be a useless alias?

I think such guessing would be theoretically possible, but especially if
Git guesses wrong, that could be very frustrating to fight against.

Martin
