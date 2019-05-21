Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20201F462
	for <e@80x24.org>; Tue, 21 May 2019 16:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfEUQGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 12:06:31 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38728 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfEUQGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 12:06:30 -0400
Received: by mail-vs1-f66.google.com with SMTP id x184so10446067vsb.5
        for <git@vger.kernel.org>; Tue, 21 May 2019 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU7vYo606hRurpvJj+b4lWKofA8Z+dRBYcMcZO0u3VU=;
        b=VzvOk4WrhH40UvovHtQUlxtGWBTAn7qHK8YiHFWiqG436tYWzq9zac7IEwaGr25aEE
         85dbl7h7Y0FuJks/GpevBhUdrCHQFMKu2KOjRyG7/C8dK5plCVpk4mQg/8zmS4h9C0Vj
         EYP9ZIFsv55uU304RRkEjm1/mhx4KinfcMDsnP9gTgs7tvTGFS5PssmSeNWok+RX+BGd
         nJrH9zu2Fs/OA1KTojmeWCjOa8Rhm8ez6msq05q2qTnE4tiiGYy9OREMcPcWtT1/XRJf
         KBPhDHKusc/R38JRdgvIu71xwxpBxeixckJ9ddPXTyu3+dLhajmylO7DMiGIBWxNBXZe
         V9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU7vYo606hRurpvJj+b4lWKofA8Z+dRBYcMcZO0u3VU=;
        b=dnAZYWQ4D96ah6MzIQ9IhkEZVVocalw8GA6XXBeFzgbr37dWX63gykgF9NaOrWSjIZ
         Q2eEULNWbZ3gy/BAEVI73OX3ddTSKwsPkhV+5UJwQo6TXJh4cVZQISseMj3XbVbMuDcb
         t60uy45PxA9cc2wK1H97tk1A2aPQyG/rJRcDhHbYPlJl2+ZfMmgRaFuA/Rgc3eTq/lCR
         ZK8Mqv+3gBryBpEs3aEcy1H0gErq6sPtaPu03F6dfgda1d21hDYSyR1L3O+wwjivD42x
         JQKVKQdTRHVpa+Nos5qOydk4m1RzFDG6RxqEgMwc1EXs9w0/ALels1QjOlPRwE0WoFbt
         5tRQ==
X-Gm-Message-State: APjAAAWMeW7pGtWHfg0EKZYBMJ+85M2eYnbKVTR4t/sKfj+VjgSqKy8d
        RA4jEYEaJZJZfl1Lpda+uPKFH78JfbRY6IQCLN4=
X-Google-Smtp-Source: APXvYqzYVxAmKiM4TQH5s/8kb5uqPxy/BmJUpzx4xYhTqJQv7lqYQyNis9FSALfrwjUEXOUeCZKgEUT2MYe1ux6E46g=
X-Received: by 2002:a67:df13:: with SMTP id s19mr42353094vsk.175.1558454789611;
 Tue, 21 May 2019 09:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190517204826.45308-1-emilyshaffer@google.com> <20190521010036.70378-1-emilyshaffer@google.com>
In-Reply-To: <20190521010036.70378-1-emilyshaffer@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 May 2019 09:06:18 -0700
Message-ID: <CABPp-BHehO4dJCpNHws=PAaqxTyoeLyb3N1BGFG+AEEgBYVtBQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc: hint about GIT_DEBUGGER
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 6:01 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> We check for a handy environment variable GIT_DEBUGGER when running via
> bin-wrappers/, but this feature is undocumented. Add a hint to how to
> use it into the CodingGuidelines (which is where other useful
> environment settings like DEVELOPER are documented).
>

Two very minor nits:

> It looks like you can use GIT_DEBUGGER to pick gdb by default, or you

I think it'd sound better without 'It looks like'; perhaps drop that part?

> can hand it your own debugger if you like to use something else (or if
> you want custom flags for gdb). Hopefully document that intent within
> CodingGuidelines.

Maybe just leave out 'Hopefully'?

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/CodingGuidelines | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 32210a4386..e99af36df9 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -412,6 +412,12 @@ For C programs:
>     must be declared with "extern" in header files. However, function
>     declarations should not use "extern", as that is already the default.
>
> + - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
> +   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
> +   run `GIT_DEBUGGER=my-debugger-binary my-args ./bin-wrappers/git foo` to
> +   use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
> +   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
> +

Other than the minor nits above:
Acked-by: Elijah Newren <newren@gmail.com>
