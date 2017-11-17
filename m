Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB76202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 17:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760025AbdKQRgK (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 12:36:10 -0500
Received: from siwi.pair.com ([209.68.5.199]:59083 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbdKQRgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 12:36:09 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BD177844DB;
        Fri, 17 Nov 2017 12:36:08 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 78BFE844D7;
        Fri, 17 Nov 2017 12:36:08 -0500 (EST)
Subject: Re: [PATCH v4 5/6] rev-list: add list-objects filtering support
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171116180743.61353-1-git@jeffhostetler.com>
 <20171116180743.61353-6-git@jeffhostetler.com>
 <20171116124354.3d800cc27dbe3ea668c64519@google.com>
 <xmqqd14htzw5.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f59d4b4a-3eec-6cc2-d822-f65d0d8fd99e@jeffhostetler.com>
Date:   Fri, 17 Nov 2017 12:36:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqd14htzw5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/16/2017 9:14 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> If it were up to me, I would remove all existing mentions of "partial
>> clone" and explain the presence of the "--missing" argument as follows:
>>
>>      In the future, we will introduce a "partial clone" mechanism wherein
>>      an object in a repo, obtained from a remote, may reference a missing
>>      object that can be dynamically fetched from that remote once needed.
>>      This "partial clone" mechanism will have a way, sometimes slow, of
>>      determining if a missing link is one of the links expected to be
>>      produced by this mechanism.
>>
>>      This patch introduces handling of missing objects to help debugging
>>      and development of the "partial clone" mechanism, and once the
>>      mechanism is implemented, for a power user to perform operations
>>      that are missing-object-aware without incurring the cost of checking
>>      if a missing link is expected.
> 
> That sounds quite sensible.
> 

will do.  thanks.
Jeff
