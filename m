Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD5D1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeIJVum (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:50:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:10327 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbeIJVum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:50:42 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 109163F4012;
        Mon, 10 Sep 2018 12:55:43 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CFE0E3F4000;
        Mon, 10 Sep 2018 12:55:42 -0400 (EDT)
Subject: Re: [PATCH 2/2] mingw: fix mingw_open_append to work with named pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <pull.35.git.gitgitgadget@gmail.com>
 <f433937d55974b75750cfc7d579a6a56109259a4.1536344387.git.gitgitgadget@gmail.com>
 <1c524f56-2021-a961-168f-e5c6d7914ec2@kdbg.org>
 <f207bc28-a303-5d63-e9f4-da8e4d466bd5@kdbg.org>
 <0d38ec8e-3f4b-c0fb-ba6f-e2cef39e4db4@jeffhostetler.com>
 <xmqq5zzduwwe.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d415b6c9-9ce6-a7bb-a5db-53b11ce2cccb@jeffhostetler.com>
Date:   Mon, 10 Sep 2018 12:55:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zzduwwe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/10/2018 12:42 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> Yeah, this whole thing is a little under-documented for my tastes.
>> Let's leave it as you have it.  I'll re-roll with a fix to route
>> named pipes to the existing _wopen() code.
> 
> OK, I have these two patches in 'next', but let's postpone it for
> now.  Windows port will be built with extra topics over what we have
> a the release anyway, so your improved version may become part of
> that and then can come back to benefit us in the next cycle ;-)
> 
> Thanks.
> 

That's fine.  This can easily wait until after 2.19.0.

Thanks
Jeff
