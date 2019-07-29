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
	by dcvr.yhbt.net (Postfix) with ESMTP id 162811F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfG2U3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:29:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34443 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG2U3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:29:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so28597013pfo.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IP0c7sI++mXCr78M8B50izbG7+h8ESMKldkuan3onXA=;
        b=BPaxASBVXUrJ1Y7fHh7SijUdtTXRC7p9uTdBwnniZDNDoWOuJC0oRDA83oGckLUm2G
         2ikj6786R2xudcNUk5qEn/5ESeBF561+IPcmdq2S2HED4RcKzZSGOEfr1SyhV7H9INoe
         b9vgjQocB8whsOFbAM77A6SQwlii6A7TYKvNhJiTh4ttTf1Z3U8bmC5saGOW2HmYJN+h
         rcijY6w7gbnW6TOd9JxZ8rycEOQJorDZLXLNsrfdDM+dC7OcXAOC5R6vZvsgwM5H7UVY
         DzZfyQvav4AyM+KTFmAa1fSnkDUANBC9JpyJWi7wJgWD4CBxfV0/ga7KM0ylJB88r5Vh
         ROcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IP0c7sI++mXCr78M8B50izbG7+h8ESMKldkuan3onXA=;
        b=mhJemmPov2ga3f45X3ZBvxcJblCVZNlAORWQ13/102LUs/9X7QE41h+Rn2aDjSZ/pN
         QCnSaAzdsoJQcID+17hTxVLHowipuEiSUnP+TSRdKF4g8PibDOGA5zSvM99Rm/mLgAft
         pJZcmfQKf5QRbgCUDOyN/R3AZxnbc8zqMrGqwMDevP8fD/W0snLZgUoC2qotkU6an22/
         6UU8AN58uHpdpzjTBzt56Ped7e4HVuklM3ugDYhKosmWq8z3g5hOwrQ6FeZYKStl8wDW
         jjllbNYIj9YAtOZG3FlaQ97TFZZ33MnO/wGk9U58xsA0FF9FMxoLvTFvCaTeJwJWkeAV
         +WwA==
X-Gm-Message-State: APjAAAXztF4nSBA3HAOihPfrTYoy52rux5SVUYlUvhZpxdbSYbVqmDh/
        Woyjb7rO3xUWtjtbFP8f7dQc1cM+2n0ysK3l6Iw=
X-Google-Smtp-Source: APXvYqwHqdq+zZ2Kc2T8t0mOI0ElvDFszWKX72kOnJsOZ24SpZ9uXp/3JbbxniccyhvRhy/wu0ZeLdjAyVgR37kKJV0=
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr61791682pjt.108.1564432159380;
 Mon, 29 Jul 2019 13:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 29 Jul 2019 22:29:07 +0200
Message-ID: <CAN0heSr4N-+fjn3+58oUvvv57vDXtA2tR-NEEyoS4toj36V2-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] pre-merge hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Jul 2019 at 01:56, Josh Steadmon <steadmon@google.com> wrote:
> This series revives an old suggestion [...] to make merge honor
> pre-commit hook or a separate pre-merge hook. Since pre-commit does not
> receive any arguments (which the hook could use tell between commit and
> merge) and in order to keep existing behaviour (as opposed to the other
> patch) this series introduces a pre-merge hook, with a sample hook that
> simply calls the pre-commit hook.

Argh, I wanted to comment on this in the cover letter, but forgot and
just left a bunch of nits.

I wonder if we might ever regret naming this "pre-merge" and not, e.g.,
"pre-merge-commit". There's the pre-rebase hook which runs before
git-rebase even starts actually rebasing, so I could well imagine a
"pre-merge" hook which would get called before merging starts.

I'm also pondering whether there should be an "automatic" in there, but
"pre-automatic-merge-commit" looks a bit awkward. Anyway, I'm not even
sure an "automatic merge commit" is a well-defined thing. I can figure
out what it pretty certainly means, but it's not crystal clear. There
might be a need for some more discussion in the added docs for what this
new hook is for and how it compares to pre-commit. Right now, the
proposed docs suggests they're equivalent in a way, but I think that's a
bit confusing -- they are certainly not synonyms, and they'd never both
be called, for example. They can be used for the same purpose in
different scenarios, sure.

I tried coming up with some proposed docs for githooks.txt, but didn't
feel I achieved much of value. :-/

Martin
