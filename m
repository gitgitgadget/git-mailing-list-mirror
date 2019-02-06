Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766F51F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBFRSh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:18:37 -0500
Received: from siwi.pair.com ([209.68.5.199]:51675 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfBFRSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:18:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 503DE3F4042;
        Wed,  6 Feb 2019 12:18:36 -0500 (EST)
Received: from [IPv6:2001:4898:6808:13e:8d04:4166:3409:fa6a] (unknown [IPv6:2001:4898:8010:2:7638:4166:3409:fa6a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2AB013F4023;
        Wed,  6 Feb 2019 12:18:36 -0500 (EST)
Subject: Re: What's cooking in git.git (Feb 2019, #01; Tue, 5)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq1s4lst7m.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b24bfabf-3f79-a290-50b7-5246d870ae12@jeffhostetler.com>
Date:   Wed, 6 Feb 2019 12:18:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq1s4lst7m.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/5/2019 6:37 PM, Junio C Hamano wrote:
> * jh/trace2 (2019-02-01) 15 commits
>   - trace2: add for_each macros to clang-format
>   - trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
>   - trace2:data: add subverb for rebase
>   - trace2:data: add subverb to reset command
>   - trace2:data: add subverb to checkout command
>   - trace2:data: pack-objects: add trace2 regions
>   - trace2:data: add trace2 instrumentation to index read/write
>   - trace2:data: add trace2 hook classification
>   - trace2:data: add trace2 transport child classification
>   - trace2:data: add trace2 sub-process classification
>   - trace2:data: add editor/pager child classification
>   - trace2:data: add trace2 regions to wt-status
>   - trace2: collect Windows-specific process information
>   - trace2: create new combined trace facility
>   - trace2: Documentation/technical/api-trace2.txt
> 
>   A more structured way to obtain execution trace has been added.
> 
>   Still needs some fix-ups.
>   cf. <d91d1d89-5759-2006-7b38-4211db5988af@jeffhostetler.com>

I just pushed a V6 of this series that addresses the hdr-check warning
in trace2/tr2_tls.h.

Jeff

