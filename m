Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A03C1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391329AbfHWTRO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 15:17:14 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:56226 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390909AbfHWTRO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 15:17:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46FWP33rSFz5tlC;
        Fri, 23 Aug 2019 21:17:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 85EF52B7;
        Fri, 23 Aug 2019 21:17:10 +0200 (CEST)
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190819214110.26461-3-me@yadavpratyush.com>
 <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
 <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
 <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
 <20190821214829.2dzat2quo3h2s3z2@localhost.localdomain>
 <nycvar.QRO.7.76.6.1908231500030.46@tvgsbejvaqbjf.bet>
 <xmqqk1b3n8vv.fsf@gitster-ct.c.googlers.com>
 <20190823170327.7msmc5khsstejkoh@localhost.localdomain>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7e0d99af-9f2f-d8d2-5d5b-1a00eab8e9d5@kdbg.org>
Date:   Fri, 23 Aug 2019 21:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823170327.7msmc5khsstejkoh@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.08.19 um 19:03 schrieb Pratyush Yadav:
> So how about we keep a copy of the diff in another variable. This allows 
> us to enable undoing of reverts. The obvious limitations are that 
> firstly, unless we use a stack/deque that means only one undo is 
> allowed. I'm not sure if using an undo stack would be worth the added 
> complexity. Secondly, if the working tree is changed between the revert 
> and the undo, there are chances of a merge conflict.
> 
> If people are okay with these limitations, we can be rid of the 
> confirmation dialog while providing a safety net. Sounds like a good 
> idea?

Yes, sounds like an idea worth persuing.

-- Hannes
