Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382DD1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeKVAmz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:42:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32856 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKVAmz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:42:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so3926159qtp.0
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=csbeLh5LJK7xeMBQpiz9My7EvnrhtCkfW051lrQHgPY=;
        b=flK1JZX7cLD9os+wgvCTzPkfL8Jyj3rfGpJMbTynTzJT0bEGNzdhMBEXbzMdIieH0O
         fEQRdI62KITyB9961hKAeNqXs7toX9TO4jcXQwSICfIjxELMoOa/qAPreeZcLWwEt7te
         BcQbbMya7qQvHycYrWU1yXNZqDDVF4nDYJ7Gxd1JPGGfWfvO3E3nREkdGVA8RgHo/S6g
         7MatrlLUjHYw+Jd3j00LU/g24nAfYk9hatze3tl6qjv45qhLVKxKSelRwxMFt36OLHfA
         eBwy3BgJ2lGCRuTkn1yuxhXqsbpFC11CyeGi0AVGkrCIlUWRnjf6ixEW47kt5VjbYSrK
         3hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=csbeLh5LJK7xeMBQpiz9My7EvnrhtCkfW051lrQHgPY=;
        b=Xooq6p0wPrr6M+tbNqgDxGoMajzDqPCBUSb9Z79LMDjl/PKdGZdh3nL1XTMGAK7L/k
         7xQBFjLcOFGP41U4I8Zkg/9JO+7NSGCFX450C72MDmYWff4MgguCJQ1ZxGLtzaiOTiWN
         WgDAaZK4mzoIMxBbYw9Z3hxuOUwaWOPHYN7NfXFetP0xfzk+erE9m+CGy8a+uIo4rgKX
         TRZ0KJruv0uw5E6s7gnaLCZG+J2CCreHEUbtDnxj3vmHiIj+4CoBSsWHHHEWbdA0Ck/e
         idZP5gvUiT6WQ/3F3cTAnrVo94+WhVHU3Hop4C01/en7nBaLx8aeAMPmygZ/rwYpmaQZ
         d4OA==
X-Gm-Message-State: AGRZ1gKQrMlYhxwN71j77rsPdY8s0DDqVugqRLCPRC1rbTAU9yao3oed
        P3gvNq2f7fkMKqfYBWZYoeC7QCwfUf9wpymEfjo=
X-Google-Smtp-Source: AJdET5f26TOrkVBXa9C3/WBdBcTtD4chNSY6zEfWM3QYxCIy4s0PhPW/bzJ4FhpkRQ9Zamgd+kmSw+gx4LFQAOWlP9o=
X-Received: by 2002:ac8:51d4:: with SMTP id d20mr6066377qtn.365.1542809300847;
 Wed, 21 Nov 2018 06:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20180927204049.GA2628@rigel> <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-3-nbelakovski@gmail.com> <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
 <20181112121423.GA3956@sigill.intra.peff.net> <20181112180549.ojt3twhsfm5xkako@rigel>
 <20181113144931.GC17454@sigill.intra.peff.net>
In-Reply-To: <20181113144931.GC17454@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 21 Nov 2018 15:07:54 +0100
Message-ID: <CAC05385gbR+_cuD+9NPgX+f9aOoRhxu4BHXU+hvtdO54excE4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] branch: Mark and colorize a branch differently if
 it is checked out in a linked worktree
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, I see 3 votes for cyan and 4-5 people participating in the thread,
so I'll make it cyan in the next revision.
On Tue, Nov 13, 2018 at 3:49 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 12, 2018 at 06:07:18PM +0000, Rafael Ascens=C3=A3o wrote:
>
> > On Mon, Nov 12, 2018 at 07:14:23AM -0500, Jeff King wrote:
> > > just adding a bunch of color variants. It would be nice if we could j=
ust
> > > do this with a run-time parse_color("bold red") or whatever, but we u=
se
> > > these as static initializers.
> >
> > I suggested those colors, but now, I think this needs to be
> > configurable.
>
> I think they are configurable in that patch, since it provides
> "worktree" as a n entry in color_branch_slots. But yeah, every color we
> add needs to be configurable, and this is really just about defaults.
>
> > I suggested using green and dim green as the obvious theoretical choice
> > but after using it for a while I found out that both shades are way too
> > similar, making it really hard to tell by glancing at the output,
> > especially when they're not side by side.
> >
> > If we continue with two dual green approach, current branch needs to be
> > at least bold. But I'm not sure if it's enough.
> >
> > I've been trying some other colors, and cyan feels neutral-ish.
>
> Yeah, cyan seems pretty reasonable to me.
>
> -Peff
