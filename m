Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAE31F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 11:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfHNLLN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 07:11:13 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51929 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNLLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 07:11:13 -0400
X-Originating-IP: 157.45.27.62
Received: from localhost (unknown [157.45.27.62])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EA73840009;
        Wed, 14 Aug 2019 11:11:10 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:41:08 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: How to reset selected lines?
Message-ID: <20190814111108.lymvzdwicpil53at@localhost.localdomain>
References: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
 <1f31dd2c-3023-2d13-3466-bffabab703cc@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f31dd2c-3023-2d13-3466-bffabab703cc@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/08/19 12:07AM, Johannes Sixt wrote:
> Am 13.08.19 um 16:18 schrieb Pratyush Yadav:
> > Now, I want to add a similar feature, but one that discards/resets the 
> > selected lines. And I'd like to avoid the hack that git-gui's 
> > apply_range_or_line is. So, is there a cleaner way to do this that does 
> > not involve generating a diff and then applying it?
> 
> Don't waste your time. I'm using this feature since years. It's
> available in these three commits:
> 
> https://github.com/j6t/git/commit/55276690b2bc6a
> https://github.com/j6t/git/commit/f12b294b68b595
> https://github.com/j6t/git/commit/00860615691604
> 
> Thanks go to Bert Wesarg. The patches are also available in this thread:
> 
> https://public-inbox.org/git/cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com/#t

Thanks for letting me know. I did try a similar change, before asking 
here, but git-apply complained about corrupt patches, so I thought more 
work had to be done. I'll look into the patches and see if I can work 
them into patches fit for merging.

-- 
Regards,
Pratyush Yadav
