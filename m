Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990CF1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfKSQup (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:50:45 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:15126 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfKSQup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:50:45 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iX6i8-0003ra-8x; Tue, 19 Nov 2019 17:50:40 +0100
Subject: Re: [PATCH v2 2/6] pathspec: add new function to parse file
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
 <96697ba0724caee556f21ada3959c4190d80c0b9.1573055478.git.gitgitgadget@gmail.com>
 <xmqqzhgsxv77.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <6b37c14b-d618-7cc9-150d-ef95f5402ab1@syntevo.com>
Date:   Tue, 19 Nov 2019 17:50:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqzhgsxv77.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2019 6:59, Junio C Hamano wrote:
>> +	FILE *in = NULL;
> 
> Useless initialization to NULL can be dropped here.

Changed in V3.
