Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857FF202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdCOTuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 15:50:01 -0400
Received: from avasout04.plus.net ([212.159.14.19]:51805 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 15:50:00 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id wKow1u00622aPyA01KozhM; Wed, 15 Mar 2017 19:48:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=6sJgdx7PQk_OAjWGXdwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
To:     Junio C Hamano <gitster@pobox.com>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
 <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
 <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
 <1fce97df-7eb8-79d5-b96b-2086746bf19d@ramsayjones.plus.com>
 <20170314234659.wamzgpqu2aikghci@genre.crustytoothpaste.net>
 <dd285cb9-c7c7-e945-1fa2-7eb58d83ea06@ramsayjones.plus.com>
 <xmqqvarafs7j.fsf@gitster.mtv.corp.google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <512b2a2b-237b-1e73-5a85-1a19a796aa2b@ramsayjones.plus.com>
Date:   Wed, 15 Mar 2017 19:48:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvarafs7j.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/03/17 15:57, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 14/03/17 23:46, brian m. carlson wrote:
>>>>>
>>>>> Since the SHA1_HEADER include is not defined in such a case, developers
>>>>> see spurious errors when using these tools.  Furthermore, while using a
>>>>> macro as the argument to #include is permitted by C11, it isn't
>>>>> permitted by C89 and C99, and there are known implementations which
>>>>> reject it.
>>>>
>>
>>> Junio, do you want to amend the commit message before you merge it?
>>
>> Yes, please! ;-)
> 
> If only you were a few hours quicker.

Oops, sorry. When I wrote that I didn't know it was already in 'next'.

[I tend not to reply to emails as soon as I read them (because it
often gets me into trouble!), but wait until I've read everything
in my inbox. Unfortunately, I get so much email, it can be hours
later before I respond ... (I keep saying that I will unsubscribe
from some mailing lists ;-) ).]

> Let me see how bad the fallout is to revert the merge to 'next' and
> merge an amended version in.

Hmm, I didn't intend to add to your workload! Is it worth the hassle?
In the great scheme of things, it's not a major issue. I dunno.

> I _think_ the whole "Furthermore" sentence can go, since nobody
> complained since cef661fc ("Add support for alternate SHA1 library
> implementations.", 2005-04-21) started using the Makefile construct.

Yep.

[BTW, I haven't finished reading everything in my inbox yet, hopefully
I won't get into trouble. :P ]

ATB,
Ramsay Jones


