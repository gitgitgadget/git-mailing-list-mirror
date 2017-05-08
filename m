Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2AE1FC44
	for <e@80x24.org>; Mon,  8 May 2017 20:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756804AbdEHUSo (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 16:18:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:41090 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756773AbdEHUSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 16:18:44 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9C9FF844DA;
        Mon,  8 May 2017 16:18:32 -0400 (EDT)
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
To:     Christian Couder <christian.couder@gmail.com>
References: <20170414203221.43015-1-git@jeffhostetler.com>
 <20170414203221.43015-2-git@jeffhostetler.com>
 <CAP8UFD2v8R8bSjUi8+1271fJ=jR5JbbGfgO_fdeYpzE=EGx_Pw@mail.gmail.com>
 <962eefec-2ea6-6b43-7bd5-51da4150bb6a@jeffhostetler.com>
 <CAP8UFD1dR1QY81tCAcbB6RP61vBxXy-u8zFAhLpk9uP71Jna-Q@mail.gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c9f77c02-c498-1b0d-26c2-27d6f576ee71@jeffhostetler.com>
Date:   Mon, 8 May 2017 16:18:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1dR1QY81tCAcbB6RP61vBxXy-u8zFAhLpk9uP71Jna-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/8/2017 4:03 PM, Christian Couder wrote:
> On Mon, May 8, 2017 at 6:50 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>
>> On 5/8/2017 5:45 AM, Christian Couder wrote:
>>>
>>> This test does not pass when the GIT_TEST_SPLIT_INDEX env variable is
>>> set on my Linux machine.
>>>
>>> Also it looks like you sent a v8 of this patch series with a different
>>> test, but what is in master looks like the above test instead of the
>>> test in your v8.
>>
>> There was concern about using sed on a binary file not being portable
>> and a request to change the test to just corrupt the checksum rather
>> than an index-entry, so I changed it in v8.
>>
>> Does the v8 version of the test also fail on your machine ?
>
> The v8 version of the test succeeds on my machine.

OK, thanks.  It worked on mine too.  Since the v8 version is a
better test, I'm content to stick with it and not try to address
the problem with the previous version.

Jeff
