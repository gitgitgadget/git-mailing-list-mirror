Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9162022C
	for <e@80x24.org>; Tue,  8 Nov 2016 06:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbcKHGZ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 01:25:56 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:28050 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbcKHGZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 01:25:56 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tCfSS2k8Zz5tlC;
        Tue,  8 Nov 2016 07:25:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 920AD14C;
        Tue,  8 Nov 2016 07:25:27 +0100 (CET)
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
 <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <65a1bb6d-e924-21aa-70d3-303ebdc499f1@kdbg.org>
Date:   Tue, 8 Nov 2016 07:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.2016 um 01:40 schrieb Jeff King:
> In addition to J6t's fix in t0021, ...

Just to get things straight: Of my two patches, this one ("uniq -c 
variations")

https://public-inbox.org/git/c842e0a7-b032-e0c4-0995-f11d93c17c0a@kdbg.org/

is a bug fix in my environment, and I have a suspicion that it is also 
required in other less frequently tested environments (Solaris? BSD 
variants?)

The other one, which you most likely remember as dealing with "leading 
whitespace in wc -c"

https://public-inbox.org/git/b87ddffd-3de1-4481-b484-9f03a73b6ad1@kdbg.org/

is "only" an optimization. The link points at the final version.

-- Hannes

