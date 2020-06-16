Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8762C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 22:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92A42082E
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 22:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFPWD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:03:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33962 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFPWD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 18:03:28 -0400
Received: (qmail 27807 invoked by uid 109); 16 Jun 2020 22:03:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 22:03:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18016 invoked by uid 111); 16 Jun 2020 22:03:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 18:03:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 18:03:26 -0400
From:   Jeff King <peff@peff.net>
To:     Kaue Doretto Grecchi <kauedg@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-for-windows supporting public shaming and repressing
 community's opinion
Message-ID: <20200616220326.GB685107@coredump.intra.peff.net>
References: <CAMWmj-xR7f_F5HMuEDyn2L0N7pdBWmyzin6Yk=D048H7TDXEPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMWmj-xR7f_F5HMuEDyn2L0N7pdBWmyzin6Yk=D048H7TDXEPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 05:52:02PM -0300, Kaue Doretto Grecchi wrote:

> > Just my own guess here, but I think calling others' arguments "dull
> > and kind of childish" is not civil or respectful, and thus that you
> > missed the reasons for your being blocked.
> 
> Stating that *an argument* is "dull and kind of childish" does not
> mean I think the same about who wrote it.

Just to be clear, I think saying something like "your argument is
stupid", even though it does not attack the person _directly_, is still
not up to the level of communication I'd hope in our community. In
particular:

  - it's unconstructive; say what you don't like about the argument in a
    way that can move the discussion forward.

  - it's needlessly inflammatory

> I was making arguments, the
> user stated that *I* would be wary of using the word "cock" in one of
> my projects' name as if I was not mature enough.

I didn't read the original comment that way at all. I read it as a
response to the notion that words have different meanings in different
contexts.  I.e., that while nobody is likely to think the original
writer using "cock" meant the male anatomy and not the bird, the word
carries enough connotations that one might be careful of using it. Even
though the reader can tell you meant one and not the other, it often
puts the image of the other in their mind before they get to that point.

Certainly I think one could argue how often this is or isn't the case
for "master", or what responsibility writers have to avoid this
situation, etc, which might be more constructive directions (though they
also risk hitting unconstructive dead-ends on base assumptions, it can
sometimes be useful to play out the arguments and get a better
understanding).

> It's a personal,
> disrespectful statement that tried to insult and shame me as immature.
> From my point of view I was blocking for defending myself while trying
> to address the issue's reasoning.

I'm sympathetic to that, if that's how you interpreted the comment. In
such a case I find it can sometimes be helpful to explain how you
perceived the comment. That can help clear up misunderstandings. Or if
you did interpret their view correctly, maybe expose the other side more
clearly as a jerk, at which point you're probably better off saying
"please stop being a jerk" and disengaging (again, in my experience).

That's not always easy, of course.

> But for the sake of arguing, let's say I did deserve the block. Why
> was it made *after* a whole lot of other commentaries and negative
> votes on the proposal rather than at the moment it was made? Because
> the block has nothing to do with the comment itself nor a will to
> enforce the CoC.

I'm not sure what you're asking here. Maintainers of projects aren't
reading comments in real-time. Nor is their sole job policing comments.
It seems reasonable to me that they might not realize action needs to be
taken in a thread until the thread as a whole has started moving in an
unproductive direction. At which point it may be worth marking any
communication in the thread that isn't up to the project's standard.

But perhaps your question was purely rhetorical in order to make the
final sentence. I don't agree with the conclusion in your answer,
though.

-Peff
