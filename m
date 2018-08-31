Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521EC1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 08:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeHaNAp (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 09:00:45 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:39840 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeHaNAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 09:00:45 -0400
Received: by mail-it0-f49.google.com with SMTP id h1-v6so6255694itj.4
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VPrrJmQzovUkd9/Y2eM5cpDeCXhbUhNy/S5mAyr2O78=;
        b=TLBZcEG+HQC9yt7IErj1MjE+OsqjcqUf/ZuzA9k8QrvQXltniubBlTF28K6tbF/0wF
         IoO3I9sWMWVDkAOBh08xsQd1u/n6jfpdF5cFS+W89AQ0dPcvlypDb1ZmZ7S88DO6DO+h
         OzzSYAitSzO7ewfh4BXWc/jOJuIKLKTs8YLpp2LHxNA4I67b50alNJqH09u5/H4mI7fE
         vtV5znF3khSWM5B1Aa2/PGrORuE5CdfV2PjoYcFnlZhQajdZyTxzwxUmcRjO9JSM6W5Q
         5sZE8F+zSmI++Tz15wic2IRsXgcvDHiPsl3pYox7C0L9aO6F4Ngv9ciccGoCrgCecqss
         yF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VPrrJmQzovUkd9/Y2eM5cpDeCXhbUhNy/S5mAyr2O78=;
        b=dJ9LjEeNsfQRq7RHx+9gWYzzzGTo6LO3TlSSM/C5Q5dXgRB2LvTqCykkQnUCXJC9km
         oGPI1UwOCojT2fe4xLc25AIpvzrvzXRnEgLSLfs42djgNVc3R6WCPWxCwMnlP9wOYTt9
         uByMGO6VUs2L3UImEg/gSCBrycBTvQ74cUh/qcF0SwkLKcjJYsXSbVJjI83dHd/Sak3u
         ozTKXNBfJ9bBXPpJO9WhteybJZ5VyuAOesAIiIHVH++EAX1O7hgwskjY6EE99fptas7r
         rnOW8cEl35AqwPx9/nEL4iutTJlbhNRFlfYmPSG3yo2RzMNzriFDsTdGtpDk90M2XMlt
         RP2g==
X-Gm-Message-State: APzg51BwztzXP7sde97P2uKO8R5hnn6piagXazGBGvBWTmFKqmVDs3y5
        a2viiIiad1TvwnqziXx/VqvpSX7D61MU/cHgJr0=
X-Google-Smtp-Source: ANB0Vdb6k0gscHzH41NGTzLYQzYKb56lj+Fw1bmsOE6YGz7J+cwo88qBPxvvT3LbtemvqfuvWr4iSXj+FTz+nk8ZUHQ=
X-Received: by 2002:a24:45a4:: with SMTP id c36-v6mr4304313itd.145.1535705658214;
 Fri, 31 Aug 2018 01:54:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 01:54:17
 -0700 (PDT)
In-Reply-To: <20180830192453.GC19685@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <8736uxe2pm.fsf@evledraar.gmail.com>
 <20180830031607.GB665@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
 <20180830192453.GC19685@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Aug 2018 10:54:17 +0200
Message-ID: <CAP8UFD0AnS1Zp2QdqtLTqBrsUiogODC_apG-vumxRuoijW=r4A@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 9:24 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 30, 2018 at 01:46:00PM +0200, Johannes Schindelin wrote:
>
>> I am willing to mentor, and the only reason that kept me from already
>> stepping forward and trying to brush up the landing page is this concern:
>> traditionally, we (as in: the core Git contributors) have been less than
>> successful in attracting and retaining contributors from under-represented
>> groups. I don't think any regular reader of this mailing list can deny
>> that.
>>
>> And while I find it very important to reach out (there are just *so* many
>> benefits to having a more diverse team), I have to ask *why* we are so
>> unsuccessful. As long as we do not even know the answer to that, is it
>> even worth pursuing Outreachy?
>>
>> I mean, if we make serious mistakes here, without even realizing, that
>> directly lead to being stuck in our old bubble, then we are prone to
>> simply repeat those mistakes over and over and over again. And that would
>> just be a waste of our time, *and* a big de-motivator for the Outreachy
>> students.
>>
>> What's your take on this?
>
> My feeling is that our lack of diversity has less to do with driving out
> diverse candidates, and more that they do not join in the first place.

I agree with that.

> Which isn't to say we _wouldn't_ drive out diversity, but that I'm not
> sure we have very good data on what happens in that second stage.

Maybe we could ask Olga in CC what we could do better?

> If we
> can use the program to overcome "step 1", that helps us get that data
> (and hopefully react to it in time to be useful, and not just use the
> candidate as a guinea pig; I agree there is the possibility of doing
> more harm than good to a student who becomes de-motivated).

I agree.

> That leaves aside the question of whether things we are doing prevent
> people from participating in the first place. I'm certainly open to that
> idea, but I think it's a separate discussion.

Yeah, I think there is a lot we could do to improve in this area and
it would help.
