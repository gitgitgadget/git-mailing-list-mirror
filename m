Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96322021E
	for <e@80x24.org>; Tue, 15 Nov 2016 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbcKOTqJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 14:46:09 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:63418 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbcKOTqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 14:46:07 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tJHv15tGTz5tlL;
        Tue, 15 Nov 2016 20:46:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AE4F613E;
        Tue, 15 Nov 2016 20:46:04 +0100 (CET)
Subject: Re: [PATCH 1/2] push: --dry-run updates submodules when
 --recurse-submodules=on-demand
To:     Brandon Williams <bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479172735-698-2-git-send-email-bmwill@google.com>
 <4a72ad14-0a8f-ede9-9f54-601fcd37740b@kdbg.org>
 <20161115172909.GA66382@google.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1aeed608-ee6e-0f10-2ce0-2f264d2f23e6@kdbg.org>
Date:   Tue, 15 Nov 2016 20:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161115172909.GA66382@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.11.2016 um 18:29 schrieb Brandon Williams:
> I'm assuming the reason we want to avoid sub-shells is
> for performance reasons right?

Yes, every fork() saved is a win on Windows. (No pun intended ;)

-- Hannes

