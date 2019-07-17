Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D4E1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfGQRXU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 13:23:20 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:24368 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfGQRXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 13:23:19 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45pkcj1SlDz5tlJ;
        Wed, 17 Jul 2019 19:23:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D3BA61E78;
        Wed, 17 Jul 2019 19:23:16 +0200 (CEST)
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
 <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
 <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
 <20190714005129.GA4525@sigill.intra.peff.net>
 <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
 <20190715144602.GA26636@sigill.intra.peff.net>
 <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
 <20190715181527.GA30747@sigill.intra.peff.net>
 <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a6af2961-3f09-5d8a-b92b-c50e6877ec81@kdbg.org>
Date:   Wed, 17 Jul 2019 19:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.19 um 21:01 schrieb Junio C Hamano:
> but as long as we declare that we take "{ 0 }" as a mere convention
> [...], I am perfectly fine with it, and if it is hidden
> behind a macro, that would be even better ;-)

And I thought that "Avoid macros!" would be a welcome guideline...

I think we enter subjective territory. Let's stop here.

-- Hannes
