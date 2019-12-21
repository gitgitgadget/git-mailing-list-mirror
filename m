Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D58EC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEA320725
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 16:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfLUQsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 11:48:45 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:29501 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfLUQsp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 11:48:45 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iihvn-00042G-3e; Sat, 21 Dec 2019 16:48:43 +0000
Subject: Re: [PATCH 2/9] commit-graph: write changed paths bloom filters
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <e52c7ad37a306891487bd79a09b040bfb657d723.1576879520.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <39ef6bc6-4f21-1ba6-ad6e-06cb1a2423ac@iee.email>
Date:   Sat, 21 Dec 2019 16:48:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e52c7ad37a306891487bd79a09b040bfb657d723.1576879520.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

spelling nit?

On 20/12/2019 22:05, Garima Singh via GitGitGadget wrote:
> 1. The implementation sticks to the recommended values of 7 and 10 for the
>    number of hashes and the size of each entry, as described in the blog.
>    The implementation while not completely open to it at the moment, is flexible
>    enough to allow for tweaking these settings in the future.
>    Note: The performance gains we have observed so far with these values is
>    significant enough to not that we did not need to tweak these settings.
s/not/note/ (first occurrence)
>    The cover letter of this series has the details and the commit where we have
>    git log use bloom filters.
Philip
