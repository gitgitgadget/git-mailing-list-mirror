Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC751F731
	for <e@80x24.org>; Thu,  1 Aug 2019 16:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfHAQEX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 12:04:23 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.107]:40993 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbfHAQEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 12:04:22 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htDYw-0006VQ-D9; Thu, 01 Aug 2019 18:04:18 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
 <xmqqef24op5q.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <a6610e94-6318-b962-5dd0-ca379def3bba@syntevo.com>
Date:   Thu, 1 Aug 2019 18:04:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqef24op5q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.08.2019 17:56, Junio C Hamano wrote:
> So, reading paths from a file (which could be "-" as you suggest)
> would be a good solution for that.

To summarize:
1) Implement --paths-file for high-level commands.
2) '--paths-file -' would mean reading from stdin.

Is that something you're ready to accept patches for?
