Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E685C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 14:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbiBCOMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:12:16 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:35237 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351018AbiBCOMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 09:12:15 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nFcqL-0001mT-Bz; Thu, 03 Feb 2022 14:12:14 +0000
Message-ID: <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email>
Date:   Thu, 3 Feb 2022 14:12:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Git in GSoC 2022?
Content-Language: en-GB
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/2022 18:29, Kaartic Sivaraam wrote:
> If we are interested in participating we need:
>
>   - Volunteers who are wiling to act as mentors. I would be
>     willing to be volunteer myself as a mentor for one student.
>  
>   - Microprojects: I believe we could repurpose the Outreachy
>     microproject ideas[2] for GSoC too. If others have suggestions
>     for microproject ideas, please share them.
>
>   - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>     but both were picked by GSoC students the previous year. So,
>     we would need new ones this year.
Git Demonstration Repositories
=============================

One idea/concept that I've had that might be suitable for a project
either here or within the Google Season of Docs is to generate
demonstration repositories that match the examples used in the
documentation and parts of the test suite to help users explore and
understand the concepts that are being documented in the man pages.

It's more than a classic coding problem because it impinges on a lot of
subjective and admin areas but should be fairly beneficial for users.

The two examples that come to mind are the --show-pulls repo [1], and
the 'history simplification' repo [2].

Using the test suite as the repo generator ensures the Demo Repos are
reproducible/deterministic.

My latest thinking is that the repos would be held in-tree under
/Documentation/RepoBundles and have been exported as bundles by an
explicit test_export_function. Of key importance in the project is to
minimise/eliminate any extra maintainer actions, so once a patch with a
repo export is accepted, the flow through the delivery process to user
installs is essentially the same as the man pages.

Not sure if that's fleshed out enough, or if it's at the wrong level for
GSoC, or If I'm right as a Mentor, but I'd be happy to co-mentor.

>
>     Taylor showed interest in a bitmap-related project during
>     the Outreachy application period [4]. Taylor, are you still
>     interested in mentoring a bitmap-related project? Would it
>     be possible for you to do so for the upcoming GSoC?
--
Philip
[1] Git log --show-pulls
{the sha1
https://github.com/git/git/commit/8d049e182e2e213a012e2d6839becfe0e2de79db,
 get the t/tnnnn t/t6012-rev-list-simplify.sh,
 get the docs rev-list #L582-707}

[2] git rev list History simplification
{get the man page #Lnn
https://github.com/git/git/blob/master/Documentation/rev-list-options.txt#L386-L425,
 get the Chuck Li https://github.com/ChuckTest/git-history-test.git,
 get the gfw
https://groups.google.com/d/msgid/git-users/11286f4a-c961-4d12-91a0-f49e34d8691bn%40googlegroups.com}
