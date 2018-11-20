Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5B31F97E
	for <e@80x24.org>; Tue, 20 Nov 2018 12:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeKTWqn (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 17:46:43 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:41323 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeKTWqn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 17:46:43 -0500
Received: by mail-yb1-f175.google.com with SMTP id t13-v6so634008ybb.8
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 04:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4S2V6mMnNrfJzK7vcCYRPxSuWaEP/TM89AggdCSs2Co=;
        b=bL/eXIAQhzhbyG7HxW18uGbuB9aeORrJw91I0xPwW9JaoDYG6O5Y1V4xJvSdNIB2vh
         3b03tz+oA3UcGzTf8aSnh/Z0J4Oe19NMOMQM1Dz1goJ5+gmd6VLuVbemK9TOeS24P1Pd
         gJChKoAVVs88qozWaZotxjSh2Gvikp5o9uRNCOsBpJ5W8wHq4B9HG+TxRtU+hA3g4iNh
         cnUOuJjGupPeXhQMh5oUYYv52BAdLBbnSr6DUolhmrj96muxVPI/NJgassl/qqMviMjm
         WH9wHkkpzV/uhHLdd+Ao3ORKxw+gRbV5V7gG1SXc6AdVAtQumf5efG8zXiDGlMvgnI0I
         QJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4S2V6mMnNrfJzK7vcCYRPxSuWaEP/TM89AggdCSs2Co=;
        b=Jv1DsiV5GUqypiGMf85itqOUzdHpcVNqcZlXhvVzUo21Ex8O0pZ0TG71tBP16U8FYg
         mQeZhrzFRSV+zlTXAjPltORYNaVNFWGTE9veKzPq/e4g6uiz/ZbfWnSgoFf2hlR2TP6P
         FAf81WMiOhAcNi6ZMUvgrxhXpkaqipG3nS5CV0Nb2p3WhazeRMnB0TadOvV5uODOhGuK
         NfO1joyeofjAb5dllrqbJg8AloG7pcUK1jkCuGytnakMPhzBpZe2nKDuzYdV+mniBmPV
         cV+hhG9K8QTZw8LmswkoGBTmFGfP32DgV+Q7YhfTNBJ89bG77RI+eDfZ7Qu/9nXYcs1f
         4WDA==
X-Gm-Message-State: AA+aEWbne1pQI8PDdX8DWJa1Uw/THbqbAh8Cn4GgrsbxBMdFvWzAFqCN
        Yb/pWrAMZT2a9r0zNTU8BlWFP1zW
X-Google-Smtp-Source: AFSGD/VJZv+vJfonEeYW2nyaNj1Qm6jFY7jQMf1SOiajhaGPxuuCyqDTC35ANjF6/RXvgvyFWvRZOg==
X-Received: by 2002:a25:5443:: with SMTP id i64-v6mr1516729ybb.287.1542716270335;
        Tue, 20 Nov 2018 04:17:50 -0800 (PST)
Received: from [10.0.1.11] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id k192-v6sm14293401ywk.99.2018.11.20.04.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:17:49 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
 <20181120113423.GA29319@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <80690e4b-4fc4-7846-009f-59dee9fbdd86@gmail.com>
Date:   Tue, 20 Nov 2018 07:17:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181120113423.GA29319@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2018 6:34 AM, Jeff King wrote:
> On Mon, Nov 19, 2018 at 10:40:53AM -0500, Derrick Stolee wrote:
>
>
> Since depth is never incremented, we are not covering this block. Is it
> possible to test?
> This should be covered by the fix in:
>
>    https://public-inbox.org/git/20181120095053.GC22742@sigill.intra.peff.net/
>
> because now entries at the top-level are depth "1". The "depth++" line
> is still never executed in our test suite. I'm not sure how much that
> matters.

Thanks! I'll go take a look at your patch.

>>> delta-islands.c
>>> c8d521faf7  53) memcpy(b, old, size);
>> This memcpy happens when the 'old' island_bitmap is passed to
>> island_bitmap_new(), but...
>>
>>> c8d521faf7 187) b->refcount--;
>>> c8d521faf7 188) b = kh_value(island_marks, pos) = island_bitmap_new(b);
>> This block has the only non-NULL caller to island_bitmap_new().
> This is another case where it triggers a lot for a reasonably-sized
> repo, but it's hard to construct a small case. This code implements a
> copy-on-write of the bitmap, which means the same objects have to be
> accessible from two different paths through the reachability graph, each
> with different island marks. And then a test would I guess make sure
> that the correct subsets of objects never become deltas, which gets
> complicated.
>
> And I think that's a pattern with the delta-island code. What we really
> care about most is that if we throw a real fork-network repository at
> it, it produces faster clones with fewer un-reusable deltas. So I think
> a much more interesting approach here would be perf tests. But:
>
>    - we'd want to count those as coverage, and that likely makes your
>      coverage tests prohibitively expensive
>
>    - it requires a specialized repo to demonstrate, which most people
>      aren't going to have handy

Do you have regularly-running tests that check this in your 
infrastructure? As long as someone would notice if this code starts 
failing, that would be enough.

>>> c8d521faf7 212) obj = ((struct tag *)obj)->tagged;
>>> c8d521faf7 213) if (obj) {
>>> c8d521faf7 214) parse_object(the_repository, &obj->oid);
>>> c8d521faf7 215) marks = create_or_get_island_marks(obj);
>>> c8d521faf7 216) island_bitmap_set(marks, island_counter);
>> It appears that this block would happen if we placed a tag in the delta
>> island.
> Yep. Again, exercised by real repositories.
>
> I'm not sure how far we want to go in the blind pursuit of coverage.
> Certainly we could add a tag to the repo in t5320, and this code would
> get executed. But verifying that it's doing the right thing is much
> harder (and is more easily done with a perf test).

Blind coverage goals are definitely not worth the effort. My goal here 
was to re-check all of the new code (since last release) that is not 
covered, because it's easier to hide a bug there.

>
>>> c8d521faf7 397) strbuf_addch(&island_name, '-');
>> This block is inside the following patch:
>> [...]
> Yeah, this triggers if your regex has more than one capture group (and
> likewise, we almost certainly don't run the "you have too many groups"
> warning).

Did you know that regexes are notoriously under-tested [1]? When looking 
at this code, I didn't even know regexes were involved (but I didn't 
look enough at the context).

[1] https://dl.acm.org/citation.cfm?id=3236072

>
>>> c8d521faf7 433) continue;
>>> c8d521faf7 436) list[dst] = list[src];
>> These blocks are inside the following nested loop in deduplicate_islands():
>>
>> +       for (ref = 0; ref + 1 < island_count; ref++) {
>> +               for (src = ref + 1, dst = src; src < island_count; src++) {
>> +                       if (list[ref]->hash == list[src]->hash)
>> +                               continue;
>> +
>> +                       if (src != dst)
>> +                               list[dst] = list[src];
>> +
>> +                       dst++;
>> +               }
>> +               island_count = dst;
>> +       }
>>
>> This means that our "deduplication" logic is never actually doing anything
>> meaningful.
> Sorry, I don't even remember what this code is trying to do. The island
> code is 5+ years old, and just recently ported to upstream Git by
> Christian. And that's perhaps part of my laziness in the above tests; it
> would be a significant effort to re-figure out all these corner cases.
> It's a big part of why I hadn't been sending the patches upstream
> myself.

Sure. Hopefully pointing out these blocks gives us more motivation to 
manually inspect them and avoid silly bugs.

Thanks,
-Stolee
