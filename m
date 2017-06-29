Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D669202B3
	for <e@80x24.org>; Thu, 29 Jun 2017 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbdF2NZK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 09:25:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:48734 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbdF2NZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 09:25:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8FD3C845A6;
        Thu, 29 Jun 2017 09:25:08 -0400 (EDT)
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5C6B98459B;
        Thu, 29 Jun 2017 09:25:08 -0400 (EDT)
Subject: Re: [PATCH 2/2] hashmap: migrate documentation from
 Documentation/technical into header
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
References: <20170629011334.11173-1-sbeller@google.com>
 <20170629011334.11173-3-sbeller@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0749bca3-a2b7-7314-b9fb-2217390b919e@jeffhostetler.com>
Date:   Thu, 29 Jun 2017 09:25:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170629011334.11173-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/28/2017 9:13 PM, Stefan Beller wrote:
> While at it, clarify the use of `key`, `keydata`, `entry_or_key` as well
> as documenting the new data pointer for the compare function.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   Documentation/technical/api-hashmap.txt | 309 --------------------------------
>   hashmap.h                               | 249 +++++++++++++++++++++++--
>   2 files changed, 231 insertions(+), 327 deletions(-)
>   delete mode 100644 Documentation/technical/api-hashmap.txt
 > ...

This looks very nice. Thank you!

Jeff
