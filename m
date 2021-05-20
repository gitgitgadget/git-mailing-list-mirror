Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB16C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C6760C3D
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbhETPNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:13:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:39615 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243641AbhETPNO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:13:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 711103F4098;
        Thu, 20 May 2021 11:11:52 -0400 (EDT)
Received: from MININT-MG8E6GJ.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5537E3F4090;
        Thu, 20 May 2021 11:11:52 -0400 (EDT)
Subject: Re: [PATCH v2] simple-ipc: correct ifdefs when NO_PTHREADS is defined
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
 <pull.955.v2.git.1621520547726.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a4eceb72-6fbf-3fd1-5ba8-ef03900bf7e7@jeffhostetler.com>
Date:   Thu, 20 May 2021 11:11:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.955.v2.git.1621520547726.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/20/21 10:22 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Simple IPC always requires threads (in addition to various
> platform-specific IPC support).  Fix the ifdefs in the Makefile
> to define SUPPORTS_SIMPLE_IPC when appropriate.
> 

I got in a hurry this morning and forgot to update the CMake script.
I'll look at that now.

Jeff

