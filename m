Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2331F207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 17:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938897AbdD1RFT (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 13:05:19 -0400
Received: from mout.web.de ([217.72.192.78]:54175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755333AbdD1RFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 13:05:18 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MduMb-1dT5nE0G8j-00Pdyt; Fri, 28
 Apr 2017 19:04:53 +0200
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <070a4b85-98e0-12a4-6c9c-557f3dfa733c@web.de>
Date:   Fri, 28 Apr 2017 19:04:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:arclMJrEGzm5cXHBfnP4mwuzOC0dfq+Shr7EjwlhcFgFs/JuigW
 20wKdG2PGhKY2f09iQkumowzCN71Hcl9wKv6v2sEudUAs8+E1fk1vBlZNLCO0dsK8KB7MIm
 B50eU3YBggxagqSACIbwe8pCC6+GQa6vHvcQe1Eo0eTeW121h+FiZsc5erlcQrjPU+gmJKf
 nAbYgYl/Un3znDy3sBdQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RorVnqz+DJo=:wg/oQW+3gf2ycVU66MIUnY
 Lr3QASA5lQkN7XHsuwjhrznTZy90Vfg11Xw0w4T7Nd01/TUvI45KMUC/nvCx1rceHL0m4X0Ei
 myehJyKN4IAc5VfEnuUXgEJqLcos6gbyL0Fxl0Jnqt8iGJ2KZzsvRYxBUfpySSDXKeVS7Wv/X
 RorjJygj6LFj+N8AshwBPPqpPPKbESxoxTQJT0fMjsiG+Kh6h+rTqxcWjyf/DOpVHkxWSL3+h
 YjMk54GHZsxZZ/YC1s3wJawaIwgYvWsuzKkM0hINx8og2c6KYselj4PgrpGLr3r7F/bQ7TQQ1
 epljk2KWF4yzDZ/ZMlSWjSP8mLiI5E5MaHqL4cD16QJPnKKkmmHSOlKmOM4eOAKK48jambpmr
 /JZ1XTp7GXxmNcEz1YNeEy6+YbBTN1b5B9mCW58OHACLKQTPXNurcqpJDbql6iYg4uQy2uQ6r
 Y+v8tgC8UF3dJnSAkWSWVMi1PggLc/2Eo8RUgEFGnhiUmfQqwMJIFcOfZDKSmgl9VOpsE8jGW
 /1rLIUtMUcl4BlWd+ObjMkccedZ/sJ+JcOscXi1FNHoq9vFfUJe5Sg7V3+3M7pICr8xRU5QEu
 KE3xCYGI3vEqg5IudRGk5TckYiOMLZy0MMK7nMVRPK/MxhZcLfsbqJp4fE5b6WDWP+Qd7C8xW
 nZqv6IekogvD9PI6REnX3+dNNTTWEEhaeCMN4ORoQUGBDSaGXhneXXDb6r7ZCPkajIx1fUDtt
 rWLu5COgokRxtvydC1QQx0DdhRIUBhIupt2x7xVPci1aDXD9FroaQ5JCarQ/j3+fJFZcVG166
 rxZzf3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 13:29 schrieb Jeff King:
> On Sat, Jan 28, 2017 at 10:38:21PM +0100, René Scharfe wrote:
> 
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 87237b092b..66cd466eea 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -527,6 +527,16 @@ static inline int ends_with(const char *str, const char *suffix)
>>   	return strip_suffix(str, suffix, &len);
>>   }
>>   
>> +#define SWAP(a, b) do {						\
>> +	void *_swap_a_ptr = &(a);				\
>> +	void *_swap_b_ptr = &(b);				\
>> +	unsigned char _swap_buffer[sizeof(a)];			\
>> +	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
>> +	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
>> +	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
>> +	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
>> +} while (0)
> 
> What should:
> 
>    SWAP(foo[i], foo[j]);
> 
> do when i == j? With this code, it ends up calling
> 
>    memcpy(&foo[i], &foo[j], ...);
> 
> which can cause valgrind to complain about overlapping memory. I suspect
> in practice that noop copies are better off than partial overlaps, but I
> think it does still violate the standard.
> 
> Is it worth comparing the pointers and bailing early?

Hmm, so swapping a value with itself can be a useful thing to do?
Otherwise an assert would be more appropriate.

Swapping with *partial* overlap sounds tricky, or even evil.  If
we want to support that for some reason we'd have to use memmove
in the middle.  But that would still corrupt at least one of the
objects, wouldn't it?

> A related question is whether the caller should ever be asking to swap
> something with itself. This particular case[1] comes from
> prio_queue_reverse(). I suspect its "<=" could become a "<", but I
> haven't thought it through carefully.

The line in question is this one:

	for (i = 0; i <= (j = (queue->nr - 1) - i); i++)

Assignment in the middle?  Hmm.  Why not do it like this?

	for (i = 0, j = queue->nr - 1; i < j; i++, j--)

Looks less complicated to me.

René
