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
	by dcvr.yhbt.net (Postfix) with ESMTP id D95BF1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 16:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404364AbfISQaR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 12:30:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45577 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404350AbfISQaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 12:30:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so3962694qkb.12
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6bS8NbPQTsD+bj4Wi9FeWdhddUqXC9JBT6PidSMof74=;
        b=c4QoUniCstYhnV2eL4rfKQim5yFk29NT2ZTP/hj1HRutGHtceGDtfrDQ5FxOKka83H
         C/QsCOllQT7Bq+vNd3i4PUN6nfmCbvNaw07S8Swq9rJzK3yGU9PdoOyyMJXAKElRcVbG
         +JIbryUeSYzx3Y1ugN02cYQQgWkWME9LmoYP40iMBDG4IZqMUKrkOonqCbbKOZHbP1Po
         BBUhkF+2S/TueQd0FZ/zGcAUdmsl/VQBGQCzyX+sRXZ45hrZ02ic057yuh962q1RVO3R
         XVn6KH4Ovy7fVbHy2JNQ6o3iACKdypzUeiceop864QHbEjSBPGFQS8tCeH0UPrqlXYMo
         GGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6bS8NbPQTsD+bj4Wi9FeWdhddUqXC9JBT6PidSMof74=;
        b=RJSEpB5ePAZrN0LTUp42PRZbRMtTdyUbmqJcGKqOso658+QRWyRdC6KGy/hl8ely8h
         EqdonZiIx2oUk4trztcQiCog5F4G4nPq+rpJMZ2/2N3+uGllJjstaByNEE4yQnU3OSrS
         EkuD+7oTgcOqLMSAsQaq9q9TT2sZZbcL0eS0wagxMtRp2kF3nLzkKX/9owgVcboko7lH
         0cQwLWee5wMzUwWEJr/cfVJoXs1A8hXF32Ak6ipc3gXzsCx2kgt7PEo8ipGXd0Ds6xaU
         u66FBZN1/oBYJ/YH/YY3MPx1exLah+taVmrImdE1pGRbX4wsiBLg14Gb49x5zNYNOtH+
         juNQ==
X-Gm-Message-State: APjAAAWNkK1qO7p806Eu7gZYrkJyotXkasMXoF4K7SYcg5lti0GO+ffj
        ypVkKT7ucZ2aXsMl8eLGfbloS1HaPqE=
X-Google-Smtp-Source: APXvYqyWLiXGg6K3r8ECZ1+HlpubzE9IAG5/yCvq7cUTcDxz0cjawe8+ejUGAB4o1dxMlGgmIyTzcA==
X-Received: by 2002:ae9:eb51:: with SMTP id b78mr3912180qkg.452.1568910615410;
        Thu, 19 Sep 2019 09:30:15 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id i30sm4972695qte.27.2019.09.19.09.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 09:30:14 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
Subject: [DISCUSSION] Growing the Git community
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Message-ID: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Date:   Thu, 19 Sep 2019 12:30:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the Virtual Git Contributors' Summit, Dscho brought up the topic of
"Inclusion & Diversity". We discussed ideas for how to make the community
more welcoming to new contributors of all kinds. Let's discuss some of
the ideas we talked about, and some that have been growing since.

Feel free to pick apart all of the claims I make below. This is based
on my own experience and opinions. It should be a good baseline
for us to all arrive with valuable action items.

I have CC'd some of the people who were part of that discussion. Sorry
if I accidentally left someone out.

I. Goals and Perceived Problems

As a community, our number one goal is for Git to continue to be the best
distributed version control system. At minimum, it should continue to be
the most widely-used DVCS. Towards that goal, we need to make sure Git is
the best solution for every kind of developer in every industry. The
community cannot do this without including developers of all kinds. This
means having a diverse community, for all senses of the word: Diverse in
physical location, gender, professional status, age, and others.

In addition, the community must continue to grow, but members leave the
community on a regular basis for multiple reasons. New contributors must
join and mature within the community or the community will dwindle. Without
dedicating effort and attention to this, natural forces may result in the
community being represented only by contributors working at large tech
companies focused on the engineering systems of very large groups.

It is worth noting that this community growth must never be at the cost
of code quality. We must continue to hold all contributors to a high
standard so Git stays a stable product.

Here are some problems that may exist within the Git community and may
form a barrier to new contributors entering:

