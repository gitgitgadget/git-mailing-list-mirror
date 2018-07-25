Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1CF1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 12:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeGYNmM (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 09:42:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:23426 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeGYNmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 09:42:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3CA763F4085;
        Wed, 25 Jul 2018 08:30:43 -0400 (EDT)
Received: from [192.168.1.6] (43.sub-174-231-167.myvzw.com [174.231.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 04A933F4046;
        Wed, 25 Jul 2018 08:30:41 -0400 (EDT)
Subject: Re: [PATCH v1] msvc: fix non-standard escape sequence in source
To:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, larsxschneider@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180724144249.2857-1-git@jeffhostetler.com>
 <e443fe24-e072-d11c-a6b0-53e7de8a7f5c@drbeat.li>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9559a485-1977-d7e8-1bfb-ab2b65b60c02@jeffhostetler.com>
Date:   Wed, 25 Jul 2018 08:30:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e443fe24-e072-d11c-a6b0-53e7de8a7f5c@drbeat.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/24/2018 2:13 PM, Beat Bolli wrote:
> Hi Jeff
> 
> On 24.07.18 16:42, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Replace non-standard "\e" escape sequence with "\x1B".
> 
> This was already fixed in <20180708144342.11922-4-dev+git@drbeat.li>.
> 
> Cheers,
> Beat
> 

Thanks for the pointer.  I see that commit is in 'next'.
I was only looking in 'master'.

Thanks,
Jeff

