Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2AF1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfA3M31 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:29:27 -0500
Received: from siwi.pair.com ([209.68.5.199]:22655 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3M31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:29:27 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3A0E73F404F;
        Wed, 30 Jan 2019 07:29:26 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F12833F4051;
        Wed, 30 Jan 2019 07:29:25 -0500 (EST)
Subject: Re: [PATCH] trace2: fix hdr-check warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ba0549c5-25f1-efcc-e49a-d7e76be73fe3@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <00e08dc3-a610-0429-e819-1d29d0ddb81a@jeffhostetler.com>
Date:   Wed, 30 Jan 2019 07:29:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ba0549c5-25f1-efcc-e49a-d7e76be73fe3@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/26/2019 4:07 PM, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Jeff,
> 
> If you need to re-roll your 'jh/trace2' branch, could you please
> squash this into the relevant patches (sorry, I didn't look to
> see which patches need to be modified).

Will do. Thanks.

BTW, how do you find these?  I ran both "make sparse" and
"make DEVELOPER=1" and it didn't complain about these items.

Jeff

