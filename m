Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5772B203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936515AbcKKUzB (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:55:01 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:58696 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756014AbcKKUzA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:55:00 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFscL2mWsz5tlC;
        Fri, 11 Nov 2016 21:54:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F28E3145;
        Fri, 11 Nov 2016 21:54:57 +0100 (CET)
Subject: Re: [PATCH v2] t6026: ensure that long-running script really is
To:     Junio C Hamano <gitster@pobox.com>
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
 <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
 <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
 <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
 <6a421222-a138-5647-4965-8ede24d904b2@kdbg.org>
 <xmqq60nt3fqc.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Andreas Schwab <schwab@suse.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ba2b3f08-87b1-c954-2020-e5a4bece7f83@kdbg.org>
Date:   Fri, 11 Nov 2016 21:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq60nt3fqc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2016 um 21:48 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Good point. Here is an updated version.
>
> Unfortunately, I already took the version before this one and
> started my integration cycle today.  I'll wiggle this in; it
> essentially is about adding a big comment to explain what is going
> on and then moving the when-finished down below it, right?

Correct.

Thank you very much!
-- Hannes

