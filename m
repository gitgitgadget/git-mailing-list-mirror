Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE29521847
	for <e@80x24.org>; Wed,  2 May 2018 00:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeEBAI2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:08:28 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51587 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeEBAI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:08:27 -0400
Received: by mail-wm0-f47.google.com with SMTP id j4so19892718wme.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f2ClrTU6YyrYGa8H/TBdykgAEqe1+nqILOtc4oVjLAc=;
        b=RN3f3cyUBblSuOW7NKiXIaadkVT2a8NzBryvt9F/7k/pkAnhaS+9DBU0yoJEyqh1c6
         4LWaToG/EYxaW+NRVwc/om4/fcibgglGHPOVN9PVR3c/XxCU4EcX8NiWvS20Pdi2oaqy
         mJSml97UPB9jyLJRuafObnoZJMSBLTg/n4fdQId+lkj6wDz5vmlhszdhYLxt8qPkE4Ga
         gqVjSisrA93PZHI/hmQvHyrqafi2PEuMUS35C8ZlKoA51Jxpkxlb1SZyTzRp7VyZgQt5
         Ivc4gVWimdtqE6AEhDOSK1zUM2Y8Y904knKWTIxqJ3x9GdvpIiNTu7Jy4Dc7lYCj8Nos
         Wq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f2ClrTU6YyrYGa8H/TBdykgAEqe1+nqILOtc4oVjLAc=;
        b=CL0CgcSsA3fYbMavwyZaV/Q5D1YAu7T7mlT1aOdSvWcIyGO9Pe3RQmqkBazvIOmiTR
         fqeUG0daM1pJT8Wvc1FIVXEBVP6iOAWJ74rfBGC5gi7obhWytE1o1aQcx+f8Qo8vMhzX
         5kHZENhxdGYiR97tOsW4LnDeKkztmAGGJhQX5/xGEdcdvBYDLQ2clfqAbgvLC0/ReuHu
         HTMR2VmhrEaTo7SykezNavMvLQY7obFwOkeYcaYP2NKk3R8w/KW56AG6ytR0EwrRtbws
         GzrnnBhCovzJ9ZL53ORL4Gk3Ixy5nlm4MeDJ/d+sFYqzeJNQt/RbewDgqq0jsQomdj7n
         9ZPQ==
X-Gm-Message-State: ALQs6tAxwr7zrs4V1RnE9E79ccvoxO7785ShxmLBbeayzYhicmbn9j6B
        FYLpLnCyrSE0bL/vwVWpCWsC85GbVpZ3BOzY9Vo=
X-Google-Smtp-Source: AB8JxZrAU5HHSn2fPbWo4eqJf1/1kIdjPzlopUEhz/m6+68awlcEtAAzx75eYz0oKSb/dYrIH1PWaDsRH2Nh5flt6Io=
X-Received: by 2002:a50:da0c:: with SMTP id z12-v6mr7202078edj.62.1525219706612;
 Tue, 01 May 2018 17:08:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Tue, 1 May 2018 17:08:06 -0700 (PDT)
In-Reply-To: <xmqqh8nrx8m1.fsf@gitster-ct.c.googlers.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com> <20180501165931.25515-1-wink@saville.com>
 <87zi1jxjqn.fsf@evledraar.gmail.com> <CA+P7+xry-dE0-TMtRzNjiJpR1ZVmGXDy5ObfMxKyWA+eR8XMsQ@mail.gmail.com>
 <xmqqh8nrx8m1.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 1 May 2018 17:08:06 -0700
Message-ID: <CA+P7+xrPkMkt4zULuhEY-H9QHq8QE3gbkY-i+_HFk04W=vS29w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Wink Saville <wink@saville.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 4:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I also agree, I'd prefer if we aim for the mapping to be something
>> which works for all refs in the future, even if such support isn't
>> added now, which is why i've proposed using "refs/remote/<name>/" so
>> that a tag would go from
>>
>> refs/tags/v1.7
>>
>> to
>>
>> refs/remote/<name>/tags/v1.7
>>
>> Ideally, we could work to update "refs/remotes/<name>" to go to
>> "refs/remote/<name>/heads" as well.
>
> This is *not* imcompatible with having refs/remote-tags/* as an
> interim solution.

Sure. I'm just proposing that we pick a name that all the refs can move to now.

>
> We'll have to support refs/remotes/<name>/<branch> anyway long after
> we start using refs/remote/<name>/heads/<branch> by (1) switching
> the fetch refspecs newer "git clone" writes to the latter format,

Ofcourse we'll have to support this, and i didn't mean to imply we wouldn't.

I was just hoping to avoid having even more places to check in the future.

> and (2) extending the dwim table to try both formats.  Having Wink's
> solution as an interim step adds one more entry to (2) but the
> machinery is already there.  And it does not change (1), either.
>

Sure, we could. And yes, we have to do (1), which means we have to do
(2) anyways. But we can still pick something which is more easily
expandable than refs/remotes/<name> was.

Thanks,
Jake
