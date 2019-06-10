Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778351F462
	for <e@80x24.org>; Mon, 10 Jun 2019 09:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbfFJJGt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 05:06:49 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:19780 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbfFJJGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 05:06:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45MnLw39cKz5tlL
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 11:06:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1CF76450
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 11:06:48 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: git-send-email Warning: unable to close filehandle properly: Bad file
 descriptor during global destruction.
Message-ID: <33086711-946f-9036-bbac-174620cda3b9@kdbg.org>
Date:   Mon, 10 Jun 2019 11:06:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just used git-send-email the first time since ages. When it finished,
I saw a stream of 16 warnings:

Warning: unable to close filehandle properly: Bad file descriptor during
global destruction.

The invocation was this:

   git send-email --to git@vger.kernel.org patches

where the argument 'patches' is a directory with 4 patches.

The patches were sent quite fine, as it seems. I can help debug if
someone is interested.

-- Hannes
