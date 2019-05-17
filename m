Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449641F461
	for <e@80x24.org>; Fri, 17 May 2019 19:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEQTrt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:47:49 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:5119 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfEQTrt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:47:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 455JjZ3Dgzz5tlB;
        Fri, 17 May 2019 21:47:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DD9E720BA;
        Fri, 17 May 2019 21:47:44 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
To:     "LI, BO XUAN" <liboxuan@connect.hku.hk>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        philipoakley@iee.org
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190511041331.51642-1-liboxuan@connect.hku.hk>
 <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
 <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
 <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org>
 <xmqqlfz64uzw.fsf@gitster-ct.c.googlers.com>
 <262eb1d4-a898-c6d0-8e04-ce6c58eaa4e6@kdbg.org>
 <xmqq8sv63rfc.fsf@gitster-ct.c.googlers.com>
 <CALM0=-=2PBLm6+pQxUq5L2=8hEUh3nFFheFN=HhN5CUGj6Kfeg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <cb16942d-3e2e-d5b0-4eb8-25937cd9d573@kdbg.org>
Date:   Fri, 17 May 2019 21:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALM0=-=2PBLm6+pQxUq5L2=8hEUh3nFFheFN=HhN5CUGj6Kfeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.19 um 14:19 schrieb LI, BO XUAN:
> On Fri, May 17, 2019 at 7:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> I'd prefer to keep this list at the minimum necessary as long as it is
>>> hard-coded in C.
>>
>> Yeah, I know that feeling.
> 
> So do we reach a consensus? Should I merge the Octave rules into Matlab rules?

Yes, please, that would be very much appreciated. Bonus points if you
add some test cases for the hunk header patterns to the t/t4018 directory.

-- Hannes
