Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF2E20209
	for <e@80x24.org>; Sat,  1 Jul 2017 13:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdGANAt (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 09:00:49 -0400
Received: from mout.web.de ([212.227.15.3]:52735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdGANAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 09:00:48 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5bEe-1dgaqM3Nu4-00xY3T; Sat, 01
 Jul 2017 15:00:22 +0200
Subject: Re: [PATCH v6 2/2] strbuf: change an always NULL/"" strbuf_addftime()
 param to bool
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170701125507.27214-1-avarab@gmail.com>
 <20170701125507.27214-2-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <10b2f9ba-89d1-851d-bf3c-bf70abebc8a7@web.de>
Date:   Sat, 1 Jul 2017 15:00:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170701125507.27214-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ev2hraCxQ4+xoJazn96g5TL+0rZYazdjxQdX2BVcnL7i7N6IfU/
 Dl3YMDXcvWnC52N4eLZ1KE6h7vjlORqBmmQIGOVkluEJXyeD3jFERu0YuK7RNefbqgTXM8q
 svWp4UttsPqtdLjuBFWcMOjBHgB937T46uiBMaSE0zyQqkKrUawirC6O54NTcBjXvqn1po5
 B+Ea5ISie0e/0FIQBHoSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4PzRRqth3rs=:Kk4WHwUJINGjacP1Hlr77U
 Kma1JANTTyUaAzUFtp9dj/w8SYtKJRnPbbdaQOIRs50pCoIsiEYF3XmKTnycB4LWqb7one3uy
 9gdWzVel5U1ze+agBx1Qx0dFLZql1/WcLDWX7mVJYUX+Dc4AH7YWZMx6v/gUq0b6LMYQzzIdo
 a7UnzRWbQCZjxhZOiECljlOM5kZC+ddOuwMJf3lQK0sBezLojBL5RyotcOd+BY1zoIOdDn1nv
 Sedy0IAKnx7jMRgjiIWoPMKK1V5UUVCxuB8l8R8hsWgl6RwWOYMU+/iqLaLC+6n2RN98HvjTS
 5hy0eFtpakTZnATx29fHPIUB4a2eIgW5sNo14w01j7aCt/ICA2iaMjI7FQ12kKU15a/OsL5wT
 RI8r3QxDNBvbMHxnfN97ZOMYnZ65k38TcubGYRGM3s9YShiqWGckQYj7yUEMIbX5asEcg+Imd
 aeowXxm7gp3av3NQ//d2NR4OVxsTVXlUR2Iw2IOtWze7vTJuKniBCyEVOMWod9pvzacaeP/Mb
 bNYDyhj8eOkDYF+7pX9pnt5NZteKMqSQ9oyFWIUqBtX7mtt0agYoqrfZ4KvO10ekc3c4jou81
 KNmwFD5o/1JehfGRvBzKqcajmnF8Rd2FUGPe24RA2Hq78MtgTmnMhNsAmao0aAb9JNGUQlSzj
 ozipkfIZyYrMWkK1c0xwdnLjZvmGDzlnGfBt/nWd1wFpKNk1+dnDjZeTR1WRQO+UWWQGe15SX
 JJoS21h1dKqxMrpByddJ7HeihPMsN+pqfVJnc6cKEHRKMxs0tb08/i67viXdbU0g8XIq0KgIJ
 pMAc40E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.07.2017 um 14:55 schrieb Ævar Arnfjörð Bjarmason:
> strbuf_addstr() allows callers to pass a time zone name for expanding
   ^^^^^^^^^^^^^^^
That should be "strbuf_addftime()" instead (my typo), as Junio noted.

> %Z. The only current caller either passes the empty string or NULL, in
> which case %Z is handed over verbatim to strftime(3).  Replace that
> string parameter with a flag controlling whether to remove %Z from the
> format specification. This simplifies the code.
> 
> Commit-message-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Sat, Jun 24 2017, Junio C. Hamano jotted:
>> René Scharfe <l.s.r@web.de> writes:
>>> Here's an attempt at a commit message that would have be easier to
>>> understand for me:
>>>
>>>    strbuf_addstr() allows callers to pass a time zone name for expanding
>>>    %Z.  The only current caller either passes the empty string or NULL,
>>>    in which case %Z is handed over verbatim to strftime(3).  Replace that
>>>    string parameter with a flag controlling whether to remove %Z from the
>>>    format specification.  This simplifies the code.
>>
>> I think the first one is strbuf_addftime(); other than that, I think
>> this version explains what is going on in this patch than the
>> original.

René
