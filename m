Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C2B1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbeBATkK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 14:40:10 -0500
Received: from siwi.pair.com ([209.68.5.199]:13169 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754593AbeBATkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 14:40:09 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2D38A844EB;
        Thu,  1 Feb 2018 14:40:09 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 75EB4844E7;
        Thu,  1 Feb 2018 14:40:08 -0500 (EST)
Subject: Re: [PATCH v2 00/27] protocol version 2
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <02c14b43-34b0-44c7-725c-1d0c1ead28e5@jeffhostetler.com>
Date:   Thu, 1 Feb 2018 14:40:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/25/2018 6:58 PM, Brandon Williams wrote:
> Changes in v2:
>   * Added documentation for fetch
>   * changes #defines for state variables to be enums
>   * couple code changes to pkt-line functions and documentation
>   * Added unit tests for the git-serve binary as well as for ls-refs
[...]


This looks really nice.  I'm eager to get this in so we can do some
additional commands to help make partial clone more efficient.

Thanks,
Jeff

