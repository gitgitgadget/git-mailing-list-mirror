Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CBB11F404
	for <e@80x24.org>; Wed,  7 Feb 2018 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeBGQkA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 11:40:00 -0500
Received: from siwi.pair.com ([209.68.5.199]:18822 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754421AbeBGQj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 11:39:59 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 843E03F4121;
        Wed,  7 Feb 2018 11:39:58 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5978C3F411E;
        Wed,  7 Feb 2018 11:39:58 -0500 (EST)
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository
 object
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180205235508.216277-1-sbeller@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1ba0cc21-aeb3-eeaf-4e1d-c8e1eeca0763@jeffhostetler.com>
Date:   Wed, 7 Feb 2018 11:39:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/5/2018 6:51 PM, Stefan Beller wrote:
> This series moves a lot of global state into the repository struct.
> It applies on top of 2512f15446149235156528dafbe75930c712b29e (2.16.0)
> It can be found at https://github.com/stefanbeller/git/tree/object-store
> 
> Motivation for this series:
> * Easier to reason about code when all state is stored in one place,
>    for example for multithreading
> * Easier to move to processing submodules in-process instead of
>    calling a processes for the submodule handling.
>    The last patch demonstrates this.
[...]

Very nice.  My eyes glazed over a few times, but I like the
direction you're heading here.

Thanks for tackling this!
Jeff


