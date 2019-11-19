Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AABA1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfKSQ4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:56:12 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.108]:27613 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfKSQ4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:56:12 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iX6nP-0001IT-8z; Tue, 19 Nov 2019 17:56:07 +0100
Subject: Re: [PATCH v2 6/6] commit: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
 <cb5fc9b14dbe81703a7fc61b56f5c68c4a49ebc2.1573055478.git.gitgitgadget@gmail.com>
 <xmqqo8x8xup8.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <74889f88-b5dd-b1bd-f619-9201ce14db29@syntevo.com>
Date:   Tue, 19 Nov 2019 17:56:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqo8x8xup8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2019 7:10, Junio C Hamano wrote:
>> +--pathspec-file-nul::
>> +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
>> +	separated with NUL character and are not expected to be quoted.
> 
> Although it is not incorrect, "are not expected to be quoted" feels
> a bit weak as the technical description.  Are they not expected to
> be quoted, but the command gracefully works on them even when they
> are found to be quoted?
> 
> Rephrasing to avoid such misinterpretation may be worth doing,
> perhaps
> 
> 	... and are taken as-is without unquoting (i.e. as if
> 	`core.quotePath` is set to `false`).
> 
> or something like that?

I think that a reference to `core.quotePath` could be confusing here, 
because it doesn't really affect the option. I have reworded it in V3, 
please see if you like it.

Thanks for pointing out!
