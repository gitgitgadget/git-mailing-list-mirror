Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946761F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJFBV2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 21:21:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35305 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeJFBV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 21:21:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id j9-v6so13612961otl.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Xg7L2lqk90ufbZxj+b6LV4VdbuiVJh2ArHWvMMZSgU=;
        b=cl1yax1PPkKRH5pdtqpaNEZbkN5ZnLrOpA3+xWAdojgyt1qpxUlvTtN6J1zD3lEnwI
         anUXuMHSRHag2GxIUAQpTytyFg4XM48uRewzJ3OmbeUf/wwGR4qdGSz1iU7LhibYL4rP
         B86VZEJEOhemvlktgyxgKTDK2OOgmuvtr47bthH/9U+k6aNgggY/56cvEwYNl6mhyhSf
         kd6A0ybIboNA/UY5/GfxG/WZ2bBa6i9+Nfdn2IFj1cZUjds24/7lJj0nM06x0++LAjUx
         hW99IXA7n+7ITXboPEqjqEUNUSBIuCeJbh6e7UdmKuXHiKaqvZ8FL8sYyQVt+t42lrBW
         TQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Xg7L2lqk90ufbZxj+b6LV4VdbuiVJh2ArHWvMMZSgU=;
        b=hPBEbv2sDwRoQPNGLY/wCVMjcexs22j0W29yFRU5nCXAfY0qG2n/Qiq3G5Hqng5IIN
         TXX0JppdHyPKI3gjqGHbqKcdmPJc05/4hLmIvQGCwISsGKALPGf6v5e2wErw9DyL6xuP
         dax0fyyI+jTNMZv/Y4yIs3VbnfyQ/+VGdiEHwa19gmny9QbyqfynxZYXDRM3fBzmnpkJ
         DFVjDiRCSudfX1WiJa0YwPSwJQweRN8Qj4IR9nEouzAaM0iXAlfcxdfGIk73jzT0qM/M
         +uZc3uvOCCo61/fjbj8BJJGxOiTN0WyGf1PfUT7sk2kvvWmkm0oNYbgQQOHPXhnVW8LJ
         RNfw==
X-Gm-Message-State: ABuFfogMHDFWkd7lE1923/Q4SHlvwYxua/L7UtLt7YrswXMyT20ixH1l
        4u8x3o5Gt7MT8I0VEuh1jqsQFcaGbq7l76zoXjgr
X-Google-Smtp-Source: ACcGV620P3wqbrzvk9gFMOAT9Hm0aFjv81GkdSlyTOD5bydLrP0ob8SdK57mfZFCVPmksv5aVpOUihNs2MkSzVX04qk=
X-Received: by 2002:a9d:32c3:: with SMTP id u61-v6mr6837788otb.173.1538763693811;
 Fri, 05 Oct 2018 11:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
 <a45b646fced228e5a7fab4db7a35c1c6084e58d0.1538581868.git.matvore@google.com> <xmqq5zygwd9k.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zygwd9k.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 5 Oct 2018 11:21:22 -0700
Message-ID: <CAMfpvhKgr8EFbc-hkEcC4ocjW2U2YCopeRuMyLTq9xk9cd8b=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] Documentation: add shell guidelines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 5, 2018 at 9:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > Add the following guideline to Documentation/CodingGuidelines:
> >
> >       &&, ||, and | should appear at the end of lines, not the
> >       beginning, and the \ line continuation character should be
> >       omitted
>
> "should be omitted" sounds as if it is the norm to have such a
> character, but it is not.  The text in the actual patch body does a
> much better job than this.
>
> Perhaps
>
>         Break overlong lines after "&&", "||", and "|", not before
>         them; that way the command can continue to subsequent lines
>         without backslash at the end.
That sounds good. Fixed.

> > + - If a command sequence joined with && or || or | spans multiple
> > +   lines, put each command on a separate line and put && and || and |
> > +   operators at the end of each line, rather than the start. This
> > +   means you don't need to use \ to join lines, since the above
> > +   operators imply the sequence isn't finished.
>
> Correct.  Even though I wonder if we need to say the last sentence,
> which is rather obvious, patch is already written and I do not see
> much point editing this further.
ack

> > @@ -466,6 +466,34 @@ And here are the "don'ts:"
> >     platform commands; just use '! cmd'.  We are not in the business
> >     of verifying that the world given to us sanely works.
> >
> > + - Don't use Git upstream in the non-final position in a piped chain, as
> > +   in:
>
> "upstream in the non-final position" is a bit redundant, isn't it?
>
>   - Don't feed the output of 'git' to a pipe, as in:

Done, but I changed it to "Don't feed the output of a git command to a
pipe, as in:" since referring to it as "git command" without the
quotes seems rather common in this file.

Thank you for the review!
