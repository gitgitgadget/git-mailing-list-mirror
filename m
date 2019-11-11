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
	by dcvr.yhbt.net (Postfix) with ESMTP id 625601F454
	for <e@80x24.org>; Mon, 11 Nov 2019 01:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKBEW (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 20:04:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46864 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfKKBEW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 20:04:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id x11so10582644eds.13
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 17:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9UVimI3iVB1uaRHYhKMUhAF5mr7VnSgEjNr53T3zfU=;
        b=ZuEve+bmB15kAqkVQVnHIxP6KuMD5Cug1G2TD2QSFjnw6SxWDNAdp/1Sks3AjHoPzN
         g5EVQJPNBpcKAPEB+RlGKvhk5rftRfiddBXCWu4UcFmtXY8qsu9DcSwbSNJo9FwoCJMj
         4s1ZQcvSQZM0HyBYQ6LwQvV5YmfcRNJMEM1zmjleE/k9Vp1f8SOUnKwFQVK8d2xeTxwW
         wAn/biuLC5IUvw4cGlB4Ozag8mx8NScKBMMf1rvOG+yR8kzuprBzGynn8t9bBHIFVK0X
         vbz5ppRzg4kh3FO9OA3OuclZGW1VBgW7Yq8Komq+HGHaKMJZ6irrfy3evs1Ld96GB0JC
         QYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9UVimI3iVB1uaRHYhKMUhAF5mr7VnSgEjNr53T3zfU=;
        b=esBMDo/sg7tbRBUcVkEkSZ5tw6tIMrDo4LT8+qH1FHKLO4siqySRV/NgnT5ShH9ydz
         IrX65N1ESRfN69R3AZvCa3i6jG8AUMm4w6Zk3R7l3Ep2rYsMwgYcoRqiCxzbEn2MpSRl
         hASD7f86A3VOpjFTOorCz1zhdTGYd+AX8YWZyl8GJledw6TrgWkdhltQau2UVGCjxaEq
         iaPyNBBHjpI6x65mWRQCJgjjNpAmqXuEoSDUbbEp6knRo5S8kNyMqyKjw0PduAgLFaCn
         d0qfqxi0yubq4jX5VMF8OXdM4JyGqx9KPedduyKkosDnxDHZlZwjfe1YHjTSN+Hx+BRb
         6bEw==
X-Gm-Message-State: APjAAAXOL6hwle0dXAfB238uhWM2hCJQPVEpIxtKIXtniEUC2Q4/oreo
        Olq/slf2bc7+Plzv7Til59/X11jhU1hzuZBJKk4=
X-Google-Smtp-Source: APXvYqySs7Vl/Ti/UaRn5qQi1XwN2nbhN3ABjVBsD04jYzyKrfnZq+ad59TRl4nOszfvcfhL+iGiZhQ1XIMdWaA4arg=
X-Received: by 2002:a17:906:245b:: with SMTP id a27mr20623460ejb.192.1573434259870;
 Sun, 10 Nov 2019 17:04:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com> <3499b99538425f9605fead842c10bc63238f94b9.1573034387.git.gitgitgadget@gmail.com>
 <20191106220324.GD229589@google.com>
In-Reply-To: <20191106220324.GD229589@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 11 Nov 2019 14:04:08 +1300
Message-ID: <CACg5j26J_MpmfF+-5g=V0yZAXTLN7KXm62EbV=fxG010-75Mgg@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] sigchain: move doc to sigchain.h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 7, 2019 at 11:03 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Nov 06, 2019 at 09:59:38AM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Move the documentation from Documentation/technical/api-sigchain.txt
> > to sigchain.h as it's easier for the developers to find the usage
> > information beside the code instead of looking for it in another doc file.
> >
> > Also documentation/technical/api-sigchain.txt is removed because the
> > information it has is now redundant and it'll be hard to keep it up to
> > date and synchronized with the documentation in the header file.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  Documentation/technical/api-sigchain.txt | 41 -----------------------
> >  sigchain.h                               | 42 ++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+), 41 deletions(-)
> >  delete mode 100644 Documentation/technical/api-sigchain.txt
> >
> > diff --git a/Documentation/technical/api-sigchain.txt b/Documentation/technical/api-sigchain.txt
> > deleted file mode 100644
> > index 9e1189ef01..0000000000
> > --- a/Documentation/technical/api-sigchain.txt
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -sigchain API
> > -============
> > -
> > -Code often wants to set a signal handler to clean up temporary files or
> > -other work-in-progress when we die unexpectedly. For multiple pieces of
> > -code to do this without conflicting, each piece of code must remember
> > -the old value of the handler and restore it either when:
> > -
> > -  1. The work-in-progress is finished, and the handler is no longer
> > -     necessary. The handler should revert to the original behavior
> > -     (either another handler, SIG_DFL, or SIG_IGN).
> > -
> > -  2. The signal is received. We should then do our cleanup, then chain
> > -     to the next handler (or die if it is SIG_DFL).
> > -
> > -Sigchain is a tiny library for keeping a stack of handlers. Your handler
> > -and installation code should look something like:
> > -
> > -------------------------------------------
> > -  void clean_foo_on_signal(int sig)
> > -  {
> > -       clean_foo();
> > -       sigchain_pop(sig);
> > -       raise(sig);
> > -  }
> > -
> > -  void other_func()
> > -  {
> > -       sigchain_push_common(clean_foo_on_signal);
> > -       mess_up_foo();
> > -       clean_foo();
> > -  }
> > -------------------------------------------
> > -
> > -Handlers are given the typedef of sigchain_fun. This is the same type
> > -that is given to signal() or sigaction(). It is perfectly reasonable to
> > -push SIG_DFL or SIG_IGN onto the stack.
> > -
> > -You can sigchain_push and sigchain_pop individual signals. For
> > -convenience, sigchain_push_common will push the handler onto the stack
> > -for many common signals.
> > diff --git a/sigchain.h b/sigchain.h
> > index 138b20f54b..a990f18cf6 100644
> > --- a/sigchain.h
> > +++ b/sigchain.h
> > @@ -1,12 +1,54 @@
> >  #ifndef SIGCHAIN_H
> >  #define SIGCHAIN_H
> >
> > +/**
> > + * Code often wants to set a signal handler to clean up temporary files or
> > + * other work-in-progress when we die unexpectedly. For multiple pieces of
> > + * code to do this without conflicting, each piece of code must remember
> > + * the old value of the handler and restore it either when:
> > + *
> > + *   1. The work-in-progress is finished, and the handler is no longer
> > + *      necessary. The handler should revert to the original behavior
> > + *      (either another handler, SIG_DFL, or SIG_IGN).
> > + *
> > + *   2. The signal is received. We should then do our cleanup, then chain
> > + *      to the next handler (or die if it is SIG_DFL).
> > + *
> > + * Sigchain is a tiny library for keeping a stack of handlers. Your handler
> > + * and installation code should look something like:
> > + *
> > + * ------------------------------------------
> > + *   void clean_foo_on_signal(int sig)
> > + *   {
> > + *     clean_foo();
> > + *     sigchain_pop(sig);
> > + *     raise(sig);
> > + *   }
> > + *
> > + *   void other_func()
> > + *   {
> > + *     sigchain_push_common(clean_foo_on_signal);
> > + *     mess_up_foo();
> > + *     clean_foo();
> > + *   }
> > + * ------------------------------------------
> > + *
> > + */
> > +
> > +/**
> > + * Handlers are given the typedef of sigchain_fun. This is the same type
> > + * that is given to signal() or sigaction(). It is perfectly reasonable to
> > + * push SIG_DFL or SIG_IGN onto the stack.
> > + */
> >  typedef void (*sigchain_fun)(int);
> >
> > +/* You can sigchain_push and sigchain_pop individual signals. */
> >  int sigchain_push(int sig, sigchain_fun f);
> >  int sigchain_pop(int sig);
> >
> > +/* push the handler onto the stack for many common signals. */
> It was lacking in the original doc too, but I want to know which common
> signals it pushes for. Is it too much work for you to peek in the
> implementation and let us know?

Sure, no problem, I'll add the signals to the comment.

> >  void sigchain_push_common(sigchain_fun f);
> > +
> >  void sigchain_pop_common(void);
> >
> >  #endif /* SIGCHAIN_H */
> > --
> > gitgitgadget
> >
>
> Otherwise this one looks fine for me.
>
>  - Emily
