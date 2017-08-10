Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3881F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdHJXCz (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:02:55 -0400
Received: from avasout06.plus.net ([212.159.14.18]:50223 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbdHJXCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:02:54 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id vb2r1v00518PUFB01b2trV; Fri, 11 Aug 2017 00:02:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=vI_Ic911-OKdOk6Y-zYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
 <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
 <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
 <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <98b14604-33f1-6d91-8c9e-ddfa0c5cb0e7@ramsayjones.plus.com>
Date:   Fri, 11 Aug 2017 00:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/08/17 22:10, Jeff King wrote:
> On Thu, Aug 10, 2017 at 11:06:40PM +0200, Christian Couder wrote:
> 
>>>> Related to this, I wonder if people might want to "normalize" in
>>>> different ways later. If that happens, we might regret having called
>>>> this option "--normalize" instead of "--one-per-line" for example.
>>>
>>> What is normal?
>>>
>>> Maybe --style=[one-line, wrapped:72, rfc, json, xml, ...]
>>> then?
>>
>> Yeah, we could go there right now (using perhaps "--pretty" or
>> "--format" instead of "--style", so that we are more consistent with
>> other commands), but on the other hand we don't know yet if the other
>> formats will really be needed.
> 
> But some of those things are not 1:1 mappings with normalization.  For
> instance, --json presumably implies --only-trailers. Or are we proposing
> to break the whole commit message down into components and output it all
> as json?

Hmm, to me the operation wasn't so much a normalization, rather
it was an --unfold (or maybe --un-fold ;-D). I suppose going in
the other direction could be --fold=72, or some such.

[blue is my favourite colour ... :-P ]

ATB,
Ramsay Jones

