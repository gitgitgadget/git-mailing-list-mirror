Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A051FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbcLEWnQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:43:16 -0500
Received: from avasout06.plus.net ([212.159.14.18]:57017 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbcLEWnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:43:14 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id GNiy1u0030srQBz01NizMc; Mon, 05 Dec 2016 22:42:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ZhwETxuJmUYw_JJCz-MA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
To:     Junio C Hamano <gitster@pobox.com>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
 <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
 <ab1e7ce9-1022-0c72-2f72-63e3b9182bc9@ramsayjones.plus.com>
 <xmqq7f7e5jsy.fsf@gitster.mtv.corp.google.com>
 <e74163ee-e7d4-bcbd-e65f-368bc2ee9a2d@ramsayjones.plus.com>
 <xmqqr35m2eva.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <cbb39f75-dc3b-6bc7-9c60-9ce4e7d225f7@ramsayjones.plus.com>
Date:   Mon, 5 Dec 2016 22:42:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqr35m2eva.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/12/16 22:24, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> As I said, the original version of the patch just removed the
>> --abbrev=7, but then I started to think about why you might have
>> used --abbrev in the first place (first in commit 9b88fcef7 and
>> again in commit bf505158d). Making sure to override the configuration
>> was the only thing I could come up with. So, I was hoping you could
>> remember why! :-P
> 
> Nope.  As a maintainer support script, the only thing I cared about
> it is that there is no -gXXXX at the end for anything I release ;-)
> 
>> (I assumed it was to force a measure of uniformity/reproducibility).
> 
> You cannot force uniformity/reproducibility with fixed abbrev,
> unless you set abbreviation length to 40, so you are correct to add
> "a measure of" there ;-)

Indeed. ;-)

>                            The first choice (i.e. 4) may have had a
> justification to force absolute minimum, and the second one (i.e. 7)
> may have had a justifiation to make it clear that we are using the
> same setting as the default, so in post-1.7.10 era, I think it is
> fine for us to just say "we have been using the same as default, so
> let's not specify anything explicitly".

So, you would be happy with just removing the '--abbrev' argument?

(That's fine by me; I don't set core.abbrev!)

ATB,
Ramsay Jones