1. Discovering how to contribute to Git is non-obvious.

2. Submitting to a mailing list is a new experience for most developers.
   This includes the full review and discussion process.

3. The high standards for patch quality are intimidating to new contributors.

4. Some people do not feel comfortable engaging in a community without
   a clear Code of Conduct. This discomfort is significant and based on real
   experiences throughout society.

5. Since Git development happens in a different place than where users
    acquire the end product, some are not aware that they can contribute.

II. Approach

The action items below match the problems listed above.

1. Improve the documentation for contributing to Git.

In preparation for this email, I talked to someone familiar with issues
around new contributors, and they sat down to try and figure out how to
contribute to Git. The first place they went was https://github.com/git/git
and looked at the README. It takes deep reading of a paragraph to see a
link to the SubmittingPatches docs.

To improve this experience, we could rewrite the README to have clearer
section markers, including one "Contributing to Git" section relatively
high in the doc. We may want to update the README for multiple reasons.
It should link to the new "My First Contribution" document
(https://git-scm.com/docs/MyFirstContribution).

2. Add more pointers to GitGitGadget

We have a reference to GitGitGadget in the GitHub PR template to try and
get people who try to submit a pull request to git/git to instead create
one on GitGitGadget. However, that captures contributors who didn't read
the docs about how to submit! (This is somewhat covered by the "My First
Contribution" doc as well, so making that more visible will also help.)

Could we reference GitGitGadget as part of the Submitting Patches doc
as well?

3. Introduce a new "mentors" mailing list

From personal experience, all new contributors at Microsoft (after Jeff
Hostetler at least) have first had their patches reviewed privately by
the team before sending them upstream. Each time, the new contributor
gained confidence about the code and had help interpreting feedback from
the list.

We want to make this kind of experience part of the open Git community.

The idea discussed in the virtual summit was to create a new mailing
list (probably a Google group) of Git community members. The point of
the list is for a new contributor to safely say "I'm looking for a
mentor!" and the list can help pair them with a mentor. This must
include (a) who is available now? and (b) what area of the code are they
hoping to change?

As evidence that this is a good idea, please see the recent research
paper ""We Don't Do That Here": How Collaborative Editing With Mentors
Improves Engagement in Social Q&A Communities" [1].

[1] http://www.chrisparnin.me/pdf/chi18.pdf

When asking your first question on Stack Overflow, this group added
a pop-up saying "Would you like someone to help you with this?". Then,
a mentor would assist crafting the best possible question to ensure
the asker got the best response possible.

I believe this would work in our community, too. The action items
are:

a. Create the mailing list and add people to the list.

b. Add a pointer to the list in our documentation.

Note: the people on the mentoring list do not need to be
"senior" community members. In fact, someone who more recently
joined the community has a more fresh perspective on the process.

4. Add an official Code of Conduct

So far, the community has had an unofficial policy of "be nice,
as much as possible". We should add a Code of Conduct that is
more explicit about the behavior we want to model. This was also
discussed in the meeting with wide approval.

5. Advertise that Git wants new contributors

After we put items 1-4 in place, we should reach out to the
general tech community that we are interested in new
contributors. It's not enough to open the door, we should
point people to it.

This item is much less explicit about the _how_. This could
be done at the individual level: posting to social media or
blog posts. But perhaps there is something more official we
could do?

III. Measurement

How do we know if any of these items make a difference? We
need to gather data and measure the effects. With the size
of our community, I expect that it will take multiple years
to really see a measurable difference. But, no time like
the present to ask "What does success look like?"

Here are a few measurements that we could use. Each "count"
could be measured over any time frame. We could use major
releases as time buckets: v2.22.0 to v2.23.0, for example.

1. How many first-time contributors sent a patch?

2. How many contributors had their first commit accepted into
   the release?

3. How many contributors started reviewing?

4. How many total patches/reviews did the list receive?

What other measurements would be reasonable? We could try
building tools to collect these measurements for the past
to see historical trends. Based on that data, we may be
able to set goals for the future.

With such a small community, and an expected small number
of new contributors, it may also be good to do interviews
with the new contributors to ask about their experience.
In particular, we would be looking for moments where they
had trouble or experience friction. Each of those
moments is a barrier that others may not be clearing.


I look forward to the discussion.

Thanks,
-Stolee
