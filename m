Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5942207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942196AbcJFQSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:18:42 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33912 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcJFQSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:18:40 -0400
Received: by mail-qk0-f174.google.com with SMTP id f128so787862qkb.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uRxayUGP3Vpf8NrE/bQxplg8wUh17HnmNDC2APqx2h8=;
        b=rUR5yXaVxkflQKokGGmVkT5avgMj99BoVsh9G0c6aPgTYpuST/xLgjgtHv7eyG+tcN
         4B9otl4LhDsqxmasVCn8MbU4XwMfQ8VoBGPWY2Bmj+vvo9BFYUzXr5uYId9mWTYgwULK
         Q9v/lX8cxWh7tczqLSTOyQ/A7SFa6HH8ffnLu+MvxZn7hsGjuGRVPhg9EbEiH9XKonJn
         gIOldugayC+iBEg32dauxpYJoj5ysHLog+0IDmSgir8u2S89LyxcT2wIewuPMCJrrJLy
         mHgCUh2jI3k9BUw7lJ1Lsurf9FfdNNjhkW19mBZ5GdgeRLR0rDu0cwooSdNu5hnnjqqz
         6AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uRxayUGP3Vpf8NrE/bQxplg8wUh17HnmNDC2APqx2h8=;
        b=GDkRRYdVJwtedSx53uxTLjFM16UfIUvJvmg4Wgdtn0WBABoVCWKulY5UHjTeAHbA2U
         c6rvKl/NkSj3E5adheYU9/UNUiBiD76VjqX0QJHJOm2oZEtBWUovlVn/pMoPrmbRq3B0
         Be1y3DUfrJ2ecbFIKbYVG0LKfPvsZZ0eaLcB1wnVDrnnHITfd3Fkdc0R7O9MlUVrQSj+
         sKLdvGAoq1Ihq4jphazY/kV+dKqPywuNmCSjWjgPtwMl12+loA1/WMN8T11M9HeG8Tnd
         0kOE4y+K329RYco/lPVtSUzr6k6t9OlWexubaKOysjMjsIwS4+aeEXYXKaHbJ1HuQKh5
         PmMA==
X-Gm-Message-State: AA6/9Rl4L3ClSOZyktqOZMzllLaE3/HizYCcIkHU0oeDNIXwWy2jXtGRhxCm0CRs1XYFq3JowXt8W5NbflrV+w==
X-Received: by 10.55.77.201 with SMTP id a192mr16317400qkb.198.1475770719582;
 Thu, 06 Oct 2016 09:18:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Thu, 6 Oct 2016 09:18:18 -0700 (PDT)
In-Reply-To: <vpq1sztsmji.fsf@anie.imag.fr>
References: <20161006084905.14944-1-avarab@gmail.com> <vpq1sztsmji.fsf@anie.imag.fr>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 6 Oct 2016 18:18:18 +0200
Message-ID: <CACBZZX5ycZbFrrVgr4PVy5pKQDbnvmvDxuephx7-uHzzcm3u=g@mail.gmail.com>
Subject: Re: [PATCH] push: Re-include "push.default=tracking" in the documentation
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2016 at 2:13 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> That's bad, either we shouldn't support it at all, or we should
>> document what it does. This patch does the latter.
>
> I vaguely remember a similar discussion and probably even a patch in the
> past (maybe by you actually). I think the proposal was to add a mention
> of tracking but avoid promoting it at the same level as the others.
>
> I have a slight preference for a patch adding stg like "`tracking` is a
> deprecated alias supported only for backward compatibility" to the item
> of `upstream`, but I'm OK with the current patch too.

You're right! I wasn't trying to be sneaky here, but apparently I just
keep running into the same things. We talked about this back in 2012,
kicked off by you proposing a patch to remove it completely from
config.txt and me submitting this:
http://www.spinics.net/lists/git/msg198264.html

After some back & forth Junio ended up applying fa23348 to address
that, but that was wiped away just a few months later in 87a70e4.

I'd just like it mentioned in the docs in some way, because I *did*
run into exactly the situation I described in my E-Mail back in 2012,
i.e. found a repo with push.default=3Dtracking and couldn't find any
mention of what it did in the docs.

Junio, looks like from the 2013 discussion that you preferred just
having that mention in parenthesis instead of its own item, how about
just re-applying your fa23348 (with conflicts resolved)?

>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2344,6 +2344,10 @@ push.default::
>>    pushing to the same repository you would normally pull from
>>    (i.e. central workflow).
>>
>> +* `tracking` - Deprecated synonym for `upstream`, which we still
>> +  support for backwards compatibility with existing configuration
>> +  files.
>
> Nit: I think the doc normally doesn't use "we" this way (we =3D the Git
> developers or the Git tool). Hence my s/which we still support/still
> supported/ above.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
