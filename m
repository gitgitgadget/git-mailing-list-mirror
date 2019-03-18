Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6713220248
	for <e@80x24.org>; Mon, 18 Mar 2019 12:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCRMfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 08:35:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:50846 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfCRMfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 08:35:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 12BD23F4023;
        Mon, 18 Mar 2019 08:35:35 -0400 (EDT)
Received: from [IPv6:2600:1700:840:e760:8c2:e809:e774:3a6d] (unknown [IPv6:2600:1700:840:e760:8c2:e809:e774:3a6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DC5743F400D;
        Mon, 18 Mar 2019 08:35:34 -0400 (EDT)
Subject: Re: [PATCH v1 1/1] trace2: NULL is not allowed for va_list
To:     tboegi@web.de, git@vger.kernel.org, jeffhost@microsoft.com
References: <20190316104715.27138-1-tboegi@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <30c8b265-d6bf-3265-b2ae-029aa60d63e5@jeffhostetler.com>
Date:   Mon, 18 Mar 2019 08:35:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190316104715.27138-1-tboegi@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/16/2019 6:47 AM, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
> 
> Some compilers don't allow NULL to be passed for a va_list.
> Use va_list instead.
> 
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>

Thanks for the fixup.

For future reference, can you elaborate on which compiler
and/or platform has the problem ?

Jeff
