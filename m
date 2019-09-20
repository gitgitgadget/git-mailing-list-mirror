Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C7D1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 10:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408709AbfITKsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 06:48:54 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:20270 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408705AbfITKsy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 06:48:54 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iBGT2-0000lz-Bb; Fri, 20 Sep 2019 11:48:49 +0100
Subject: Re: [DISCUSSION] Growing the Git community
To:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0e563d60-c892-d18b-fd00-8fcc1afddf7a@iee.email>
Date:   Fri, 20 Sep 2019 11:48:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Some rhetorical top level systemy thinking...

On 19/09/2019 17:30, Derrick Stolee wrote:
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
>
> I. Goals and Perceived Problems
>
> As a community, our number one goal is for Git to continue to be the best
> distributed version control system.
I'm always cautious about "best" (as in "best-practice" etc). Git is 
only good in it's particular environment (version control in physical 
engineering has different problems with different solutions, which did 
pollute the older computer VCS systems). It certainly should be 'good'.
>   At minimum, it should continue to be
> the most widely-used DVCS. Towards that goal, we need to make sure Git is
> the best solution for every kind of developer in every industry.
The community is wider than developers, and can include lawyers, 
historians, screenwriters, all with their own particular needs (e.g. the 
new timestamp range capability)
> The
> community cannot do this without including developers of all kinds. This
> means having a diverse community, for all senses of the word: Diverse in
> physical location, gender, professional status, age, and others.
>
> In addition, the community must continue to grow, but members leave the
> community on a regular basis for multiple reasons. New contributors must
> join and mature within the community or the community will dwindle. Without
> dedicating effort and attention to this, natural forces may result in the
> community being represented only by contributors working at large tech
> companies focused on the engineering systems of very large groups.
We should also ask why engineering companies don't have the same cycle, 
so as to compare and contrast the issues.
>
> It is worth noting that this community growth must never be at the cost
> of code quality. We must continue to hold all contributors to a high
> standard so Git stays a stable product.

I want to "disagree" here about the accidental tone of perfection at all 
times and in all places.

There is a core integrity to the Git data model that validates and 
verifies the stored content of the versions, which should be inviolate, 
but beyond that, as the distance from the core increases, the "quality" 
can soften for both new and existing parts of the code (corner cases, 
quadratic and worse behaviours, design for small textural repos).

We are poor at clarifying which parts (of the code) require that top 
level of integrity, leading down to those parts that are simply 
convenience capabilities for the broad-based user. And then there is 
documentation, and the difficulty of understanding of Git for the 
general user. The shift to narrowing the core-git may further reduce the 
community.
>
> Here are some problems that may exist within the Git community and may
> form a barrier to new contributors entering:
>
> 1. Discovering how to contribute to Git is non-obvious.
>
> 2. Submitting to a mailing list is a new experience for most developers.
>     This includes the full review and discussion process.
>
> 3. The high standards for patch quality are intimidating to new contributors.
Given that Git does support fixups and further patches in a distributed 
environment, we can be our own worst enemy here. Maybe we need to look 
carefully in the mirror.
>
> 4. Some people do not feel comfortable engaging in a community without
>     a clear Code of Conduct. This discomfort is significant and based on real
>     experiences throughout society.
A tricky one. It will depend on how they are used and whether they 
promote community and tolerance.
>
> 5. Since Git development happens in a different place than where users
>      acquire the end product, some are not aware that they can contribute.

Should we also address the Windows community and ecosystem? A good 
neighbour to the Friendly fork? Misunderstandings about the difference 
between the users and the provider?... etc.

These systemy comments are about ensuring we are solving the right 
problems and ensuring we don't miss some issue that will negate any good 
work here.
--
Philip
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
>
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
>
> 3. Introduce a new "mentors" mailing list
>
>  From personal experience, all new contributors at Microsoft (after Jeff
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
>
> 4. Add an official Code of Conduct
>
> So far, the community has had an unofficial policy of "be nice,
> as much as possible". We should add a Code of Conduct that is
> more explicit about the behavior we want to model. This was also
> discussed in the meeting with wide approval.
>
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
>     the release?
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
>
>
> I look forward to the discussion.
>
> Thanks,
> -Stolee

