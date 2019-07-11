Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05B31F461
	for <e@80x24.org>; Thu, 11 Jul 2019 21:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfGKVHh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 17:07:37 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:13105 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfGKVHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 17:07:37 -0400
Received: from [192.168.1.22] ([89.241.179.146])
        by smtp.talktalk.net with SMTP
        id lgHuhY0yKnuQZlgHuhqrOz; Thu, 11 Jul 2019 22:07:34 +0100
X-Originating-IP: [89.241.179.146]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=tep6GD389W9SVPjeVVsDrw==:117
 a=tep6GD389W9SVPjeVVsDrw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=xtxXYLxNAAAA:8 a=mdmap_6We6rQRhGcmhMA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Git Test Coverage Report (Wed. July 10)
To:     Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <2f2925b8-8276-c2cb-595f-badaa5cedc1e@gmail.com>
 <0bb53084-0604-21c1-c127-0eecd6481bbb@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <6613af78-9c73-6e0d-79f2-9206cce0ab8f@iee.org>
Date:   Thu, 11 Jul 2019 22:07:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bb53084-0604-21c1-c127-0eecd6481bbb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFIw+we9zOE1K4ugz01Q539rTCznMYu5AUJ4SPKjpfoDyrY45xhP9x2e+h7exldmIcnPFtWnsbYP+I2taHHU4BOYr893in23FCYYufwn4hrYkM5ioFuc
 mehgJygVyllLtLcZaRDdFlUeFRMExgmVMqGVN0LYUobuxa1BZOnTOpf4MIxWtIdRiobZ08tCnYSZUJrIg1xc6i8dlpy40mneirY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2019 03:13, Derrick Stolee wrote:
> I apologize for the incorrect report sent earlier. I changed something about my workflow, and it changed where build outputs were downloaded and I included an old report.
>
> -Stolee
>
> ---
>
> pu	c984b65d414a0da7af629eb476f12b27e13ede0b
> jch	2bb3fc833ce3b23a27fdaba73982b617ba480bb7
> next	f5cf68d754516a24d6a948b93daa5343b6152217
> master	6d5b26420848ec3bc7eae46a7ffa54f20276249d
> master@{1}	8dca754b1e874719a732bc9ab7b0e14b21b1bc10
>
[snip]
>
> Uncovered code in 'master' not in 'master@{1}'
> --------------------------------------------------------
>
> builtin/branch.c
> 1fde99cf 841) die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
>

[snip]

>
> Commits introducting uncovered code:
> ...
> Philip Oakley	1fde99cf doc branch: provide examples for listing remote tracking branches
>
Hi Stolee,

Back at [1] (8 Jun 2019) I suggested a possible test that could cover 
this update to the message.

The main doc changes went through following [2] (14 Jun 2019) after 
confirming that the original RFC note on my patches was just for the 
die() message change (which then begat this test coverage omission).

However there are a large number (34) of other die() messages in 
branch.c, so it may not be worth a special effort to catch all of them. 
I'm minded to let it drop.

Philip

[1] 
https://public-inbox.org/git/f28dd5b1-fda8-cf51-5582-067a7d2c2472@iee.org/
[2] 
https://public-inbox.org/git/024373d9-e032-1af8-ba26-439ad5620bf5@iee.org/
