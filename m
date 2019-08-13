Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86A31F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 22:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfHMWH3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 18:07:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:30987 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfHMWH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 18:07:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 467Rf66M72z5tlB;
        Wed, 14 Aug 2019 00:07:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6F3DB143;
        Wed, 14 Aug 2019 00:07:26 +0200 (CEST)
Subject: Re: How to reset selected lines?
To:     Pratyush Yadav <me@yadavpratyush.com>
References: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <1f31dd2c-3023-2d13-3466-bffabab703cc@kdbg.org>
Date:   Wed, 14 Aug 2019 00:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.19 um 16:18 schrieb Pratyush Yadav:
> Now, I want to add a similar feature, but one that discards/resets the 
> selected lines. And I'd like to avoid the hack that git-gui's 
> apply_range_or_line is. So, is there a cleaner way to do this that does 
> not involve generating a diff and then applying it?

Don't waste your time. I'm using this feature since years. It's
available in these three commits:

https://github.com/j6t/git/commit/55276690b2bc6a
https://github.com/j6t/git/commit/f12b294b68b595
https://github.com/j6t/git/commit/00860615691604

Thanks go to Bert Wesarg. The patches are also available in this thread:

https://public-inbox.org/git/cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com/#t

-- Hannes
