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
	by dcvr.yhbt.net (Postfix) with ESMTP id F180B1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 22:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfH1Wv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 18:51:27 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39502 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfH1Wv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 18:51:27 -0400
Received: by mail-vs1-f49.google.com with SMTP id y62so1124561vsb.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGwFzp9bCogOhF37XsofKlcSKyD/yM+r4hyQzgV5oAU=;
        b=P1fGJkta4cDhx9GMQDQBoydY7+CZFhjhzGpzpHEhOh+hVP0ljl685ZqROalBAMK/75
         sHKZc1+NXl/+W/Wsd8/3ebY1/MgMT6qvf4kAMghVot0JUqTO8Q5RcAbW4Ph8eo7p/E9a
         p9EquP3uWSvdfcPEhzeOfy3LCF5t3pVYkdPteRskr3ny4FaTpUNCiYz3gIxkqphdhcLQ
         miSeHjp2EDfOgfa/6c4ZxwbIQjOQEFU2TR6oP7N6XSYjb1ShAFKFa0ngtQUboYdXhmzE
         z65CIUNrVGoptCvk8bXKQ9hRl2FM6Ra31Ic5RGNPuXJvOZ3oavwMCO2ptWgHUjsp5+Fl
         tfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGwFzp9bCogOhF37XsofKlcSKyD/yM+r4hyQzgV5oAU=;
        b=ph6xda7vZ5Hdj00qWQLjqpmIdwmhThBRuKj9N5Q5BCdttJiYM4zhwlOf6u1/Cj33Zb
         3j5Gm86cTpSva5ZOKz5X16R8IJ+dnLlYlXRBr4C+HmpG805EnnG9tzqrlWhkBH6L6k0v
         Iu0G+sMC6+mvYO2h1Biq9pKjYBbV+aEhT3/FeaubXqexn7p1oo6vo31F81+QLfm0scEE
         ZQW3SWW8dgqRgH7WNhdVGBKaBB4WQnB7gVYmZ9y1kop4MwbKpKEQvrPKNjLhaZB1CVvV
         rOoc+Gp8HnjFxgTHa2qoaiolqsQBfsueAwY4cA1FDeVdNNWB6qG/qz4L7juBgsP5ImHZ
         A36g==
X-Gm-Message-State: APjAAAWDWuW5AexKXqpdbJcXchTlOlZ2UwG6QeeN7hGXiRN+qVRTmi5v
        X3jGdIvCpgAmvnaSyuSTcb/Cu8k57wFR05kYQLw=
X-Google-Smtp-Source: APXvYqx8TwFiyZgwqqlLxO2rS+Woj5nDsHIxfcTq251sqTbszExLFeOkwQS8nEMo0ncZfeCMEWwKvf/aG6sKVv2WhEo=
X-Received: by 2002:a67:f546:: with SMTP id z6mr3626711vsn.136.1567032686263;
 Wed, 28 Aug 2019 15:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <877e6x3bjj.fsf@osv.gnss.ru> <20190828155131.29821-1-newren@gmail.com>
 <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com> <87a7btqeyx.fsf@osv.gnss.ru>
In-Reply-To: <87a7btqeyx.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Aug 2019 15:51:14 -0700
Message-ID: <CABPp-BEsRL-JipotZ2FyrXiPcry6aSAvL8e5cbOm5jrPM63j-g@mail.gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various
 ff-related options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 12:15 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Hi,
>
[...]
> Dunno if it helps, but here is what I came up with somewhere in previous
> discussions:
>
> --ff::
> --no-ff::
> --ff-only::
>         When the merge resolves as a fast-forward, only update the

I think this loose wording (that you just took from the original) is
problematic.  Saying that a "merge resolves as a fast-forward" seems
to imply that there are circumstances when a fast-forward is the only
option.  An _individual_ can decide to resolve a merge as a
fast-forward in some circumstances, but it's certainly not the only
choice in any circumstance.  If you want to keep this wording short,
you could replace "resolves" with "can be resolved".

>         branch pointer (without creating a merge commit).  When a fast

Only update the branch pointer to what?  (Yes, I know the original
text we were improving left this unclear, but it's worth noting.)

>         forward update is not possible, create a merge commit.  This is
>         the default behavior, unless merging an annotated (and possibly
>         signed) tag that is not stored in its natural place in
>         'refs/tags/' hierarchy, in which case --no-ff is assumed.

Maybe it's just me, but I think it takes extra human cycles to figure
out that this paragraph is referring just to the --ff case, and that
users might not be able to do so until after reading the next 2-3
sentences.  While more brief, I think it will cause people to need to
read the description for these three options twice, removing most the
savings from being shorter.  It'd be better if it could be re-worded
to not need re-reads.

> +
> With --no-ff create a merge commit even when the merge could instead
> resolve as a fast-forward.
> +
> With --ff-only resolve the merge as a fast-forward (never create a merge
> commit). When fast-forward is not possible, refuse to merge and exit
> with non-zero status.

Something else I was trying to address with my patch that perhaps you
can see a different way to tackle: Using the wording "when possible"
is probably going to make users wonder when a fast forward is
possible; the "can be resolved" wording tweak also makes it more
likely they will wonder about this.  Another question they will be
wondering about is what a fast forward is (which you partially
explain).  Some basic knowledge of both are probably very useful in
helping them decide which option to actually pick.  As such, I think
trying to explain the answers to these sub-questions will assist them
in knowing which option to use.  Simply inserting a couple phrases
(e.g. "when the merged branch contains the current branch in its
history", and "only update the branch pointer *to match the merged
branch* and do not create a merge commit") may help a lot.

Anyway, I'll send a v3 addressing Martin's comments; if you've got
further suggestions for streamlining or rearranging, though, please do
send them along.
