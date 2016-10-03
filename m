Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6118D207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 19:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbcJCTz7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 15:55:59 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38692 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcJCTz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 15:55:57 -0400
Received: by mail-it0-f53.google.com with SMTP id o19so107887933ito.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=saHXybjNLxKveBQYlO6R1uVl/9hcVazISf/IZrQ2C18=;
        b=XCwfLLl6XtpYYwF5zv8KxHXI5F1nQ+G7BA594S46qsKW28jch5wbPWHUdo2bkHsVeh
         wagYI7JmptK+a9hV/2+lP+Uea8ZJ2/Z/OUtj3Eeja7twrQ6Ytv+fiKoO2WpgHsA1V9cb
         0LEiKa+P2Vm4V23WdiVG8KyAJ80UJiM5XIiwyTnnZZKDcJ4hBpJl/Xqk4k5s1cAjSokG
         gdU8okBgQOvhPhnfRTX+mtmed+77L6TOaWyS/IGYD9YRJMwJ8CK07EMI069H4w745PYl
         yBosD63Q0MXzqxio6QzEwlaDfFj8HJY3ZFYorsJ4W48HvVfShpdza8NWBmJdC4jxyip1
         lg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=saHXybjNLxKveBQYlO6R1uVl/9hcVazISf/IZrQ2C18=;
        b=Y7eYTIa+rw2EBvJysdeGwx90UaIZz3xbxFMZJbNV4+W/yCc4HEDDeetGA5fBJhesYR
         up3cNWc3h/p8A5VXDfy1CUUzomvsWMPKaay1XxsA+1X+e14PUAUE8dCT7tPltD0E98Xu
         fYl8Qu6cyLVjEN86F61sU+NLsostXlqwMm3BG81LBw/Ht/FYks1b+HAjFZpTQiQdAWht
         fiOJogHsmWO5wj8VaAoVeTwfUEqwsBMG2TJdFJUHeUn6pRaP0JKVlEJj3iersWFBPCGj
         apFJSn01znxwUxF36zOUBrCQqMsdjRlo7GsTKn0QuluJzMMCp0guX5XJSxCDTROyIHUp
         nJuQ==
X-Gm-Message-State: AA6/9RlSJG1btMuu4TOrQHeEgf1B/ZFBytmNwNjJ4+V/BJvCfzjACr3lIibkctrrmGXhk5PDZQetaO8q/LegmmTc
X-Received: by 10.36.192.193 with SMTP id u184mr17747225itf.91.1475524556368;
 Mon, 03 Oct 2016 12:55:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 3 Oct 2016 12:55:55 -0700 (PDT)
In-Reply-To: <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com> <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
 <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Oct 2016 12:55:55 -0700
Message-ID: <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> * jc/attr (2016-05-25) 18 commits
>>> ...
>>>  The attributes API has been updated so that it can later be
>>>  optimized using the knowledge of which attributes are queried.
>>>
>>>  I wanted to polish this topic further to make the attribute
>>>  subsystem thread-ready, but because other topics depend on this
>>>  topic and they do not (yet) need it to be thread-ready.
>>>
>>>  As the authors of topics that depend on this seem not in a hurry,
>>>  let's discard this and dependent topics and restart them some other
>>>  day.
>>>
>>>  Will discard.
>>
>> So I just realized this is a big hint for me to pick up that topic; I assumed
>> you'd want to tackle the attr subsystem eventually, so all I was doing, was
>> waiting for your motivation to look at attr stuff to come back.
>>
>> So what is the actual lacking stuff here?
>
> Quite a bit.  Do you want a grand vision, or just the minimum that
> will hopefully futureproof us?

That is a good question. I do want the bare minimum at least; time
permitting I can do more.

I looked through jc/attr and I think all commits up to
0a5aad (2016-05-25, attr.c: plug small leak in parse_attr_line())
are better off if we'd include them today, no matter if we go with the
grand vision or the bare minimum viable, because all commits
up to that one are fixing real issues (memory or readability issues)

Starting with its child b649c7a50c (attr: rename function and struct
related to checking attributes) we start off going on an adventure which
may lead to the grand vision implemented, so these should be held off
until we have implemented a viable way.

