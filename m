Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937E720281
	for <e@80x24.org>; Sat, 16 Sep 2017 04:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdIPEGj (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 00:06:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64412 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbdIPEGi (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Sep 2017 00:06:38 -0400
X-AuditID: 1207440e-bf9ff70000007085-7e-59bca34d97d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 94.49.28805.D43ACB95; Sat, 16 Sep 2017 00:06:37 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC9BD.dip0.t-ipconnect.de [87.188.201.189])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8G46YmU022095
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 16 Sep 2017 00:06:36 -0400
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
Date:   Sat, 16 Sep 2017 06:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170915184323.GU27425@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1PVdvCfS4FqztEXXlW4mi4beK8wW
        b28uYbT43/aOzYHFY+esu+weFy8pe3zeJBfAHMVlk5Kak1mWWqRvl8CV8fFyJ1vBQbGKV9te
        MjYwHhXsYuTkkBAwkbh18wNzFyMXh5DADiaJ03fWskA4F5gkbnxZxAJSJSwQLHH+1xEwW0RA
        Q+L5p29sIDazQJrEjQ3rGSEa+hkl3hzvZwRJsAnoSizqaWYCsXkF7CV6n00FWsHBwSKgKnFn
        lxJIWFQgQqLv7WV2iBJBiZMzn4DN5wQqP/thIgvEfHWJP/MuMUPY4hK3nsxngrDlJba/ncM8
        gVFgFpL2WUhaZiFpmYWkZQEjyypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2M
        kODm28HYvl7mEKMAB6MSD2/D5d2RQqyJZcWVuYcYJTmYlER5rfz2RArxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4WWZA5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw
        ai4CahQsSk1PrUjLzClBSDNxcIIM5wEaPnMhyPDigsTc4sx0iPwpRkUpcV4nkGYBkERGaR5c
        Lyz5vGIUB3pFmLcVpIoHmLjgul8BDWYCGnzm9A6QwSWJCCmpBsYpySe/+0s+XmxTPi/c7fj7
        o6H/6zdrHfmsafIwXPrK/2lGR7Q2fL7Lv7nJdt1m77kpvA0s+kuecBitt9Ytc2JbtjPU7EPG
        3bIlCRX/pc9t3vRk55O9ttxyp/RNf1378ES6wFF7s92DA6ufPWPffGuSWtIMzeeHg//rtYmd
        Sjv8Sy5Na1vSQ8dOJZbijERDLeai4kQAgQoCdxkDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/15/2017 08:43 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> If you pass a newly-initialized or newly-cleared `string_list` to
>> `for_each_string_list_item()`, then the latter does
>>
>>     for (
>>             item = (list)->items; /* note, this is NULL */
>>             item < (list)->items + (list)->nr; /* note: NULL + 0 */
>>             ++item)
>>
>> Even though this probably works almost everywhere, it is undefined
>> behavior, and it could plausibly cause highly-optimizing compilers to
>> misbehave.
> 
> Wait, NULL + 0 is undefined behavior?
> 
> *checks the standard*  [...]
> NULL doesn't point to anything so it looks like adding 0 to a null
> pointer is indeed undefined.

Thanks for the legal work :-)

>                             (As a piece of trivia, strictly speaking
> NULL + 0 would be undefined on some implementations and defined on
> others, since an implementation is permitted to #define NULL to 0.)

Isn't that the very definition of "undefined behavior", in the sense of
a language standard?

> [...]
>> It would be a pain to have to change the signature of this macro, and
>> we'd prefer not to add overhead to each iteration of the loop. So
>> instead, whenever `list->items` is NULL, initialize `item` to point at
>> a dummy `string_list_item` created for the purpose.
> 
> What signature change do you mean?  I don't understand what this
> paragraph is alluding to.

I was thinking that one solution would be for the caller to provide a
`size_t` variable for the macro's use as a counter (since I don't see a
way for the macro to declare its own counter). The options are pretty
limited because whatever the macro expands to has to play the same
syntactic role as `for (...; ...; ...)`.

> [...]
> Does the following alternate fix work?  I think I prefer it because
> it doesn't require introducing a new global. [...]
>  #define for_each_string_list_item(item,list) \
> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
> +	for (item = (list)->items; \
> +	     (list)->items && item < (list)->items + (list)->nr; \
> +	     ++item)

This is the possibility that I was referring to as "add[ing] overhead to
each iteration of the loop". I'd rather not add an extra test-and-branch
to every iteration of a loop in which `list->items` is *not* NULL, which
your solution appears to do. Or are compilers routinely able to optimize
the check out?

The new global might be aesthetically unpleasant, but it only costs two
words of memory, so I don't see it as a big disadvantage.

Another, more invasive change would be to initialize
`string_list::items` to *always* point at `dummy_string_list_item`,
rather similar to how `strbuf_slopbuf` is pointed at by empty `strbuf`s.
But I really don't think the effort would be justified.

Michael
