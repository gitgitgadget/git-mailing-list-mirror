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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8D31F463
	for <e@80x24.org>; Thu, 19 Sep 2019 22:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392597AbfISWV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 18:21:27 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40792 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406715AbfISWVX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so1027308uaq.7
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBC4udl7j7j1K5VmUPRz6Od6j1hkcBKnvpmma6CTBfo=;
        b=KNnpAFFLBBrp0yqIy/gQvWgM/M39o1zoR0J5zlLVpcGYX8LcGLKEMvmJQBUe/1H7Uz
         xXm0OMDjV2XetkZxJ/IBEpe5xE2fmx2n+rqsnC91G8+NmplMAxRrKhvXnNbfgLtgMzXt
         QmEGo+4rzKPBnHeRqI58TLGLIuzkiMWy5yB8k66ohtSdPHDHonBw3iCRpJPlx5OK9Gk2
         LJOIhyyytWWEw1VE+ULGCBuT9y6YliZrmdquSz5fL1Ol4esLYX2TCpDnN6fldiVZCjsp
         CDSb1Jjc5IdfAOCCeBDDuLjkOfquZvaYxe2FdIf+8D5LUEUWCGwrBSdLYIJMir89Io+E
         jIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBC4udl7j7j1K5VmUPRz6Od6j1hkcBKnvpmma6CTBfo=;
        b=kp+pXlFKZxC0qIZ4sSfzTLF72QFLSKby2U2EwieM2jQ3lmvb7drPSJVRgJKD+9Bv5r
         ahcMN23E7BGZ2laSvEfeFuBvhr9wnyptWJfdS0VApfaf0o6jggW2f60ik4f2SsET0IeU
         04tNxTiaGXPX2HEYvKFRfGC4z3A0Zdi+NfB6fcobxsVdpUybnMjoR7EquXhlHyRAPMpD
         vJZI7i5OQ6gC2jJU8CXTavG/Cw2BqRFkmeDVWS2vnPPwASYULHTapJftJN3ZfZbN0THp
         HdcPSPIkyhqcWrAYvKFMwgEpyuLGnFjA3laHkS3iB5D2cUHtDC+ktyBrb/7rDEjLa1UU
         01TA==
X-Gm-Message-State: APjAAAVcNH0iRuh2296n8M/9TOfuqIcAMByfgFCq3xYZwx2UJS5/jHdf
        wp0F3Ow+uF3nW3AKn2YJQGY5y3hrjDVBI1tiihA=
X-Google-Smtp-Source: APXvYqwqg7zMvxlofqHGiOC0MvN/axUXCiu0+n6bdNDfBMGkPkj149lWGlqJtzIeipOm6RtXWVIsjBqbd6G3rAmowQs=
X-Received: by 2002:ab0:4891:: with SMTP id x17mr6598244uac.87.1568931681331;
 Thu, 19 Sep 2019 15:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Sep 2019 15:21:08 -0700
Message-ID: <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 11:37 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> During the Virtual Git Contributors' Summit, Dscho brought up the topic of
> "Inclusion & Diversity". We discussed ideas for how to make the community
> more welcoming to new contributors of all kinds. Let's discuss some of
> the ideas we talked about, and some that have been growing since.
>
> Feel free to pick apart all of the claims I make below. This is based
> on my own experience and opinions. It should be a good baseline
> for us to all arrive with valuable action items.
>
> I have CC'd some of the people who were part of that discussion. Sorry
> if I accidentally left someone out.

Thanks for working on this.  I like the overall thrust, and many of
the concrete proposals.  I've got lots of comments and feedback, and
if I focus too much on things that could be improved, just remember I
like the overall thrust.

> I. Goals and Perceived Problems
>
> As a community, our number one goal is for Git to continue to be the best
> distributed version control system. At minimum, it should continue to be
> the most widely-used DVCS.

I'd rather we stated our goal in terms of what problems we are trying
to address rather than accolades we want sent our way.  E.g. "Our goal
is to make developers more productive by providing them increasingly
useful version control software".

> Towards that goal, we need to make sure Git is
> the best solution for every kind of developer in every industry. The
> community cannot do this without including developers of all kinds. This

This sounds much too strongly worded to me.  I don't like the idea of
everything for everyone; it suggests that if someone comes up with a
one-off usecase that affect 3 people in the world, we have to devote
resources to it (even at the risk of making ongoing maintenance
harder).  I would prefer a statement like we want to solve more
usecases than we do today, and we want to bring in developers from a
diverse background to help us do so.

> means having a diverse community, for all senses of the word: Diverse in
> physical location, gender, professional status, age, and others.

