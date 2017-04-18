Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3609B1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757317AbdDRPCS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 11:02:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:40659 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757296AbdDRPCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 11:02:14 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8095A84531;
        Tue, 18 Apr 2017 11:02:12 -0400 (EDT)
Subject: Re: [PATCH] p0004: make perf test executable
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <20170418142407.20976-1-chriscool@tuxfamily.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8762531a-f490-a682-1411-52b703229394@jeffhostetler.com>
Date:   Tue, 18 Apr 2017 11:02:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170418142407.20976-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/18/2017 10:24 AM, Christian Couder wrote:
> It looks like in 89c3b0ad43 (name-hash: add perf test for lazy_init_name_hash,
> 2017-03-23) p0004 was not created with the execute unix rights.
> Let's fix that.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/perf/p0004-lazy-init-name-hash.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 t/perf/p0004-lazy-init-name-hash.sh
>
> diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
> old mode 100644
> new mode 100755
>


Thanks!
Jeff
