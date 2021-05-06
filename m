Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F33C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D926112D
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhEFG7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:59:21 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:16017 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhEFG7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:59:18 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 1466wH3K036309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 5 May 2021 23:58:17 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
 <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
 <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
From:   Yuri <yuri@rawbw.com>
Message-ID: <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
Date:   Wed, 5 May 2021 23:58:16 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/21 11:43 PM, Johannes Sixt wrote:
> I know. But, as I said, when you turn away from your current work, which
> is precious, then you should make a commit, in particular, when you can
> forsee that you might not be able to come back soon.


How can I commit unfinished work? Commits are public, this would break 
things.

> For long-term storage, use branches.

Branches are too heavy-weight. They need merging. Sometimes several stash items need to be used together, which makes it inconvenient.

Yuri

