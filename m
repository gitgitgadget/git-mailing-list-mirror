Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16FF202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 20:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCOUO0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 16:14:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:12292 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCOUO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 16:14:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 87B7C3F4012;
        Fri, 15 Mar 2019 16:14:25 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:d487:82da:e467:b584] (unknown [IPv6:2001:4898:8010:2:bdbb:82da:e467:b584])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 452BA3F400E;
        Fri, 15 Mar 2019 16:14:25 -0400 (EDT)
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1552519463.git.steadmon@google.com>
 <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
 <87h8c6baif.fsf@evledraar.gmail.com>
 <1431dc76-1b1c-c581-6355-b796591e99a8@jeffhostetler.com>
 <87sgvo9bwt.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6dc8e2db-4ae4-4be4-ab4f-bba12e3429d0@jeffhostetler.com>
Date:   Fri, 15 Mar 2019 16:14:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <87sgvo9bwt.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/15/2019 3:26 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 15 2019, Jeff Hostetler wrote:
> 
[...]
>>
>> I'm routing the Trace2 data to a named-pipe/socket and have a daemon
>> collecting and filtering, so I have a single pathname for output and
>> yet get the per-file stream handling that I think Josh is looking for.
> 
> Is the collecting code something you can share & general enough that it
> might be useful for others?
> 

Yes, we're currently talking about releasing the source for that too.
It probably won't happen this month, maybe early next quarter.

Jeff
