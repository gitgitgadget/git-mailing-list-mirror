Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4F320467
	for <e@80x24.org>; Wed, 11 Oct 2017 22:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdJKWZi (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 18:25:38 -0400
Received: from avasout08.plus.net ([212.159.14.20]:38486 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdJKWZg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 18:25:36 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id LNRa1w0030M91Ur01NRbpx; Wed, 11 Oct 2017 23:25:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=VSiMYLrKmzgEjHXern4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: v2.15.0-rc1 test failure
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
Message-ID: <edfe891b-1aa1-0b20-6af7-8b8bc47d69c9@ramsayjones.plus.com>
Date:   Wed, 11 Oct 2017 23:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8dd12465-0dc2-340e-8db0-e37719f34efc@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/10/17 23:15, Ramsay Jones wrote:
> Hi Adam,
> 
> I had a test failure on the v2.15.0-rc1 build tonight.
> The test in question being t0021-conversion.sh #15
> ('required process filter should filter data'). I didn't
> have any test failures on v2.15.0-rc0, and I don't see
> any change that would have affected this test.
> 
> Also, I ran this test by hand (well, in a shell loop) at
> least 70 times tonight (after the test-suite run), without
> any failures, so ... (unfortunately, I don't have a trash
> directory to look at. :( )
> 
> I have just kicked off another full test-suite run.
> 
> Just a heads up! ;-)

Oops, for mailing list reader, I should have made clear that
this failure is only on cygwin. :-D

ATB,
Ramsay Jones


