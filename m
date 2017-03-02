Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C002023D
	for <e@80x24.org>; Thu,  2 Mar 2017 06:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbdCBGKS (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 01:10:18 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:53465 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbdCBGKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 01:10:17 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.108])
        by bsmtp2.bon.at (Postfix) with ESMTPS id 3vYhhB3klZz5txH
        for <git@vger.kernel.org>; Thu,  2 Mar 2017 07:08:26 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3vYhfz5fRlz5tlC;
        Thu,  2 Mar 2017 07:07:23 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 29B07F0;
        Thu,  2 Mar 2017 07:07:23 +0100 (CET)
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Junio C Hamano <gitster@pobox.com>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702101647340.3496@virtualbox>
 <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
 <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
 <xmqqmvdbz23d.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa38e22e-3114-fab8-38ed-5f52125e81bb@kdbg.org>
Date:   Thu, 2 Mar 2017 07:07:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvdbz23d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.2017 um 22:54 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> I'll use the patch for daily work for a while to see whether it hurts.
>
> Please ping this thread again when you have something to add.  For
> now, I'll demote this patch from 'next' to 'pu' when we rewind and
> rebuild 'next' post 2.12 release.

As I already said in [1], I have no objection. I've used the patch in 
production for some time now and did not notice any slowdowns.

[1] 
https://public-inbox.org/git/0080edd6-a515-2fe9-6266-b6f6bbedfdde@kdbg.org/

-- Hannes

