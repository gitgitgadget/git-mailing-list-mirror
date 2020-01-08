Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B56C33CA2
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABFE20720
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 15:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAHPct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:32:49 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.107]:47441 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 10:32:48 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ipDK8-0004Xb-OS; Wed, 08 Jan 2020 16:32:44 +0100
Subject: Re: [PATCH v4 0/3] t: rework tests for --pathspec-from-file
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
 <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
 <xmqqh8173r8e.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <12861b02-386c-3ae8-cd2f-ffe07c6aabc7@syntevo.com>
Date:   Wed, 8 Jan 2020 16:32:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8173r8e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.01.2020 22:13, Junio C Hamano wrote:
> With the third step the series won't merge cleanly with other topic
> you have in 'next' (t7107 gets somewhat heavy merge conflicts).
> 
> I'll queue the first two for now but let's clean them up post 2.25
> release.

OK, I will re-submit the remaining patch after 2.25.

I will implement the next --pathspec-from-file patches as if this third 
patch was accepted (that is, without copy&pasted tests).

Thanks for accepting this and other polishing branches, I was already 
quite pessimistic about them.
