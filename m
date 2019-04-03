Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369A720248
	for <e@80x24.org>; Wed,  3 Apr 2019 08:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDCIt4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 04:49:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:15739 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCIt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 04:49:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 813D03F40F4;
        Wed,  3 Apr 2019 04:49:55 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E2CC23F4088;
        Wed,  3 Apr 2019 04:49:54 -0400 (EDT)
Subject: Re: [PATCH v1 2/2] Documentation/git-status: fix titles in porcelain
 v2 section
To:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20190330183001.16624-1-tmz@pobox.com>
 <20190330183001.16624-3-tmz@pobox.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a8be0a1e-bb34-5709-0307-68b1fdd2d95c@jeffhostetler.com>
Date:   Wed, 3 Apr 2019 04:49:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190330183001.16624-3-tmz@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/30/2019 2:30 PM, Todd Zullinger wrote:
> Asciidoc uses either one-line or two-line syntax for document/section
> titles[1].  The two-line form is used in git-status.  Fix a few section
> titles in the porcelain v2 section which were inadvertently using
> markdown syntax.
> 
> [1] http://asciidoc.org/userguide.html#X17
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> 
> The '^### ' lines were added in 1cd828ddc8 ("git-status.txt: describe
> --porcelain=v2 format", 2016-08-11).  I'm _presuming_ they were made
> with markdown syntax in mind, but if not I can drop that bit from the
> commit message.  Jeff H, do you happen to recall?

Yes, I was probably had markdown on the brain that day.
Thanks
Jeff