>
> The current attribute API is optimized for a very narrow use case
> where a single thread looks up a single set of attributes for
> adjacent paths, without mixing lookups for other attributes of
> distant paths.
>
> Take "conversion" codepath for an example.  "git checkout" will
> iterate over the paths in the index and is interested in the eol,
> text and filter attributes (perhaps more, but the details do not
> change the overall picture that much).  When it checks dir/fileA, it
> is expected that it would next want to check dir/fileB, before it
> would want to check dir2/fileC and it would move much later to
> otherdir/fileD.  It also is expected that it would want to learn the
> same set of attributes, simply because the codepath is doing the
> same operation over these paths (i.e. learn how the Git "clean"
> representation needs to be converted to the external "smudged"
> representation).
>
> Based on the "adjacent paths" assumption, the attribute subsystem
> has a single cache that holds the contents of the .gitattributes
> files that matter to the current query.  This has to be split up if
> we ever want to do a parallel checkout with multiple threads.  One
> thread may be walking the first half of the index, while another one
> may be walking the second half of the index.  They would benefit
> from the same optimization that keeps track of the contents of
> .gitattributes files that matters to each of their traversal.  If
> the first thread is responsible for working on dir/fileA, it will
> work on dir/fileB next, before going to dir2/fileC, but it does not
> want to share the cache with the other thread that would be scanning
> entries far-away from what it's scanning, like otherdir/fileD, if it
> evicts the cached information for dir/* that is still useful for the
> first thread.
>
> Another thing we would want to see is to take advantage of the
> "lookup is for single set of attributes from a single codepath" for
> further optimization.  The way each of the callers is structured is
> to first declare a set of attributes it is interested in by
> preparing git_attr_check_elem[] array and then make repeated calls
> to git_attr_check() passing it and a path.
>
> The current implementation however does not tie the cache to this
> git_attr_check_elem[] array but has only one single global cache.
> The cache _could_ be used to query any attribute because of it, and
> that leads to inefficiency.  It has everything it read from relevant
> .gitattributes files, even the entries that do not affect any
> attributes that a single codepath showed its interest in.  I am
> hoping that we can do better by having a per <thread, callsite>
> cache of .gitattributes files, so that a caller in one thread (say,
> "git checkout" that scans the first half of the index) that asks for
> "eol" and "filter" would use a cache that does not have entries
> irrelevant for the attributes the caller is intereseted in, and that
> is tied to the directory hierarchy the caller is asking about
> (i.e. what prepare_attr_stack() does).
>
> Up to 079186123a ("attr: retire git_check_attrs() API", 2016-05-16)
> of the series gives us "struct git_attr_check" to replace the
> git_attr_check_elem[] array.  I originally hoped that this struct
> can hold the per-callsite cache itself, before we hit the threading
> issue too early (IIRC, that was preload-index code) and realize that
> the cache needs to be not just per callsite but needs to be per
> <thread, callsite>.  This new structure cannot be used to store the
> cache itself, but this change is probably a necessary first step for
> allowing the API in multi-threaded context.  git_attr_check_elem[]
> array was static and had slots to receive returned values, which
> would not have worked in threaded environment.  We'd further need to
> change it so that the inquiry keys (which are "interned" git_attr
> objects) of "git_attr_check" are initialized just once before
> starting to make repeated calls to git_attr_check(), but the
> mechanism to return values would be thread-safe.  git_check_attr()
> call may have to gain an extra/separate variable for the caller to
> specify an array to return values, or something.

I am looking at the tip of jc/attr-more and for a minimum
thread safety we'd want to change the call sites to be aware of the
threads, i.e. instead of doing

    if (!check)
        check = git_attr_check_initl("crlf", "ident",
                    "filter", "eol", "text",
                    NULL);

We'd rather call

        struct git_attr_check *check;
        check = git_attr_check_lookup_or_initl_threadsafe(
                "crlf", "ident", "filter", "eol", "text", NULL);
         if (!git_check_attr(path, check)) {
             ...

So we would make all init functions (git_attr_check_initl,
git_attr_check_alloc) to be aware of the threads and we would
not have a static variable to keep the state as that is global unfortunately,
but rather have a threadsafe lookup function. Though this makes me
wonder how much performance we need to care about here as the version
with the static variable seems to be optimized a lot. So maybe we'd add this
lookup function in attr.h so the respective callers can inline it?

>
> The way "interned" git_attr objects are managed needs to become
> thread-safe by protecting their creation and registering with mutex,
> but that is relatively isolated and straightforward conversion so I
> didn't pay any attention to that in my series.  In the final state,
> it of course needs to be taken care of.
>
> So that's the overall "grand vision" picture the series leading up
> to the tip of jc/attr-more was trying to lead us to.
>
> The minimum that would future-proof us, that is still missing from
> the series, would probably be to separate the query parameter
> "struct git_attr_check" and the return values from git_check_attr().

Not sure what you mean here with separating as a preparation for
the thread safety. As I understand it we can still keep the thread local
states in git_attr_check, we'd just have to route each thread to its
own part of the memory in there?

> Once it is done, I think we do not need to update the caller when we
> update the attr.c infrastructure to be thread-safe.
