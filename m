Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7DD208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdH1U4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:56:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:42375 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbdH1U4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:56:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 863058457D;
        Mon, 28 Aug 2017 16:56:51 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 238228457C;
        Mon, 28 Aug 2017 16:56:51 -0400 (EDT)
Subject: Re: [PATCH v2 0/4] Some ThreadSanitizer-results
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <cover.1503323390.git.martin.agren@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <35ca4125-baed-c54b-7478-7531066daa0a@jeffhostetler.com>
Date:   Mon, 28 Aug 2017 16:56:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cover.1503323390.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/21/2017 1:43 PM, Martin Ågren wrote:
> This is the second version of my series to try to address some issues
> ... 
> 2) hashmap_add, which I could try my hands on if Jeff doesn't beat me to
> it -- his proposed change should fix it and I doubt I could come up with
> anything "better", considering he knows the code.

Now that I'm back from vacation, let me take another stab at this.

Jeff

