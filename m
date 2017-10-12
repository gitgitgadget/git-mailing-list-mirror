Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A3620372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbdJLUax (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:30:53 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:42893 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753209AbdJLUaw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:30:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3yCjCB50Wjz5tl9;
        Thu, 12 Oct 2017 22:30:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AAA82274;
        Thu, 12 Oct 2017 22:30:13 +0200 (CEST)
Subject: Re: [PATCH v1 1/1] completion: add remaining flags to checkout
From:   Johannes Sixt <j6t@kdbg.org>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
 <5bc82075-0fb2-0929-2da7-d9069222a3fe@kdbg.org>
Message-ID: <d1bbd196-ad9f-cb22-a363-43b113a354ce@kdbg.org>
Date:   Thu, 12 Oct 2017 22:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5bc82075-0fb2-0929-2da7-d9069222a3fe@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.2017 um 18:50 schrieb Johannes Sixt:
> Am 12.10.2017 um 14:20 schrieb Thomas Braun:
>> +            --force --ignore-skip-worktree-bits --ignore-other-worktrees
> 
> Destructive and dangerous options are typically not offered by command 
> completion. You should omit all three in the line above, IMO.

Ah, no, only --force and --ignore-other-worktrees are dangerous, 
--ignore-skip-worktree-bits is not.

-- Hannes
