Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5485203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbcLLUxR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:53:17 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:45573 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbcLLUxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:53:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tcw6218BHz5tlK;
        Mon, 12 Dec 2016 21:53:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E32B71D19;
        Mon, 12 Dec 2016 21:53:11 +0100 (CET)
Subject: Re: [PATCH 2/2] tmp-objdir: quote paths we add to alternates
To:     Jeff King <peff@peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d83cd58f-9b52-cbc5-04dd-5aafe2822533@kdbg.org>
Date:   Mon, 12 Dec 2016 21:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.12.2016 um 20:53 schrieb Jeff King:
> Johannes, please let me know if I am wrong about skipping the test on
> !MINGW.

Thanks for being considerate. The !MINGW prerequisite is required for 
the test as written.

> The appropriate check there would be ";" anyway, but I am not
> sure _that_ is allowed in paths, either.

That was also my line of thought. I tested earlier today whether a file 
name can have ";", and the OS did not reject it bluntly. Let me see 
whether I can adjust the test case for Windows.

-- Hannes

