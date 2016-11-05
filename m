Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3E82047A
	for <e@80x24.org>; Sat,  5 Nov 2016 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbcKEV4S (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 17:56:18 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33901 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbcKEV4R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 17:56:17 -0400
Received: by mail-lf0-f41.google.com with SMTP id o141so16000981lff.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2016 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sg8zoSdA3qeNho+YA8tkWsfT3AmB60NzLDN03onytrA=;
        b=zn0xpCi9yfHT5uLm+0J8W9KpqcO1MgsNz+pHMIdhE01uGPaKjuFf8vPFQU8URMwhG6
         wyDj+X9fyp4hRnolAU9SYisSk8GFjwm5EB36Fw+6mShkiIqDPKHk3i0kkdBO5BGlNUHm
         /N/dXQoyIR01/s9Qr+JLI8SwcJTV2jM17mnJTaQ6l5yfYU9ZaXq79+mD9lMzhbVh1gA2
         Pk8Q8wx3ilUNCS/VAdHQDt8KgQDFM1EJWqI1eOz0rY2Ru/yjt4Ng9PXmDHm0XDMWAAzV
         867G9tSDXO1FFwdeROCVAmGXrP13AaFaMzdg4jtm62KrAxA8ehaDoNYtdQ3I1RwmkjlX
         0yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sg8zoSdA3qeNho+YA8tkWsfT3AmB60NzLDN03onytrA=;
        b=mct07mq3tw3mg5l+dd9dufD3LuxSyZQE0cIUXwvhhPUasPrArmL5CJD1YLRP69mgMe
         nZEnFqnYq35ByfbQOszcuI3xh6n2VOvmQg7qoNuKwYX0l0egQGwJBCy/ugFvEDDNCLHA
         mDgZnVdZJT1QRxM6vgdA4iuPvmW7EY+s1EG7ovUL76XAMkhK/NjZ5y6BRWz9Awm5UDmf
         Sspo7t4MTVknmUfQbVK6kI0EtBu6W6OIB9HM15AOW23vt8bMtKiy7yKM7cDqGMB1BWTN
         rUR8jH5xdn2+ggyflbJspSOR6LQXshkDYTOnNNTGlcDRwn6EVDtwo1xcbhdsP1dKcY7Y
         5LJA==
X-Gm-Message-State: ABUngvdKK4/wkDMhYyi/xSqM10/Dxm10ZQExKGka6il/65wNj/N/z6Bnt1cLN6Ywwq0fEdKDbnKLyUBQWvd4qw==
X-Received: by 10.25.93.84 with SMTP id p20mr4358258lfj.151.1478382974836;
 Sat, 05 Nov 2016 14:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 5 Nov 2016 14:56:14 -0700 (PDT)
In-Reply-To: <20161104211959.3532uiud27nhumt7@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <20161104211959.3532uiud27nhumt7@x>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 22:56:14 +0100
Message-ID: <CAP8UFD1ipYZNHcWRoX8XwTjpQ4=P+fgwRB5gtbovjU3Gddf8Og@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 10:19 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Fri, Nov 04, 2016 at 09:47:41PM +0100, Christian Couder wrote:
>> On Fri, Nov 4, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > Imagine we invent a new tree entry type, "gitref", that is similar
>> > to "gitlink" in that it can record a commit object name in a tree,
>> > but unlike "gitlink" it does imply reachability.  And you do not add
>> > phony parents to your commit object.  A tree that has "gitref"s in
>> > it is about annotating the commits in the same repository (e.g. the
>> > tree references two commits, "base" and "tip", to point into a slice
>> > of the main history).  And it is perfectly sensible for such a
>> > pointer to imply reachability---after all it serves different
>> > purposes from "gitlink".
>>
>> The more I think about this (and also about how to limit ref
>> advertisements as recently discussed in
>> https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/),
>> the more I think about Shawn's RefTree:
>>
>> https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/

Just to make things clear, after reading the above link that I posted :-) ...

>> Couldn't a RefTree be used to store refs that point to the base
>> commit, the tip commit and the blob that contains the cover letter,
>> and maybe also a ref pointing to the RefTree of the previous version
>> of the series?
>
> That's really interesting!  The Software Heritage project is working on
> something similar, because they want to store all the refs as part of
> their data model as well.  I'll point them to the reftree work.
>
> If upstream git supported RefTree, I could potentially use that for
> git-series.  However, I do want a commit message and history for the
> series itself, and using refs in the reftree to refer to the parents
> seems like abusing reftree to recreate commits, in a reversal of the
> hack of using commit parents as a reftree. :)
>
> What if, rather than storing a hash reference to a reftree as a single
> reference and replacing it with no history, a reftree could be
> referenced from a commit and have history?  (That would also allow
> tagging a version of the reftree.)

... I think that indeed that's what Shawn's reftree proposal is about,
so I agree that it makes sense.

We just need to find a good way to specify object reachability.
