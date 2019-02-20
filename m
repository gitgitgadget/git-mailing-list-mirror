Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50CC1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 13:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfBTNDp (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 08:03:45 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33406 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfBTNDp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 08:03:45 -0500
Received: by mail-wr1-f52.google.com with SMTP id i12so25946739wrw.0
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wcEPLtMphMfd1V7fsZeJvXHmS/uE5bAOr2dJzrrPOlE=;
        b=EzIw7gvc9Qr2w57sm9kQZS1WXnjqkIDvsp6Q3Zj3ZDTvXToQyJmn6+phAkxiRL0mKh
         8DuQ/3z1xzq66l0KHH71jYrChCQSaJbaBYZ3XhaTLRDPxIHwfutjI1fjAcGVfioNMiSW
         vh8dPCoaibwfoagHUNH1UnWw0FGsbXl6354CHvRJf6UEJDDnIbBeubpqAi1sjQu+fD8D
         BQFdZURktxBLNTUwLrgFrQedcxT1N66A1Z/gD8woWM3w/J+N+TTlrI+jwMk8k6xdRvfh
         rTXQ2O6xvXx6FCJL9EwGLUqSdYIE4Agbra3A4Sg/4zmyrxspYstjUbaMGMRG1WgZ0m51
         68fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wcEPLtMphMfd1V7fsZeJvXHmS/uE5bAOr2dJzrrPOlE=;
        b=gXORhPoIasM32CBRJQdqx1QgYCAjY4SN8w3ZRDuSgXWnCMEfFzeIz7PKMmoKgfEqeZ
         sqO02419wW0SYfPMg2vvwMfd9jZoOJ7PfKGE3/Qq+gNpRZ6aHF5XKW7UhnBohPoRzKBc
         Gvj6g5Xr99g7UkTaiotJYcl1Pw+Pmk8ZnUKIUrbyr/oVu5gHDhKgLEUtadXw4yuOr8O6
         sXtq5f4/r/18oAFCUJsGO7XqCMRTEqBJz9lme4B5X87mB2Ry2Y4p/vLy4YiTV1dyG8Lm
         d4YR+0fTXawSBbU/+2JYT2crkDyBEhebb36QPu0kXnCMZC/86bIdApMnTzssd7sBYvPH
         9XmA==
X-Gm-Message-State: AHQUAuaItBWl3vSncOfzDedhIKY6Mbxvtivq91oEezLk4cKIHXKERP86
        Xd3s3l4J22Tzt6x7muCXoXfzUlptzvk=
X-Google-Smtp-Source: AHgI3IYCOjMAxoh27l7zXjTxzNExpqbZE5nmEh9L2iMj7d8FC7/ozbKC3zpTxcfnmKuYDHHoofcI1Q==
X-Received: by 2002:adf:e385:: with SMTP id e5mr25361521wrm.267.1550667822949;
        Wed, 20 Feb 2019 05:03:42 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h126sm8158391wmf.2.2019.02.20.05.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 05:03:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Git Merge Conference Recordings [was: Re: [ANNOUNCE] Git Merge Contributor's Summit Jan 31, 2019, Brussels]
References: <20181109104202.GA8717@sigill.intra.peff.net> <2139295744.18413.1550666884748@ox.hosteurope.de>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <2139295744.18413.1550666884748@ox.hosteurope.de>
Date:   Wed, 20 Feb 2019 14:03:40 +0100
Message-ID: <87ef82628j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 20 2019, Thomas Braun wrote:

> Hi Jeff,
>
> I wanted to point a colleague of mine to one of the talks. Unfortunately =
I could not find the recordings of the talks anywhere.
>
> Are these available?

I have no insider knowledge, but can tell you that in past years it's
taken GitHub a bit to process these and put them on YouTube[1].

E.g. last year's conference was in early March, and the videos trickled
in in late-March to early April, the year before that it was in February
and the videos were published in May of that year.

Historically the 3-4 month delay has been more of the norm than 1-2.

So subscribe to their channel on YouTube, it'll be uploaded sometime
soon-ish.

1. https://www.youtube.com/user/github/videos

>> Jeff King <peff@peff.net> hat am 9. November 2018 um 11:42 geschrieben:
>>
>>
>> Git Merge 2019 is happening on February 1st. There will be a
>> Contributor's Summit the day before. Here are the details:
>>
>>   When: Thursday, January 31, 2019. 10am-5pm.
>>   Where: The Egg[1], Brussels, Belgium
>>   What: Round-table discussion about Git
>>   Who: All contributors to Git or related projects in the Git ecosystem
>>        are invited; if you're not sure if you qualify, please ask!
>>
>> This email is just to announce the date so people can start planning.
>> You'll need to register eventually, but I don't have the invite codes
>> yet.  Registration should be similar to past years. In particular, if
>> you're coming to the contrib summit, DON'T register for the main
>> conference yet. I think the codes I get will cover both (and as with
>> previous years, contrib summit attendees will have the option of a
>> complimentary pass to the main conference, or can pay =E2=82=AC99 that g=
oes to
>> Software Freedom Conservancy).
>>
>> The content / agenda is whatever we choose. There's some more discussion
>> on format in this thread from August:
>>
>>   https://public-inbox.org/git/20180813163108.GA6731@sigill.intra.peff.n=
et/
>>
>> though it sounds like people are mostly on board with what we've done in
>> past years. I'm looking into getting better A/V for remote attendance,
>> but I'm not sure yet what will be possible.
>>
>> Any thoughts or discussion on format, content, etc are welcome. The only
>> thing set so far is the time and place. :)
>>
>> -Peff
>>
>> [1] This is the same venue as 2017: https://goo.gl/maps/E36qCGJhK8J2
>>
