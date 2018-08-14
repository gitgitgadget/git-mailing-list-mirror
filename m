Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720121F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeHNQxp (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 12:53:45 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36837 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbeHNQxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 12:53:45 -0400
Received: by mail-wr1-f50.google.com with SMTP id h9-v6so17355669wro.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=stvEY+aXyiVeEITm/+MKd2BtJHkjfxbQ0NU8cKEpIf4=;
        b=MiGsUZ5gwYZnO4oHqaiZCW9hDbuV6hDm5cjgKOroDDX0UT/WpXuyU9f1tK/Dv8t9j1
         WNtBtznZC2P1MVJbxu+ABv26pDH97jw2/gFMBwmL6ic1O97NiZ6/zE0lg7kreH4p5uHo
         GJhLxoqFidQcTnIup7QRxp7vTAm11IKWPfxOQeCNzuw6QKWPCp71BCoYgE6AkMHkwt4E
         v0QgeGgYW/ITb+w81GKWecCruZhFtSbOvTjGAly7kVp/PKb0swnKG7iUFmFV31P5eO2l
         5q2kp1X5bio5dXRsNVEGxWDcv7N4PKf6BiTSLXZDx5kNhgps7X3ZSOlgP+Br1umvBV6S
         +E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=stvEY+aXyiVeEITm/+MKd2BtJHkjfxbQ0NU8cKEpIf4=;
        b=bsruPW0r1HdFEmsASAVar9JIqVzhNnNM8c43KJuAfmyzk8A9Fq6FFWdt6Go5n7O9K+
         gRiquK3ly9EEdQxSDgJTp58XblpB5/EOYBEMeom4+OPaFenJ4j3Z9+9HyQpu/WM4kqBn
         XbVw9kd/t4qycGiU3tjP8o3J3u4NeOcecQr3SlFVX3CoNA6ckqvUS9MLWN4HC8kjKeKg
         nrAb2ZNxDXHBbju/CP2644Xo0wQt0eaSMRwkwdyTjLBaLQOYCC7TvFHCY4jHc2Xs823K
         OWsb5Id6T8TGwVCZxIc9c7TkMmPh79HljDaywiSG/AHukhd60SFgLLss6uiBdObH3szE
         oU6Q==
X-Gm-Message-State: AOUpUlE0jJ8LbIFTrKlCy15JfIBTjbUXbPDH159ssyrDMHGCVRWoYlgz
        YS2TrupC+NyEx+WPLJgLF1U=
X-Google-Smtp-Source: AA+uWPxSZzJVsCWP5r4KWFV+Evk80r8XRP5Nu496Cf01ocTt+mC1d7J7+aungRlMHLECQpclJDzq7g==
X-Received: by 2002:adf:fac1:: with SMTP id a1-v6mr13564666wrs.74.1534255585194;
        Tue, 14 Aug 2018 07:06:25 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id y206-v6sm13317241wmg.45.2018.08.14.07.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 07:06:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Elijah Newren' <newren@gmail.com>, 'Jeff King' <peff@peff.net>,
        'Git Mailing List' <git@vger.kernel.org>
Subject: Re: Contributor Summit planning
References: <20180813163108.GA6731@sigill.intra.peff.net> <CABPp-BHdoRobhF=avL+12rAJF=Qmp2vNHgwdqJxBPFs=EBm+Tw@mail.gmail.com> <000601d433d2$4f9b6600$eed23200$@nexbridge.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <000601d433d2$4f9b6600$eed23200$@nexbridge.com>
Date:   Tue, 14 Aug 2018 16:06:23 +0200
Message-ID: <878t59rqjk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 14 2018, Randall S. Becker wrote:

> On August 14, 2018 2:53 AM, Elijah Newren wrote:
>> On Mon, Aug 13, 2018 at 10:27 AM Jeff King <peff@peff.net> wrote:
>> >
>> > For the past several years, we've held a Git Contributor Summit as
>> > part of the Git Merge conference. I'd like to get opinions from the
>> > community to help plan future installments. Any feedback or opinion is
>> > welcome, but some obvious things to think about:
>> >
>> >   - where, when, and how often?
>> >
>> >     Plans are shaping up to have Git Merge 2019 in Brussels right after
>> >     FOSDEM in February (like it was two years ago), with a contributor
>> >     summit attached.
>> >
>> >     Are there people who would be more likely to attend a contributor
>> >     summit if it were held elsewhere (e.g., in North America, probably
>> >     in the Bay Area)? Are people interested in attending a separate
>> >     contributor summit not attached to the larger Git Merge (and if so,
>> >     is there any other event it might be worth connecting it with,
>> >     time-wise)?  Are people interested in going to two summits in a year
>> >     (e.g., Brussels in February, and then maybe some in North America
>> >     later in the year), or is that diminishing returns?
>>
>> Convincing my employer to send me to an event in North America is a lot
>> easier than one in Europe; they mostly allow me to work on git stuff as a side
>> project just to make me happy rather than as a business priority, so
>> competing business interests, shifting managers, etc. make things hard for
>> me to predict (so you may want to weight my preferences less than normal).
>>
>> My last manger did say they'd send me to the next contributor summit (I
>> think even if it ended up being in Europe rather than North America), but of
>> course, he was pulled to a different team a few months ago, so I'm not sure
>> if that still stands.
>>
>>
>> On a personal note, I'm also somewhat travel averse.  It'd be nice to go to a
>> Git conference again (last and only I went to was I think Git Together 2011),
>> but I know when it comes close to time to actually travel, I'll start
>> questioning my sanity when I said that -- particularly if it's far away or at all
>> complicated.  (So maybe you really ought to discount my preferences...)
>
> Unrelated directly to above, I noticed that I actually showed up on
> the list for 2018 based on git log anyway. Does this mean I'd be
> welcome? Personally, it's actually easier to get approval to travel to
> Brussels now than SFO even though the latter is closer. With that in
> mind, I can do either (or both - depending on scheduling).

I very much regret sending that 'git log' command without some further
explanation.

It was only meant as a *very* rough shortlist of people in the context
of a discussion of why some active contributors don't come to the
contributor summit. I.e. whether that's because of the location, timing
or whatever.

Any output from such a command definitely doesn't mean "you shouldn't
come to the contributor summit because this one-liner doesn't list
you".

I only meant to suggest that it would be interesting as a heuristic to
solicit feedback from people who *are* very active contributors to the
main git project who don't show up, to see why that is. Only because it
might be indicative of why some people who'd otherwise don't show up
don't show up.
