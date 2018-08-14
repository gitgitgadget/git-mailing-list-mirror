Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BD31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 04:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeHNHRN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 03:17:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38472 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbeHNHRN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 03:17:13 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so17795440itb.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=usG73SGAts8QN67pvUhrz6aNFomqrczkZ8Z3oPvWN4g=;
        b=HiI5ZM6CEis0judBgSvjMm7s/MFqa5u2mn0XF4pyuKoseVEsv/KTXCH0EDdNml2WFb
         AQTl4Rqzn3lRB+lcEG8vaY+s2BmiLJGZoUcblP12h2vKes0+7XHmZH709ApEK9OvxVTa
         T2vsWK8c+epzpaUcwNTcTAE58VaH9YUHQFbMTLe6iDdIoSvBpmEOxVemT8ZDo1+St5Lj
         EscDqOi9hQnPEYqO8j/1q606mhDKj9Axqkh3XLdKzYYUpIgnCQM1c49mUusBA9qfUpv7
         n7Pq66eX/QXVfeLsQAWSpbCBFiFOkuw/QtDAOCVE9sS0evZP5Ccw/dmFRq0x+O3x1XEO
         ZdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=usG73SGAts8QN67pvUhrz6aNFomqrczkZ8Z3oPvWN4g=;
        b=EkozHflnVh2EM9HGeh99wiP3Ch1TjHlB7vEC4JMtiknyYKKJN6Qn8XP47a3V3xjpVi
         s7nMohbnV83LIGKSfW8qP0inreu9cKc4e5olTc09/Zk6VpqhdEsRwaP/wcF4i+Q/C+eX
         gEpwv4iK6zQIcIWf9zYuaMMFmGclbeOqtta4CAa490cH6eyF9m3rJzMA4THbbx/niii7
         O50Lf9RQogz0qjPeeDvZDamIM4lzL2d6eZHypVgl/MIdp0W2mfLMHveLNx/+jxT2cKcG
         EZs7GSqA5s5f+m21IGTrvyZdHWwe4HtNTDvFo4ECW2uULMxUbuNoNvoHwLDc7zYNoaTs
         IoCw==
X-Gm-Message-State: AOUpUlErAzBUhcFTLYkaEOevJROqd1n23xUwwkQ54gY+lBRyGbHVGLHv
        4fHkcPl0gsY5XP6UbSTG/Bq64CJKJXy4qSXUc5k=
X-Google-Smtp-Source: AA+uWPzehTOs53SMADGUQQDjMVDd7vS5f82v+VbJBkNstnnuHeOZRMaLBXfcsZpFbqZh9n4pbCqWcQl8ag6adU5pvhQ=
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr12584125itl.96.1534221110722;
 Mon, 13 Aug 2018 21:31:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 21:31:50
 -0700 (PDT)
In-Reply-To: <CAGZ79kYMV0DCd89Pw3v4d48GyQN9iQzt=XZ9=aGswHFHWhas3g@mail.gmail.com>
References: <20180813163108.GA6731@sigill.intra.peff.net> <CAGZ79kYMV0DCd89Pw3v4d48GyQN9iQzt=XZ9=aGswHFHWhas3g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 14 Aug 2018 06:31:50 +0200
Message-ID: <CAP8UFD11BTfkw3pP_F9O5miRw2wtcE7Unnhj0DMEPwo+LW=Dhw@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 7:46 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Aug 13, 2018 at 9:31 AM Jeff King <peff@peff.net> wrote:
>>
>> For the past several years, we've held a Git Contributor Summit as part
>> of the Git Merge conference. I'd like to get opinions from the community
>> to help plan future installments. Any feedback or opinion is welcome,
>> but some obvious things to think about:
>>
>>   - where, when, and how often?
>>
>>     Plans are shaping up to have Git Merge 2019 in Brussels right after
>>     FOSDEM in February (like it was two years ago), with a contributor
>>     summit attached.
>>
>>     Are there people who would be more likely to attend a contributor
>>     summit if it were held elsewhere (e.g., in North America, probably
>>     in the Bay Area)? Are people interested in attending a separate
>>     contributor summit not attached to the larger Git Merge (and if so,
>>     is there any other event it might be worth connecting it with,
>>     time-wise)?  Are people interested in going to two summits in a year
>>     (e.g., Brussels in February, and then maybe some in North America
>>     later in the year), or is that diminishing returns?
>
> We have been kicking around the thought of reviving the GitTogethers
> like back in the olden days (I only know them from hearsay), in
> Mountain View or Sunnyvale at the Google Campus, but we have not yet
> spent enough thought to make it so.

I think it would be great to have GitTogethers again around the time
of the GSoC Mentor Summit like we did a long time ago!

> I think twice a year is fine for the community and has not reached the
> point of diminishing returns.

I agree.

> As most contributors are from North America (estimated), I would not
> mind a conference somewhere here.

Yeah, it looks like the Git Merge is most of the time in Europe, so it
would be nice to have something in North America too.

> I'd be looking forward to Brussels next February!

Looking forward to it too! I think it is a great idea to have it
around the time of the FOSDEM.

>>   - format
>>
>>     For those who haven't attended before, it's basically 25-ish Git
>>     (and associated project) developers sitting in a room for a day
>>     chatting about the project. Topics go on a whiteboard in the
>>     morning, and then we discuss each for 30-60 minutes.
>>
>>     We could do multiple days (which might give more room for actually
>>     working collaboratively instead of just discussing). We could do
>>     something more formal (like actual talks). We could do something
>>     less formal (like an all-day spaghetti buffet, where conversation
>>     happens only between mouthfuls). The sky is the limit. Some of those
>>     ideas may be better than others.

If we have GitTogethers again, I think it would be nice indeed if we
could do 2 days. For example maybe one day unconference and one day
working collaboratively or discussing in smaller groups. 2 days
instead of 1 would make it more valuable for developers based in
Europe (and maybe in North America and elsewhere) to come.

> Personally I think the way is fine; we could collect topics in advance on
> the list to have a head start, but the whiteboard is totally fine, IMHO.

Yeah for the GitTogethers we used to collect topics in advance, but we
still had a whiteboard and voted on them at the beginning of the
actual GitTogether.

Thanks for starting this discussion.
