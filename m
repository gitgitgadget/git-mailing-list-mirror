Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132BA1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeFHIN1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 04:13:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40096 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeFHINX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 04:13:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so1947047wmc.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jVnNwqD6MPQ1AlKrgDl0oUevM3Fkykyx8RGMRYS27DI=;
        b=gS/h09jMG2BZ7r4Cf3XbteSNvyN4c38nlAAbMUe/aZfSfL1axVrf2fSvl+GPNKR9kR
         jsKdtRqnUGRZaNmmv7sMOACRSsyP2x+XvMX9XDI52+lfHpu8jZz44IobGXWcKM5e+q61
         KP0rF/5DPS1LkzPuSUZim94aU1uz/i31IWUTZsWa/otjzUJuHkMl2DKo8+wjIdFthCUb
         jM33cr3cXBI/olO+fTaohStLo0W/PPNfpCyfNd5kY5iIWpHIJd+WJMnGE1D5dypL4Tst
         aqm2xmNX4TEcLjy0rWTEx63DMDToxeRo7cRk/2i5xzkoq4BiQzH7bD5gpebcA5wgmGZQ
         qJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jVnNwqD6MPQ1AlKrgDl0oUevM3Fkykyx8RGMRYS27DI=;
        b=dIuWGKp8jWk/aQNdEB8oGLs1MTzofmJdx1wcNxhhMw7VSezIIIdVGlCd5HieP5NdGU
         Bn9J3JBFhas39N2Ihxu6amoYY+OmkzBIgnt16o0IPgBrOrCiV4Yjy1afzjr5uAlRuvIf
         CxYzTUavqSKrcU1vxkTxupPPWrgkO0eMM/iuDAG/v8bp7HeqyBmizVdDmYtGucZxwMQp
         culwsQoBcl5l9vThW9hSPkOMpvKJSPGCMpjc6mYsUM8REUsEKVt7QExSZh3i8jR+a5t1
         iVeEdFvtkeBn+ZuRYTXj+R5Q/8BZqCIVH0GIW8R6aYbvhNiwyVmtBDtfc3DO2UBJOQgh
         sd8g==
X-Gm-Message-State: APt69E1/pnmOJ0HrsIzkIuc7PTZeICVjut9jE8T2cmOeE90BN736Ake5
        g5gb7T16G5zxqv3WJ3PS3oY=
X-Google-Smtp-Source: ADUXVKL+18y92JjlInmyWBzIf8XovN0MEA/Zt/a+Q2sUaTis3dBSNfyqv8v2OZcKtR1kDW2xtw4u3w==
X-Received: by 2002:a50:8783:: with SMTP id a3-v6mr6144246eda.34.1528445602361;
        Fri, 08 Jun 2018 01:13:22 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id x2-v6sm10013388edr.24.2018.06.08.01.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 01:13:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, David Lang <david@lang.hm>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
References: <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
        <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
        <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
        <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
        <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
        <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
        <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
        <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
        <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
        <20180608025313.GA12749@thunk.org>
        <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
Date:   Fri, 08 Jun 2018 10:13:20 +0200
Message-ID: <8736xxzof3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 08 2018, Peter Backes wrote:

> On Thu, Jun 07, 2018 at 10:53:13PM -0400, Theodore Y. Ts'o wrote:
>> The problem is you've left undefined who is "you"?  With an open
>> source project, anyone who has contributed to open source project has
>> a copyright interest.  That hobbyist in German who submitted a patch?
>> They have a copyright interest.  That US Company based in Redmond,
>> Washington?  They own a copyright interest.  Huawei in China?  They
>> have a copyright interest.
>>
>> So there is no "privately".  And "you" numbers in the thousands and
>> thousands of copyright holders of portions of the open source code.
>
> Of course there is "privately". Every single one of those who have the
> author information can keep it, privately, for themselves. But those
> that have received a request to be forgotten must not keep publishing
> it on the Internet for download or distribute it to others.

Can you walk us through how anyone would be expected to fork (as create
a new project, not the github-ism) existing projects under such a
regiment?

E.g. in git.git we have SOB lines for the whole history, in lieu of
GNU-style copyright assignment (which is how things mainly worked back
in the CVS days) someone can just clone the repository and create a
hostile fork, which is one of the central ideas of free software.

In the world you're describing the history would have been expunged
publicly, and no hosting site would be willing to host it. It might be
gone in practical terms to anyone who just doesn't like how (in this
example) the Git project is run, and thinks they can do it better.

Maybe (again, in this example) the Software Freedom Conservancy's scope
would have to expand to retain this private history (right now they have
nothing to do with copyright).

But then how am I going to fork the Git project if the SFC decides they
don't want to cooperate with me?

As David Lang notes upthread, "the license is granted to the world, so
the world has an interest in it". I wouldn't be so sure that this line
of argument wouldn't work.
