Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16991F404
	for <e@80x24.org>; Sat,  1 Sep 2018 08:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIAMpw (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 08:45:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:36174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbeIAMpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 08:45:52 -0400
Received: (qmail 26349 invoked by uid 109); 1 Sep 2018 08:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 08:34:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11696 invoked by uid 111); 1 Sep 2018 08:34:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 04:34:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 04:34:36 -0400
Date:   Sat, 1 Sep 2018 04:34:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        avarab@gmail.com, git <git@vger.kernel.org>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180901083436.GB25852@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <8736uxe2pm.fsf@evledraar.gmail.com>
 <20180830031607.GB665@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
 <20180830192453.GC19685@sigill.intra.peff.net>
 <CAP8UFD0AnS1Zp2QdqtLTqBrsUiogODC_apG-vumxRuoijW=r4A@mail.gmail.com>
 <CAL21BmmmD1V+EWFevNT1t9M+nwrN9GR_PTx981ji_zGwfbpd_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21BmmmD1V+EWFevNT1t9M+nwrN9GR_PTx981ji_zGwfbpd_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 01:30:05PM +0300, Оля Тележная wrote:

> I was Outreachy intern last winter. I guess I need to speak up: I will
> be happy if my feedback helps you.
> At first, I want to repeat all thanks to Outreachy organizers and Git
> mentors. That was unique experience and I am so proud of being a part
> of this project. But, I need to say that my internship wasn't ideal.
> Mentors, please do not feel guilty: I just want to improve the quality
> of future internships and give some advises.

As one of those mentors, let me first say: thank you for this feedback.
It's very valuable to get your honest perspective.

I more or less agree with everything you said. A few specific comments:

> 1. The main problem of Outreachy internship is positioning. I mean, I
> had strong confidence that it's an internship for newbies in
> programming. All my friends had the same confidence, and that's the
> reason why 2 my friends failed in the middle of the Outreachy
> internship. Load was so big for them, noone explained this fact in the
> beginning, noone helped with this situation during the internship. I
> was thinking I could be overqualified and I took someone's place (I
> had 2 other SWE internships before Outreachy). The truth is that my
> skills were barely enough.

Some of this may be due to Outreachy (I'm not very familiar with the
materials they use to get applicants). But we propose the individual
projects, and I don't think there's anything stopping us from something
that might be smaller in scope (i.e., to focus more on "soft" skills
like participating in the project, and less time on system design or
tricky coding).

I think ideally we'd have various project options with a range of
difficulties, and part of the application period could involve steering
candidates to the right project.

> 2. Please tell more about minimal requirements: write it down on a
> landing page in the beginning and maybe repeat them in every task. I
> guess it would be the same this year: good knowledge of C, gdb, Git
> (as a user: intern needs to know how to work with forks, git remote,
> git rebase -i, etc), Shell, base understanding of Linux terminal,
> being ready to work remotely. It's good idea to mention that it's not
> 100% requirement, but anyway at least 60% from the list must be
> familiar.

Yes, I agree that we don't really communicate the expected skills very
well. That's something we should be able to fix pretty immediately for
the next round.

> 3. If you decide to be a mentor - at first, thanks a lot. Please be
> ready to spend A LOT OF time on it. You need to explain not only the
> task to your intern, but also how to split the task into subtasks, how
> to look for solutions, how to work with the terminal, how to debug
> better and many other questions. It's not only about solving
> internship task. It's about learning something new. And I did not
> mention code reviews: there would be many stupid errors and it's a
> talent not to be angry about that.

I'd agree with this. I think one of the biggest mistakes I made for your
internship was not being focused and spending enough time. Johannes
mentioned that he actually does online pair-programming with his GSoC
students, and I think that would have helped a lot in our case.

Ironically, I was actually worried about being _too_ involved (which is
obviously dumb in retrospect). Since there were some interesting design
problems, I didn't want to just dictate "here's what your design should
look like, go code it and get back to me". I wanted to give you the
space to explore the problem, maybe even make some mistakes, and be
there to "unstick" you when you got stuck. But with basically weekly
check-ins, 3 months goes by _really_ fast.

I think we probably needed to be talking things through and working in
real-time at least an hour a day.

> 4. I fully sure that you need to talk with your intern by the voice. I
> mean regular calls, at least once a week. It's good idea to share the
> desktop and show how you are working, what are you using, etc.
> Ask your intern to share the desktop: you need to feel confident that
> they understand how to work with the task. Help them with the
> shortcuts.

Yeah. I think it would have helped a lot to have a real-time session
where we're actually working on the problem collaboratively, and not
just discussing problems you might have run into. That gives the
opportunity to reveal workflow issues: the intern can see how the mentor
does things (and ask "how/why did you do that neat thing?") and the
mentor can see how the intern does things ("I see you're doing it this
way; did you know you can also do it this way, which is easier?").

> 5. In the ideal world, I want to force all mentors to get special
> courses (it will solve problems 2-3-4). Great developer is not equal
> to great mentor. And, if you work with really newbie, it becomes so
> necessary.

I definitely agree with the "not equal" thing. It might even be
inversely proportional in some cases. ;)

> I hope that was useful.

It was. Thanks again for your thoughts.

-Peff
