Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8CF1F97E
	for <e@80x24.org>; Mon, 20 Aug 2018 08:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeHTMME (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 08:12:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35144 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 08:12:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so13118903wmc.0
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=a038+9B1LKLT11n+89CYiieXa6NxlyLeDmCD5uoh44w=;
        b=ZE8x0XZLc+rqguQ6s/lFy01v8Af2WU2IS07vf50pe41LiuYdzmP6kRV09Xd/51wz/x
         1wai00pCmIIJJw7YbuaKgCh+Zdi9xXo6tFsHGO7D3UcgDTNs64MTfbmwc0WjSbsUgV4+
         i7LfcQe6BedX4olcecT9U5HuxIHVpug+bsIigRwt/fYetuTYSkPDRfl6cBAjppVq5oCd
         rXYSLUP8ed9F0Xfm0B3w7MNURgYbk8bq77M/Z7sfVz2dNBdMtX4mBO1crdHPCYWe6cyF
         E21EuyREAYtfAJrJ425wP1FWbxCD7/2H+XC1mw6ttNf7IR+xKgqxcwCG05u5BExib9g9
         94pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=a038+9B1LKLT11n+89CYiieXa6NxlyLeDmCD5uoh44w=;
        b=dqqsZBu4R30aDaIv6gljDT6nP/EId36OOPPoVuX4BvnAY6RbjeMGWsj7NATp7xd2+6
         lVt7/N/pljby1eIQvhl2EzjE+6oEtRGqGVJSJSCnbmpQTJZR/C0M3SCh2pbFv/T6N0Zm
         IIKAcELWnNgfji7cFB6NpE3nBzJg/n3r7NRbij4xAMC6A7WlLok1vn2ATqfLJyDNOld2
         dCbXtiBMvRuYh8aJxRp6L30kjSjBrb2bQo3+sgMTGdnvXXAkjHhcvWjoJWbWJTiUs3zX
         y2R8qQRiWVeQt6EazTKJ6SiKQO/kbgNAuPtbXNUzBIeAeU/mRE+OaGEA6EY1GypKPwio
         pWbA==
X-Gm-Message-State: AOUpUlHtevkXP/A6WDkcdgvtUph8eEEKx9XuuUQauPWGWSw76+H38U3I
        OW9NyCmO+pV/ca9FrdxET0c=
X-Google-Smtp-Source: AA+uWPwejDmmGnxiFEXABD/x1J4WQuLRcvlgTpYgEbJMQpPJZRw+0kkiwhemG7HbzHGx9iuzSTnb+Q==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr24622788wmf.148.1534755435914;
        Mon, 20 Aug 2018 01:57:15 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id w201-v6sm175626wmw.39.2018.08.20.01.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 01:57:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: Antw: Re: non-smooth progress  indication for git fsck and git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
        <20180816155714.GA22739@sigill.intra.peff.net>
        <87bma2qcba.fsf@evledraar.gmail.com>
        <20180816205556.GA8257@sigill.intra.peff.net>
        <5B7A7CDC020000A10002CDCF@gwsmtp1.uni-regensburg.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <5B7A7CDC020000A10002CDCF@gwsmtp1.uni-regensburg.de>
Date:   Mon, 20 Aug 2018 10:57:13 +0200
Message-ID: <87woslpg9i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 20 2018, Ulrich Windl wrote:

>>>> Jeff King <peff@peff.net> schrieb am 16.08.2018 um 22:55 in Nachricht
> <20180816205556.GA8257@sigill.intra.peff.net>:
>> On Thu, Aug 16, 2018 at 10:35:53PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> This is all interesting, but I think unrelated to what Ulrich is talking
>>> about. Quote:
>>>
>>>     Between the two phases of "git fsck" (checking directories and
>>>     checking objects) there was a break of several seconds where no
>>>     progress was indicated
>>>
>>> I.e. it's not about the pause you get with your testcase (which is
>>> certainly another issue) but the break between the two progress bars.
>>
>> I think he's talking about both. What I said responds to this:
>
> Hi guys!
>
> Yes, I was wondering what git does between the two visible phases, and between
> the lines I was suggesting another progress message between those phases. At
> least the maximum unspecific three-dot-message "Thinking..." could be displayed
> ;-) Of course anything more appropriate would be welcome.
> Also that message should only be displayed if it's foreseeable that the
> operation will take significant time. In my case (I just repeated it a few
> minutes ago) the delay is significant (at least 10 seconds). As noted earlier I
> was hoping to capture the timing in a screencast, but it seems all the delays
> were just optimized away in the recording.
>
>>
>>> >> During "git gc" the writing objects phase did not update for some
>>> >> seconds, but then the percentage counter jumped like from 15% to 42%.
>>
>> But yeah, I missed that the fsck thing was specifically about a break
>> between two meters. That's a separate problem, but also worth
>> discussing (and hopefully much easier to address).
>>
>>> If you fsck this repository it'll take around (on my spinning rust
>>> server) 30 seconds between 100% of "Checking object directories" before
>>> you get any output from "Checking objects".
>>>
>>> The breakdown of that is (this is from approximate eyeballing):
>>>
>>>  * We spend 1-3 seconds just on this:
>>>
>>
> https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack
>
>> -check.c#L181
>>
>> OK, so that's checking the sha1 over the .idx file. We could put a meter
>> on that. I wouldn't expect it to generally be all that slow outside of
>> pathological cases, since it scales with the number of objects (and 1s
>> is our minimum update anyway, so that might be OK as-is). Your case has
>> 13M objects, which is quite large.
>
> Sometimes an oldish CPU could bring performance surprises, maybe. Anyway my
> CPU is question is an AMD Phenom2 quad-core with 3.2GHz nominal, and there is a
> classic spinning disk with 5400RPM built in...
>
>>
>>>  * We spend the majority of the ~30s on this:
>>>
>>
> https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack
>
>> -check.c#L70-L79
>>
>> This is hashing the actual packfile. This is potentially quite long,
>> especially if you have a ton of big objects.
>
> That seems to apply. BTW: Is there a way go get some repository statistics
> like a histogram of object sizes (or whatever that might be useful to help
> making decisions)?

The git-sizer program is really helpful in this regard:
https://github.com/github/git-sizer

>>
>> I wonder if we need to do this as a separate step anyway, though. Our
>> verification is based on index-pack these days, which means it's going
>> to walk over the whole content as part of the "Indexing objects" step to
>> expand base objects and mark deltas for later. Could we feed this hash
>> as part of that walk over the data? It's not going to save us 30s, but
>> it's likely to be more efficient. And it would fold the effort naturally
>> into the existing progress meter.
>>
>>>  * Wes spend another 3-5 seconds on this QSORT:
>>>
>>
> https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack
>
>> -check.c#L105
>>
>> That's a tough one. I'm not sure how we'd count it (how many compares we
>> do?). And each item is doing so little work that hitting the progress
>> code may make things noticeably slower.
>
> If it's sorting, maybe add some code like (wild guess):
>
> if (objects_to_sort > magic_number)
>    message("Sorting something...");

I think a good solution to these cases is to just introduce something to
the progress.c mode where it learns how to display a counter where we
don't know what the end-state will be. Something like your proposed
magic_number can just be covered under the more general case where we
don't show the progress bar unless it's been 1 second (which I believe
is the default).

>>
>> Again, your case is pretty big. Just based on the number of objects,
>> linux.git should be 1.5-2.5 seconds on your machine for the same
>> operation. Which I think may be small enough to ignore (or even just
>> print a generic before/after). It's really the 30s packfile hash that's
>> making the whole thing so terrible.
>>
>> -Peff
