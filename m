Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351CE20248
	for <e@80x24.org>; Fri,  5 Apr 2019 02:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfDECvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 22:51:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45259 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDECvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 22:51:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so3856794ljd.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 19:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=ycCvuB24l+nSUC3QEFo9lqTXVqJmEufXyUwpPEo8F44=;
        b=Lz72JldnHK51P++V6BrIfU2q00lodD1uAqsbmWKJlnrUla87c4GdEivrlNzy5nGsAQ
         sh6tRyTnBPAyDoUtIwGOSsN7Yn/S1ypQmzLV0IYuFWNbmumAlrWHg8BC3qTwi0ZRr0Q0
         VA1M6YLmIz28nxjf2Vcd0VievA2LjRBBcyCYa24mALI9N4Z5T/5ax1uOtp1Lxe167jpL
         5veSVsuwwfWzhvaxfjsUTo/+N2pwN5UOPeOyMAgPpbWU0QSUOQJq76WVsvcPnjXByMt4
         IwSmD7kLc9Uzgk8v2aAqG8GA8Y+/1iD8SyYiTAiFU9a4jgh+ZZ1gFyEGdbY9X+UqZP6l
         2nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=ycCvuB24l+nSUC3QEFo9lqTXVqJmEufXyUwpPEo8F44=;
        b=jl41LZ/RuKO8T6AIxRC9c/z3B+S75c2ssMipNIuyQTgEMUSZCX4Gf6elv80TaSpFMi
         C1tCrvbQGCndCI9xJilpiIyCsMWef9OjZu8C6UbMF5SPDQ1Whe/8X1ocORKHuwcnK36/
         CE7JPJIaQqiz1qT30NgC1jjkY11jd8hAoYQxR/wQk3NlsDUkz9cFJ9hJTWA3rEbuC2hY
         lFdHHpJMBB+xkKmUuGb9onFoI7Gq5uVvf8CLW5tRaNWkQ3bBz1a1JSWYkJlbwabzfGKy
         A4hJG1GV0iGIHKwkfPtJ16OnGvsE2ZdOwvUWg8xoTD35JbEWV7MmXJYHlLzCl2ypa9QI
         bi9g==
X-Gm-Message-State: APjAAAV+wdqo8mM/lFwr3tZg89jvJw2LZKS6Cvh0Ruo9esAQLMpEs40D
        B+narUg164gAmcVT4pvt9oGY35Q61AxVRHA4bTs=
X-Google-Smtp-Source: APXvYqwd2+8n8pq7P+TGdtjzZDm0+00wapkg4HWagFnd8umfEYjKrtXhHzUpMxOLjtB/m0kG4L20JF5oHbl5CdEoHOw=
X-Received: by 2002:a2e:8347:: with SMTP id l7mr5307079ljh.17.1554432697198;
 Thu, 04 Apr 2019 19:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l> <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com> <CAHd499C9g3yPvs=wuaSuLrW=R09yjT5DcKHfpH9=PYYkAcpuhg@mail.gmail.com>
 <xmqqbm1mf74c.fsf@gitster-ct.c.googlers.com> <CAHd499Dr5sjzFCFYvkwcS0WOo0W51_RyL7nLAg_MaGeFy5eQKQ@mail.gmail.com>
 <xmqqimvte8yr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimvte8yr.fsf@gitster-ct.c.googlers.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 4 Apr 2019 21:51:26 -0500
X-Google-Sender-Auth: pcKpJCZ6vo_P6CSiuuDLQbJ_2GQ
Message-ID: <CAHd499Bp0QaZGcWhibWpJZJjMn-QqMBzW3vet1HnuMTTffQBRA@mail.gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 4:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
> > It might be fine within the realm of git itself, because git knows how
> > to deal with them by peeling, as you say, but there are 3 reasons I
> > dislike that this is allowed:
>
> That sounds as if you have tools that forgets to peel when it should
> in mind.  Isn't that what you should be looking into fixing?  After
> all, tools that aim to work with Git should strive to come close to
> "within the realm of git itsef" in the modern world.
>
> > 1. The intent by the user was to create a tag pointing to the commit
> > that another tag points to.
>
> You make it sound as if you are convinced that is the truth.  I am
> not.  If I want to tag the commit pointed at by tag v1.0, I'd say I
> want to tag "v1.0^0", because otherwise there won't be a way to say
>
>     $ git tag -s -m "i am aware of this tag" initial v1.0
>
> i.e. making a tag that points at a tag.  So I take the lack of ^0
> (or ^{commit}) peeling an explicit sign that shows the intent by the
> user (well, those who know the tool, anyway) is clearly to create a
> tag pointing to that tag.  In other words, peeling at the tagging
> time is wrong, and rejecting tag creation is also wrong.
>
> > 2. When users on my team do a `git show tag`, they see 2 descriptions
> > and 2 tags. This creates a LOT of confusion.
>
> So what?  Not everybody will forever stay to be a newbie ;-)
>
> As I said, an opt-in tag.allowCommitOnly is fine.  That would train
> their fingers to peel with ^{commit} when they want to tag a commit.
> An opt-in tag.autoPeelTags might also be fine, even though that
> would not help training their fingers (so they will have to be
> prepared for the same "confusion" on a fresh machine)
>
> When the command line clearly tells us that the user wants to tag a
> tag, we should not get overly "smart" and refuse to create a tag of
> a tag, unless the user tells us otherwise with some means.
>
> > 3. Even if Git internally handles peeling tags, external 3rd party
> > tooling may not. As I mentioned in another thread, `git lfs migrate`
> > was not programmed to peel tags. I reported the issue here:
>
> That is good, and it is the right way.  After all, external 3rd
> party tooling may tag a tag even after we castrate "git tag" to be
> incapable of doing so, so a bug like the one you are helping to fix
> in lfs needs to be fixed anyway.  In other words, thats the only
> sensible way forward when you care about the entire Git ecosystem,
> not just the main/reference implementation we work on here.
>

Look, I'm not saying you're wrong. You're probably absolutely right
about all the technical details. You know a lot more about this than I
do, that's for sure. But based on my observations and experience,
everything you're saying isn't set in reality. I have guys on my team
at work that haven't learned anything significant about Git in the
past 3 years; they don't care to learn it. They use a GUI tool for
everything and it's a means to an end for them. Most folks just want
to check out branches, merge, and push commits. They don't understand
what objects or blobs are, or what a tree vs tag vs commit is. Hell, I
have trouble explaining rebase to most people, and that's arguably
much more straightforward. But all of this is OK. We're hired to be
programmers, not experts at Git.

I think what needs to be right is what most people expect, and from my
experience that's not in alignment with your opinion on how this
should work. And I want to apologize if it seems like I'm arguing with
you. My intent is just to clarify my point of thinking. I feel like
you're still very wrapped up in the bowels of Git and the deep
technical details. I just want to make sure I'm being clear about my
perspective, since I'm approaching this from a somewhat non-technical
angle.

Again, regardless of what gets decided, I very much appreciate
everyone looking into this. I feel like whatever you folks come up
with will ultimately be the best decision, even if it may not be 100%
what I'm expecting.
