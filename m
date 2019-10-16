Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818BD1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfJPToi (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:44:38 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32777 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPToi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:44:38 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D9EA340003;
        Wed, 16 Oct 2019 19:44:35 +0000 (UTC)
Date:   Thu, 17 Oct 2019 01:14:31 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hariom18599@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH 1/1] builtin/blame.c: constants into bit shift format
Message-ID: <20191016194431.pax5kahg7d3zhlmo@yadavpratyush.com>
References: <20191016191012.ij3zbexu7pxupdho@yadavpratyush.com>
 <20191016193750.258148-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016193750.258148-1-jonathantanmy@google.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/19 12:37PM, Jonathan Tan wrote:
> > There was some discussion recently about converting these related 
> > #defines to enums [0]. We might consider doing that here.
> > 
> > If you read through that entire thread, you'd see that there were some 
> > disagreements about whether using enums for sets of bits is a good idea 
> > ([1] and [2]), but it is at least something worth considering while we 
> > are on this topic.
> > 
> > FWIW, I think it is a good idea to use an enum here.
> 
> [snip]
> 
> > [0] https://public-inbox.org/git/20191010115230.10623-1-wambui.karugax@gmail.com/
> > [1] https://public-inbox.org/git/20191014182754.82302-1-jonathantanmy@google.com/
> > [2] https://public-inbox.org/git/xmqqk19ag60g.fsf@gitster-ct.c.googlers.com/
> 
> Thanks for the handy references. You know my opinion on bitflags as
> enums from reading them, but I think that we have already had that
> discussion and came to a conclusion. So don't use an enum here.

Ah! I missed your last email in that thread that finally settled on 
avoiding bitsets, and thought the discussion was still ongoing. My bad 
:)
 
> The patch itself looks good, and I also prefer the bit shift format over
> octal.

-- 
Regards,
Pratyush Yadav
