Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5631F462
	for <e@80x24.org>; Mon, 27 May 2019 18:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfE0SVf (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 14:21:35 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50967 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbfE0SVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 14:21:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45CQKS6LY9z5tlC;
        Mon, 27 May 2019 20:21:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7AC56213C;
        Mon, 27 May 2019 20:21:31 +0200 (CEST)
Subject: Re: git filter-branch re-write history over a range of commits did
 notwork
To:     LU Chuck <Chuck.LU@edenred.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
Date:   Mon, 27 May 2019 20:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.05.19 um 10:01 schrieb LU Chuck:
> Hi team,
> 
>     The issue comes from https://github.com/git-for-windows/git/issues/2206.
> 
>     I want to re-write history by filter-branch command over a range of commits, but the command did not work.
>     I have referred to the following three documentation about how to use git filter-branch:
>     https://stackoverflow.com/questions/15250070/running-filter-branch-over-a-range-of-commits
>     https://stackoverflow.com/questions/28536980/git-change-commit-date-to-author-date
>     https://git-scm.com/docs/git-filter-branch
> 
>     You can reproduce the problem by the following steps
>     1. clone the repository https://github.com/chucklu/LeetCode/
>     2. checkout to the temp branch
>     3. run the command git filter-branch --env-filter 'export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"' ... 67d9d9..f70bf4

Did you not tell us everything because you write ... in this message
when you cited the command you used, or do you say that you used ...
literally in the command?

>     4. You will got the info "Found nothing to rewrite"
>  
>     However, it was supposed to overwrite the history from commit 9c1580 to commit f70bf4, make the commit date same as date.
>     I am not sure if I am using the filter-branch correctly, or if there is a bug in git?
> 
>     Anyone can help me? Thanks in advance.

-- Hannes
