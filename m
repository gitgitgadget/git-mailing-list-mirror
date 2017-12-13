Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F8E1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 18:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbdLMSi3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 13:38:29 -0500
Received: from siwi.pair.com ([209.68.5.199]:43302 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbdLMSi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 13:38:28 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 017AD844BB;
        Wed, 13 Dec 2017 13:38:28 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9F222844B9;
        Wed, 13 Dec 2017 13:38:27 -0500 (EST)
Subject: Re: [PATCH v6 3/3] rev-list: support --no-filter argument
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171205165014.64488-1-git@jeffhostetler.com>
 <20171205165014.64488-4-git@jeffhostetler.com>
 <CAP8UFD1A8+tRqeY5v9gbbUHY6W6fS2LS-7Z3zCqiBZQ8ZTHkNg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ac918329-82bb-1d71-ae44-df16878b4934@jeffhostetler.com>
Date:   Wed, 13 Dec 2017 13:38:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1A8+tRqeY5v9gbbUHY6W6fS2LS-7Z3zCqiBZQ8ZTHkNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/11/2017 1:17 AM, Christian Couder wrote:
> On Tue, Dec 5, 2017 at 5:50 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach rev-list to support --no-filter to override a
>> previous --filter=<filter_spec> argument.  This is
>> to be consistent with commands that use OPT_PARSE
>> macros.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   Documentation/rev-list-options.txt | 15 ++++++++++-----
>>   builtin/rev-list.c                 |  4 ++++
>>   2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 11bb87f..8d8b7f4 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -715,16 +715,21 @@ ifdef::git-rev-list[]
>>   The form '--filter=blob:none' omits all blobs.
>>   +
>>   The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
>> -or units.  The value may be zero.
>> +or units.  n may be zero.  The suffixes k, m, and g can be used to name
> 
> "'<n>' may be zero" would be more consistent with other parts of this file.
> s/k, m, and g/'k', 'm', and 'g'/ could also help.

good catch. thanks.
jeff

