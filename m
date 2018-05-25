Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7B61F42D
	for <e@80x24.org>; Fri, 25 May 2018 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030666AbeEYWGv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 18:06:51 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39607 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030612AbeEYWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 18:06:49 -0400
Received: by mail-yw0-f193.google.com with SMTP id i201-v6so2180435ywe.6
        for <git@vger.kernel.org>; Fri, 25 May 2018 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VuQ6iL/c10sYEWAnmqgqBnrTET5mP1odLx3WS/3PHxs=;
        b=A14Y5AbdcQseLv+C5Rvln2gAu87kznnX0q52zUK+k8IQRntIJlmn8rXzYgcuq5ujM0
         asnnr4wbRXLzZZBX6bn/iJH19U5kIXe0ceMPXVbaQEHEipkh+TuCxzO2dQdXx/UmQxwT
         KVAvqDmCQEwJPYRtIu/Z9sdYRrCeerLtUsGFymNaIN9sW3zWOvBppmLhKQGa0g8hUsff
         A4Tz/XsNbOXtxmBWqp5wPKWkY16vubq51GHW+xPS2BrFz/rG9zgoli8pgc5fFti92NmJ
         ZSGTdL4HL+2E9vzk+hYRXhyL5QBOYHu2d7sYXvkPt6B/zGtki6bPVzHC7DpDEGq1A96r
         i3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VuQ6iL/c10sYEWAnmqgqBnrTET5mP1odLx3WS/3PHxs=;
        b=TUcs0dU4Ndo5TOK5NzGHOZthvkOplyQUNOD6r3taAyR66nSHPwkTrK92iYt/85yXej
         Agv3wvV7v3lLUuhtZtayCKlDk92q56KM4zdSeU4nu2XmKX6jcK81YCm9RT19mWAjHcjw
         bNwDLTL3itfitxuGVMZlKPQLLEzsKmoZCjWgTnanLHW0+VzDZmrbds4nze/aRuAVWauV
         HXC4RyvHThCPmbm4Pew74wk1trAqLOJ5+2W4SpC/ueaVipsv7uMlWr28iJk975WoYkid
         Q/uZL0IATWg6jYiNDJm+jG/qNPKCydCVNEu++JlYIDor8Pzx2CZZ7hbDdshIifbbBJnR
         3hDA==
X-Gm-Message-State: ALKqPwerFXnc8rpYE8IzZs1UBp9Hbm4D93N7BnNl7ZHpDKTbmQiw8HrC
        KEBykHkX26jZwlmc/rvh8LeT/hDIGENuDDX0ZgQOQg==
X-Google-Smtp-Source: ADUXVKJSqHO/1XWl8/j8xpLKirA9rais1ZulF5+a/UylP8WJsM/x4t1iD64FsNooSHvhCX5g/DvF//5Q9ckYz/VgKog=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr2400750ywf.33.1527286008354;
 Fri, 25 May 2018 15:06:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 25 May 2018 15:06:47 -0700 (PDT)
In-Reply-To: <87in7f9aym.fsf@evledraar.gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
 <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com> <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
 <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com> <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
 <20180508034429.GA7242@sigill.intra.peff.net> <87in7f9aym.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 May 2018 15:06:47 -0700
Message-ID: <CAGZ79kZg-24OtWp-qk4gAyU3O8vJBdDH_maTERqzqHSE86_fqg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes,

On IRC you wrote:
<dscho> And BTW this is not bike-shedding to me. Discussing the name
of a variable, or indentation, or line wrapping, is. But improving the
user experience is important. We *suck* on that, historically, and I
do want to break with that habit.
...
<dscho> avar, _ikke_: so a colleague of mine whose opinion on naming I
respect more than all Git developers combined *also* came up with the
term `range-diff`, independently.
...
<dscho> Yes, you are looking at two ranges. But not *any* two ranges.
*That* is my point.

So I sat back and want to try again;

IIUC your dislike for "range-diff" boils down to:
(A) it doesn't diff any arbitrary range, as the output would become
very cumbersome and hard to understand,
(B) it is not a good intuitive name for users, as they would not think
of range-diff when they'd want to have this feature.

Regarding (A), I think the same can be said about input to the diff
machinery, e.g. 'git diff v2.0.0 v2.17.0' is just very much text, and
it is hardly useful (except as a patch fed to the machine).

Over time there were added tons of options that make the diff output
easier to digest, e.g. additional pathspecs to restrict to a sub tree or
ignoring certain things (white spaces mostly), such that
'git diff -w v2.0.0 v2.17.0 -- refs.h' is easier for a human to grok.

Regarding (B), I agree, but blame it on the nature of an open
source project that provides a toolbox. So the way a user is
going to discover this feature is via stackoverflow or via
asking a coworker or finding the example output somewhere.

I think that last point could be part of the feedback:
git-diff has prominently hints at its name via "diff --git ..."
in the first line of its output, so maybe the output of this feature
also wants to name itself?

Other thoughts:
We could go down the route and trying to find a best possible
technical name, for which I could offer:

  revision-walk-difference
  revwalk-diff

As that literally describes the output: two rev walks are
performed and then those outputs of the rev walks is diffed.
Based off these technicals we could get more creative:

  redo-rev-walk-spot-the-difference
  re-walk-spot
  retravel-spot
  spot-diff

But I think all these do not address the feedback (B).

"What would a user find intuitive?"; I personally thought
a bit about how I discovered cherry-pick. I just took it as
a given name, without much thought, as I discovered it
by tell tale, not looking for it in the docs. It sort of made
sense as a command that I learned earlier about,
"interactive rebase", also has had the "pick" command,
such that "picking" made sense. I think I retroactively
made sense of the "cherry" part. Now I tried to find it
in the mailing list archive and actually learn about its origin,
but no good stories are found there.

For what the user might find most useful, I just looked
at other tools in Gerrits landscape and there the expectation
seems that you upload your code first and do the diff of the different
patches serverside. I think the same holds for Github or other
branch based reviewing systems. You can force push the
branch that is pull requested and the web UI somehow makes
sense of it.

That leads me to the (weak) conclusion of branch-diff or tbdiff
to be useful most for patch based / mailing list based workflows
as there is no magic server helping you out.

Searching for "kernel +tbdiff" to find the kernel devs using tbdiff
gave me no results, so I may be mistaken there.

Trying to find "interdiffs" (for the lack of a better name) between
patches on the kernel mailing list also is not obvious to the uninitiated.

So for the various workflows, I could come up with

  change-diff
  pullrequest-diff
  patch-series-diff

but we do not look at diffs, rather we only use this tool to work on
incremental things, so maybe instead:

  change-history
  pullrequest-history
  patch-series-evolution

Note how these are 3 suggestions, one for each major workflow,
and I'd *REALLY* would want to have a tool that is agnostic to the
workflow on top (whether you use pull requests or Gerrit changes),
but now I would like to step back and remind us that this tool
is only mostly used for viewing the evolution of your new thing,
but it can also be very useful to inspect non-new things.
(backported patches to maint, or some -stable branch)

Or rather: We do not know the major use case yet. Sure
I will use it in my cover letter and that is on my mind now,
but I think there are other use cases that are not explored
yet, so we should rather make the naming decision based
off of technicals rather than anticipated use case and user
discovery methods.

I hope this is actually useful feedback on the naming discovery.

Thanks,
Stefan
