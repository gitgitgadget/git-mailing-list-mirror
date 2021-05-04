Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7ACC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A6F613D2
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhEDUgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 16:36:09 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:35785 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhEDUgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 16:36:07 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1le1l8-0000Iv-Bn; Tue, 04 May 2021 21:35:10 +0100
Subject: Re: Git commit allow empty docs unclear
To:     Cristiana Man <man.cristiana1@gmail.com>, git@vger.kernel.org
References: <CAL2wJUAk50O-iSH9PEewYHwE9tV-TZZerqd1Eh9OTQfWBkmCgA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <4c7e5858-7694-efe3-d048-da35fc8cba3a@iee.email>
Date:   Tue, 4 May 2021 21:35:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAL2wJUAk50O-iSH9PEewYHwE9tV-TZZerqd1Eh9OTQfWBkmCgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi Cristiana,

On 04/05/2021 19:31, Cristiana Man wrote:
> Hi
>
> The documentation for Git commit --allow-empty option
> (https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---allow-empty)
> contains the acronym SCM which is confusing to me.
> Do you mean Software Configuration Management, Source Control
> Management or Source Code Management?
> Clarifications are appreciated!

Yes, all of them ;-)

Basically the Git (Linux codebase) philosophy is to always have
meaningful changes, with meaningful commit change messages.

When Git was being developed (i.e. being implemented in many other code
bases) there was a lot of migration of from old "documentation" systems,
which often had 'cruft' where options were needed to allow such empty
commits, and the common TLA (three Letter abbreviation) of the time
'SCM' could cover all of them. The key aspect is that they were
'foreign' to the Git ecosystem.

Hope that helps.

> --
>
> Kind regards,
> Cristiana Man
--
Philip
