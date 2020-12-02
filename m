Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5410C83012
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A50221E9
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbgLBQ0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:26:12 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:47648 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgLBQ0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 11:26:12 -0500
Received: from client3368.fritz.box (i5C747DCD.versanet.de [92.116.125.205])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id B196D3C0439;
        Wed,  2 Dec 2020 17:25:30 +0100 (CET)
Subject: Re: bugreport
To:     Ole M <superole2@gmail.com>, git@vger.kernel.org
References: <CAAhqouLmyfj=c58mFmvkBOtTtyoM_c9uO4T==h2T9y6_tb0nrQ@mail.gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Serg Tereshchenko <serg.partizan@gmail.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <e9020543-a5b5-c49b-3286-23a1db04da3d@haller-berlin.de>
Date:   Wed, 2 Dec 2020 17:25:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAAhqouLmyfj=c58mFmvkBOtTtyoM_c9uO4T==h2T9y6_tb0nrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.12.20 11:08, Ole M wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> * open Git Gui in a repository from git bash ($ git gui&)
> * select some text in the diff pane
> 
> What did you expect to happen? (Expected behavior)
> * selected text should be highlighted with white text on blue
> background (maybe it used to use system defined colors?)
> 
> What happened instead? (Actual behavior)
> * selected text is highlighted with white text on black background

Hi Ole,

thanks for the report. It's a known bug, a fix for this is already in
the works.

Best,
Stefan


> What's different between what you expected and what actually happened?
> * The contrast has increased to a level that is painful for me to look
> at, making it difficult to read the selected text.
> * It also makes the experience of this tool different from gitk,
> making me focus on the tool rather than the content and workflow.
> 
> Anything else you want to add:
> 
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.29.2.windows.2
> cpu: x86_64
> built from commit: 3464b98ce6803c98bf8fb34390cd150d66e4a0d3
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Windows 10.0 18363
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
> 
> 
> [Enabled Hooks]
> 
