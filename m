Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0771F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfKFP41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:56:27 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:37550 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKFP41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:56:27 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSNfS-0004NY-Jo; Wed, 06 Nov 2019 16:56:22 +0100
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
 <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <ffd13b85-e82d-3b7a-da0b-d28e8f546796@syntevo.com>
Date:   Wed, 6 Nov 2019 16:56:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have implemented most suggestions in PatchV2. Thanks!

On 05.11.2019 16:03, Phillip Wood wrote:
> I'm confused reset does not use stdin does it?

I have improved commit message to clarify.

> --pathspec-file would be shorter and still conveys the intent of the 
> option.

I decided to stay with writing suggested by Junio.

> Is this line missing a leading space?

I think it's good. Maybe you were confused by patch formatting?

> Alignment again

I think it's good again :)

> If I've understood correctly this doesn't test if a path is correctly 
> unquoted, only that it is accepted.

Already agreed that test is good, just a bit non-obvious.

> s/^/--pathspec-from-file / ?

I decided not to repeat '--pathspec-from-file' in every test, because 
test package already has it in description. Is that good?
