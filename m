Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198ABC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F094560E9B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350797AbhIUDAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:31 -0400
Received: from mta-07-4.privateemail.com ([68.65.122.27]:23073 "EHLO
        MTA-07-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351454AbhIUCjq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:39:46 -0400
X-Greylist: delayed 7644 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 22:39:46 EDT
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id AA8051800206;
        Mon, 20 Sep 2021 22:38:17 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.209])
        by mta-07.privateemail.com (Postfix) with ESMTPA id EC60118000BF;
        Mon, 20 Sep 2021 22:38:16 -0400 (EDT)
Date:   Mon, 20 Sep 2021 22:38:10 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v6 2/2] pretty: colorize pattern matches in commit
 messages
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-Id: <MBJRZQ.9003XUH26Y7G2@effective-light.com>
In-Reply-To: <YUk3zwuse56v76ze@coredump.intra.peff.net>
References: <20210921003050.641393-1-someguy@effective-light.com>
        <20210921003050.641393-2-someguy@effective-light.com>
        <YUk0OEXg36QXrkDm@coredump.intra.peff.net>
        <YUk3zwuse56v76ze@coredump.intra.peff.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021 at 09:39:27 PM -0400, Jeff King <peff@peff.net> 
wrote:
> Here are two patches I prepared on top of your series to show what's
> possible, though I think we should do one of:
> 
>   - put them at the front of your series (with the appropriate
>     adjustments) as preparatory cleanup
> 
>   - keep them separate. You can put a comment above the cast to 
> mention
>     what's going on and why it's OK for now, and then later when 
> they're
>     both merged, we can remove that cast.

Option 1 is preferable from my perspective, in that case.


