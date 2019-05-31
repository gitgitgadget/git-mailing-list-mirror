Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094AD1F462
	for <e@80x24.org>; Fri, 31 May 2019 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEaTfb (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 15:35:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:21394 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfEaTfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 15:35:31 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0BBF03F404C;
        Fri, 31 May 2019 15:35:30 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CC2C03F4047;
        Fri, 31 May 2019 15:35:29 -0400 (EDT)
Subject: Re: [PATCH] list-objects-filter: correct usage of ALLOC_GROW
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com, jeffhost@microsoft.com,
        gitster@pobox.com, pclouds@gmail.com
References: <20190531184606.GA29730@comcast.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <de6e0e74-2388-8fef-c9c7-a7f65733c174@jeffhostetler.com>
Date:   Fri, 31 May 2019 15:35:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190531184606.GA29730@comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/31/2019 2:46 PM, Matthew DeVore wrote:
> In the sparse filter data, array_frame array is used in a way such that
> nr is the index of the last element. Fix this so that nr is actually the
> number of elements in the array.

I don't remember why I did it that way.
Thanks for fixing!

Jeff
