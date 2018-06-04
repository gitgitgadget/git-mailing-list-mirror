Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06AB1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeFDJu1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 05:50:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:46122 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeFDJu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 05:50:26 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2018 05:50:26 EDT
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B82533F4019;
        Mon,  4 Jun 2018 05:41:24 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C6643F4018;
        Mon,  4 Jun 2018 05:41:24 -0400 (EDT)
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, wink@saville.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
 <CACsJy8DcGp29iJDZKUz0JM-bvbE_G3KnqWyLk_efjd7T3URTYw@mail.gmail.com>
 <20180602051344.GA28311@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <27b02292-9434-edfb-fa43-549973bf7b93@jeffhostetler.com>
Date:   Mon, 4 Jun 2018 05:41:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180602051344.GA28311@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/2/2018 1:13 AM, Jeff King wrote:
> On Sat, Jun 02, 2018 at 06:41:06AM +0200, Duy Nguyen wrote:
> 
>> On Mon, Mar 26, 2018 at 4:31 PM,  <git@jeffhostetler.com> wrote:
>>> +static inline void assert_in_array(const struct json_writer *jw)
>>> +{
>>> +       if (!jw->open_stack.len)
>>> +               die("json-writer: array: missing jw_array_begin()");
>>
>> When you reroll, please consider marking all these string for
>> translation with _(), unless these are for machine consumption.
> 
> Actually, these are all basically asserts, I think. So ideally they'd be
> BUG()s and not translated.

Yes, these are basically asserts.  I'll convert them to BUG's and send
up another version this week.

Thanks
Jeff

