Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B531F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 19:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfJFThR (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 15:37:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:10026 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfJFThR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 15:37:17 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iHCLD-0006Qs-6V; Sun, 06 Oct 2019 20:37:15 +0100
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Harish Karumuthil <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com>
 <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
 <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <293e0738-85dd-14eb-20b9-a837aa88c0cc@iee.email>
Date:   Sun, 6 Oct 2019 20:37:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/2019 19:39, Pratyush Yadav wrote:
>> That way, you don't have to introduce settings separate from
>> `git-cola`'s, and you can reuse the short-and-sweet variable name.
> I think a more important question is whether we_really_  need to have
> compatibility with git-cola. Most of our shortcuts don't match with
> them, so is it really worth the effort to try to keep compatibility?
>
> I'm not against something like this, but just want to be sure we
> evaluate whether the effort is worth it.
I just wondered if the custom list would/could be split between a 
"Common-shortcuts" list, and "GUI-local" list (and hence, elsewhere, a 
"Cola-local" list)

I don't use Cola at all, so this is just a bikeshed comment...
-- 
Philip
