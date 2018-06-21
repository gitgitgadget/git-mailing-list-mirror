Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B991F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeFUV0A (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:26:00 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34338 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933274AbeFUVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:25:59 -0400
Received: by mail-vk0-f68.google.com with SMTP id q135-v6so2761566vkh.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fQEu67j3RpwSlB1yivL0AyeoSmQUoYiKGU0BxgUDXVs=;
        b=FE4E2Q3Owj5T+HPcqyV6hhrLiMJmXHQfe2cIs85xpExn5gTQ2KwarNNJUBNq0Yh8ZA
         oI092bsanNbLGNEv4+noF4J2kKxJRJFHaLK453TTMEY6aTmymHVUpfH9R0iKUS33Js/l
         QvpZoi81BppXSM0e2cX5/J5hrupdeYZNGxBoUrELPB8C/jcj71cCPPykCR610aC0CgYS
         X9ONr9PW0hnFuNDAcjGWaSKt9l/T+Xfqmb9F2YrX4SQxbvzpimbii6pEehMeakOhAkAl
         /UZ04aC4dtjQB5iLIQzZ3F7Xe4QmGmaM+oT5hTto5WpYofGBWBL50xg90dOoMOICLZKM
         4S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fQEu67j3RpwSlB1yivL0AyeoSmQUoYiKGU0BxgUDXVs=;
        b=Q6HoiTdADy2BmgydproVgq1M5mTNauyBXTPo9h6HcQnP4HPcgN886G4/b3I7EMf1tz
         t1oIBk5pa8KTTwFMxSB0Sw3dtRaFeR3oAZJAoz2cXY6DFrwazjs2+SPoYeJOm+SJrZqI
         sLbCJAO1YtTuMGJeHKsaVbAMz7mr/VFnc+o55S4dFRfaqJ1obMsy3duoB7ASLuSSgkAV
         XTZVq34iPtKqRAQS0iIct/OhpDtviPlRP+xHPOE3iJxrFHtjEMyzVQT6HxIdnKxSMOX0
         AYNqm7OGxl7yoreQuuDVCL8l/VtWpgZ5JVDXB1zMb2qCYLcutOhQr+ye8IRgVwa0DEKJ
         PgOg==
X-Gm-Message-State: APt69E3EysKFWgKZmcQpkC3mBYJzSy3+e7F5lilWFAWoIevAINnsxI/e
        MSrLtRJjLGUEKE3UoUCtjqHxYBEcZ1OdssWhEDs=
X-Google-Smtp-Source: ADUXVKJe94KbtmIFo5/GpT1GvD80eUZ0r2yJOzaZ4K2cQ2AtIrJvPywrf8u2G8cBAlKUVyxMh3fXzYkPJMxbJ4mCZnw=
X-Received: by 2002:a1f:e483:: with SMTP id b125-v6mr16021564vkh.149.1529616358708;
 Thu, 21 Jun 2018 14:25:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 14:25:58
 -0700 (PDT)
In-Reply-To: <xmqqfu1fswdh.fsf@gitster-ct.c.googlers.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-6-newren@gmail.com> <xmqqfu1fswdh.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 14:25:58 -0700
Message-ID: <CABPp-BH5GYed+BBMadY869qGVpP7DDcD3HQtJSed_RPDVFJ-vA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] git-rebase.txt: document behavioral
 inconsistencies between modes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Jun 21, 2018 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> +BEHAVIORAL INCONSISTENCIES
>> +--------------------------
>> +
>> +  * --no-ff vs. --force-rebase
>
> Do we want to `--quote` these?

Ah, good point.

>> + * empty commits:
>> +
>> +    am-based rebase will drop any "empty" commits, whether the
>> +    commit started empty (had no changes relative to its parent to
>> +    start with) or ended empty (all changes were already applied
>> +    upstream in other commits).
>> +
>> +    merge-based rebase does the same.
>> +
>> +    interactive-based rebase will by default drop commits that
>> +    started empty and halt if it hits a commit that ended up empty.
>
> I think the description is accurate.
>
> WRT a change that ends up being empty (as opposed to a change that
> is empty from the beginning), I'd think that the current behaviour
> is desireable one.  "am" based rebase is solely to transplant an
> existing history and want to stop much less than "interactive" one
> whose purpose is to polish a series before making it publishable,
> and asking for confirmation ("this has become empty--do you want to
> drop it?") is more appropriate from the workflow point of view; so
> it may deserve s/inconsistencies/differences/.

Are you arguing the default for an explicit interactive rebase, or
also an implied one?

I would argue that implied interactive rebases also solely have the
purpose of "transplanting an existing history", as you say.  Thus, if
the user passes --rebase-merges (or --strategy or --strategy-options
after git-rebase--merge becomes part of git-rebase--interactive), then
the default should be the same as for am-based rebase, i.e. just
silently drop the empty commits.

>> +    The --keep-empty option exists for interactive rebases to allow
>> +    it to keep commits that started empty.
>
> On the other hand, lack of --keep-empty on the "am" side is probably
> a bug that wants to be fixed.

I personally don't like --keep-empty; it's too granular.  I'd prefer a
  --empty={drop,halt,keep}
flag, and have it apply to both patches that were empty when the
rebase started as well as patches that became empty after application
on the new base.  I think that'd be useful for both am-based and
interactive-based rebases.

Then we could also make an explicit --interactive flag imply
--empty=halt, if so desired, and otherwise make --empty=drop the
default.

I'm interested in implementing that, if other folks think it's not crazy.

Thoughts?

>> +  * empty commit messages:
>> +
>> +    am-based rebase will silently apply commits with empty commit
>> +    messages.
>> +
>> +    merge-based and interactive-based rebases will by default halt
>> +    on any such commits.  The --allow-empty-message option exists to
>> +    allow interactive-based rebases to apply such commits without
>> +    halting.
>
> Ditto for desirable difference coming from workflow point of view.

I can see the argument for having a difference for rebases if the
interactive rebase was explicit, though I disagree with the argument.
See https://public-inbox.org/git/CABPp-BHrcUHX_zHxpojV5=sxJ1=NoDg9uhxv+NH5BsHsQYavPQ@mail.gmail.com/
for my views on this.

However, I'm curious again -- is your argument only for
interactive_rebase=explicit or also for interactive_rebase=implied?

>> +  * directory rename detection:
>> +
>> +    merge-based and interactive-based rebases work fine with
>> +    directory rename detection.  am-based rebases sometimes do not.
>
> I quite do not get what the big deal is with "directory rename"; it
> is merely a degree of magic heuristics employed while detecting file
> renames.  It is natural to expect that the less information you make
> available to the machinery, the less amount of heuristics gets
> exercised to make "magic" happen.  Is the internal implementation
> detail described below (omitted) all that interesting to general
> readers of "git rebase --help", I wonder?  I would understand it if
> this were under Documentation/technical/, though.

You are right that the last two paragraphs are probably much too
technical and belong elsewhere; I can move them.  However, I am not
sure if you were requesting just those paragraphs be moved, or if you
wanted the whole "directory rename detection" section removed from the
manpage.  Could you clarify?  Also, if the latter...How would users
know how much "information is made available to the underlying
machinery", as you put it?  Or, at a higher level, what is the right
way to communicate to them how they can obtain a behavior they might
want (directory rename detection), if it's not mentioned somewhere in
the manpage?  Is there an alternate place to put this in the document?


Thanks,
Elijah
