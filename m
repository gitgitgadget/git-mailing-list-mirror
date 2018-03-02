Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25AA1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 20:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeCBUee (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 15:34:34 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:40502 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932917AbeCBUec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 15:34:32 -0500
Received: by mail-pl0-f51.google.com with SMTP id i6-v6so6324231plt.7
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CR1BjZzlfjV+JRxGCYag8OuA1TuapC8y3vMI8gHNiYA=;
        b=fSdJMzoKCnYfxxJ9txRFZIxAx7IJnyceyo+VyyXhO7MARJ4XKRmxngBRFer0PxWolw
         aYD8cuR87NSfa31j2s8zcJoE5IC5YmajQsEhUThz7UG/BWb99YhnM3vlFFtE7p9rxZiV
         u+XsZzwl5jpXcX9YAMt1BpTzNON4glisIriGlj56w5i+4KQU30hMCdlJWDXwmc8exlOF
         9ME9puN5+hxmC6D/F8YZ3CHMqekt9uRFknbg0RfwrKDaQQgtyhJUljNMprTG45skLBk0
         BUo8gyyjoh6YvYK7rXj8rNvNHEPIEN5u515Khi2OgjvsdYnT2u6PmoL8WSSad+GbNR7h
         +8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CR1BjZzlfjV+JRxGCYag8OuA1TuapC8y3vMI8gHNiYA=;
        b=Op8ofKgzxL5njpBRMXdkAc4iu7FQxHvi9qy46mywOIjJ+niJYPSUpzZTJy1k6jd8Cy
         Rdr/FuCMlJqDWtWeYiVurdax9aS03maqxKQyJPIm+vh2O4t5MYV1yIhXOBIwrx8hOyhU
         W7Wz92A2qDam5dETw+cTfWe2BnhYU/27nOaGTvktWfsy6sENKc7ZOv5zo5+itp2wSb8Q
         tmhJdfr0leYBrKEZv0drbQ5xSKm4YXl0x9kYH9ni7BRMa5aoyTLLrnJRFTFy3f/Irl4F
         WSYgdNEm0xjTW9o1tKjvvcn+k/2DHFIhGMj2pzjA0xd/emDTyp/MpiC/JHhDeL2MBYeE
         zNYw==
X-Gm-Message-State: APf1xPDyxv9BUdF3zkL5mOWCMSVzb6hGbiSX6wFzuEG3riXxmcdPnws7
        V7gLTPyJOhxXOjVUhQSJbvMPdBR4L0lhyC/kNVAdEA==
X-Google-Smtp-Source: AG47ELtZs3NamYahtSdnqgCZM7VU/QpQ7GNE/c127nktIrZ/L5ZiHXXrA8fBU+aI5rrHJxer8om+qLGjPSS2eZ5DSH8=
X-Received: by 2002:a17:902:5596:: with SMTP id g22-v6mr6173333pli.4.1520022872117;
 Fri, 02 Mar 2018 12:34:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.137.23 with HTTP; Fri, 2 Mar 2018 12:34:30 -0800 (PST)
In-Reply-To: <xmqqefl2cqsd.fsf@gitster-ct.c.googlers.com>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302104232.GA11074@sigill.intra.peff.net> <xmqqefl2cqsd.fsf@gitster-ct.c.googlers.com>
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Fri, 2 Mar 2018 20:34:30 +0000
X-Google-Sender-Auth: HFAMpTaOPE2sjHTQ7_2vAKX2Q1U
Message-ID: <CAD-Jur+nRsDnV2YrUwC9pt2aLCYHpEunXFKb22KdZ0sKF-Ga+A@mail.gmail.com>
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2018, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> Unfortunately, I don't think there's an easy way to do what you want
>> (show word-diffs but apply the full diff).
>
> The current "word-diff" discards the information on where the lines
> end, and it is pretty much hopeless/useless in the context of "add
> -p".

This is unfortunate.

I am familiar with the model-view-controller ("MVC") paradigm used in
some software packages. I had hoped that Git followed this paradigm
somewhat, and cleanly separated the underlying model of the diff (i.e.
a representation that would be generated in all cases where a diff is
needed), and the view of the diff (i.e. the visual representation,
e.g. word-diff, line diff, colored, non-colored, etc, as requested by
the user).

Such separation of concerns strikes me as being the best approach
here. It could be a lot of work, but I would be grateful if the Git
developers/maintainers could work towards it as an end goal for this
aspect of Git's architecture.

Unfortunately, I am not very familiar with the Git codebase, nor
well-versed in its primary languages, so I can't be of much help here
:(

> It would be a good addition to revamp it so that it keeps the
> original lines in pre/post images but only colors/highlights the
> byte ranges in such a way that (1) on a pre-image line, paint only
> the byte range that do not appear in the post-image, and (2) on a
> post-image line, paint only the byte range that do not appear in the
> pre-image.
>
> E.g. Given these two
>
>     diff --git a/1 b/2
>     index aa49234b68..1cd9f6b5fd 100644
>     --- a/1
>     +++ b/2
>     @@ -1,2 +1 @@
>     -a b c e
>     -f g i j
>     +a b d f g h
>
> the current word-diff would give (I cannot do colors here, so I'll
> upcase the colored letters):
>
>     @@ -1,2 +1 @@
>     a b C ED f g I JH
>
> as the output, but if we produced
>
>     @@ -1,2 +1 @@
>     -a b C E
>     -f g I J
>     +a b D f g H
>
> instead, then colored "add -p" would become easier to see.
>
> And that would be useful outside the context of "add -p", which is a
> huge plus.

This would be much better than the current situation, where the visual
representation gives misleading feedback about the underlying diff,
and where the error I reported crops up.

However, in my opinion your proposed solution would still be not as
good as separating the two concerns, as described earlier in this
email, on two fronts:

1. It would yield, IIUC, less flexibility to create new kinds of view
based on a consistent, standardised underlying model.

2. It is harder to read, for some types of input (e.g. prose) than the
view generated by the existing word-diff algorithm. Your approach, as
outlined in your example above, requires the reader to visually jump
(saccade) between two lines that are separated by an intervening line,
in order to see what has changed. The existing word-diff is much
easier to use: it puts the changes right next to each other, avoiding
line-skipping and allowing horizontal saccades (which are much more
familiar to people used to languages written in left-to-right or
right-to-left scripts).

I don't want to sound negative. As I say, I think your solution is a
big improvement on what currently exists. But I would see it as an
intermediate solution - a stopgap - rather than an endpoint of
development.

In other words, if your solution would be much quicker to implement
than the one I proposed, then please go ahead with yours first, and
please add mine to the longer-term to-do list :)

Thank you again for helping to make Git such a great tool, and for
working tirelessly to improve it further!

P.S. There is a related StackOverflow question here:
https://stackoverflow.com/questions/49058817/git-add-patch-with-word-diff
