Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4967C1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeABTe1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 14:34:27 -0500
Received: from avasout03.plus.net ([84.93.230.244]:43010 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeABTe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 14:34:26 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id WSKMe6Z9kCEdVWSKNeOd5r; Tue, 02 Jan 2018 19:34:25 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Nc2W7yL4 c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=SGrWqMT5xfb6k5-0B0AA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Test failure for v2.16.0-rc0 on cygwin
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
 <20171230144019.GB29210@dinwoodie.org> <20180102113649.GC29210@dinwoodie.org>
 <3616d866-9a53-6e32-0a62-488342ae214f@ramsayjones.plus.com>
Message-ID: <e69657de-9455-2b97-09d7-2bd58ce513f6@ramsayjones.plus.com>
Date:   Tue, 2 Jan 2018 19:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <3616d866-9a53-6e32-0a62-488342ae214f@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBAEPDI55xjiwt4xulRW36H5gyIeUsSe47X2Mnmu+ghh/Be3oEPPPJxk5KHYm/3KvELQvmqYm0FcPy0XFl6NJZJS0YojLbIN5sG24imtrmy0Y/jTgxEf
 eDWot9MwikqyoUDZelxureXmOC6uCsT45ToYZRWuyvRPSv5dJ9yI050GXgc/yZRGIDe4f1A32quwig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/01/18 15:32, Ramsay Jones wrote:
> On 02/01/18 11:36, Adam Dinwoodie wrote:
>> On Saturday 30 December 2017 at 02:40 pm +0000, Adam Dinwoodie wrote:
>>> On Saturday 30 December 2017 at 02:21 pm +0000, Ramsay Jones wrote:
[snip]
>> I'm not able to reproduce this: t5580 is passing on both my Windows 10
>> test systems on v2.16.0-rc0.
[snip]
> I just tried running the test again by hand, and I can't get it to fail!
> 
> Hmm, I have just set off a complete test-suite run, so I won't be able
> to report on that for a while ... ;-)

Yep, as expected, the test-suite passes no problem now! ;-)

> I have an idea: when running the failing tests the other day, I was
> remotely logged in via ssh (I have cygwin sshd running on my win10
> box), but today I was logged in directly. The sshd daemon is run by
> a privileged user, so maybe that could be related ... dunno.

Also, when logged-in remotely it fails consistently, when logged-in
directly it passes consistently. :-D

ATB,
Ramsay Jones


