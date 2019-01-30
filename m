Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083981F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfA3THE (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:07:04 -0500
Received: from siwi.pair.com ([209.68.5.199]:29672 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfA3THC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:07:02 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E274C3F4050;
        Wed, 30 Jan 2019 14:07:01 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C7A973F4019;
        Wed, 30 Jan 2019 14:07:01 -0500 (EST)
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2fcac3f7-22be-71fa-eee9-9cc630711029@jeffhostetler.com>
Date:   Wed, 30 Jan 2019 14:07:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/29/2019 5:15 PM, Junio C Hamano wrote:
> 
> * jh/trace2 (2019-01-28) 14 commits
>   - trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
>   - trace2:data: add subverb for rebase
>   - trace2:data: add subverb to reset command
>   - trace2:data: add subverb to checkout command
>   - pack-objects: add trace2 regions
>   - trace2:data: add trace2 instrumentation to index read/write
>   - trace2:data: add trace2 hook classification
>   - trace2:data: add trace2 transport child classification
>   - trace2:data: add trace2 sub-process classification
>   - trace2:data: add editor/pager child classification
>   - trace2:data: add trace2 regions to wt-status
>   - trace2: collect platform-specific process information
>   - trace2: create new combined trace facility
>   - trace2: Documentation/technical/api-trace2.txt
> 
>   A more structured way to obtain execution trace has been added.
> 
>   Ready?

I'm about to send in a V3 that includes an updated design doc
and addresses most of the clang-format suggestions.

The CI build reports that my V3 collides with a change
added yesterday in submodule.c in master.  It was added in
/sb/submodule-recursive-fetch-gets-the-tip.

I'll rebase onto the tip of master and fix it up.

And if there are no comments on my V3, I think it is ready.

Jeff
