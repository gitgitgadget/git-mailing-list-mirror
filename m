Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40141FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 18:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965748AbcLVSsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 13:48:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:34147 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755587AbcLVSsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 13:48:37 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tl0sb1GK7z5tlP;
        Thu, 22 Dec 2016 19:48:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 185151B85;
        Thu, 22 Dec 2016 19:48:34 +0100 (CET)
Subject: Re: [PATCH 0/2] Really fix the isatty() problem on Windows
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
 <b0541907-ee79-207b-dc0f-1e3e7d761950@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ecc920bc-5323-a85c-c29f-9a3a7e4450e8@kdbg.org>
Date:   Thu, 22 Dec 2016 19:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <b0541907-ee79-207b-dc0f-1e3e7d761950@kdbg.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.2016 um 22:15 schrieb Johannes Sixt:
> Am 21.12.2016 um 18:53 schrieb Johannes Schindelin:
>> The current patch series is based on `pu`, as that already has the
>> winansi_get_osfhandle() fix. For ease of testing, I also have a branch
>> based on master which you can pull via
>>
>>     git pull https://github.com/dscho/git mingw-isatty-fixup-master
>
> Will test and report back tomorrow.

This version 1 of the series passes the test suite (next + a handful 
other topics) for me. It has also undergone a bit of field testing, and 
things look fine.

I haven't looked at the resulting code, yet, but I don't expect to find 
anything fishy.

-- Hannes

