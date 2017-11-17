Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21046202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 20:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760713AbdKQUWs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 15:22:48 -0500
Received: from avasout04.plus.net ([212.159.14.19]:46063 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932517AbdKQUWZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2017 15:22:25 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id Fn9ZeaQzezbmWFn9aeAFdw; Fri, 17 Nov 2017 20:22:23 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=7ljj9gndDECPSUgsQLUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 07/10] introduce fetch-object: fetch one promisor
 object
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
References: <20171116181257.61673-1-git@jeffhostetler.com>
 <20171116181257.61673-8-git@jeffhostetler.com>
 <e7b5e42f-b13c-50c8-501c-0100d8c48d00@ramsayjones.plus.com>
 <798096fe-dd01-5351-94d3-949039c84e69@jeffhostetler.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a414c170-3eba-e5b9-6235-c6785129097e@ramsayjones.plus.com>
Date:   Fri, 17 Nov 2017 20:22:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <798096fe-dd01-5351-94d3-949039c84e69@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMFUlvMz3g4I9IJdXS+D8t9TsB6YUQcUPbF8pPA7QhZLowyzdbt/37kmmOvGmkQN1urvzhwhYmlzQQsDj5FLGRKGqv/4yy26HZQHnhYjHq7DY9sIafTV
 Sf7y3+u84cGa+XyPw3ODIbSnRpdHwrEZHdzLADNqqqUOeCRzeNd34gWKAilBZAqo7OgRcSAOj5uXbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/11/17 19:49, Jeff Hostetler wrote:
> 
> 
> On 11/16/2017 2:57 PM, Ramsay Jones wrote:
>>
>>
>> On 16/11/17 18:12, Jeff Hostetler wrote:
>>> From: Jonathan Tan <jonathantanmy@google.com>
>>>
>>> Introduce fetch-object, providing the ability to fetch one object from a
>>> promisor remote.
> [snip]
>>> +#include "transport.h"
>>
>> I note that this still does not #include "fetch_object.h".
>> [If you recall, this suppresses a sparse warning].
>>
> 
> Sorry, I missed that.  I know I did a DEVELOPER=1 build and
> I didn't see a warning, but I'll check again.

Unless you have sparse installed and 'make sparse' as part of
your build, you won't see anything. ;-)

However, ignore sparse for the moment, if you don't #include
the header (interface) file in fetch-object.c, you can't
expect the compiler to tell you when there is a mismatch
between the interface and implementation.

There are some additional sparse warnings associated with
these series, ... (hopefully I can find some time tonight)

ATB,
Ramsay Jones


