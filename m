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
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCB11F404
	for <e@80x24.org>; Wed,  5 Sep 2018 13:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIERxl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 13:53:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54198 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeIERxk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 13:53:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so7995709wme.3
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h1+xjnaIYhWrbZWDn1G4EbJvtYAF5A8SSmHC5XDeLPU=;
        b=rz/qFtJnznkfE711b9g8I/OBdEP/F9KueHYqMDMT41C5F7CZUk7BnfPbM1jCNnc9qD
         gfyuMvkyM/FiAMn/ZfLu3IJ3E3JzCyxzTmcqGX4QGGD0YGuXlRx3EDhnyclM+C58OPrq
         pxKynrSafbwEi1dWKoI5458TD+v/xu8hehYswKMwh41l9Qpk/sJayepHPihZ/lIRtWg2
         r8Gfd1oZNSkxRgYl8ZSVp6b7X0zb1nw0O95cLrFfACUcwQlKZRKv/F0rnWN9KRRQPy6U
         qzrbQagP8eKH0qeAY8puZEj5mriCjq2uD14Z2lLEDY4cJ78wTUaPtZy4izdLV9gq5Prf
         AVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=h1+xjnaIYhWrbZWDn1G4EbJvtYAF5A8SSmHC5XDeLPU=;
        b=R4O+Xw4RWVeORuLxiRx4KQ7KGNlrLEf/4v9ZIcut3EiR9gJr3GcoGjdolSMKTSVXSX
         vovT+oYkYMiWObhJyU0Q4wriGTEeu3ACRoAWxdZ/V10va4zZI3smWx0OrGd42T5A9+Gd
         mUML1o6d7PDhIBUbFs+DpA8fceQsBYlohodwv7/0wxPLMsZwsiZLjNnHrVjSc+kGrD9a
         USYYpKDZmYKM3dqbXqTZJMXar5wv1mo25LVRbNo7YFdbTWcsZ9H9sVhqpxDo1GEFCTh/
         ZQDHSIHHa+hwvtXCpqTgQsLf+SM3x57e2jm6kZWTYUJW7cFF57rVh6SRjVzxmW9gEYul
         J2lg==
X-Gm-Message-State: APzg51Ac8HzWFv3Qq70xp1G4k4WlI7QZkJ+6f+49LKXikIqCodVoKJmQ
        qodqnJ7SxYATCbUomZkYXzg48IJKz6g=
X-Google-Smtp-Source: ANB0VdYZGinyk3z2aUoqlmPxoqfSP4IAqve18oQiZzWeoQX+q0rGrWZbkAdwcffVpMAiaOfiV5oOfQ==
X-Received: by 2002:a1c:938a:: with SMTP id v132-v6mr257396wmd.114.1536153803516;
        Wed, 05 Sep 2018 06:23:23 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2571371wmd.32.2018.09.05.06.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 06:23:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
References: <20180828151419.GA17467@sigill.intra.peff.net>
        <8736uxe2pm.fsf@evledraar.gmail.com>
        <20180830031607.GB665@sigill.intra.peff.net>
        <87sh2wcak4.fsf@evledraar.gmail.com>
        <20180830194223.GD19685@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180830194223.GD19685@sigill.intra.peff.net>
Date:   Wed, 05 Sep 2018 15:23:21 +0200
Message-ID: <874lf4rsc6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Jeff King wrote:

> On Thu, Aug 30, 2018 at 02:18:19PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> >   - it naturally limits the candidate pool to under-represented groups
>> >     (which is the whole point of the program, but if you don't
>> >     actually care about that, then it's just a complication)
>>
>> I'm fine with doing selection discrimination of under-represented groups
>> through such a program. Particularly if, as you mention, there's
>> earmarked funding for it which otherwise might not be available, so it's
>> not zero-sum when it comes to a hypothetical alternative of casting a
>> wider net of our own (and as you mention, that would be more work).
>
> Yeah, just for reference, my "you" there was a hypothetical "one might
> or might not care about...", not responding to your particular email.
>
>> I do think it's unfortunate that the selection criteria for the program
>> privileges U.S. citizens and U.S. residents above other people,
>> particularly since they're also accepting worldwide candidates (and
>> we've had at least one non-American participant that I know about), so
>> it's not e.g. for U.S. administrative or tax reasons as one might expect
>> if they only accepted Americans.
>
> I assume you mean this bit from the eligibility rules:
>
>   You must meet one of the following criteria:
>     - You live any where in the world and you identify as a woman (cis
>       or trans), trans man, or genderqueer person (including genderfluid
>       or genderfree).
>     - You live in the United States or you are a U.S. national or
>>       permanent resident living abroad, AND you are a person of any
>       gender who is Black/African American, Hispanic/Latin@, Native
>       American/American Indian, Alaska Native, Native Hawaiian, or
>       Pacific Islander
>
> So there are more categories for the US, but I think that is largely
> because under-representation is somewhat regional. Being black in the US
> is different than being black in Africa. Certainly one could argue that
> Africa as a whole is under-represented in the tech world, but I think
> you'd probably need to draw different boundaries in different places if
> you want to extend opportunities to those who are least likely to
> already have them.
>
> I don't know what those groupings would look like in, say, Europe. If
> you're suggesting that the program would be better off having
> region-specific rules for more regions, I'd certainly agree with that. I
> don't know if it's something the Outreachy folks have considered or
> discussed; it might be worth bringing it up.

[I don't mean to drag this up again, I had a draft here that I hadn't
sent, and thought given that I'm standing for the Git Project Leadership
Committee which presumably has something to say about this it was better
if I clarified].

I don't mean that just doing the equivalent of s/U.S. national//g on the
criteria would improve things, for the reasons you explained that
clearly wouldn't be an improvement or in the spirit of the criteria.

I was imagining that there was some way to phrase this that would
include the current group(s) but be country-neutral. E.g. instead of
talking about some specific minorities in specific countries say that if
you're in a group below such-and-such a percentage.

Although reading this again and consulting Wikipedia they seem to be
using all U.S. census groups below 20% with the exception of one (two if
you count "Other"), so I don't know how that would translate to other
countries, or if that's just an unintentional omission. Perhaps some mix
of group + mean income within that group? I don't know, and I'm not
familiar enough with the U.S. to speculate as to how they came up with
that.

Or, just a third criteria of:

    Projects can opt-in to consider non-U.S. nationals or residents who
    they believe fulfill the spirit of criteria #2 as it would apply to
    another country.

Then we could (if Outreachy approves) opt-in to that, since considering
that on a case-by-case basis is surely less gnarly than trying to come
up with some general rule.

So again, I don't think this particular thing is a big deal, or
something worth spending time worrying about at this point. Just
something to keep an eye out for and potentially gently poke Outreachy
about.

I just think we might stand to get better/more candidates and have more
fair process, and be seen to spend project funds in a less biased way if
the criteria wasn't an OR'd statement whose second half starts off by
outright limiting itself to less than 5% of the world population based
on a specific nationality, before further narrowing things down.

