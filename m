Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D839A1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeFZVA1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:00:27 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:25189 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeFZVA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:00:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41FdjP2Dr9z5tlG;
        Tue, 26 Jun 2018 23:00:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EE5EE1CBC;
        Tue, 26 Jun 2018 23:00:24 +0200 (CEST)
Subject: Re: [PATCH 17/29] t: use test_must_fail() instead of checking exit
 code manually
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-18-sunshine@sunshineco.com>
 <CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com>
 <CAPig+cRTG625H3CF1Zw30vQt2W8uKf1xLxVaQni2YbJ=xAif2g@mail.gmail.com>
 <29d090a2-bbe4-0d87-6dda-037ae675d4a3@kdbg.org>
 <CAPig+cRnbW9fRh68ZorNQHjDFHQBWmqfEPSO+H7qgMJVOcbJmQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <07314f8f-e242-b9b9-fd20-7e1ef8df8e47@kdbg.org>
Date:   Tue, 26 Jun 2018 23:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRnbW9fRh68ZorNQHjDFHQBWmqfEPSO+H7qgMJVOcbJmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.06.2018 um 20:14 schrieb Eric Sunshine:
> On Tue, Jun 26, 2018 at 2:06 PM Johannes Sixt <j6t@kdbg.org> wrote:
>> Hence, these lines should actually be
>>
>>                  p4 help client &&
>>                  ! p4 help nosuchcommand
> 
> Thanks for the comment; you're right, of course. I'll certainly make
> this change if I have to re-roll for some other reason, but do you
> feel that this itself is worth a re-roll?

Not worth a re-roll IMO.

-- Hannes
