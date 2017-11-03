Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3D820450
	for <e@80x24.org>; Fri,  3 Nov 2017 14:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbdKCOWq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 10:22:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:56111 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753361AbdKCOWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 10:22:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AD51584591;
        Fri,  3 Nov 2017 10:22:44 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3F9278458D;
        Fri,  3 Nov 2017 10:22:44 -0400 (EDT)
Subject: Re: [PATCH 00/14] WIP Partial clone part 3: clone, fetch, fetch-pack,
 upload-pack, and tests
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
 <20171102164135.435c05e07f71dcaf34149c2e@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7fcb5464-d638-74f7-db5d-3b015e88ec2d@jeffhostetler.com>
Date:   Fri, 3 Nov 2017 10:22:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102164135.435c05e07f71dcaf34149c2e@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/2/2017 7:41 PM, Jonathan Tan wrote:
> On Thu,  2 Nov 2017 20:31:15 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This is part 3 of 3 for partial clone.
>> It assumes that part 1 [1] and part 2 [2] are in place.
>>
>> Part 3 is concerned with the commands: clone, fetch, upload-pack, fetch-pack,
>> remote-curl, index-pack, and the pack-protocol.
>>
>> Jonathan and I independently started on this task.  This is a first
>> pass at merging those efforts.  So there are several places that need
>> refactoring and cleanup.  In particular, the test cases should be
>> squashed and new tests added.
> 
> Thanks. What are your future plans with this patch set? In particular, the
> tests don't pass at HEAD^.
> 
Patch 14/14 fixed 2 existing tests.  I think I want to merge that with
patch 2/14 as part of the cleanup.

Bigger picture, I would like squash all this down.  But first I wanted
you to see if there was anything I missed during the merge.

> I took a quick glance to see if there were any issues that I could
> immediately spot, but couldn't find any. I thought of fetch_if_missing,
> but it seems that it is indeed used in this patch set (as expected).
> 
> I'll look at it more thorougly, and feel free to let me know if there is
> anything in particular you would like comments on.
> 

Thanks, will do.
Jeff

