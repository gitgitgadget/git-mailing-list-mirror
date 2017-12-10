Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1ED61F407
	for <e@80x24.org>; Sun, 10 Dec 2017 19:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdLJT6V (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 14:58:21 -0500
Received: from avasout04.plus.net ([212.159.14.19]:50250 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751994AbdLJT6U (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2017 14:58:20 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id O7juemJPnzbmWO7jveQW5D; Sun, 10 Dec 2017 19:58:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=PM_bwM5RYzhMJqn7-0wA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t9001 failures on 32-bit Linux?
Message-ID: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com>
Date:   Sun, 10 Dec 2017 19:58:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDmwJG0qbZ/KGE4+a8RbBe+AHL7ZikK3madoJUvth7fNWWKnqefIDBYppKTkmRMHAH/8h4KvXG2/vsTIQuU1no2GNSUqXK4+avSMpZItnLdvlGDwtRXn
 +4tLMKQ6agHCgqNurOyFrRgTxVyNzDYxSQBax23v/hiUkttY71pgOS2yS7ojzMJIauW5bhFp5H/AMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I noticed the revert of the 'ab/simplify-perl-makefile' branch on
top of 'pu'. So, I fired up my 32-bit Linux and attempted to see
if I could debug this t9001 test failure.

Unfortunately, I could not get it to fail. :(

Both of the 'pu' (@77e921d77d) and 'pu~1' (@cfef1ebefd) builds pass
the full test-suite and, likewise, running t9001 in a loop for a
count of 100 (about 45 minutes run-time each).

[If it makes any difference, I don't have sendmail installed (no
/usr/sbin/sendmail or /usr/lib/sendmail), or any sendmail in my
$PATH.]

Sorry I couldn't help with this! :(

ATB,
Ramsay Jones



