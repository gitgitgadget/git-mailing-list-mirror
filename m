Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10B020A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbdLEWCO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:02:14 -0500
Received: from siwi.pair.com ([209.68.5.199]:57763 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbdLEWCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:02:13 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 70BC3844E1;
        Tue,  5 Dec 2017 17:02:12 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 23202844B9;
        Tue,  5 Dec 2017 17:02:12 -0500 (EST)
Subject: Re: [PATCH v6 09/12] fixup: sha1_file: convert gotos to
 break/continue
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
 <20171205165854.64979-10-git@jeffhostetler.com>
 <xmqqk1y0j3p2.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6952d10c-5f99-e183-548b-e400aed7d49b@jeffhostetler.com>
Date:   Tue, 5 Dec 2017 17:02:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1y0j3p2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/5/2017 3:54 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   sha1_file.c | 40 ++++++++++++++++++++--------------------
>>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> The second (i.e. this) part and the third part are not yet in
> 'next', so it will perfectly be fine to squash these into the
> commits that introduces the issues that are corrected in this
> "fixup".  The same comment applies to all the other "fixup" patches.
> 

OK thanks.  I left this one as a separate commit so that
we could debate the merits of the while(1) vs the gotos
and keep/reject independent of the other changes.  I'll
squash it in the next version.

Thanks
Jeff

