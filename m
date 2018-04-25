Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8AA1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756308AbeDYTaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 15:30:09 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:32201 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756282AbeDYTaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 15:30:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40WVdp1tj5z5tlH;
        Wed, 25 Apr 2018 21:30:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9091B10B;
        Wed, 25 Apr 2018 21:30:05 +0200 (CEST)
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
 <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
 <nycvar.QRO.7.76.6.1804250938370.4978@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2411e97e-bda2-869e-956e-12871761c4cc@kdbg.org>
Date:   Wed, 25 Apr 2018 21:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804250938370.4978@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2018 um 09:41 schrieb Johannes Schindelin:
> Hi Hannes,
> 
> On Wed, 25 Apr 2018, Johannes Sixt wrote:
> 
>> Am 25.04.2018 um 02:05 schrieb Junio C Hamano:
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>> It is not uncommon to request that the output remains visible in
>>>> the terminal.
> 
> I ran `git log` and then hit `q`, and the latest screen contents were
> still visible in all of these scenarios:
> 
> - in a Linux VM via SSH client
> 
> - in Git Bash on Windows
> 
> - in Git CMD on Windows
> 
> Granted, this is only the latest screen, but that is usually good enough
> here.
> 
> Is anything different happening in your setups?

I have LESS=RS in my environment, because I do want that the alternate 
screen is used by the pager. Nevertheless, occasionally I want git's 
output to remain visible.

-- Hannes
