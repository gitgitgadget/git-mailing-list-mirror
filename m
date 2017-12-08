Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E051F20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 16:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbdLHQ21 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 11:28:27 -0500
Received: from avasout04.plus.net ([212.159.14.19]:33537 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753530AbdLHQ20 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2017 11:28:26 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id NLVfefQMHzbmWNLVgePOEv; Fri, 08 Dec 2017 16:28:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=YzJCTmcHEbofR-zbNRgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
References: <20171208002447.20261-1-sbeller@google.com>
 <20171208002447.20261-2-sbeller@google.com>
 <20171208093434.GD26199@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <643e1afd-43e2-7fcc-452b-8b9ceac6868c@ramsayjones.plus.com>
Date:   Fri, 8 Dec 2017 16:28:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171208093434.GD26199@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ02mq2QjQv47Sp3rLBhNGGCJobjfvTTLQ1SqXB/sQaW0ifGEbaTEf0qj0ufdSiVyT+qLv4EEGu7ci2qd5/u3+pQA92j2a+yBRaGJLRsCvFiJNTIkyfP
 l3g4T7GIvFfhhN4091qUeYNgTG3F5Jw4A/cAwSg+FQBR8mo3jYB0jyMtk6x9+QoNo9ri67+eEI6VYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/12/17 09:34, Jeff King wrote:
> On Thu, Dec 07, 2017 at 04:24:47PM -0800, Stefan Beller wrote:
[snip]
>> Junio hinted at a different approach of solving this problem, which this
>> patch implements. Teach the diff machinery another flag for restricting
>> the information to what is shown. For example:
>>
>>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
>>   b2feb64309 Revert the whole "ask curl-config" topic for now
>>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
>>
>> we observe that the Makefile as shipped with 2.0 was introduced in
>> v1.9.2-471-g47fbfded53 and replaced in v2.0.0-rc1-5-gb2feb64309 by
>> a different blob.

Sorry, this has nothing to do with this specific thread. :(

However, the above caught my eye. Commit b2feb64309 does not 'replace
the Makefile with a different blob'. That commit was a 'last minute'
revert of a topic _prior_ to v2.0.0, which resulted in the _same_
blob as commit 47fbfded53. (i.e. a53f3a8326c2e62dc79bae7169d64137ac3dab20).

[I haven't been following this topic, so just ignore me if I have
misunderstood what the above was describing! :-D ]

ATB,
Ramsay Jones

