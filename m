Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6892A1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHMKvh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 06:51:37 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:45463 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfHMKvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 06:51:37 -0400
Received: by mail-ed1-f53.google.com with SMTP id x19so100595747eda.12
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veCGHpwmKqRgqpTNTowYyFMax3qEglCHDx4s/YIkT3s=;
        b=qMp5gjbe58uuN12hAimcxNlS5V/ED3E9bqbYl4h+iw1S9BC8LlzcFq4X92YOGA0ufC
         A5Q7OJ7YBkCD9Zk/7zhnya+zNgBlzyuVVIKINIeXMgNOLGGRzFm1kcahkSZnN5YjarSw
         yKyg7jSTetUSShEpvFlIOVld3ykeJvLZEqC5SJvoJC8FmrS+msgsk+pS5PQ4OenTTvXM
         C4wWW/Bh7HAnvno028B/Y86xPSvtjE7vIJUFeWPzF2LUODb/T6R5PttYL+TR3q2oz+SI
         UziK6vYkxCe8pLXnKIZRZUcZVi6o2J6DJGCqRbm/Vn3AoNzW8Je01DDGS008LoosCSLY
         wZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veCGHpwmKqRgqpTNTowYyFMax3qEglCHDx4s/YIkT3s=;
        b=sksi2s3SyFnRpMFPA0P84wTdiCPP8rhwP6xHTW01tzJozgIgjuxfLLMkVgSMe23f0c
         agt+i+slAyiBmF1TZDi8cdtyj7PZRokUKLzNmKWtvNbFxiWygjCdeexRuiMQSDTm7HUA
         RyYp9RqElNZO5XK1xbEFrz2sgPy5R57dkja2KgE3UQtIHr8xG/X9vFLvdwmvJPMiGVjG
         LbMFuGZPObr9RA033OxnLU4fGeaBNRY9PjxfUtz7yKAECS7jCjwV/t/BuxXfx2YtWJQ6
         nL2tF6Xngki2KJRYr4ocieUNrfQwp3xPeQaanf+4nN/US9zM+zKn62uJf9MRhnrN9sTD
         Y+Dg==
X-Gm-Message-State: APjAAAWPTRVTq4SBi8EZpUjXGK9Lpt8HsAKxzIUl3AfrWDzcH2Hzw7CL
        Cw2XWov6BN/pcf97b2lYyVqdaU+gS4TAV+qlrW8=
X-Google-Smtp-Source: APXvYqx1oXAUvRgFfvKzbr+Kjn0wnwO+BuUm0mpnXmag+iADdO6AZMxSA2V3g01w68rrYqLfJ/hY4pX8/0rw/ZD7Q1c=
X-Received: by 2002:a17:906:3c7:: with SMTP id c7mr25535028eja.187.1565693495225;
 Tue, 13 Aug 2019 03:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW7aOeDEDFJxj+Pro7-fDiaMzOvas-YQs9Vtx02nZEQkpA@mail.gmail.com>
In-Reply-To: <CAHd-oW7aOeDEDFJxj+Pro7-fDiaMzOvas-YQs9Vtx02nZEQkpA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 13 Aug 2019 12:51:23 +0200
Message-ID: <CAP8UFD26K413SmV7bTCkSQmH7iqkm+sJMA4KpDmVv3cswZt37Q@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Tue, Aug 13, 2019 at 6:06 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I just posted a new update on my project:
> https://matheustavares.gitlab.io/posts/simplified-version-of-parallel-inflation

Great blog post as usual!

> This week I sent a simplified version of the series I was working on
> last week (which would still take some time to finish). And I'm
> working to improve it with support to --textconv and
> --recurse-submodules in the added optimizations. I've been also
> working on a patch to make git-grep stop adding submodules to the
> alternates list.

I don't know what refactoring you think is needed on your patch:

https://github.com/matheustavares/git/commit/05536a503b3315d36ad13276af7728adf674ed51

I think it's worth sending to the list with or without addressing the
small nits that I commented on.

Thanks,
Christian.