The combination of wording above ("need to...cannot do this...all
kinds...all senses of the word") suggests that more extreme measures
are in scope.  For example, what about programming language?  C is
going to restrict us to a small and possibly shrinking set of
developers.  I think that changing language is far-fetched and not
worth it, but the wording above would suggest it.

A different way to avoid such interpretations might be if you can find
a way to imbue the document with a "evolutionary not revolutionary"
feeling or wording.

> In addition, the community must continue to grow, but members leave the

"must"?  I agree that we want to grow, but "must" suggests a
priortization level of effort that makes me uneasy.  If you said that
we find it really important and will invest resources in it, then I'm
all for it.

> community on a regular basis for multiple reasons. New contributors must
> join and mature within the community or the community will dwindle. Without
> dedicating effort and attention to this, natural forces may result in the
> community being represented only by contributors working at large tech
> companies focused on the engineering systems of very large groups.
>
> It is worth noting that this community growth must never be at the cost
> of code quality. We must continue to hold all contributors to a high
> standard so Git stays a stable product.
>
> Here are some problems that may exist within the Git community and may
> form a barrier to new contributors entering:
>
> 1. Discovering how to contribute to Git is non-obvious.
>
> 2. Submitting to a mailing list is a new experience for most developers.
>    This includes the full review and discussion process.
>
> 3. The high standards for patch quality are intimidating to new contributors.
>
> 4. Some people do not feel comfortable engaging in a community without
>    a clear Code of Conduct. This discomfort is significant and based on real
>    experiences throughout society.
>
> 5. Since Git development happens in a different place than where users
>     acquire the end product, some are not aware that they can contribute.
>
> II. Approach
>
> The action items below match the problems listed above.
>
> 1. Improve the documentation for contributing to Git.
>
> In preparation for this email, I talked to someone familiar with issues
> around new contributors, and they sat down to try and figure out how to
> contribute to Git. The first place they went was https://github.com/git/git
> and looked at the README. It takes deep reading of a paragraph to see a
> link to the SubmittingPatches docs.
>
> To improve this experience, we could rewrite the README to have clearer
> section markers, including one "Contributing to Git" section relatively
> high in the doc. We may want to update the README for multiple reasons.
> It should link to the new "My First Contribution" document
> (https://git-scm.com/docs/MyFirstContribution).

Sounds good.

> 2. Add more pointers to GitGitGadget
>
> We have a reference to GitGitGadget in the GitHub PR template to try and
> get people who try to submit a pull request to git/git to instead create
> one on GitGitGadget. However, that captures contributors who didn't read
> the docs about how to submit! (This is somewhat covered by the "My First
> Contribution" doc as well, so making that more visible will also help.)
>
> Could we reference GitGitGadget as part of the Submitting Patches doc
> as well?

+1; that'll also give some automated build feedback for the new
contributors, and provide some useful links in the cover letter (I
like how GitGitGadget provides links for fetching the changes without
using git-am).  I should probably use it more myself.

> 3. Introduce a new "mentors" mailing list
>
> From personal experience, all new contributors at Microsoft (after Jeff
> Hostetler at least) have first had their patches reviewed privately by
> the team before sending them upstream. Each time, the new contributor
> gained confidence about the code and had help interpreting feedback from
> the list.
>
> We want to make this kind of experience part of the open Git community.
>
> The idea discussed in the virtual summit was to create a new mailing
> list (probably a Google group) of Git community members. The point of
> the list is for a new contributor to safely say "I'm looking for a
> mentor!" and the list can help pair them with a mentor. This must
> include (a) who is available now? and (b) what area of the code are they
> hoping to change?
>
> As evidence that this is a good idea, please see the recent research
> paper ""We Don't Do That Here": How Collaborative Editing With Mentors
> Improves Engagement in Social Q&A Communities" [1].
>
> [1] http://www.chrisparnin.me/pdf/chi18.pdf
>
> When asking your first question on Stack Overflow, this group added
> a pop-up saying "Would you like someone to help you with this?". Then,
> a mentor would assist crafting the best possible question to ensure
> the asker got the best response possible.
>
> I believe this would work in our community, too. The action items
> are:
>
> a. Create the mailing list and add people to the list.
>
> b. Add a pointer to the list in our documentation.
>
> Note: the people on the mentoring list do not need to be
> "senior" community members. In fact, someone who more recently
> joined the community has a more fresh perspective on the process.

Sounds useful for new contributors, _if_ there are enough volunteers
with enough time.  I'm a little worried it might be initially staffed
well and make a nice splash, but wane with time and possibly even to
the point that it makes new contributors more jaded than if we didn't
have such a list.  Hopefully my fears are unfounded, as it did sound
at the conference like there might be a good number of volunteers, but
I just wanted to voice the concern.  (And I feel bad, but I really
don't know that I have the bandwidth to volunteer.)

Another point that might help here:  New contributors might be
surprised by the rigor of the code review process, and might assume
they just aren't good enough to contribute.  It might be useful to
countermand that subtle unspoken assumption by pointing out how much
existing long-term contributors spend revising patches.  Personally,
despite doing my best to think of issues and make sure to send in
really high quality patches, I still generally expect to spend at
least as much time after submitting patches revising them as I did in
coming up with them originally, and I'm not surprised if the time is
doubled.  And that's after contributing for years.  I don't generally
experience reviews anywhere near as thorough in other communities.

> 4. Add an official Code of Conduct
>
> So far, the community has had an unofficial policy of "be nice,
> as much as possible". We should add a Code of Conduct that is
> more explicit about the behavior we want to model. This was also
> discussed in the meeting with wide approval.

I agree with the part of Denton's view that there isn't much of a
problem currently in Git; which I am happy about.  I think such a time
is a wonderful time to introduce a Code of Conduct.

From experience watching another community years ago, I think trying
to introduce one when there are existing problems is much harder and
leads to compromises like saying it's merely an aspirational statement
and explicitly state that there is absolutely no enforcement
whatsoever (unless a maintainer of a sub-project has stated they'll
enforce it for their sub-community).  A code of conduct in more
extreme cases like that is still useful, much as adding "all men are
created equal" to the United States' declaration of independence was
useful -- it guided people over hundreds of years closer to that
ideal.

I think adding a Code of Conduct provides four distinct benefits for us:
  * it prevents future problems
  * it gets everyone to subtly improve behavior on their own
  * it improves the selection filter of who joins the project over time
  * it makes it easier for folks to have a discussion about problems,
should they arise.

On the second point, a rather memorable exchange I remember from that
other community (which I think helped people towards accepting the
code of conduct) was:

"I can understand Ethics code, but I wouldn't sign this, knowing full
well that I'll have bad days, and I call people things worse than
nitwit even on a good day."

"As do I. And people should know that's not how we are in general."

As humans, we sometimes make mistakes.  And short of mistakes, we
sometimes miss social cues.  Further, the inherent lack of tone of
voice and other body language due to using email as a communication
mechanism sometimes leads to misunderstandings.  Behavior is sometimes
black and white, and while we definitely want to keep some behaviors
out of the community, there are a large number of gray areas (e.g.
when reviewing code -- do we remember to praise the good, or only
point out the bad?  I tend not to do as well on that front.)  I think
a code of conduct helps us (subconsciously) move towards lighter
shades of gray.

> 5. Advertise that Git wants new contributors
>
> After we put items 1-4 in place, we should reach out to the
> general tech community that we are interested in new
> contributors. It's not enough to open the door, we should
> point people to it.
>
> This item is much less explicit about the _how_. This could
> be done at the individual level: posting to social media or
> blog posts. But perhaps there is something more official we
> could do?
>
> III. Measurement
>
> How do we know if any of these items make a difference? We
> need to gather data and measure the effects. With the size
> of our community, I expect that it will take multiple years
> to really see a measurable difference. But, no time like
> the present to ask "What does success look like?"
>
> Here are a few measurements that we could use. Each "count"
> could be measured over any time frame. We could use major
> releases as time buckets: v2.22.0 to v2.23.0, for example.
>
> 1. How many first-time contributors sent a patch?
>
> 2. How many contributors had their first commit accepted into
>    the release?
>
> 3. How many contributors started reviewing?
>
> 4. How many total patches/reviews did the list receive?
>
> What other measurements would be reasonable? We could try
> building tools to collect these measurements for the past
> to see historical trends. Based on that data, we may be
> able to set goals for the future.
>
> With such a small community, and an expected small number
> of new contributors, it may also be good to do interviews
> with the new contributors to ask about their experience.
> In particular, we would be looking for moments where they
> had trouble or experience friction. Each of those
> moments is a barrier that others may not be clearing.

I think these look like useful things to do, including measuring.  It
may turn out into a great success.  But...I'm a little worried that
the measuring might result in folks getting discouraged and giving up
in a few years.  Even if the numbers aren't as rosy as we hope, I
think there are other advantages that you might not be naturally
measuring here.  For example, the adoption of a code of conduct in
another project slowly made that community more enjoyable to work in
over a period of years, in my opinion (coming from someone who isn't a
minority and was already a core contributor).  I have no way to
measure that, but it was my opinion.  Also, within our community, the
efforts to make contributions for others easier might yield more tools
like Dscho's GitGitGadget that makes the life of existing contributors
better.  Anyway, just some food for thought.


Elijah
