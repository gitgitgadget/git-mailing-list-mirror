Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67C51F403
	for <e@80x24.org>; Mon, 11 Jun 2018 11:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeFKLnr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 07:43:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:49016 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932841AbeFKLnr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 07:43:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D6DA73F4021;
        Mon, 11 Jun 2018 07:43:46 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A691C3F4018;
        Mon, 11 Jun 2018 07:43:46 -0400 (EDT)
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
 <f1154c86-9d11-f272-643f-4316be40e9b7@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <134901ed-eab9-b921-9c81-4397430c0069@jeffhostetler.com>
Date:   Mon, 11 Jun 2018 07:43:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f1154c86-9d11-f272-643f-4316be40e9b7@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/8/2018 2:05 AM, René Scharfe wrote:
> Am 07.06.2018 um 16:12 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Add a series of jw_ routines and "struct json_writer" structure to compose
[...]
>>   TEST_PROGRAMS_NEED_X += test-index-version
>> +TEST_PROGRAMS_NEED_X += test-json-writer>  TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
>>   TEST_PROGRAMS_NEED_X += test-line-buffer
>>   TEST_PROGRAMS_NEED_X += test-match-trees
> 
> This doesn't apply cleanly on master, because most test helpers have
> been combined into a single binary to reduce their disk footprint and
> link times.  See efd71f8913 (t/helper: add an empty test-tool program)
> for the overall rationale.
> 
> test-json-writer could become a built-in as well, I think.  You can see
> e.g. in c932a5ff28 (t/helper: merge test-string-list into test-tool)
> what needs to be done to convert a helper.
> 
> René
> 

You're right, the test helper framework changed since I started this
patch series.  I was trying to keep the same parent commit as my V1
to make it easier to compare, but that's not working out so well.

I'll move it forward to the current master and fix it up.

Thanks,
Jeff
