Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDB820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLKQl2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:41:28 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:32801 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKQl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 11:41:28 -0500
Received: by mail-qt1-f179.google.com with SMTP id l11so17144268qtp.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 08:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/ttoQn9aux6fU176z6OTzVHO1v3/y+fQ+KByFv7xzi0=;
        b=mcrK2SkIObiWbZIivuPw0+jEP7nYsDsofSO+QHdk1QzIxgJmE5syuG/2bKUYOqdf1M
         EGU2x448OpZrv4zDctd+8k6MfFuAVFmdvGwnpYkl9BJpUDHLTo59VYVPLguDi9O+Hwbd
         9kMOfkWPgTaWWHDDyQQSMtGbL4R+LH4QYKtCEzwgnTTCHctyLOxWW0n84Unkq6AlDqyj
         RkRN9AYA2AmWjdN2sBCHWaM9Fkw9YssN7krMflJHT9yZuFlNGLZv+xBpbdyNMJQC02W6
         9lSf9ACwg8jhgmsme5qp3yyn0CkN92ZuZ/uN+Uc3XPLcxAGqjis4QfgGK2ar2fklbeGp
         TNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/ttoQn9aux6fU176z6OTzVHO1v3/y+fQ+KByFv7xzi0=;
        b=tlK+xRuEEzUInx5muctLdbabr/gwIyUALfpnvEvne/2IB/af7d6E+TaAd7Y/3TWLas
         c4A71vs4N4+NGMWWGw//LIEHN5v2HElGrNU/I7rCffU4VXfTjf0SVDkipgFaEQYdBjHz
         qNhCfWsPb+QYmdpxO1c0GR6brzpBZOo31voLYLFBecbXv9D3JuT0NEwt07E63h1qstjc
         JUIGxXI4LD6LT7GUrBFuwM6Jj/PVGtnIMZfI+Z6PsHT0Zl6R606iHgRhhJVUW4J2lPEX
         YnyD8DIrRqKd/zPQb04bvNMRyHDIx2svMPL6vuG2MRnmqNRkEF6UaB7VnifSwt0FBK7y
         lyaw==
X-Gm-Message-State: AA+aEWY4ThUN5J2wVi3lrRBkLXQHCI4c7HaDanM5ntOYWCGAbYNicXy+
        Z4Ujy8Lp3bcCglw6v8pdYiY=
X-Google-Smtp-Source: AFSGD/WtJyhcm7iR0zwbsTOCgLy3Bxt9cmM/30Rxq253/ekeGnLjje2HcvWuGQv8diA2HFWC5NCnCQ==
X-Received: by 2002:a0c:afd1:: with SMTP id t17mr16027205qvc.93.1544546486804;
        Tue, 11 Dec 2018 08:41:26 -0800 (PST)
Received: from dyn-160-39-175-48.dyn.columbia.edu (dyn-160-39-175-48.dyn.columbia.edu. [160.39.175.48])
        by smtp.gmail.com with ESMTPSA id r67sm11627764qkr.28.2018.12.11.08.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:41:25 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Difficulty with parsing colorized diff output
From:   George King <george.w.king@gmail.com>
In-Reply-To: <871s6oni3a.fsf@evledraar.gmail.com>
Date:   Tue, 11 Dec 2018 11:41:18 -0500
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB1AF739-F97B-4905-9736-2A003722AD9A@gmail.com>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
 <20181208071634.GA18272@sigill.intra.peff.net>
 <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
 <20181211101742.GE31588@sigill.intra.peff.net>
 <871s6oni3a.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I first started playing around with terminal colors about 5 years ago, =
and I recall learning the hard way that Apple Terminal at least behaves =
very strangely when you have background colors cross line boundaries: =
background colors disappeared when I scrolled lines back into view. I =
filed a bug thinking it couldn't be right and Apple closed it as =
behaving according to compatibility expectations. I never figured out =
whether they had misunderstood my report or if old terminals were just =
that crazy. Instead I decided that the safe thing to do was reset after =
every line. Perhaps some git author reached the same conclusion.

=46rom the perspective of parsing this output, it is really much easier =
if each line can be understood without considering state of previous =
lines. If anything, I think it is a safe approach to ensuring that it =
renders correctly on various terminals as well.

> On 2018-12-11, at 11:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Tue, Dec 11 2018, Jeff King wrote:
>=20
>> On Mon, Dec 10, 2018 at 07:26:46PM -0800, Stefan Beller wrote:
>>=20
>>>> Context lines do have both. It's just that the default color for =
context
>>>> lines is empty. ;)
>>>=20
>>> The content itself can contain color codes.
>>>=20
>>> Instead of unconditionally resetting each line, we could parse each
>>> content line to determine if we actually have to reset the colors.
>>=20
>> Good point. I don't recall that being the motivation back when this
>> behavior started, but it's a nice side effect (and the more recent =
line
>> you mentioned in emit_line_0 certainly is doing it intentionally).
>>=20
>> That doesn't cover _other_ terminal codes, which could also make for
>> confusing output, but I do think color codes are somewhat special. We
>> generally send patches through "less -R", which will pass through the
>> colors but show escaped versions of other codes.
>=20
> I wonder if optimizing this one way or the other matters for some
> terminals. I.e. if we print out some huge diff of thousands of
> consecutive "green" added lines is it faster/slower on some of them to
> do one "begin green" and "reset" at the end, or is one line at a time
> better, or doesn't it matter at all?

