Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7851F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 08:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfJTIFl (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 04:05:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35323 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJTIFl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 04:05:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id v8so7680763eds.2
        for <git@vger.kernel.org>; Sun, 20 Oct 2019 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rh/CWHK5DkhbP7ds6FqDwH7WSl+qaX6o2R9EpDQLKBg=;
        b=Z+osW7s2FagMi/4TLx3/djMVn2zg8WKts6zjJpA/52F3cux6LAu8uLokzQtzTGsj5k
         1oaLaNhOl0qwD+LBbcuNfdlohfDM2G8cPRRJKeXhO16Cx1XYhR6yvxPjmXZVyf3Or1Nv
         +RVb7drsWtH7f7aP+fQJb0aLScEkdcLHnsDUiXibzlkBqx6VMMfBUih2SZZ4m6yh4FwE
         l7MTJ0jarSE5EljwtW4Qkr4RLmZJhdBaKdBjVf8fUTBMhEGqePawZt6MeofwjTgPPmcz
         7LXrTYXATMfChjl6DmNmTjaD4tBVBtPPj2eGx8h5KYnl1Xw8/TvlVfWHHbHPRJXs5dsR
         7rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rh/CWHK5DkhbP7ds6FqDwH7WSl+qaX6o2R9EpDQLKBg=;
        b=nD0oY+ZhgEjyPm8xgrzQIbfa3t3VB6miypqjHW1vUH30nYP3c/wuNyto+Sk4xkLM7Y
         CwviueKlVAlmzeresvwOkttllWu7qV1dETqOd9KrM8PxjgdhnsEbtEPG4nGfIWRK5beU
         cYwWYq3rKw9vj56V8BNRjLweBrTkI7BdCUNVVaF/XSMdl11Ic4eP6ZNbAi+bW/5Fdm0q
         mjGvUjR3sndPUBcn9CQFVfQCfmc84c2ppAJbJWHJMXWusdiI+Q7/DCG9ToVfwxKS3RmU
         X/ESU7UudDDGrPukjemYCESNeMRdYhsf/TCH+HV56CIiyqboIzALK6p0oe8lJiUrJZMI
         UqOw==
X-Gm-Message-State: APjAAAUaTI7Dz8bU73zfZD1nCSybLm7Pw0QsikgG4E/YWfIFI4/6nlfv
        mvKItigQK0gpybfy0h5jdR7ev5guJB4cEb9R78g=
X-Google-Smtp-Source: APXvYqz1nzwB1sGiKaKhwEcy6gkqZwYnXDwH96hTbcPak/WwpiSJb3NIqqDa2WHEEY09+iiQa8Ia+XBqS854iQQpnFo=
X-Received: by 2002:a17:906:1655:: with SMTP id n21mr16613040ejd.110.1571558739258;
 Sun, 20 Oct 2019 01:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <2e42eafb5db6192829e9e206e9e9905b31f8e8a6.1571357219.git.gitgitgadget@gmail.com>
 <20191018220705.241778-1-jonathantanmy@google.com>
In-Reply-To: <20191018220705.241778-1-jonathantanmy@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sun, 20 Oct 2019 21:05:27 +1300
Message-ID: <CACg5j25HsQwjjruHJ2E7F6UF4jP70x436km8r52qpzNSHXfpbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] config: add documentation to config.h
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 19, 2019 at 11:07 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > This commit is copying and summarizing the documentation from
> > documentation/technical/api-config.txt to comments in config.h
>
> Thanks for this commit!
>
> As for your commit message, as far as I know, the idea is to move the
> documentation, not to copy it. Also, write this in imperative form,
> e.g.:
>
>   Move the documentation from Documentation/technical/api-config.txt
>   into config.h.
>
> Also change the title of the commit message accordingly, e.g.:
>
>   config: move documentation to header file
>
Ok.
> Also, include the deletion of api-config.txt in this commit.
I wasn't sure if the api-config.txt should be removed or not so I
decided to keep it
and wait for feedback. I assume I'll need to delete api-config.html as well?

> If you are doing any summarizing, describe what summarizing you are
> doing in the commit message too.
Ok, will do so.

> > + * A config callback function takes three parameters:
> > + *
> > + * - the name of the parsed variable. This is in canonical "flat" form: the
> > + *   section, subsection, and variable segments will be separated by dots,
> > + *   and the section and variable segments will be all lowercase. E.g.,
> > + *   `core.ignorecase`, `diff.SomeType.textconv`.
> > + *
> > + * - the value of the found variable, as a string. If the variable had no
> > + *   value specified, the value will be NULL (typically this means it
> > + *   should be interpreted as boolean true).
> > + *
> > + * - a void pointer passed in by the caller of the config API; this can
> > + *   contain callback-specific data
> > + *
> > + * A config callback should return 0 for success, or -1 if the variable
> > + * could not be parsed properly.
> > + */
> > +
> >  struct object_id;
> >
> >  /* git_config_parse_key() returns these negated: */
> > @@ -73,6 +107,11 @@ struct config_options {
> >
> >  typedef int (*config_fn_t)(const char *, const char *, void *);
> >  int git_default_config(const char *, const char *, void *);
>
> The config callback is config_fn_t so that documentation should be
> placed above that typedef.
>
Cool, I couldn't find it, thanks!

> Other than that, this looks good to me. The result is perhaps not as
> tidy as we would like (especially with some functions being documented
> and others not) but I think, anyway, that a verbatim movement should be
> done in one commit (this one) and improvements, in a subsequent commit.
You're right, I would have loved to get all the functions documented, but that's
something I'm not able to do right now as I'm still getting familiar
with the code base.
But it's a good start!
I agree with you about moving the documentation and deleting the file
in one commit.
Will do so.

Thank you for the feedback!

Heba
