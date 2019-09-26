Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE6C1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 15:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfIZPYD (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 11:24:03 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50227 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfIZPYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 11:24:03 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iDVcf-0002dH-4L; Thu, 26 Sep 2019 16:24:01 +0100
Subject: Re: sizeof(var) vs sizeof(type), was Re: [PATCH] git: use COPY_ARRAY
 and MOVE_ARRAY in handle_alias()
To:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
 <20190923222659.GA22645@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1909261521380.15067@tvgsbejvaqbjf.bet>
 <b79f52f7-4a7e-f7cd-ed8a-cb6cfbadd7b2@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7bbcf6fa-e36d-4a1e-86e1-437e9e92dab7@iee.email>
Date:   Thu, 26 Sep 2019 16:24:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b79f52f7-4a7e-f7cd-ed8a-cb6cfbadd7b2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/2019 14:36, Derrick Stolee wrote:
>>> Another good reason to use "sizeof(var)" instead of sizeof(type)". :)
>> That is indeed a very good reason, in addition to getting the type right
>> automatically (by virtue of letting the compiler pick it).
>>
>> Should we make this an explicit guideline in our documentation?
> Better yet: can we create a Coccinelle script to fix it automatically?
>
> -Stolee
>
How about 'Both'. We can't assume all contributors have Coccinelle on 
their OS/system.

Philip
