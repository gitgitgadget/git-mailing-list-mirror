Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9CA2082E
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 21:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFPVoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:44:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFPVoi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 17:44:38 -0400
Received: (qmail 27349 invoked by uid 109); 16 Jun 2020 21:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 21:44:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17903 invoked by uid 111); 16 Jun 2020 21:44:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 17:44:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 17:44:37 -0400
From:   Jeff King <peff@peff.net>
To:     Kaue Doretto Grecchi <kauedg@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-for-windows supporting public shaming and repressing
 community's opinion
Message-ID: <20200616214437.GA685107@coredump.intra.peff.net>
References: <CAMWmj-w3Z4176kvNi3GQTfCSDBzMMay33ki4xmdPwC3sFqbdzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMWmj-w3Z4176kvNi3GQTfCSDBzMMay33ki4xmdPwC3sFqbdzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 04:28:03PM -0300, Kaue Doretto Grecchi wrote:

> Recently I've been blocked from the git-for-windows Github repository
> because of this
> (https://github.com/git-for-windows/git/issues/2674#issuecomment-643795833)
> comment. At the same time the following user was not blocked and his
> comment hasn't been marked "off-topic" until the issue was closed to
> "only collaborators" due to the high rate of people disagreeing with
> the motivations of the issue.
> 
> (https://github.com/git-for-windows/git/issues/2674#issuecomment-642049938)

First off, I think it's important to separate the two comments.

If a comment is violating the CoC, or is insulting, unconstructive, etc,
then it's grounds for being marked as such and hidden. Even if somebody
is saying or doing something worse, that still does not excuse bad
behavior.

Of course it's perfectly fine to say "this other comment is violating the
CoC, and please deal with it" as appropriate. But "the person I was
arguing with was also behaving badly" should never be grounds for
justifying poor behavior.

So taking your comment on its own for a moment (I'll post it here
because the direct links don't seem to actually open blocked comments):

> > Nobody's telling you what you can or cannot say.
> 
> Read the whole sentence. "IF we take the reasoning away"*. And that's
> what is being done here, reducing a word to one shallow dualistic
> political meaning even though it has other suitable and acceptable
> meanings. It's just one statement away.
> 
> I don't really care about the branch's name, I care about the reason the change is being made.
> 
> if ... then constructs shouldn't be a problem here.
> 
> > The Git terminology is derived from BitKeeper. Yes, it's a
> > master-slave metaphor.
> > But even if it wasn't, ultimately it doesn't matter. "Cock" is the
> > accepted term for a male bird, but you'd probably be wary of using
> > it in your project name, right?
> 
> Well there is a product called "Bengay" which has nothing to do with
> "gay"... just to name one. So your argument is really dull and kind of
> childish.
> 
> But even if it wasn't, ultimately it doesn't matter.
> 
> That's all folks.

I think the problem is in the second half. Calling the other person's
argument dull and childish is inflammatory and unproductive.

On another topic, in another thread, it's possible that this comment
might not even have been called out. But in an issue thread which was
rapidly becoming heated and deteriorating in the quality of the
communication (by many people), I think it's important for people to be
doubly careful about their communication style. I find it hard to fault
the Git for Windows maintainers for blocking comments that were
contributing to the degrading atmosphere.

I do notice you've also been blocked from the project. AFAICT the hiding
of comments and the blocking of people happened more or less at the same
time (from the perspective of the commenters). IMHO it would be nice to
be given some feedback along the lines of "this isn't an appropriate
communication style for this forum" to give people the opportunity to
adjust their behavior before being banned. If that's the case here, I'd
be in support of giving banned users an opportunity to contribute
constructively.

On to the other comment:

> > mlvzk 6 days ago
> >
> > Agreed. On a side note, GitHub should maintain a repository with a list of developers that still
> > use the master/slave terminology. Perhaps that'd be enough of an incentive for some to change - > name and shame!
> > We could also have an icon on their profile page that'd flag them as dangerous.

I agree this is a harmful comment. We should be able to discuss the
issue in an honest manner without fear of reprisals.

However, that comment _also_ seems to have been marked as off-topic and
hidden. In addition, several people responded directly to the comment
and explained why it wasn't acceptable. Some of those were in turn
hidden, because they were also inflammatory. But I think this response
from Philip gets to the heart of it:

   PhilipOakley 6 days ago
   > On 10/06/2020 15:33, mlvzk wrote:
   > - name and shame!
   Unfortunately that approach would be a vicious circle, rather than a
   virtuous circle of improvement. It can be a form of bullying.

   Let's keep this work positive and supportive.

> It is appalling that the repo's maintainers kept this comment and
> allowed the user to continue interacting, while suppressing and
> blocking users who were on-topic, having a civil, respectful
> discussion but happened to disagree with the issue's author (dscho -
> https://github.com/dscho) reasons.

I'm open to the notion that a maintainer is abusing their power and
silencing dissent under the guise of the CoC. But I don't really see
evidence of that here.

> I am sending this message in the git mailing list because the
> git-for-windows project is very closely related to it and because I
> wasn't even able to defend myself there.
> 
> I don't even want to be unblocked from that repo, as this is the way
> things are done there. But all of you should know what's happening and
> be aware that "community" doesn't mean what it once used to. Now it's
> just "people who agree with PC reasons for doing stuff".

OK. Thank you for making us aware of your viewpoint. It sounds like
there's no specific action you're asking to be taken, so I'll leave it
at this response for now.

-Peff
