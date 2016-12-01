Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE0C1FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 07:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbcLAHJV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 02:09:21 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:56786 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750856AbcLAHJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 02:09:19 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tTpLN6HTCz5tlF;
        Thu,  1 Dec 2016 08:09:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3208D1A28;
        Thu,  1 Dec 2016 08:09:16 +0100 (CET)
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
To:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com> <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa54bb08-4206-ebd5-6808-f7de6cf4b9a2@kdbg.org>
Date:   Thu, 1 Dec 2016 08:09:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2016 um 00:40 schrieb Jeff King:
> 20813 access("su:b/../.git/modules/su:b/refs", X_OK) = 0

Side note: where does this weirdness "su:b" come from? (I haven't looked 
at any of the patches, yet, let alone tested.) Colons in file or 
directory names won't work on Windows (in the way one would expect).

-- Hannes

