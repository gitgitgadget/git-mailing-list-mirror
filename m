Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1305E1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 22:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbdKHWKs (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 17:10:48 -0500
Received: from siwi.pair.com ([209.68.5.199]:12471 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdKHWKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 17:10:46 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F21EC84575;
        Wed,  8 Nov 2017 17:10:45 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 817D884570;
        Wed,  8 Nov 2017 17:10:45 -0500 (EST)
Subject: Re: Test failures on 'pu' branch
To:     Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <cf38b57d-1424-0776-b67f-8cfd24e087bb@ramsayjones.plus.com>
 <CAGZ79kb3NpuWW=BpTjF_DrdVhXHh3d_8aF77Jdpi+8yTxtAbVw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f61cff3c-0d2e-4d6d-4db3-3b419246a760@jeffhostetler.com>
Date:   Wed, 8 Nov 2017 17:10:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb3NpuWW=BpTjF_DrdVhXHh3d_8aF77Jdpi+8yTxtAbVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/8/2017 3:36 PM, Stefan Beller wrote:
> On Wed, Nov 8, 2017 at 12:28 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> 
>> t5300-pack-object.sh                             (Wstat: 256 Tests: 40 Failed: 2)
> 
>> t5500-fetch-pack.sh                              (Wstat: 256 Tests: 355 Failed: 6)
> 
> These are series
> 
>> t5601-clone.sh                                   (Wstat: 256 Tests: 102 Failed: 4)
> 
> This one is a spurious test. I had that flake on me once in the last weeks, too.
> But upon investigation I could not reproduce.
> See https://public-inbox.org/git/xmqq376ipdpx.fsf@gitster.mtv.corp.google.com/
> 

I suspect that the failures related to the jh/partial-clone-* branches
are probably due to slight differences between yesterday's part-1 and
last week's version of part-2 and part-3.

I'm going to be on vacation until Monday, so can we just pull those
parts out of 'pu' until I can get you new versions of parts 2 and 3 ?

Thanks
Jeff
