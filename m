Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B1C1FC45
	for <e@80x24.org>; Sat, 11 Feb 2017 08:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbdBKIBb (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 03:01:31 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:59694 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753483AbdBKIBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 03:01:30 -0500
Received: from bsmtp4.bon.at (unknown [192.168.181.107])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3vL45N2lqjz5v3F
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 09:01:28 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3vL45K59l7z5tlJ;
        Sat, 11 Feb 2017 09:01:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D28B12217;
        Sat, 11 Feb 2017 09:01:23 +0100 (CET)
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Junio C Hamano <gitster@pobox.com>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <xmqqbmublyo0.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org>
Date:   Sat, 11 Feb 2017 09:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmublyo0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.2017 um 00:41 schrieb Junio C Hamano:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Use OpenSSL's SHA-1 routines rather than builtin block-sha1 routines.
>> This improves performance on SHA1 operations on Intel processors.
>> ...
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>
> Nice.  Will queue as jh/mingw-openssl-sha1 topic; it is a bit too
> late for today's integration cycle to be merged to 'next', but let's
> have this by the end of the week in 'master'.

Please don't rush this through. I didn't have a chance to cross-check 
the patch; it will have to wait for Monday. I would like to address 
Peff's concerns about additional runtime dependencies.

-- Hannes

