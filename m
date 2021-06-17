Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05636C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6809613E7
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFQJau (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:30:50 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:52428 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhFQJat (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 05:30:49 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ltoKG-0000DJ-5s; Thu, 17 Jun 2021 10:28:40 +0100
Subject: Re: [PATCH 0/3] Fix uninitialised reads found with MSAN
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1966d581-5a02-bd28-0700-c1eb4c833d1e@iee.email>
Date:   Thu, 17 Jun 2021 10:28:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 17:48, Andrzej Hunt via GitGitGadget wrote:
> This can be worked around with an annotation in zlib (which I'm trying to
> submit upstream at [1]) 
> Andrzej
>
> [1] https://github.com/madler/zlib/pull/561
Andrzey,

Just had a look at the zlib PR and it has CI check failure asking for
extra info.

Philip
