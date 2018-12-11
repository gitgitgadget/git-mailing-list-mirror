Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB314211B3
	for <e@80x24.org>; Tue, 11 Dec 2018 18:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeLKSzU (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 13:55:20 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:35140 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKSzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 13:55:20 -0500
Received: by mail-qt1-f180.google.com with SMTP id v11so17666910qtc.2
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7hGLII5/a7yUnujdKYgzjjFbBtsJz9WnqT/BVR9kfX8=;
        b=WidrK+uyS0tCd7aroHnqWzIqANcN5LCzRm44DgdufQBUsvTTkAStRgaWuTaT3zVKZ5
         We9l1p9J6p/K5xCUmmom8JKxsll7vjfDbZSGWNMFRhZZS+GgKSyJdFThCObrNGjGn4qL
         LI0ldzKaK5UowCjnTKZt18FHO/1SrCSWAo0SyBmndoutGJvVCLs0hm9PnwpzYIhE+hTR
         ltYLiCDKiCm4ZJ18keyZeuF1tZFpnFRE1PRQ03JT18/sb3p8s3Uni9aS7RilOrf3ZdAb
         MVyc/zd1gqErSZXiylo8wyBAKDwYbZS5M4XPVTfTItFusiGXHWSX+LJIuneUliRX2Wmf
         ibbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7hGLII5/a7yUnujdKYgzjjFbBtsJz9WnqT/BVR9kfX8=;
        b=iC3hW/MkJvWM6REz6wAwE76PrGriPDNE287C3IE8/IsvVeWR2Xy9B74GUCqLeKAjP0
         /MtGHEMM0/Ssg8NQ/4MyLQ4SCaFcxAzdH66i9wyU2BXpo3Ybh8ERlzXJwvzXUoFDOkEL
         EZcZwC2dHr1QtVaqq5Kt7jAVldoEjcK6iOpHp5OOJA9G1b3HWrk+UdpOjYITtTry7gQv
         IE76EQiA/kG3V2twrc+M0tO56KZXizpAhHhrz7VyWBJH66Nyl9EhcQ7AB4ojT8eHUI1E
         9qMNAbGfdU7TOxyVkpN11LrZEIPb7EcrPzgUUol4r7GMFkHAMYtnu6yOOmb8sfQsSCsp
         MTDQ==
X-Gm-Message-State: AA+aEWY6n63i/YPo1K5DdaQ/mH5qpXcuCW26zO26NN9wzMCAjb4ADaWV
        dwyVmZNEOXuA1h2knqARdBY=
X-Google-Smtp-Source: AFSGD/VVUt2UZmPVcLDe3Nev+hEpem6DGvge3aZ5iMKltI3itbkJBRHRcldChCZOonreGoYpr3QQwg==
X-Received: by 2002:aed:25a6:: with SMTP id x35mr17028661qtc.228.1544554518302;
        Tue, 11 Dec 2018 10:55:18 -0800 (PST)
Received: from dyn-160-39-175-48.dyn.columbia.edu (dyn-160-39-175-48.dyn.columbia.edu. [160.39.175.48])
        by smtp.gmail.com with ESMTPSA id z8sm7495571qto.45.2018.12.11.10.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:55:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Difficulty with parsing colorized diff output
From:   George King <george.w.king@gmail.com>
In-Reply-To: <EB1AF739-F97B-4905-9736-2A003722AD9A@gmail.com>
Date:   Tue, 11 Dec 2018 13:55:09 -0500
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A97DD550-BE35-43BA-A181-708B7D065F3F@gmail.com>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
 <20181208071634.GA18272@sigill.intra.peff.net>
 <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
 <20181211101742.GE31588@sigill.intra.peff.net>
 <871s6oni3a.fsf@evledraar.gmail.com>
 <EB1AF739-F97B-4905-9736-2A003722AD9A@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just noticed that while `wsErrorHighlight =3D none` fixes the problem =
of extra green codes for regular diff, it fails to have any effect =
during interactive `git add -p`.


> On 2018-12-11, at 11:41 AM, George King <george.w.king@gmail.com> =
wrote:
>=20
> I first started playing around with terminal colors about 5 years ago, =
and I recall learning the hard way that Apple Terminal at least behaves =
very strangely when you have background colors cross line boundaries: =
background colors disappeared when I scrolled lines back into view. I =
filed a bug thinking it couldn't be right and Apple closed it as =
behaving according to compatibility expectations. I never figured out =
whether they had misunderstood my report or if old terminals were just =
that crazy. Instead I decided that the safe thing to do was reset after =
every line. Perhaps some git author reached the same conclusion.
>=20
> =46rom the perspective of parsing this output, it is really much =
easier if each line can be understood without considering state of =
previous lines. If anything, I think it is a safe approach to ensuring =
that it renders correctly on various terminals as well.
>=20
>> On 2018-12-11, at 11:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>>=20
>>=20
>> On Tue, Dec 11 2018, Jeff King wrote:
>>=20
>>> On Mon, Dec 10, 2018 at 07:26:46PM -0800, Stefan Beller wrote:
>>>=20
>>>>> Context lines do have both. It's just that the default color for =
context
>>>>> lines is empty. ;)
>>>>=20
>>>> The content itself can contain color codes.
>>>>=20
>>>> Instead of unconditionally resetting each line, we could parse each
>>>> content line to determine if we actually have to reset the colors.
>>>=20
>>> Good point. I don't recall that being the motivation back when this
>>> behavior started, but it's a nice side effect (and the more recent =
line
>>> you mentioned in emit_line_0 certainly is doing it intentionally).
>>>=20
>>> That doesn't cover _other_ terminal codes, which could also make for
>>> confusing output, but I do think color codes are somewhat special. =
We
>>> generally send patches through "less -R", which will pass through =
the
>>> colors but show escaped versions of other codes.
>>=20
>> I wonder if optimizing this one way or the other matters for some
>> terminals. I.e. if we print out some huge diff of thousands of
>> consecutive "green" added lines is it faster/slower on some of them =
to
>> do one "begin green" and "reset" at the end, or is one line at a time
>> better, or doesn't it matter at all?
>=20

