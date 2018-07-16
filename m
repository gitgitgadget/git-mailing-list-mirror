Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B101F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeGPN5W (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:57:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:15116 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbeGPN5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:57:21 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 272FC3F4098;
        Mon, 16 Jul 2018 09:29:54 -0400 (EDT)
Received: from [192.168.1.6] (41.sub-174-231-128.myvzw.com [174.231.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E08923F4095;
        Mon, 16 Jul 2018 09:29:52 -0400 (EDT)
Subject: Re: [PATCH v1 00/25] RFC: structured logging
To:     David Lang <david@lang.hm>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <alpine.DEB.2.02.1807131150350.20559@nftneq.ynat.uz>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a8f87adf-3f39-29b9-aef6-9c2e398f117a@jeffhostetler.com>
Date:   Mon, 16 Jul 2018 09:29:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1807131150350.20559@nftneq.ynat.uz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/2018 2:51 PM, David Lang wrote:
> Please make an option for git to write these logs to syslog, not just a 
> local file. Every modern syslog daemon has lots of tools to be able to 
> deal with json messages well.
> 
> David Lang

That is certainly possible and we can easily add it in a later draft,
but for now I'd like to stay platform-neutral and just log events to a
file.

My main goal right now is to get consensus on the basic structured 
logging framework -- the shape of the SLOG API, the event message
format, and etc.

Thanks,
Jeff
