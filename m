Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B43B20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 22:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeLJWII (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 17:08:08 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:13322 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeLJWII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 17:08:08 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43DHJQ61SCz5tlC;
        Mon, 10 Dec 2018 23:08:06 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 83E4A20B4;
        Mon, 10 Dec 2018 23:08:06 +0100 (CET)
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands
 automatically
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.90.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d2c317fd-d10a-19c1-8b4f-a7311c69a52f@kdbg.org>
Date:   Mon, 10 Dec 2018 23:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <pull.90.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.12.18 um 20:04 schrieb Johannes Schindelin via GitGitGadget:
> The idea was brought up by Paul Morelle.
> 
> To be honest, this idea of rescheduling a failed exec makes so much sense
> that I wish we had done this from the get-go.

The status quo was actually not that bad a decision, because it made 'x 
false' as a substitute for 'break' very convenient.

But now that we have a real 'break', I'm very much in favor of flipping 
the behavior over to rescheduling. (I'm actually not a user of the 
feature, but the proposed behavior is so compellingly logical.)

-- Hannes
