Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC72207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbcJCV2S (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:28:18 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33589 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcJCV2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:28:16 -0400
Received: by mail-pf0-f181.google.com with SMTP id 190so20783628pfv.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0OkcvvAyfacL3PEI3sDKY4QPOtrXTfjO7Ma/IAPbjW8=;
        b=oZHH7ZNMLZmcDMZfcGVu1VIAP9fUlLp2Fh+rem4f3XY1eHhYlis/cQIwXRpE9ZhhnJ
         lbWRKcAhrMjVMwjhV0S+8MlP2/14Mh7BO7z7h/WJ5HeYG7oNG+GHp7RVi29jVSHuTxIY
         t2wSfksSq8Plhz/31h9vb1TQOBYX13dyHm0OJiEOl7NuGMXthFOPQQm+0MwrJRPUbocl
         gqv1sGiBZCFLS6dWyzzMwPZ0kU8RERuR7m25zzRkQii6EiSMXI5XIUicP78u3DUd/ZZM
         ti7tB6IZ+S+Au8kWD6+jm7jv8QVtgvd96bSlkGIRG2OVODEiTJqK4yEarUxdHx1gZc3M
         HNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0OkcvvAyfacL3PEI3sDKY4QPOtrXTfjO7Ma/IAPbjW8=;
        b=VYFfegbMlXKR6MfJEGTV7g4b/EhmSWIg3apHTttq1+s0ZMjmZdYZeuyp/sGucXuboD
         OypMQ+PnGvzCqXfOyPpwY7oEaKnQPPAJputCBQa0QP5UKCBYjATqpXmc8kRL37T5ImYk
         1H0erGs6BOI6YAuLzygWq6nIf8EOorUV+qtRe9e3aggh+0Z2l42x9/G9zndsKvh6Ow4r
         9o7UG/GWgY4TvFRGs2Uc6bzChl0eC89g22EbJ0vyEBZBCjiVXVOQUsrn4aTgOHl5aCYk
         jILVH0apk/kYlXllFPGhRINykvZiF3JpGT1pQS/irK8bX1JYR1PRp8h/0mSxUHHjJAIG
         CfJA==
X-Gm-Message-State: AA6/9Rm2a8ucWru53kNA7JgVgk065A1MAg5BsnjFFlQev3BiJMgfRW9rvmheG6a8aJdBQPQ0
X-Received: by 10.98.198.70 with SMTP id m67mr311446pfg.34.1475530095962;
        Mon, 03 Oct 2016 14:28:15 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:a8c4:ef1c:855a:28ff])
        by smtp.gmail.com with ESMTPSA id s12sm49388074pfj.73.2016.10.03.14.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2016 14:28:14 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
 <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
 <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
 <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
 <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
 <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
Date:   Mon, 3 Oct 2016 14:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03/2016 12:17 PM, Junio C Hamano wrote:
> It may be necessary for the code to analize the lines in a block
> identified as "likely to be a trailing block" more carefully,
> though.  The example 59f0aa94 in the message you are responding to
> has "Link 1:" that consists of 3 physical lines.  An instruction to
> interpret-trailers to add a new one _after_ "Link-$n:" may have to
> treat these as a single logical line and do the addition after them,
> i.e. before "Link 2:" line, for example.
>
> I also saw
>
> 	Signed-off-by: Some body <some@body.xz> (some comment
>         that extends to the next line without being indented)
> 	Sined-off-by: Some body Else <some.body@else.xz>
>
> where the only clue that the second line is logically a part of the
> first one was the balancing of parentheses (or [brakets]).  To
> accomodate real-world use cases, you may have to take into account a
> lot more than the strict rfc-822 style "line folding".

If we define a logical trailer line as the set of physical lines until 
the next trailer line...it is true that this has some precedence in that 
such lines can be written (although this might not be intentional):

   $ git interpret-trailers --trailer "a=foo
   bar" </dev/null

   a: foo
   bar

This solves the "Line 1:" case above, but raises other issues:

1. Checking for existence (trailer.ifexists) is now conceptually more 
difficult. For example, handling of inner whitespace in between lines 
might be confusing (currently, there is only one line, and whitespace 
handling is clearly described).
2. Replacement (trailer.ifexists=replace) might replace more than expected.
3. There is a corner case - the first line might not be a trailer line. 
Even if interpret-trailers knew about "(cherry picked from", a user 
might enter something else there. (We could just declare such blocks as 
non-trailers, but if we are already loosening the definition of a 
trailer, this might be something that we should allow.)

My initial thought was to think of a trailer as a block of trailer lines 
possibly interspersed with other lines. This leads to interpret-trailers 
placing the trailer in the wrong place if trailer.where=after, as you 
describe, but this might not be a big problem if trailer.where=after is 
not widely used (and it is not the default). (The other options behave 
as expected.)

There are other options like checking for indentation or checking for 
balanced parentheses/brackets, but I think that these would lead to 
surprising behavior for the user (this would mean that whitespace or 
certain characters could turn a valid trailer into an invalid one or 
vice versa, or change the behavior of trailer.ifexists, especially 
"replace").
