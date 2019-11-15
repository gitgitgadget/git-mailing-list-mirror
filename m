Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A2E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 16:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKOQ3u (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 11:29:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39928 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfKOQ3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so4998175plk.6
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ror8xmJYRjLBovBJvjXh0RTxjB6V8CZjhC042tTfSM0=;
        b=mCpdehBqbNbBgdWBGMNXn42SaGs/dbENnElObXv50BkTY1M1eRMA02u3ZqjBfyHhso
         vA0GyMMN9srtgFrUG0p4gNz3XP7dxovMgyMuAqNVHOszPWmu2JxGkvqICNnUqwk0yZKL
         6PrxrlAZs+48BvSFqGv9xpaC4A7Kk0ykhL0BeJjc6K+jfjaPIbO+Su588zOeziX2omXe
         gJGk02P8juQdn6Xyk2Tzn4LhDsn6FAFW9Csjkc93SgVwPsyF3I0pulOpVEAc4oUTpWsM
         0FPj7wg/jfJQEmupel/hl3v1rh3CcYjj7SMUSYqyoO2YkcMvwvLnjnGJpe/X6GpaHePi
         cpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ror8xmJYRjLBovBJvjXh0RTxjB6V8CZjhC042tTfSM0=;
        b=pq5cZ2UePcipt3/qQqrn/qNUk2IAsONxSC0AlWuImpqVhGSMYZmOe4Xx1EmBCqaHQY
         9+jMFFSRM5oDkzQ1QLCbaNiU5HvxoXMnOFeKT9lf1KOAd7uKmryi3bhX7x3vi19I0/vG
         GWj2T28ZuwN7Dp4fv+FvUuZMK+fgMUij4tiYRJIdWD2rTXb8VKfu2v23yIs4af2naY6m
         3ICGsDKDzVjPWgXkdlSE6hppDa7WSLj9zl+x95yxWC6hHBFyUmY8B6VUOic7hvdsrKkU
         GjhPMpEpcWgXl0GaqRiLDzwlpTnyKzuHcR15yEi28kT2BEdQMWNdLbaFJVTa5+dQoP0M
         qJVw==
X-Gm-Message-State: APjAAAVe4L4A/B7MmkDglds3EbIsuneHxEap4JF9ec4Fg8TDdW+ScVkB
        pI/EBaN6VlSoztBrAq3t3Pvw+u3/h7b8pyLu9RiqV3Ke
X-Google-Smtp-Source: APXvYqwu+NMw1jPIqbVlFuKTP8IwsLk1h+KLGcCKA+AHYiGJ2XdW7HVAHCu3/P/YH5JsiFyP+ddaMJ3AJLy6df2kI5U=
X-Received: by 2002:a17:90a:b109:: with SMTP id z9mr20272305pjq.108.1573835389450;
 Fri, 15 Nov 2019 08:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20191115160330.A64EBD756F@wsmn.osm-gmbh.de>
In-Reply-To: <20191115160330.A64EBD756F@wsmn.osm-gmbh.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 15 Nov 2019 17:29:38 +0100
Message-ID: <CAN0heSoW1GWEDxQN-d9bR4Vs5vzMaeDMar=QzShhcVNO1A0Sxg@mail.gmail.com>
Subject: Re:
To:     Martin Nicolay <martin@wsmn.osm-gmbh.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>, yuelinho777@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin

On Fri, 15 Nov 2019 at 17:17, Martin Nicolay <martin@wsmn.osm-gmbh.de> wrote:

> While working with complex scripts invoking git multiple times my
> editor detects the changes and calls "git status". This leads to
> aborts in "git-stash". With this patch and an appropriate value
> core.fileslocktimeout this problem goes away.

Are you able to patch your editor to call
  git --no-optional-locks status
instead? See the bottom of git-status(1) ("BACKGROUND REFRESH") for more
on this.

> +long get_files_lock_timeout_ms(void)
> +{
> +       static int configured = 0;
> +
> +       /* The default timeout is 100 ms: */
> +       static int timeout_ms = 100;
> +
> +       if (!configured) {
> +               git_config_get_int("core.fileslocktimeout", &timeout_ms);
> +               configured = 1;
> +       }
> +
> +       return timeout_ms;
> +}
> +

> @@ -172,7 +174,7 @@ static inline int hold_lock_file_for_update(
>                 struct lock_file *lk, const char *path,
>                 int flags)
>  {
> -       return hold_lock_file_for_update_timeout(lk, path, flags, 0);
> +       return hold_lock_file_for_update_timeout(lk, path, flags, get_files_lock_timeout_ms() );
>  }

This looks like it changes the default from 0 ("try exactly once") to
100ms. Maybe we should stick with 0 for those who don't jump onto this
new config knob?

Martin
