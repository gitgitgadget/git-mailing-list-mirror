Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F641F406
	for <e@80x24.org>; Sun, 24 Dec 2017 11:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbdLXLvP (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 06:51:15 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:12572 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752157AbdLXLvO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 06:51:14 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3z4LDc5Cmhz5tlH;
        Sun, 24 Dec 2017 12:51:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 40DEA41E2;
        Sun, 24 Dec 2017 12:51:12 +0100 (CET)
Subject: Re: [PATCH 6/6] wildmatch test: create & test files on disk in
 addition to in-memory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>
References: <20171223213012.1962-1-avarab@gmail.com>
 <20171223213012.1962-7-avarab@gmail.com>
 <8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org>
 <874logs7vi.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9191ea80-2faf-b0d1-35c8-6e28e7b8324e@kdbg.org>
Date:   Sun, 24 Dec 2017 12:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <874logs7vi.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.2017 um 12:06 schrieb Ævar Arnfjörð Bjarmason:
> On Sun, Dec 24 2017, Johannes Sixt jotted:
>> Am 23.12.2017 um 22:30 schrieb Ævar Arnfjörð Bjarmason:
>>> +				printf '%s' '$text' >expect &&
>>
>> There are no single-quotes in any $text instances, right?
> 
> There's not, but maybe we should be more careful here and use here-docs.

Unless it is essential to test the single-quote case, we need not 
complicate the code. I just wanted to rise awareness. If a problematic 
test case is introduced, it will be noticed soon enough. It's not that 
we deal with unknown input here.

-- Hannes
