Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F041F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 21:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965430AbcJQVsN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 17:48:13 -0400
Received: from avasout03.plus.net ([84.93.230.244]:41391 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934797AbcJQVsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 17:48:11 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id wlo71t0050zhorE01lo8eR; Mon, 17 Oct 2016 22:48:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=X05Hh6uh7_33tZ-9OgIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Junio C Hamano <gitster@pobox.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
 <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610171058580.197091@virtualbox>
 <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net>
 <16298e68-c0f9-b7ff-d4b5-0d4b79306377@ramsayjones.plus.com>
 <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8bb9272b-d74e-c2e8-42ce-49d155f1884b@ramsayjones.plus.com>
Date:   Mon, 17 Oct 2016 22:48:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/10/16 21:07, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Heh, I actually have the following in my config.mak already:
>>
>> extra-clean: clean
>> 	find . -iname '*.o' -exec rm {} \;
>>
>> But for some reason I _always_ type 'make clean' and then, to top
>> it off, I _always_ type the 'find' command by hand (I have no idea
>> why) :-D
> 
> "git clean -x" anybody?

I don't use 'git clean' because, on the very few occasions that I have
tried to use it, it always deletes _far_ more than I thought it would
or should. (particularly config.mak). Hmm, "git clean -X -- '*.o'"
_might_ do what I want, but 'find' is so much easier ... :-D

ATB,
Ramsay Jones

