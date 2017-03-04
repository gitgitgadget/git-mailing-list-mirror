Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77212023D
	for <e@80x24.org>; Sat,  4 Mar 2017 15:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbdCDPHS (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 10:07:18 -0500
Received: from avasout01.plus.net ([84.93.230.227]:48377 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdCDPHR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 10:07:17 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id rr6y1u00322aPyA01r6zae; Sat, 04 Mar 2017 15:07:00 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=o0GVJlWGJlHDyHNiOxcA:9 a=QEXdDO2ut3YA:10 a=7rk4ZDrHWVEA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] http: inform about alternates-as-redirects behavior
To:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <25225b13-c8c0-b153-4ddd-499370716054@ramsayjones.plus.com>
Date:   Sat, 4 Mar 2017 15:06:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/03/17 03:13, Jeff King wrote:
> On Sat, Mar 04, 2017 at 01:35:04AM +0000, Eric Wong wrote:
[snip]
> 
> The warning itself:
> 
>> +		warning("alternate disabled by http.followRedirects!=true: %s",
> 
> feels like it could use some whitespace around the "!=", but maybe
> that's just me.

It's probably just me (too), but I think it would read better
without having '!=true' in the message at all. ;-)

ATB,
Ramsay Jones


