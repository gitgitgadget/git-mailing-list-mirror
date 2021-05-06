Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38AC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82F5611CB
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhEFGN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:13:29 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:19074 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhEFGN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:13:28 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 1466CSKp031933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 5 May 2021 23:12:28 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
From:   Yuri <yuri@rawbw.com>
Message-ID: <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
Date:   Wed, 5 May 2021 23:12:27 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/21 11:07 PM, Johannes Sixt wrote:
> I would argue that you are doing something wrong if your stashes are
> particularly valuable. If you regularly revert temporary, but precious
> work, then you should commit the work and mark it with a branch tip or tag.
>

No, it is work in progress. I begin to work on some modification or 
update, discover some issue, and stash the update until this issue is 
resolved,

It could take days, weeks, months to resolve them.


Yuri

