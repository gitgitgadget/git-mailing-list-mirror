Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E795CC433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD40610EA
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDRI3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 04:29:39 -0400
Received: from ciao.gmane.io ([116.202.254.214]:37786 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhDRI3j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 04:29:39 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1lY2nm-0009Ip-H1
        for git@vger.kernel.org; Sun, 18 Apr 2021 10:29:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Pain points in Git's patch flow
Date:   Sun, 18 Apr 2021 10:29:02 +0200
Message-ID: <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
Content-Language: en-US
Cc:     patchwork@lists.ozlabs.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-14 08:13, Jonathan Nieder wrote:

> Those four are important in my everyday life.  Questions:

Thanks for bringing up these questions in a dedicated format. I'll take 
this as an opportunity to share my thoughts on this topic, which have 
accompanied me for quite a while.

>   1. What pain points in the patch flow for git.git are important to
>      you?

Well, it's email-based. As a result it's error prone to things like 
formatting / quoting issues, putting the right people it CC, etc.

I have always wondered why Git core development does not start to make 
use of the Git ecosystem that we have by now, esp. in the form of review 
tools / platforms like GitHub (via pull-requests), GitLab (via 
merge-requests), or Gerrit (via patches). From these, Gerrit would IMO 
be the best fit for Git, due to its capability to cope well with 
rebase-workflows. Those tools avoid things like formatting / quoting 
issues completely, and shift the responsibility of assigning reviewers 
from the contributor to the tool, where people can subscribe to code 
changes or code ownership can be defined and automatically taken into 
account.

Sure, I get that that the contribution workflow to Git core has 
historically grown, but what concerns me is that the efforts to "bridge" 
the contribution workflow to the "modern world" seem to go into the 
wrong direction: Tools like submitgit [1], gitgitgadget [2] and now 
patchwork [3] were created / are considered for use to allow the legacy 
email path workflow to remain, but also allow more "GUI minded" people 
to contribute. While this has worked quite well for some time, and esp. 
gitgitgadget [2] seems to haven gotten popular, I wonder whether it's 
now the time to "swap the default", and make a patch / contribution tool 
with a GUI the standard, and bridge the legacy workflow by using / 
creating tooling that makes it convenient to use those modern tools from 
the CLI, instead of the opposite.

>   2. What tricks do you use to get by with those existing pain points?

None. I simply have stopped contributing to Git core, to be frank.

>   3. Do you think patchwork goes in a direction that is likely to help
>      with these?

No. To me, this is yet another effort that tries to come up with a 
work-around instead of fixing the root cause: It tries to lift the 
limitations of an email-based contribution workflow instead of getting 
rid of the email-based contribution workflow altogether.

>   4. What other tools would you like to see that could help?

Currently, only Gerrit [4] comes to my mind, as a complete substitute 
for the email-based contribution workflow.

[1] https://github.com/rtyley/submitgit
[2] https://github.com/gitgitgadget/gitgitgadget
[3] http://jk.ozlabs.org/projects/patchwork
[4] https://www.gerritcodereview.com

-- 
Sebastian Schuberth

