Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79484C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BF4611CA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFOViY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:38:24 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:43251 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbhFOViX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:38:23 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4G4M812jRTz5tlB;
        Tue, 15 Jun 2021 23:36:17 +0200 (CEST)
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <55d0eb59-10a0-1dff-f195-4d660c6028e0@kdbg.org>
Date:   Tue, 15 Jun 2021 23:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.21 um 07:16 schrieb Elijah Newren via GitGitGadget:
> Implement a zealous diff3, or "zdiff3". This new mode is identical to
> ordinary diff3 except that it allows compaction of common lines between the
> two sides of history, if those common lines occur at the beginning or end of
> a conflict hunk.

As a data point, I tried this series (cf9d93e547 en/zdiff3) on my
criss-cross merge test case that started this adventure, and it produces
the very same output as diff3; cf.
https://lore.kernel.org/git/60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org/

-- Hannes
