Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0B920D0A
	for <e@80x24.org>; Mon, 17 Apr 2017 08:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbdDQIEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 04:04:01 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:32557 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932860AbdDQID6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 04:03:58 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w614D6FqZz5tlB;
        Mon, 17 Apr 2017 10:03:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7976942B6;
        Mon, 17 Apr 2017 10:03:56 +0200 (CEST)
Subject: Re: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     Junio C Hamano <gitster@pobox.com>
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
 <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
 <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
 <7a07a2a8-07a6-4342-80d0-7684e6242326@kdbg.org>
 <xmqqefwrk7ao.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
        <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2304c00a-ed87-7119-3753-95f61bcf28f6@kdbg.org>
Date:   Mon, 17 Apr 2017 10:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqefwrk7ao.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.04.2017 um 06:05 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> This is about command line completion. We go a long way to avoid
>> forking processes there. What is 10x faster on Linux despite of
>> forking a process may not be so on Windows.
>
> Doesn't this depend on how many paths there are?  If there are only
> a few paths, the loop in shell would beat a pipe into sed even on
> Linux, I suspect, and if there are tons of paths, at some number,
> loop in shell would become slower than a single spawning of sed on
> platforms with slower fork, no?

Absolutely. I just want to make sure a suggested change takes into 
account the situation on Windows, not only the "YESSSS!" and "VERY 
WELL!" votes of Linux users ;)

-- Hannes

