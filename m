Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC00C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2714E6115C
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 18:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbhHFSAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:00:25 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:39591 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbhHFSAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 14:00:24 -0400
Received: from [94.228.207.202] (helo=[192.168.2.21])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1mByvu-0005VP-PA; Fri, 06 Aug 2021 14:26:38 +0200
Subject: Re: [BUG] Amending a shallow clone -> orphan branch
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <64760969-1ead-2bfb-6f98-1161d385c0ca@syntevo.com>
 <b3083a15-f2da-0eae-b07b-8a641c613906@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <fbec1ce8-a1ec-b504-72a7-2f96b646127b@syntevo.com>
Date:   Fri, 6 Aug 2021 15:27:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b3083a15-f2da-0eae-b07b-8a641c613906@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.08.2021 15:21, Bagas Sanjaya wrote:
> So you're amending merge commit by adding dummy file, so that your 
> `master` branch becomes divergent against origin. That dummy file isn't 
> contained in any commits that are included with that merge commit.

Note, the problem isn't about merge commits, it happens for regular 
commits as well. Maybe I should have picked a different repo for 
example. Still, the problem with losing all parents is the same 
regardless of merge/regular commit.
