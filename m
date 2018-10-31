Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4861F453
	for <e@80x24.org>; Wed, 31 Oct 2018 07:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeJaQEs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 12:04:48 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44705 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeJaQEr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 12:04:47 -0400
Received: by mail-oi1-f170.google.com with SMTP id k19-v6so12722448oic.11
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/hcD6dO+3WMoy4vc3bLz1+QdfRs371zaAIZWHCAJnk=;
        b=Yza8ravEL66GkHldMjOz8oWTtTLrx0iHNtz84sy/qyAZMFIS6DfQIPhc2cm+PTDnWn
         hyttf++xStfLtOeWfgOInWCuEgcAaHvJq+BuLu8DiDJxz9MSh95JPnL96nUJDroNaPwX
         gRnPkEDwP1QU7OZnomDgqLJijNnr4rH/hoSbGqHGVX1XVpXhTevUv+Yz1yOj/Oh7s155
         AqC00XN183qA+18t+OATe0XXJhYMe+H4Tw7ey8ztJ9Ku0V06rItD1D8dwIDsWc2ZpxoR
         FEhAjqdfEj76deiH04vZfQko8zDAaY+3bFlBNLrIqKRz6HYRcTm7q00y+GRBzC7JnK9f
         iaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/hcD6dO+3WMoy4vc3bLz1+QdfRs371zaAIZWHCAJnk=;
        b=tWrQn+f7b1IagROxXBVsX8jayIJtC1pCOJ/tI2/lGjBLl2GzD+ex9xcekpLa++cRPd
         7cXjqqF0W8iZEIACdRR7S7ddtN8aNxr5STJUx59rv4TS4/O3SMhZV+b8Xhjqgrl4BkdH
         NfqSZKx0DIqs0HZuV+eE7RJX08ENbnO4QOQmpTqA0MhilrkqarREEu42XypizNZW4OHE
         YZFxLYFwYqmXsThGpxXczy2sGg25aGiIeXzkSHew7Cb7PYZztWCKEiMowpmXNmi+ba7O
         NNtJwaOfPxi141VYO7ymBDqjmEsYonwRaK8f9HT37UZMd3AffKFXt7Gd5UiI48PmXrov
         V2fA==
X-Gm-Message-State: AGRZ1gIXyG4b8mh1I4gmxVGW9e8+TmDvkZ2yikotxEK8IkzjIz2Rj/iv
        60RBNPPo5vyOn3Ga2LXsKfY8Xl1l6hUC8LEHlug=
X-Google-Smtp-Source: AJdET5d2cQU5ILAGA7938OAKU9NfW1SsPyzSyTJvDr/WLtCQwhlFhl5zOKM8zicT8apy3TXdO/jdmbuVk0AdwxgGMmg=
X-Received: by 2002:aca:b2c5:: with SMTP id b188-v6mr1044859oif.160.1540969674740;
 Wed, 31 Oct 2018 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
 <xmqqlg6eyc3u.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg6eyc3u.fsf@gitster-ct.c.googlers.com>
From:   james harvey <jamespharvey20@gmail.com>
Date:   Wed, 31 Oct 2018 03:07:43 -0400
Message-ID: <CA+X5Wn6vGLiQr8O8UVkJnFpVq+OVzOjtxhtqwtZEsyh0RrSz9w@mail.gmail.com>
Subject: Re: Using --word-diff breaks --color-moved
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 12:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> james harvey <jamespharvey20@gmail.com> writes:
>
> > If you use both "--word-diff" and "--color-moved", regardless of the
> > order of arguments, "--word-diff" takes precedence and "--color-moved"
> > isn't allowed to do anything.
> >
> > I think "--color-moved" should have precedence over "--word-diff".  I
> > cannot think of a scenario where a user would supply both options, and
> > actually want "--word-diff" to take precedence.
>
> I am not sure if I follow.  If these two cannot work well together,
> then we should just reject the request as asking for incompatible
> combination of options while we are parsing the command line
> arguments, rather than arguing which one should trump the other
> one---that would simply lead to "in my opinion, word-diff is more
> important" vs "in mine, color-moved is more important", no?

I should have been more clear in my original message.  I don't mean
that if "--color-moved" is given, that the argument "--word-diff"
should be completely ignored as if it weren't given as an option.

I'm not too concerned about my reduced test case scenario.  I'm
concerned about a larger diff, where there's some areas that got
moved, some lines that got deleted, some added, and some lines with
just a word or two changed.

In those larger scenarios, WITHOUT using BOTH "--color-moved" and
"--word-diff", and INSTEAD just using "git diff --color-moved", a
typical full line(s) diff occurs for changed areas that weren't moved,
as if it were given as a hidden/default option.  It's analyzing each
differing area to see if it's going to show each of those differing
areas as a move or a full line(s) diff.  Here, "--color-moved" takes
precedence (in the way I'm trying to use the word) over the typical
full line(s) diff.

I could be wrong, but I don't see why "--color-moved" can't operate
the same way, with "--word-diff" taking the place of the typical full
line(s) diff.  So, if it would be technically accurate to show
something that was moved using either method, that it would show moved
areas as a move rather than as word-diffs.  This would leave areas not
moved to be word-diffed.

I think these options can co-exist.  I could be wrong, but I'm betting
the code for "--color-moved" was only written with the typical full
line(s) diff in mind, and wasn't written with "--word-diff" in mind.
