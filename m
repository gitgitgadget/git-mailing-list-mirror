Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830B81FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 18:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbcGLSjE (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 14:39:04 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35950 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcGLSjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 14:39:03 -0400
Received: by mail-io0-f170.google.com with SMTP id b62so24784615iod.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 11:39:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NmgoalUxJFRTV6G+Uhrj+nexJMYvJ5FdymvKWG3VcPY=;
        b=yKV6L8alYUYGRuj5YvCcjxn3cuW4I0FvB8cGe9LUL85K/mHXU3Ijgqn7lX5bMjW3Bs
         l5bCAquJPulgAbRdltlD4ppv/YcreHj331N7Sbh8KTgPAtc41hj7LhBjWaUwb6sF8pIP
         4hD2oXW91GA/rSwJHnWLs3r5Qj9Df39h44MB63mzdavRP7Ue6N9vLbL/mJMHuoUxCmi4
         2f0F/QlJFBX0d7sVgTsHV2zQpMR/eHwi989m/WxdF86VJLF5mn77ME0qv7gD23HxWkIg
         wZf79nLzGGo7cENvmFtcFYHYm/VhobRsn/hbLauAyBBoTyB2Cpa90OYCf5Aszbr1TlOk
         BGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NmgoalUxJFRTV6G+Uhrj+nexJMYvJ5FdymvKWG3VcPY=;
        b=D7d3kxaAMYO41L6VBqinO1g9Bb8oeGHgmV0PAsOZnJ153R2QpezlkXzwYjo78kN9uM
         aSzGflM0AEIsMXlSEItXqAdMqwTYYEaxWpJL+yzgpgCCTE8r/Ewzt+ClvZ8hE4YHU4gz
         cb0peXFFoScGJE3HU7110TiWU4k4RSI3CreA0CJKqTPmKGBzUYs2l9ZeTTvPtqG0xYdh
         ti+Wi0z466LKWqAi95lT8GNhZdsRjf/tufayB7Z1u1X5Qyt0Hls0mioHFlhxA2DDmHiC
         5VfLhUfKo9G+8e4vfQ5SfKpUQGZVVjmM8NoNUUgSrU2YPW6h+lG8KvGpQG21HFnooTU9
         Ijig==
X-Gm-Message-State: ALyK8tLOQXJlg6/gxGyVEbZxD6F9aFbteg0RD/cVnYLB0yLu6rEMdDsC2B8vgPygpWpR9f5j0FyFotc0yjuLuw==
X-Received: by 10.107.8.140 with SMTP id h12mr4647767ioi.95.1468348741672;
 Tue, 12 Jul 2016 11:39:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 11:38:32 -0700 (PDT)
In-Reply-To: <20160712134652.GA613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox> <mvmtwfve22e.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121249390.6426@virtualbox> <mvmh9bvdnae.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121520310.6426@virtualbox> <mvmd1mjdluz.fsf@hawking.suse.de>
 <20160712134652.GA613@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 20:38:32 +0200
Message-ID: <CACsJy8CBGcKyMh9nbCAjZ=0T8TpoY9m98YJtgPFhQztVRPvXhg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.9.1
To:	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 12, 2016 at 03:31:00PM +0200, Andreas Schwab wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Hi Andreas,
>> >
>> > On Tue, 12 Jul 2016, Andreas Schwab wrote:
>> >
>> >> Johannes Schindelin <schindelin@wisc.edu> writes:
>> >>
>> >> >> PRIuMAX isn't compatible with time_t.
>> >> >
>> >> > That statement is wrong.
>> >>
>> >> No, it isn't.  PRIuMAX is for uintmax_t, and time_t is not uintmax_t
>> >> (even if they happen to have the same representation).
>> >
>> > Sigh.
>> >
>> > So if it is wrong, what is right?
>>
>> The right thing is to add a cast, of course.
>
> In general, I think the right cast for time_t should be to (intmax_t),
> and the formatting string should be PRIdMAX (which, as an aside, needs
> an entry in git-compat-util.h).

Coincidentally, I have the same problem with unsigned long being
32-bit and have to switch to off_t in some places. Does anybody know
what a fallback in git-compat-util for PRIdMAX would look like? I
guess it's "lld"...
-- 
Duy
