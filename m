Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9F71F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 10:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeC0K2Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 06:28:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:38205 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeC0K2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 06:28:24 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8A1103F4090;
        Tue, 27 Mar 2018 06:28:23 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4AACF3F4015;
        Tue, 27 Mar 2018 06:28:23 -0400 (EDT)
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
 <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5192e88a-41ea-02ed-c765-bfcb96aaba9d@jeffhostetler.com>
Date:   Tue, 27 Mar 2018 06:28:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 11:18 PM, Ramsay Jones wrote:
> On 26/03/18 15:31, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
> [snip]
> 
> Thanks, this version fixes all issues I had (with the compilation
> and sparse warnings).
> 
> [Was using UINT64_C(0xffffffffffffffff) a problem on windows?]

Thanks for the confirmation.

I was building on Linux.  I haven't tried using UINT64_C()
for anything, but I'll keep that in mind next time.

Thanks,
Jeff


