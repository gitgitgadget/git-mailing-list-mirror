Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764A41F732
	for <e@80x24.org>; Tue,  6 Aug 2019 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfHFGZK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 02:25:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47034 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbfHFGZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 02:25:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so64933495oid.13
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mguxQXssZ8mYIPjGa06IqYKLSnaXUuhSihT/1XEDR48=;
        b=KLQvKMjIG/hdRaNPDSz5Era/hlSuvOEhFqNTunmK3VdbBmj8/Dhs1Kb2+NwzibMPY1
         kBKNZrtB/Ur0sEy2wpHqOtgVguJ132tL5ZPNXlJo1JawvpjnQ+3B5YiQkrxhs3OwtC4t
         K3EteEyLH6Sxp1HCFw0XJswIVcRUF17hSw0+QV5QXxAMtAyYh2Nd0t+hCVo7PR8PAfRy
         PsA7iXy54Ek5gPAE6EbWr4lpxQ0yDMvgfRoubg84cqQ/uVOjqYL/czz+2SQGCnV5H1PA
         yQlBqW8GGGQY4TR3GEkQW7yIrNSs0PRBQiO1ZhHXnKLYuOdDKyRZI5seFLbyb645ViUw
         sS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mguxQXssZ8mYIPjGa06IqYKLSnaXUuhSihT/1XEDR48=;
        b=KA5wHt5ZMc2pyYArtoL4LLvhivgoPNLjA9V144+5hBKsXVWHU8SlCta5PA4/v99nPn
         JikzEpYa+73PP0d6ZhBdvCrDn2rqCraZE/npAHRH9QFMrA48zETYscJk2vg47fm1uw4L
         brYVwGrNSxic6XKvbqQHsytM3ZWltrf2b8nN6BRQ5FbWe2B4xxL25AI/xm3GOZvQAWeu
         A+HgA2yKHq0otvXEkAnAgf/Brd8RHkjWUXlxTg3F4dnpvHtllspUOQqHW5p+JEBQm5Yq
         Msl/XnTjozLjb+6xVpgCvSCrliXlJppiL++wW6KoUfu9h3qxxB6K1aNooUWl0dCBsYml
         RCFQ==
X-Gm-Message-State: APjAAAXgqL333Vy+dCfMF/4oS0YdCfMWnDxc3ixt1QyQT5lb86DbSg16
        SWccR4+TV1QV77IOZvLoKhuVQuN0BYB6e6af2fs=
X-Google-Smtp-Source: APXvYqzGKBaC5NZUoqXMlYKVL2Hc+yuAyx7VrZCAnvnCTuUuq+nsWYgppIfRQpEUVI05mWggQdB27AHGEY97x2qHeAE=
X-Received: by 2002:a02:ce35:: with SMTP id v21mr2404340jar.108.1565072708621;
 Mon, 05 Aug 2019 23:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.306.git.gitgitgadget@gmail.com> <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com>
 <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com> <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 5 Aug 2019 23:24:55 -0700
Message-ID: <CAPUEsphMh_ZqcH3M7PXC9jHTfEdQN3mhTAK2JDkdvKBp53YBoA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pcre2: allow overriding the system allocator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 5, 2019 at 2:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > LGTM except from the suggestion below that might make the code more "standard"
> > and probably be a good base for a similar PCRE1 fix
> >>
> >> +static pcre2_general_context *get_pcre2_context(void)
> >> +{
> >> +       static pcre2_general_context *context;
> >> +
> >> +       if (!context)
> >> +               context = pcre2_general_context_create(pcre2_malloc,
> >> +                                                      pcre2_free, NULL);
> >> +
> >> +       return context;
> >> +}
> >
> > instead of using a static variable inside this helper function it
> > might be better to use
> > one extra field inside the (struct grep_pat *p), where all other
> > variables are kept
> >
> > Additionally to being more consistent will avoid creating the global
>
> "standard" and "more consistent" are good things, but I am not sure
> I should agree with the argument without knowing what you are
> comparing your suggested improvement with.  Whose standard practice
> are we trying to be consistent with?  Keeping dynamic resources hooked
> to "struct grep_pat" so that (1) different patterns could use different
> settings when they desire and (2) the resources are not hidden behind
> a function-scope static and can be discarded when we are done with
> the pattern, which is the standard in our "grep" subsystem?

It was my impression that we were abusing the struct grep_pat to avoid
having to deal properly with threading and interlocks.

I agree my wording wasn't clear enough and my hinting a little obscure
but the original code is racy and it wouldn't be if the "global context" will be
initialized/maintained there; as an added benefit it will be straight forward to
clear (together with the rest)

I am not advocating that as a good design, but also think the code will be
shorter (which was another rationale for the proposed change, to avoid
introducing yet more bugs and since it was even suggested for inclusion
in the next release)

> I think general context probably corresponds to a bit higher level
> than individual grep_pat.  E.g. when running "grep -e foo -e bar",
> do we expect resources needed by patterns "foo" and "bar" would want
> to be allocated and freed by potentially separate <alloc,free>
> function pairs?

no with a different design; but currently even if almost all the time
we have the same pattern for all workers (ex: -e foo), why
are we doing the compilation (plus JIT translation) and creating this
table and all other context pointers (plus a jit stack) once per
thread?

just so we can move forward with a better design will send a proposed
patch that does things
a little be better as an RFC

> > context for the
> > most common case (when the locale is either C/POSIX or UTF-8) and therefore
> > have a smaller impact on performance.
>
> I am not sure about the impact on performance, but if it helps us
> keep the subsystem reusable by avoiding function-scope static that
> we cannot clear, that would be a good thing.  But "struct grep_pat"
> may be a bit too fine-grained to control general context.

the "performance" point I was making was that with the current code
the chartable is only created when it is strictly needed (meaning the
pattern/haystack will do matching in non UTF-8 mode but with characters
with code higher than 127 and therefore MUST agree in a codepage)

most of the time (like when using UTF-8) the chartable (and therefore the
global context) is not needed (even when using alternate allocators)

there is a chance that PCRE2 might perform better with NED, but not
in my system and since we haven't been using NED with PCRE2 until
this proposed change it might be better to do that independently anyway.

Carlo
