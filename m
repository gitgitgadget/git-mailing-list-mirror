Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AAD20281
	for <e@80x24.org>; Tue, 26 Sep 2017 14:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031080AbdIZOzk (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 10:55:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:29101 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031076AbdIZOzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 10:55:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 23D53845D8;
        Tue, 26 Sep 2017 10:55:39 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BB250845D6;
        Tue, 26 Sep 2017 10:55:38 -0400 (EDT)
Subject: Re: [PATCH 00/13] RFC object filtering for parital clone
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
References: <20170922202632.53714-1-git@jeffhostetler.com>
 <20170922173957.f5601015cc8d6760c80293a9@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <03a00220-f637-5931-c8f4-07833a9b3d4f@jeffhostetler.com>
Date:   Tue, 26 Sep 2017 10:55:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922173957.f5601015cc8d6760c80293a9@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/22/2017 8:39 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 20:26:19 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> This draft contains filters to:
>> () omit all blobs
>> () omit blobs larger than some size
>> () omit blobs using a sparse-checkout specification
>>
>> In addition to specifying the filter criteria, the rev-list command
>> was updated to include options to:
>> () print a list of the omitted objects (due to the current filtering
>>     criteria)
>> () print a list of missing objects (probably from a prior partial
>>     clone/fetch).
> 
> Thanks, this last point seems useful.
> 
> I tried applying your patches and it doesn't apply cleanly on master.
> Could you try rebasing? In particular, the code references
> get_sha1_with_context(), which no longer exists (it was replaced with
> get_oid_with_context()).
> 

I usually build and submit patches relative to the latest
available tag (v2.14.1) rather than a moving target, but
yeah I'll look thru the other comments and rebase it forward.

Thanks
Jeff
