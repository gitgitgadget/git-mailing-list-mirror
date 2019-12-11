Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F76C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53F205C9
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfLKQUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:20:12 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.110]:37897 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfLKQUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 11:20:11 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1if4ic-0003jN-My; Wed, 11 Dec 2019 17:20:06 +0100
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
 <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
 <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
 <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
 <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
 <9d77a425-da8d-d6e7-f51f-c4ce6ee988d5@syntevo.com>
 <xmqq5zimrg9i.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <51a0c649-5140-5fa4-9c37-c0a0942a2e83@syntevo.com>
Date:   Wed, 11 Dec 2019 17:20:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zimrg9i.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.12.2019 17:14, Junio C Hamano wrote:
> If nobody commented on your patches, that is not a punishment.  It
> could have been that reviewers were busy addressing other issues
> back then, in which case a gentle ping by resending a polished
> version (it could be that the changes were not presented well to
> attract reviewers' attention---polishing the proposed log messages
> without changing the patch text might be all it takes to make them
> realize that the topic is worth looking at) would help.

Thanks for letting me know! This is actually a relief.

I will then merge both topics with my next '--pathspec-from-file' batch, 
because they are all parts of one work. I just thought that since they 
can be submitted separately I should do that, maybe that was a mistake.
