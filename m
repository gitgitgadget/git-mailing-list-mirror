Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8778B2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 20:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdKUUqM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 15:46:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:31216 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdKUUqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 15:46:11 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D2046844F1;
        Tue, 21 Nov 2017 15:46:10 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9BF3B844F0;
        Tue, 21 Nov 2017 15:46:10 -0500 (EST)
Subject: Re: [PATCH v4 00/15] Parial clone part 3: clone, fetch, fetch-pack,
 upload-pack, and tests
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
 <20171121101702.663a52515070faf73a97f2b8@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fe9a3ff3-00aa-555e-1865-82749121de0d@jeffhostetler.com>
Date:   Tue, 21 Nov 2017 15:46:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171121101702.663a52515070faf73a97f2b8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/21/2017 1:17 PM, Jonathan Tan wrote:
> On Thu, 16 Nov 2017 18:17:08 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This part 3 of a 3 part sequence partial clone.  It assumes
>> that part 1 and part 2 are in place.
>>
>> This patch series is labeled as V4 to keep it in sync with
>> the corresponding V4 versions of parts 1 and 2.  There was
>> not a V3 version of this patch series.
>>
>> Jonathan and I independently started on this task.  This is another
>> pass at merging those efforts.  So there are several places that may
>> need refactoring and cleanup, but fewer than in the previous submission.
>> In particular, the test cases should be squashed and new tests added.
>>
>> And I think we need more end-to-end tests.  I'll work on those next.
> 
> I think that it would be easier to review if the test for each command
> was contained in the same patch as (or the patch immediately following)
> the implementation of the command - for example, as in my modifications
> [1].
> 
> (If you're about to send out v5, that's fine - maybe take this in
> consideration for v6, if there is one.)
> 
> [1] https://github.com/jonathantanmy/git/commits/pc20171103
> 

I've already pulled the tests to be with the code changes in part 1
and part 2.  There are a few commits with tests in part 3 that we may
want to squash together, but we can do that later.  If you want to
start with my V5 set and do that, that would be fine.

What I was talking about above are some additional end-to-end tests
that I think we need.  For example, do a partial clone/fetch and then
run blame or some other commands that exercise the overall system.

As parts 1, 2, and 3 are settling down, these additional tests could
be in a part 4 for now.  Later, if it makes sense, these could be
move earlier.

Jeff
