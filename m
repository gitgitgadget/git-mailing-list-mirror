Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EAE1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932713AbdBPR4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:56:03 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:26769 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933345AbdBPRzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:55:45 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vPP2k3HRSz5tlr;
        Thu, 16 Feb 2017 18:55:42 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5D5F01D16;
        Thu, 16 Feb 2017 18:55:41 +0100 (CET)
Subject: Re: [PATCH] mingw: make stderr unbuffered again
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
 <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702141545380.3496@virtualbox>
 <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
 <alpine.DEB.2.20.1702151312330.3496@virtualbox>
 <0275af7b-eb7a-1094-a891-674300175e56@kdbg.org>
 <alpine.DEB.2.20.1702161753050.3496@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d1c65a34-3809-ee76-5e00-69ba715e0093@kdbg.org>
Date:   Thu, 16 Feb 2017 18:55:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702161753050.3496@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.02.2017 um 18:10 schrieb Johannes Schindelin:
> On Wed, 15 Feb 2017, Johannes Sixt wrote:
>> I do not see how dup2() causes a change in stdio state. I
>> must be missing something (and that may be a basic misunderstanding of how
>> stdio is initialized).
>
> It appears that dup2()ing fd 2 resets that stdio state.

OK, thanks. It's surprising, but so be it.

Thank you for the quick fix!

-- Hannes

