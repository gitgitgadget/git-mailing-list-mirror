Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87161F4C0
	for <e@80x24.org>; Tue,  5 Nov 2019 15:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbfKEPKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:10:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:54291 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfKEPKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:10:10 -0500
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 10:10:10 EST
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 154D93F4119;
        Tue,  5 Nov 2019 10:00:11 -0500 (EST)
Received: from [10.141.23.144] (rrcs-70-62-112-196.midsouth.biz.rr.com [70.62.112.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D3F4D3F4139;
        Tue,  5 Nov 2019 10:00:10 -0500 (EST)
Subject: Re: [PATCH] trace2: add dots directly to strbuf in perf_fmt_prepare()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <c4237b45-6faf-c1fc-eb13-b6c71b7fb6ef@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0fae18b6-dd98-f7df-d2a9-cfdc34916686@jeffhostetler.com>
Date:   Tue, 5 Nov 2019 10:00:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <c4237b45-6faf-c1fc-eb13-b6c71b7fb6ef@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/4/2019 2:27 PM, René Scharfe wrote:
> The initialization function of the Trace2 performance format target sets
> aside a stash of dots for indenting output.  Get rid of it and use
> strbuf_addchars() to provide dots on demand instead.  This shortens the
> code, gets rid of a small heap allocation and is a bit more efficient.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>

Looks good!
Thanks for simplifying my otherwise convoluted code.
Jeff

