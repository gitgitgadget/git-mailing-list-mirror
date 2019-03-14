Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D261520248
	for <e@80x24.org>; Thu, 14 Mar 2019 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCNUbd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 16:31:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38635 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCNUbd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 16:31:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id e10so1877067edy.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OUR/x116/h+8QDzm6bQ0YcVEpA2zeWNgeWS1uOkSLTc=;
        b=EgSXmp1xrqdr3wfKNmRcOxJG3+5xejtqWbrM/RJQqjBm7LMTDQt76Z5+L8O1bXyKUr
         L2VUwGx/lWHaEAFZQoqUIhdHV0qqsYzB3K1iX0mItxuzJmEQ9Lp92Z2q7gDIZrF+WjM4
         2ckOT76d1yIvBJ9VLNyJwWT5Wb81joBiPHfQMyogPyrGMvug/sRJYiqYr56PeuPI3ziN
         oB9Jredvdrlb+aWXi3m5cmnP1dOyI5tO4gjx7i72kPKY0U9w+/GXWimAlSuY19zYQ1VI
         JBoAQzubHAdtssa94B8h3TKjxncM3W/7GklaJsssRM/2FTuk7MaIOB5dtae0fDKIyUj+
         w0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OUR/x116/h+8QDzm6bQ0YcVEpA2zeWNgeWS1uOkSLTc=;
        b=qlIfOq4LeBojOvrLMUZ0Xhzoj+l8lSJ4RJ1oXhOCCV77udknKWR/vhPLmpmYX8lWt/
         mVSrsS0flvJDX7B0MXBFe9MXRpHFxe34XLsPavHQQhDk7RblxN/o5p2BY9y9tmRCv9he
         qBOhPuycb+waE8SkLSUjL3g1gVh3R3sr6z1YYG6HLwsyIPIbUKQ6mDTpUNTxTqBEgZQp
         oe/GvL6jfQXHmk2zUv8lFLhSN22JH+1mfkjqwFDi0aaEF3AxiXI40nT1JwOZTaMj/eG5
         bQc3vMroX2ZeGDq2qtXf3BqpLnc1OFFAXAd3K3fOW8Q3v+CektJWbNag1+13p9O6hBn6
         9Z/g==
X-Gm-Message-State: APjAAAXmuFj95WxXoZp0bXyVsvf8CQQ0GdH4EB2lvyJAZNKPec8T4lVN
        7lNF5lmQK0cUTi6fS2r2RsE=
X-Google-Smtp-Source: APXvYqwKZBmM2eVHrwPq2d8x9QcWk3UCEIjXq/xArF9NJ5SgpV3cHekAdbb2uG6+L4Vk3mFm5mtVEQ==
X-Received: by 2002:a17:906:6d50:: with SMTP id a16mr34782553ejt.170.1552595491258;
        Thu, 14 Mar 2019 13:31:31 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b8sm38315edt.34.2019.03.14.13.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 13:31:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: straw poll: git merge conference location
References: <20190313205539.GA30425@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190313205539.GA30425@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 21:31:29 +0100
Message-ID: <87bm2db3ku.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 13 2019, Jeff King wrote:

> I took an informal poll at the last contributor summit in Brussels, but
> that obviously has some bias. So I'll ask here: do you have a location
> preference for a Git Merge conference (and associated contributor
> summit) next March?
>
> We're looking at doing it in North America, but there are two specific
> questions:
>
>   - is there preference between East Coast vs West Coast?
>
>   - preferences between Canada and US?
>
> There's no commitment, but please only share your opinion if it might
> actually impact your decision (i.e., if you might actually attend the
> contribu summit). Feel free to email me off-list if you don't want to
> start a flamewar about countries or coasts. :)
>
> There's also been discussion about doing something (possibly in North
> America) in the summer or fall of this year, but as far as I know there
> hasn't been any planning so far.

This is going off-topic, but I'd be curious if splitting it up from Git
Merge in general is an option. Presumably the hypothetical event this
summer could be an experiment for that.

Personally I'd prefer to have a 2 day contributor summit stretching into
some hackathon to a 2nd day of talks for which I think most of us are
not the target audience. But maybe that's just me.

Once it's not a gigantic event requiring a gigantic conference venue
there's a lot more options for locations.

We'd just need something close to an international airport with
acceptable accommodation space for max 30-40 people. This'll also help
people who need to fly into NA stay under their respective travel
budgets, hotels in NYC or SF are going to cost a lot more than in some
small town outside a big airport. Something with more nature than
concrete would be nice.

But really, is Git Merge going to change its location on our whims? I
didn't realize we were that important :)

Maybe we can compromise on this whole ongoing NA v.s. Europe debate and
meet in Iceland :)

In Brussels I suggested in jest that we hold it in Junio's back
yard. The part that I'm serious about is that to the extent I have a
location preference it's that we warp it towards core contributors who
haven't been coming to these things, but otherwise would if the location
was different (no idea if that's the case in Junio's case...).
