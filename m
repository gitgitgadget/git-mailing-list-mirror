Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3886020C39
	for <e@80x24.org>; Fri,  8 Dec 2017 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdLHSKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:10:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:40023 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdLHSKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:10:41 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DE5E2844BE;
        Fri,  8 Dec 2017 13:10:40 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A81F0844BB;
        Fri,  8 Dec 2017 13:10:40 -0500 (EST)
Subject: Re: [PATCH v7 00/16] Parial clone part 3: clone, fetch, fetch-pack,
 upload-pack, and tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
 <xmqqtvx185kq.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <67f80ac5-6530-094f-bd10-01ef8b5a6b97@jeffhostetler.com>
Date:   Fri, 8 Dec 2017 13:10:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvx185kq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/8/2017 12:58 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This is V7 of part 3 of partial clone.  It builds upon V7 of part 2
>> (which builds upon V6 of part 1).
> 
> Aren't the three patches at the bottom sort-of duplicate from the
> part 2 series?
> 

oops.  yes, you're right.  it looks like i selected pc*6*_p2..pc7_p3
rather than pc*7*_p2..pc7_p3.  sorry for the typo.

and since the only changes in p2 were to squash those 2 commits near
the tip of p2, only those 3 commits changed SHAs in v7 over v6.

so, please disregard the duplicates.

would you like me to send a corrected V8 for p3 ?

Jeff
