Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD121F51C
	for <e@80x24.org>; Wed, 30 May 2018 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeE3K0m (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 06:26:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34470 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeE3K0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 06:26:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id a14-v6so8812749pfi.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I7+tM6YJ7q9a6Go80AuDoY50VoFLqvxcYrI4t/4UUfE=;
        b=SaLLILbuQSGX270uz++/4ZxmoDDuKUFcXPol79FNjPwJhTLA5+TA3ZjaM6ywzarSwW
         VVjfLyUHzAFNlfjeyUbA33HFcFDQz9HGsAOg4xi0f/8ECZBJzC/NoF14WDr95HgSxGoL
         yKmI+IPjGUmMj81Os6k8O5HX5iTOCgpkrZPuer5MNxff4g0h5Q2ehkaoaoFl14djFfYb
         EMX9CIqc2E0iSSdBEeXNXSt2oNE/9q35k403owqrQyljSZlA3YlR4qroab3rqadhmdHs
         uJb2+aiPTKILI+VVQuQizeqUbwTzTlSXtIFqy1iVXAXiHYUCGYF+vn4nuvVlvdc5BuTV
         NaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I7+tM6YJ7q9a6Go80AuDoY50VoFLqvxcYrI4t/4UUfE=;
        b=Bi60sR6A4R9EYMmjs8z+/LQuPJWy2fSCvPG5zAZwsWeYUlAYqM7w/zZqAWBaPVeSsJ
         y+Foaf9o8iud5yE08D9btWKoJB29NMT+6FQwvf3V/74rjhrhR880FN6S8aJVwi+GREdF
         rUQ5Z3ebD/D47PJKU6xmuDf6cgkY9kVAHbocKuiJp/2nVPLS8zaKfpZfJosTGPiD/R6U
         v4Apj5N65+yu5UprZMcOWSCpR4N3SEvsJcjrbiMVEm75FAxrNswnv3TWo4GJwxi7U3rM
         9Q21R61EgzZ6N/f3Hh9byBKCzhEwCipEfF1e9uMONYz8NVQ0tOUCEmp9R3MkpY+UUWG3
         HU8w==
X-Gm-Message-State: ALKqPwdSZz3u2QbuXdv7FTBlkev7PMVxvtVoc6F2ZG4o5WpiyLigiVmW
        L0WFTJQZpcO1+y9YwIA9D5E0by0P9LtIN73D29M=
X-Google-Smtp-Source: ADUXVKLlbt1VcK/JqxNl0jQBxR974gyC+IV5qpfH1IhwnvE+TGbQRd2U21jfMcG3yUVNzd5WU8I4A5OqXQIm6MGLJeY=
X-Received: by 2002:a62:ecdb:: with SMTP id e88-v6mr2270955pfm.16.1527676000894;
 Wed, 30 May 2018 03:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Wed, 30 May 2018 03:26:40
 -0700 (PDT)
In-Reply-To: <xmqq4lipel8a.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
 <20180529213957.GF7964@sigill.intra.peff.net> <xmqqfu29gbqp.fsf@gitster-ct.c.googlers.com>
 <xmqq4lipel8a.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 May 2018 12:26:40 +0200
Message-ID: <CAN0heSqmhaKrxYSUKWcxWFR0QwZPOG9kueBPJv6jnMNJpb+aMA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from `advise()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 May 2018 at 08:00, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> But most importantly, it means we could eventually colorize errors, too,
>>> where we are not allowed to allocate.
>>>
>>> So perhaps:
>>>
>>>   void report_lines(FILE *out,
>>>                     const char *color, const char *color_reset,
>>>                  const char *prefix, const char *msg);
>>>
>>> or something?
>>
>> Sounds good to me.  And if you hate the repeated "error:" prefix
>> that makes the prefix on the second and subsequent lines included in
>> cutting and pasting, we could use the two-prefix idea elsewhere in
>> the thread, too.

(That also gets rid of the minor strangeness of my series to introduce an
overly broad `suffix` and use it only for resetting color, not actually
for giving any textual suffix.)

> If we do not want duplicate prefix, another approach is to leave
> everything including alignment up to the translators.  For example,
>
>         error(_("the first line of error.\n"
>                 "       ... and the second."));
>
[...]
> with these entries for that hypothetical "shout in caps" language.
>
>         msgid "error: "
>         msgstr "ERRORX: "
>         msgid "the first line of error.\n       ... and the second."
>         msgstr"THE FIRST LINE OF ERROR.\n        ... AND THE SECOND."
>
> So I do not think the two-prefix idea is necessary (and if people
> prefer to have repeated prefix, that can also be done perfectly well
> within this scheme---the second and subsequent message needs to
> duplicate "error:" at the beginning, which is sort of ugly, but the
> leading spaces for alignment we see above already knows how wide
> "error:" and its translation is, so it is not that much worse
> anyway).

Thanks for lots of good input. Doing the indenting in the error does
mean that to indent properly, the translator needs to know that it is an
error, and not a warning. Or one could say that they would need to know
the amount of indentation anyway so that they can know where to wrap
optimally.

Another consequence is that if we can emit a certain string as either,
e.g., a warning or an error depending on the context, we need to address
that. Using contexts, of course. Thank you for the hint about that. (I
have not checked if we actually have such "this is a warning or an
error"-strings currently.)

Somehow it feels slightly cleaner to me, at least on first thought, to
try to decouple the indenting from the translating and line-wrapping.
But as noted above, the indenting does affect how the line-wrapping
should/may be done.

I won't have as much time as I'd like for tinkering with this the next
week, or even weeks. Hopefully when I do get around to it, I will have
processed all the very good input I have received and turn that into
something good.

Thanks,
Martin
