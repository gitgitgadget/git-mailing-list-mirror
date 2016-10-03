Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E11207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbcJCWAQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:00:16 -0400
Received: from mout.web.de ([212.227.15.14]:50340 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbcJCWAO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:00:14 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M9GYQ-1blAiy2WBK-00Cf1z; Tue, 04 Oct 2016 00:00:10
 +0200
Subject: Re: [PATCH 1/3] add QSORT
To:     Kevin Bracey <kevin@bracey.fi>,
        GIT Mailing-list <git@vger.kernel.org>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
 <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
 <83398160-555f-adab-6b1e-3283c533b5ff@web.de> <57F290DC.5080303@bracey.fi>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9ff725eb-3536-638b-1ec0-ff9130478abc@web.de>
Date:   Tue, 4 Oct 2016 00:00:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <57F290DC.5080303@bracey.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hTZJkLEm8QXM7FUxKGHi4gfqHvqBNm1mfCj/E6+gkVOv84dU+E7
 DIh1VdlGm9yKb2BooLcymD/TrJ3wiPWEuRoIRxG5XCD2c0/dIOkAbYveyHe25cHNCnRESCG
 +LuPCnLQzgdczwCR4Axd3nCTmnVXxnN3cLTUYgsq66jDp7y2ZmXJFxE9m150LIeE9XjjvQf
 dmCW+o7eTCTMtQQJ7G6mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oGsVXSJPIYs=:OLLJHqy7qldEQGKotU8Hd7
 fSz8+ojTVJ8874FtpF9w4VnqfHQdWjiRTIUkxZIaABykiWQvIhZZr7FRCq4o82YSfXZ/HPH4W
 2Q7/1LlPlocLkxvPkKzyw7nYUngxQu235tOVmkmFOitPkVdKZy/6/M8b61DT0J1eWcKt0eI6V
 4QV9yteTODUHzaWzDFX3vzWuUQFmoxOYmIlQsoA9GLh9Iw3SsLTn3NXCzCcHcVRW1f9NnsogO
 3fBtdqr1Rv2VaO3I0yCRiCjyJc7lr8UxX5N8DBJS9tmEaNOMq12zgoyN4ChTXJUWDPIKWuGCP
 UFZZLrlOZYFijJpx4AKe1823Uj4r6TEPMv+bX9TPm/W5lmww/uRjMqdhsxf9Ab/Fk0RfH/78V
 s1qI3b8xbG+MlqfX+zRHaF4IPKbEzD1nqq0KH/PiGnY/PffGsmAn37d9Dc/J2luNz0wkZxKJo
 nHZX+42w1rEvq7h+Tg+xnUKriVN8M0vhZFJPf6Np+k/X8TMLsX19n/58cn92I7+fupsQpLZfg
 97/0LEKqgHtDA2Ucy5ewDBfsRv8aS767kfyqBXLyJ5319P0TL25FRWooOmMo1139yRv9rqVap
 ZUn5tTxK1ZTY/XMSSwdQTsv+oOKa1wUAIWgFQDYjexHRFtHTUsKgyeROpkaheewoR0vGTiNHw
 xOCM3mffNyS0o76XVmWCmnnYb9rkmMEXT0xl0oGteWr/oFz2UpFG2HsQpi7+89rUGS2jLStyo
 0yXKJFibdsQOqVkfofBWTJrbidQ0USbCjErFy5k7whgVG5Ssul5shBGKtplvKv/7yRQNg/0Ye
 4OLrYia
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2016 um 19:09 schrieb Kevin Bracey:
> As such, NULL checks can still be elided even with your change. If you
> effectively change your example to:
>
>     if (nmemb > 1)
>         qsort(array, nmemb, size, cmp);
>     if (!array)
>         printf("array is NULL\n");
>
> array may only be checked for NULL if nmemb <= 1. You can see GCC doing
> that in the compiler explorer - it effectively turns that into "else
> if".

We don't support array == NULL together with nmemb > 1, so a segfault is 
to be expected in such cases, and thus NULL checks can be removed safely.

> To make that check really work, you have to do:
>
>     if (array)
>         qsort(array, nmemb, size, cmp);
>     else
>         printf("array is NULL\n");
>
> So maybe your "sane_qsort" should be checking array, not nmemb.

It would be safe, but arguably too much so, because non-empty arrays 
with NULL wouldn't segfault anymore, and thus become harder to identify 
as the programming errors they are.

The intention is to support NULL pointers only for empty arrays (in 
addition to valid pointers).  That we also support NULL pointers for 
arrays with a single member might be considered to be the result of a 
premature optimization, but it should be safe -- the compiler won't 
remove checks unexpectedly.

Does that make sense (it's getting late here, so my logic might already 
be resting..)?

René
