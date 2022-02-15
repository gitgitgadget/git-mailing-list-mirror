Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1448C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiBOPFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:05:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiBOPFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:05:23 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89DD108560
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:05:12 -0800 (PST)
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nJzOA-00091r-7e; Tue, 15 Feb 2022 15:05:10 +0000
Message-ID: <f58ad14f-f4bf-0f0a-24ba-98ab80bf0dc5@iee.email>
Date:   Tue, 15 Feb 2022 15:05:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: Git in GSoC 2022?
Content-Language: en-GB
To:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git Community <git@vger.kernel.org>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email>
 <3b112eee-8110-baf6-d7e7-cb25b03c32ff@gmail.com>
 <CAP8UFD1BYm-_p=JYw3GELsk1=hR9-o7cxEowtnrKPumi0Gk8kg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAP8UFD1BYm-_p=JYw3GELsk1=hR9-o7cxEowtnrKPumi0Gk8kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On 13/02/2022 09:33, Christian Couder wrote:
> On Sat, Feb 12, 2022 at 7:12 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> On 03/02/22 7:42 pm, Philip Oakley wrote:
>>> My latest thinking is that the repos would be held in-tree under
>>> /Documentation/RepoBundles and have been exported as bundles by an
>>> explicit test_export_function. Of key importance in the project is to
>>> minimise/eliminate any extra maintainer actions, so once a patch with a
>>> repo export is accepted, the flow through the delivery process to user
>>> installs is essentially the same as the man pages.
>> We could possibly include this one in the idea list but I suppose we might
>> need a more concrete idea on what needs to be done as part of this project.
>> That would help very much with guiding the student during the project
>> period.
>>
>> We also need to know if the end result of such a project would be an
>> acceptable contribution to the project. What it would take for the contribution
>> to be acceptable? etc.
> Yeah, I think this is the main issue with this idea. We have a section
> named "Note about refactoring projects versus projects that implement
> new features" in
> https://git.github.io/General-Application-Information/ explaining why
> projects implementing new things can be a bad idea, and what can be
> done about it.

I tend to agree. To me, it has all the hall marks of an allegedly
simple  'systems' project. The main issues in the mini-project being to
ensure all stakeholders are aligned so that the final coding is easy. I
hadn't mentioned the number of go-arounds in my head before I settled on
using individual bundles as the likely best chance of success for the
example repos.

For these type of ideas, the 'show me the code' mantra, can easily lead
to misunderstanding, mistaking the toy implementation for concept ("map
is not territory" ;-).

Maybe we do need a 'mini-projects' category to capture these
non-refactoring ideas.

>
>> Just to make it clear, I'm trying to think through on what we need to do to
>> make this a GSoC idea proposal.
>>
>>> Not sure if that's fleshed out enough, or if it's at the wrong level for
>>> GSoC, or If I'm right as a Mentor, but I'd be happy to co-mentor.
>> That's nice. Thanks for volunteering.
> Yeah, thanks for volunteering anyway!

Given that I'd suggested the min-project, I thought it worthwhile ;-)
>
>> On a related note, the organization registrations are now open for this year.
>> The deadline is February 21 - 18:00 UTC. I'm not sure if anyone else is
>> planning on applying for Git. In case no one else beats me to it, I plan on
>> applying for Git around February 15 17:00 UTC.
> I was thinking about applying for Git, but I am glad that you plan to
> do it. I will try to add some project ideas to SoC-2022-Ideas.md
> before February 15.
>
> Thanks,
> Christian.

A similar mini-project, could be to add a `git branch
--show-description` and `git branch --show-all-descriptions` along the
lines of the aliases:
    brshow = config --get-regexp 'branch.*.description'
    brshow1 = !git config --get "branch.$(git rev-parse --abbrev-ref
HEAD).description"

Fairly simple coding, if acceptable (with ensuing discussions about
whether branch descriptions are useful ..)

Philip
