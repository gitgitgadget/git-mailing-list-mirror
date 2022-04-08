Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BDC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 08:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiDHIRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiDHIRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 04:17:07 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270FB62BE6
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 01:15:04 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ncjlm-0001ab-4N;
        Fri, 08 Apr 2022 09:15:02 +0100
Message-ID: <5d6df8fa-eaea-4ead-e966-8efe60784409@iee.email>
Date:   Fri, 8 Apr 2022 09:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Make commit messages optional
Content-Language: en-GB
To:     jurgen_gjoncari@icloud.com, git@vger.kernel.org
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jurgen

On 08/04/2022 04:35, jurgen_gjoncari@icloud.com wrote:
> I think that often commit messages are unnecessary. I propose that by default a user should be able to commit without a message. 
>
> I don't think this would be a problem from the UX point of view, because a user could get a lot of information about a change, from the history of the GitHub repository, such as from the time of change, and seeing the diff. 
>
> I think that making commit messages options wouldn't even be a problem for retro compatibility because the feature would remain still functional for those who would want to use it. 

Isn't this an ideal candidate for an alias that simply passes in the
empty message?

However, it's worth reviewing and doing a retrospective about commit
messages and who they are there to inform.

They (these supposedly informative messages) used to frustrate me many
years ago. I already _knew_ what I was doing, and it was 'obvious', what
even needed saying (so say nothing).

The Git project's style has been informative in showing how to provide a
well focussed concise message that should be understandable to others,
to your future self, and help clarify one's current understanding of the
problem at hand. Often the last point will mean one upgrades the code to
meet the real need.

--
Philip
