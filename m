Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939602021E
	for <e@80x24.org>; Tue, 15 Nov 2016 14:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936573AbcKOO3N (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:29:13 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36596 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbcKOO3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 09:29:12 -0500
Received: by mail-wm0-f50.google.com with SMTP id g23so170639648wme.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 06:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I8qasQKWY0wGvoT5X+Kwm3s4B0/jemF4U8T+rGh4bTs=;
        b=MDW4qiQ6W2oHP0YQ7NYs1k2FTHuLc0yth6Za2I91DWFGQQTE8mhHAPrb/uSfEHWtw1
         vaTPsbCtLxr2R/SWe+vDy+xQhmQDCe6//HKGqg+qk3W8zDHSMS0qpiQm7mfEbblL88gs
         vMEBJvSbgmTQ1I5Tu4+i7ZOrEMdcIQNvXNNf6bue1vXScPa4axvxZWMJOIZzUh6qOtaf
         Ep0jdI7L+7CnajVUr6j+/EMUtWtDzIwahnm0PV4kpmMkuCUl0yFk0xwL+Kxd4kx4WiY2
         IhV0JDuKszcfRxKWAIxEcHxqds+F6goyHmLquzXHbT20SuMPlwEHTHUQURwjil48uwRB
         cl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I8qasQKWY0wGvoT5X+Kwm3s4B0/jemF4U8T+rGh4bTs=;
        b=QSQe5V1WQO6PIxF7lGLq/KLC4qpVGm019F3IF+Zk9xGS0j/Ib39OyPT/3pvBQTkEjs
         UKcfcrFDsh0aIw+q4P76srWWAFFyWs3OmSydub9UKoLcgCiKx4pvRL79lNesi+CJem2T
         /aOyQqTphO3C1NTa4X+coPT680C/tOV5VWPeO/fxXExzRqNTIeA+rX3gbe3x7EJzNGZw
         mZlDECWwUBl1W96/lFNaCAoFOrhiB0isI9a4AAGi5dVUYsfVOqKZ4AYnGXTN1FGSUcvv
         BFr4FP+3xrVn8xgJmdJfrCjsi8EdNTTJ3OvGJ+WiZpzo8tgiiidQWgWz3GV+Dbxyrnf9
         D/Gg==
X-Gm-Message-State: ABUngvfhhiKSYdBHz/w0aVaw2kJfPHTsfG+K/GN0WnD7UrOvS2XORUocSJoEhTRBF6XvQw==
X-Received: by 10.194.26.133 with SMTP id l5mr24401463wjg.4.1479220150844;
        Tue, 15 Nov 2016 06:29:10 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w66sm4585987wme.4.2016.11.15.06.29.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 06:29:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161115010356.GA29602@starla>
Date:   Tue, 15 Nov 2016 15:29:09 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com> <20161115010356.GA29602@starla>
To:     Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Nov 2016, at 02:03, Eric Wong <e@80x24.org> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> wrote:
>> Hi,
>> 
>> Git always performs a clean/smudge filter on files in sequential order.
>> Sometimes a filter operation can take a noticeable amount of time. 
>> This blocks the entire Git process.
> 
> I have the same problem in many places which aren't git :>
> 
>> I would like to give a filter process the possibility to answer Git with
>> "I got your request, I am processing it, ask me for the result later!".
>> 
>> I see the following way to realize this:
>> 
>> In unpack-trees.c:check_updates() [1] we loop through the cache 
>> entries and "ask me later" could be an acceptable return value of the 
>> checkout_entry() call. The loop could run until all entries returned
>> success or error.
>> 
>> The filter machinery is triggered in various other places in Git and
>> all places that want to support "ask me later" would need to be patched 
>> accordingly.
> 
> That all sounds reasonable.
> 
> The filter itself would need to be aware of parallelism
> if it lives for multiple objects, right?

Correct. This way Git doesn't need to deal with threading...


>> Do you think this could be a viable approach?
> 
> It'd probably require a bit of work, but yes, I think it's viable.
> 
> We already do this with curl_multi requests for parallel
> fetching from dumb HTTP servers, but that's driven by curl
> internals operating with a select/poll loop.
> 
> Perhaps the curl API could be a good example for doing this.

Thanks for the pointer!


>> Do you see a better way?
> 
> Nope, I prefer non-blocking state machines to threads for
> debuggability and determinism.

Agreed!


> Anyways, I'll plan on doing something similar (in Perl) with the
> synchronous parts of public-inbox which relies on "cat-file --batch"
> at some point... (my rotational disks are sloooooooow :<)

That sounds interesting! What changes to you have in mind for 
"cat-file --batch"? We are thinking about performance improvements
in that area, too. I would be happy to help reviewing your patches!

Thanks a lot for your RFC feedback,
Lars
