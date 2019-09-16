Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8A91F464
	for <e@80x24.org>; Mon, 16 Sep 2019 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfIPOcC (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 10:32:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:10933 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388666AbfIPOcB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 10:32:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C30CA3F40BC;
        Mon, 16 Sep 2019 10:32:00 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:a141:d490:d6f1:dba7] (unknown [IPv6:2001:4898:a800:1010:5277:d490:d6f1:dba7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4AF5E3F40A0;
        Mon, 16 Sep 2019 10:32:00 -0400 (EDT)
Subject: Re: [PATCH 0/3] clone --filter=sparse:oid bugs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
 <20190904045424.GA6488@sigill.intra.peff.net>
 <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
 <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
 <20190909170823.GA30470@sigill.intra.peff.net>
 <20190915010942.GA19787@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a5e9bfa0-5372-c444-cc42-5ca2f614b1b9@jeffhostetler.com>
Date:   Mon, 16 Sep 2019 10:31:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190915010942.GA19787@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/14/2019 9:09 PM, Jeff King wrote:
> On Mon, Sep 09, 2019 at 01:08:24PM -0400, Jeff King wrote:
> 
>> I'll work up what I sent earlier into a real patch, and include some of
>> this discussion.
> 
> Here it is. I pulled Jon's tests out into their own patch (mostly
> because it makes it easier to give credit). Then patch 2 is my fix, and
> patch 3 is the message fixups he had done.
> 
> This replaces what's queued in js/partial-clone-sparse-blob.
> 
>    [1/3]: t5616: test cloning/fetching with sparse:oid=<oid> filter
>    [2/3]: list-objects-filter: delay parsing of sparse oid
>    [3/3]: list-objects-filter: give a more specific error sparse parsing error
> 
>   builtin/rev-list.c            |  4 ----
>   list-objects-filter-options.c | 14 ++------------
>   list-objects-filter-options.h |  2 +-
>   list-objects-filter.c         | 14 +++++++++++---
>   t/t5616-partial-clone.sh      | 36 +++++++++++++++++++++++++++++++++++
>   5 files changed, 50 insertions(+), 20 deletions(-)
> 

This series looks good to me.

Thanks!
Jeff
