Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C2F1FF6D
	for <e@80x24.org>; Fri,  2 Dec 2016 01:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759975AbcLBBWI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 20:22:08 -0500
Received: from avasout06.plus.net ([212.159.14.18]:49470 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759959AbcLBBWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 20:22:07 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id EpMd1u0040srQBz01pMfm8; Fri, 02 Dec 2016 01:21:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=Exur_P-SfUclBfndDSUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
To:     Jeff King <peff@peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
 <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
 <20161201225331.GH54082@google.com>
 <2297C36B9A1441748D7E68363A05F8C5@PhilipOakley>
 <xmqq8trz6wrq.fsf@gitster.mtv.corp.google.com>
 <7cd35131-2e0c-0dff-8864-c099e313251d@ramsayjones.plus.com>
 <20161202001852.arasy44d6iczeeez@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jann Horn <jannh@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <777dfad5-02e2-73a9-fc38-1e6575c100aa@ramsayjones.plus.com>
Date:   Fri, 2 Dec 2016 01:21:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161202001852.arasy44d6iczeeez@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/12/16 00:18, Jeff King wrote:
> On Fri, Dec 02, 2016 at 12:07:50AM +0000, Ramsay Jones wrote:
> 
>>>> In a British context "Mallory and Irvine" were two (male) climbers who
>>>> died on Everest in 1924 (tales of daring...), so it's easy to expect
>>>> (from this side of the pond) that 'Mallory' would be male. However he
>>>> was really George Mallory.
>>>>
>>>> Meanwhile that search engine's images shows far more female Mallorys,
>>>> so I've learnt something.
>>>
>>> "baby name Mallory" in search engine gave me several sites, most of
>>> them telling me that is a girl's name except for one.
>>>
>>> Didn't think of doing image search, but that's a good way ;-)
>>
>> Heh, I didn't think about any of this. I was remembering the
>> description of 'Man-in-the-middle Attack' from Applied Cryptography
>> (Bruce Schneier) which implies that Mallory is male.
> 
> I admit that I always assumed Applied Cryptography (and other papers)
> were always talking about a female. But that's probably because I
> started with an assumption about the name in the first place. That
> probably came from watching the Family Ties sitcom as a kid; the older
> daughter is named Mallory (and if you google it, you can see some
> amazing 80's haircuts and clothes).
> 
> We can call her Marsha if you want, instead evoking Brady Bunch memories
> of 60's clothing and haircuts.

I'm not sure it matters too much, but if you are going to
change the name then Eve is also used in the description
of Man-in-the-middle (see "Practical Cryptography", Ferguson
and Schneier).

ATB,
Ramsay Jones


