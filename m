Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01558C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 02:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFAC2071A
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 02:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFPCHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:07:07 -0400
Received: from sewer.dizum.com ([194.109.206.211]:39875 "EHLO sewer.dizum.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPCHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 22:07:07 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 22:07:06 EDT
Received: by sewer.dizum.com (Postfix, from userid 1001)
        id 306635FCB0; Tue, 16 Jun 2020 03:58:11 +0200 (CEST)
From:   Nomen Nescio <nobody@dizum.com>
Comments: This message did not originate from the Sender address above.
        It was remailed automatically by anonymizing remailer software.
        Please report problems or inappropriate use to the
        remailer administrator at <abuse@dizum.com>.
To:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <6b6f161981a07070871633fe02c4c3f9@dizum.com>
Date:   Tue, 16 Jun 2020 03:58:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Over the past few days or so, there has been significant discussion
> [1] and patches [2] about changing the name of the default branch away
> from 'master' and towards something else.

> A related question is whether or not we plan to change the default
> value of 'core.defaultBranchName' at all (once Johannes' patches land,
> of course). That seems to be the intent in [4], but forming consensus
> around this would be good, too.
> 
> So, I would like to form some consensus here as to what the new name
> should be,

Some interesting consensus this is trying to form... Let's look at it.

git-for-windows [1]: 76 upvotes, 490 downvotes, overwhelming consensus
in the comments rejecting the proposed change as unwarranted. Result:
comments massively moderated, even though they weren't even in majority
abusive; many dissenters blocked; thread locked, preventing further
input.

GitLab [2]: 23 upvotes, 145 downvotes, rejection in the comments.
Result: thread locked, preventing further input, and an online poll,
that doesn't even offer the option to voice support for keeping the
"master" name.

And in this mailing list: very few people from the community on behalf
of which this is done participating to give their actual opinion on
the issue, and even fewer of them actually supporting the claim that
"master" offends them and should be changed; unspecified people who
apparently believe that "master" offends people, apparently voicing
their opinions in private, which are then apparently not even relayed
but merely vaguely mentioned to us; and on the other side, people who
feel compelled to hide behind others or post anonymously to disagree,
even as their opinion is respectful and attempts to be constructive.

So not just some consensus here, quite some inclusiveness too, this
is achieving: this is put forward in the name of making things more
inclusive, but fails to bring to the table first-hand, people actually
offended by the issue, and makes disagreeing people feel unwelcome - or
enforces them and their input as unwelcome.

Several people are working on the assumption that this change would
surely make a positive impact, even if little, and would be some step
in the right direction. Several people have put forward the argument
explaining to skeptics that it can be difficult to relate to the
struggle of people from a different community without walking in their
shoes, and difficult to understand how they can feel about a certain
issue. Do people putting forward this argument, or the claim that
this community is offended by "master", are themselves part of this
community? If not, how can they be so sure to understand properly
whether and how much this truly offends that community, that they feel
in a position to best speak on their behalf?

Taylor, how do you propose to build this consensus you're talking about
on the name change? Guesswork? What sounds like it has a good ring
to it? Going with the most popular name - i.e., letting the decision
process degenerate into a popularity contest? Whoever yells the loudest,
whatever group or project has most clout? Can you propose a consensus
process that reconciles with the loud majority of commenters who
downvoted this proposal, or justifies why their arguments are not the
right decision criteria?

I know you mean well, and my question is sincere. The stated purpose is
to avoid offending people, based on the premise that some terms offend
people, so I would propose that this would be an important aspect to
correctly assess; in order to base the renaming decision on a real
assessment of what actually offends people, rather than on what some
group says could be offensive, or on some possible drawback with such or
such name that someone did or didn't think to foresee.

So, and this would follow good software development and release
management practices, but even just for the sake of appeasement with
people who think this is not a real issue, and for the sake of going
forward with a constructive process on solid grounds, I would love to
see some data that backs up, details, clarifies and quantifies the claim
that the current "master" name offends people.

I haven't seen any such data so far. All I've seen is a popular trend,
and mentions of groups or projects who have got on board with that trend
- which as I said, is hardly relevant to the merits of its premise. I
haven't seen first-hand accounts of people being offended, anecdotal
or not. I haven't seen serious studies being linked. I haven't seen
representative surveys; opinion polls, especially online, can be
completely skewed and nearly worthless, but I haven't even seen one of
those getting brought forward in support of the name change. I haven't
seen expert or authoritative opinions being brought to the debate as
such.

So I haven't seen any assessment of people being offended by "master",
which could be solved by moving from it; and I haven't seen either
any assessment of whether the change itself would in turn offend and
alienate people who think it is unwarranted, ridiculous, outrageous
and whatnot. I haven't seen any assessment of whether people who find
this proposal offensive are a loud reactionary minority, or a silent
majority. And given the stated purpose of avoiding offending people,
that would seem important to assess too.

So again, I would love to see data that backs up the claim that this
change is necessary to solve a fathomable problem, and will have the
intended impact. I would preferably love measurable and verifiable data,
but any if possible.

I have to assume that people driving this forward would care to make
sure to effect change that actually helps. If not, then you may want
to do some soul-searching; if you don't care to determine whether your
effort actually helps, then you may want to double-check that this isn't
more about virtue signalling, or slacktivism only making yourself feel
good.

And either way, as this is all happening on the public place, putting
forward that data and even just addressing these concerns and processing
this proposal properly would help to reconcile the software community
dividing over this, and strengthen the trust and credibility that
important tools and platforms hold among it.

So please show me the data.

[1]: https://github.com/git-for-windows/git/issues/2674
[2]: https://gitlab.com/gitlab-org/gitlab/-/issues/221164

