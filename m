Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368BA208DC
	for <e@80x24.org>; Sat, 26 Aug 2017 10:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbdHZKQq (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 06:16:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35430 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdHZKQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 06:16:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id r133so2558370pgr.2
        for <git@vger.kernel.org>; Sat, 26 Aug 2017 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CdbxYFYmq+4JoQZn2EZSYeHxz0JQIWxik+6a25uiomc=;
        b=N3Qv49COvcBVRk0HY01/ykrn/It13smpFR2c6Vso7tzn2sTrSxlP+wLR0RkOUKs8m9
         OBz04+KPp0WxsCFM4sHWP1Hc1Vb7ox/jCzhnkSzqE6m1dSU3BEGuRFUUrxu+Ys7LBlL5
         jfRG6mwjwteIHsgmjfnDt7NdN352qs/5eG/QW09g/sXOSxpGQeOhSjuzaLMlNZwW84Ec
         AKie8lxVOsyTsgXWRYsZcJjOOrrIzdEE2rY4jY8J+iXEUYjSiVIOuZj+hQ+Tf6IvW2CD
         stQfD5lG6SlJGlJaY0xm1wmarC3ugMX2JjvMsPe20OrsYzb7kYPHCq8WeG3sAuYqsF7I
         PoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CdbxYFYmq+4JoQZn2EZSYeHxz0JQIWxik+6a25uiomc=;
        b=AKl/jqKRF7RWdVhLe5fcgvkHWIbToi3E3SHpY5+SGovIHvLoJL4EsiM6lVf2jN5YUH
         NR3Ag2ukLoUj8+bU8mjYe859cmJk4EuSzJnvHE/xwyflzEXDVGIOArNQ975l4d6tYLxY
         +EgOdFdVmW+IbB7dbiykvVtqq+ntlAEYlwCMWAfgFQ9UmM0a6SUdRrgsvp3ikkaxDmBj
         is2d4JWHzIJq2WzNvb681Gz2UI6bHSdJwSFr84SgD69YovHV7Bn1+LUCYZ/ZRQdy3TT/
         xMpGKZTslrH2XnFgbN6v4D1IqZiiUqhzXmMaYcUG6SD/mcr4xS4gDlirgbimdBsWYqzo
         8sjw==
X-Gm-Message-State: AHYfb5h9ijMs4zoMTpIepLuJC78qCqV23b+NBvmEPspY5No2yTDJ2IN3
        vKUFPUEKHOaf8ndy64CZgm0nKlgqjuB0
X-Received: by 10.84.215.216 with SMTP id g24mr1471449plj.273.1503742604981;
 Sat, 26 Aug 2017 03:16:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sat, 26 Aug 2017 03:16:44 -0700 (PDT)
In-Reply-To: <xmqq8ti7s6ph.fsf@gitster.mtv.corp.google.com>
References: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
 <xmqq8ti7s6ph.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 26 Aug 2017 12:16:44 +0200
Message-ID: <CAN0heSq8RdH5vWFgq1UvJOfWerMJSZwhV4FMCjvA=XUqu2OQQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/files-backend: duplicate strings added to affected_refnames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 August 2017 at 23:00, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> files_transaction_prepare() and the functions it calls add strings to a
>> string list without duplicating them, i.e., we keep the original raw
>> pointers we were given. That is "ok", since we keep them only for a
>> short-enough time, but we end up leaking some of them.
>
> Sorry, but I do not understand this statement.  If affected_refnames
> string list borrows strings from other structures who own them, and
> none of these strings are freed by clearing affected_refnames list,
> that is not "leaking"---we didn't acquire the ownership, so it is
> not our job to free them in the first place.  Among the original
> owners of strings we borrow from, some may not properly free, in
> which case that is a leak.
>
> What problem are you solving?

Sorry. Maybe this explains my intentions better:

    In lock_ref_for_update(), we populate a strbuf "referent" through
    lock_raw_ref(). If we don't have a symref, we don't use "referent"
    for anything (and it won't have allocated any memory). Otherwise, we
    hand over referent.buf to someone who uses it immediately
    (refs_read_ref_full) or to someone who holds on to the pointer
    (split_symref_update ends up adding it to a string list). Therefore,
    at the end of lock_ref_for_update() we can't unconditionally release
    the strbuf, so we end up leaking it.

    We could release the strbuf when we know that it's safe (possibly
    also only when we know that it's needed). Instead, in preparation
    for the next patch, make the string list not hold on to the raw
    pointers, i.e., make it duplicate the strings on insertion and
    manage its own resources.

Of course, the pointer-keeping and free-avoidance might be by design
and/or wanted, e.g., to avoid excessive mallocing and freeing. I admit
to not knowing what is a realistic number of iterations in the loop that
calls lock_ref_for_update, i.e., how severe this leak might be. Maybe
the "backend" nature of this code does not necessarily imply "this could
be called any number of times throughout the process' lifetime".
