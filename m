Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359F91F461
	for <e@80x24.org>; Thu, 16 May 2019 19:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfEPTVA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 15:21:00 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:15473 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEPTVA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 15:21:00 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 454h9621ZYz5tl9;
        Thu, 16 May 2019 21:20:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6872620BA;
        Thu, 16 May 2019 21:20:57 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "LI, BO XUAN" <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        philipoakley@iee.org
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190511041331.51642-1-liboxuan@connect.hku.hk>
 <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
 <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
 <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org>
 <xmqqlfz64uzw.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <262eb1d4-a898-c6d0-8e04-ce6c58eaa4e6@kdbg.org>
Date:   Thu, 16 May 2019 21:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqlfz64uzw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.05.19 um 11:19 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> In Matlab, is %%% followed by space at the beginning of a line
>> *commonly* used for something different? If I were to make a guess, I
>> would say no. If I'm right, it does not hurt to merge the Octave rules
>> into the Matlab rules.
> 
> That is true because we are not syntax-aware and error-highlighting
> text editor.  If we were, I'd suspect that your stance may probably
> be different.  But instead we apply these patterns to a program that
> is assumed to be correctly written.

Correct!

> And from that point of view, I agree with you that it would not hurt
> to make the existing patterns for Matlab slightly more receptive so
> that a correctly written programs in either language would be matched
> appropriately.
> 
> But would it hurt to have two similar entries, with a clear
> description on how they are different, in our code there, given how
> infrequently individual entries have historically been updated?

Would it hurt? Probably not. Should we open the door for everybody's
favorite dialect? Probably not, either.

See, we do not even have separate entries for C and C++. Heck, we don't
have an XML entry, because the HTML entry is good enough, and there are
probably many more XML users than Matlab and Octave users together.

I'd prefer to keep this list at the minimum necessary as long as it is
hard-coded in C. I would take a different stance if this were some
configuration file that we ship.

-- Hannes
