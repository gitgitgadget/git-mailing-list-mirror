Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C3320248
	for <e@80x24.org>; Sun, 17 Mar 2019 13:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCQNNS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 09:13:18 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52640 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQNNS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 09:13:18 -0400
Received: by mail-it1-f194.google.com with SMTP id g17so16606459ita.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMW5xh65NJDDnnOyvEp6tKmNFCnw5KBXzGT3yWxM3co=;
        b=GUp6TpZf69S1Lc6ktldNWCzfQN4BcqzJOLLI99LA8LhFS42Z7cCVP5rxYByLa+VKbT
         o/WYbS6eOA4q5/vpqW+Ap9hepxUGJ6iFXaOspbbau5X1OMIJbYOVWYXxPIg83iIXAinP
         A0I0lt6Na3W8dOeOYc7OMvjnz0p8OE1i8mrIdxA3wk6yYKkLpDnGM17NaZgk93nHv9e3
         2/HYP8mMPmkAqiyWxJKKIuMeMQjRLdiYLVYTOdOwcc1nEQJ0EKc48sF5UmmAVAujtwY4
         Vf8zQhVflxxzxsPJe76t2EU6CAIdaMzUVjD/+xUInxyH0r43g9PlAs1mhLa/fElGuMQO
         LIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMW5xh65NJDDnnOyvEp6tKmNFCnw5KBXzGT3yWxM3co=;
        b=rZqo2OSgbIEVZgc4n9QVyZBG6vX3api4Wjl7rYug5idfv7eG/hJ0TC4/EuxXSsljy4
         mj1nKOMdCWkCAg0w1q7cfBbpLkzCE4Ev+9T75k6JIxBdzj0WO7hZ76gLpY2ZnUMqqdva
         /AsF332Aus3WYse/xXelTk2YWBmbhM6o7vJotSYxH+FEtmncOP0nEdmb7PZLlEPitQMI
         iK4V5Z1fIghdvTlNEA3+ba391fmuS7QKwToUQPOM+lm0lDgBWzH0q+DOA/xA5HIV04Ux
         7ObPmXi8Avy6Zyuv4x/sYC0dVPgnesYUoPcWH5e0HVLkrDqpw88dCLrmz+HqVziXkeJD
         c+FQ==
X-Gm-Message-State: APjAAAWKXwKSli2liZNtd/Itsl4kwdgnudpBvMrph5uA4DNS8eF5zVDu
        5PZEt9ZrwkcNyt120ZSx+W+ZMFMHaI7arQxNTYc=
X-Google-Smtp-Source: APXvYqz5OlpeEt57wOhQeilQHspsHWYFvqmPFCuc3StzYRkHnYQWC9BFAZ+VJHRVenX0JsOjg44fTmGTIERysEjQjKY=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr7720936itf.123.1552828397425;
 Sun, 17 Mar 2019 06:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190228230506.GA20625@sigill.intra.peff.net> <20190301173443.16429-2-tmz@pobox.com>
In-Reply-To: <20190301173443.16429-2-tmz@pobox.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 17 Mar 2019 20:12:51 +0700
Message-ID: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: note config file restrictions for completion.commands
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Poking this thread before it goes completely dead...

On Sat, Mar 2, 2019 at 12:34 AM Todd Zullinger <tmz@pobox.com> wrote:
>
> The completion.commands config var must be set in either the system-wide
> or global config file.  The completion script does not read a local
> repository config.

After the last discussion, I think the consensus was it's ok to allow
per-repo config so we can just drop this and update the code to read
from any config file, right?

>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/config/completion.txt | 3 ++-
>  Documentation/git.txt               | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/completion.txt b/Documentation/config/completion.txt
> index 4d99bf33c9..4859d18e86 100644
> --- a/Documentation/config/completion.txt
> +++ b/Documentation/config/completion.txt
> @@ -4,4 +4,5 @@ completion.commands::
>         porcelain commands and a few select others are completed. You
>         can add more commands, separated by space, in this
>         variable. Prefixing the command with '-' will remove it from
> -       the existing list.
> +       the existing list.  The variable must be set in either the
> +       system-wide or global config.
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 00156d64aa..638f4d6cc9 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -172,7 +172,8 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>         others (all other commands in `$PATH` that have git- prefix),
>         list-<category> (see categories in command-list.txt),
>         nohelpers (exclude helper commands), alias and config
> -       (retrieve command list from config variable completion.commands)
> +       (retrieve command list from config variable completion.commands,
> +       set in the global or system-wide config file)
>
>  GIT COMMANDS
>  ------------



-- 
Duy
