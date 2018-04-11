Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D236B1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756101AbeDKUmR (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:42:17 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:40970 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756100AbeDKUmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:42:15 -0400
Received: by mail-qk0-f180.google.com with SMTP id s78so3451287qkl.8
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+isDruUwd70onp268UYiqEa4t3nROfT/gQHp8roi53I=;
        b=HsAErFEZDwtlPRx10BFn4laVGUg5vDEgXcUy8zJf7XOBwJMj92EISrPVRDdz8VTcgy
         wGbKIDDblWSzb1aqy1PnvAnU8Lysb3wtZTGxVSyiwJI0EpSU6T9zyTcbZ1XE37LGbIk6
         CMivEjU7aOEH9z7NBf3SFny3i1R8lF9S2A63UjdtRMp6ubEC1690/2Uv2Bp55MI6u7Y9
         OgFF+lm8aNQ1bSjbqRPESYpTlhQ0OCnHNTpDAfGlOvBVW0h9muTmmd0p+QY9dBzjbsir
         3J4BCLgIVYdOw158ecWemDOxhj5lk466UD/Oc4sO8islvA+ihSoqNEo0KxAqcKol0ggj
         9mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+isDruUwd70onp268UYiqEa4t3nROfT/gQHp8roi53I=;
        b=hIkVSFxg2MzR8FhXN2etEgnp94UnjV4nTEwPXnHADYhPmzrm1Q6NvKsojDQmsR1sLu
         w2HFRJQ63kOEhQAXCzMEWQLhbSCySdohf4ExAWV4CwM1yzdIQmTewuVDAKd8Jrv4YRrS
         31UDE0bNHNc+wW6O1XuceGAIm/43zGjL+eMsRXUQF5s3Ids+d0bMdAjt4HiNeDupaA9j
         docaVOZCMR9Es8M0AcYvrIe87o52PQ6XuYd6grnjrHQxu33scVZ0Q/WGxbeyiOfipmGK
         vJf83Gz+PhNLTqXeDe5TM1fjNwwNYZfRASWSnOrxsC5gRR+OIMc9ESgytMCe7XCbRMiO
         vTlA==
X-Gm-Message-State: ALQs6tCyA0BDzNK/8Prg3OAEK6aiZmYFK1CqJcIRcWy8XFJvOQt7yLfm
        BrxD0Ek8/q+kHcTqIn4lMkw=
X-Google-Smtp-Source: AIpwx48zhQwFvEmup1xUkQ7RLg62zTo7W3O8BjNNpQjdSu5R64v6cTDZxirM2ZdTkjTUSmtshB3Ybg==
X-Received: by 10.55.140.130 with SMTP id o124mr8711455qkd.187.1523479334865;
        Wed, 11 Apr 2018 13:42:14 -0700 (PDT)
Received: from [10.134.3.27] (50-241-99-157-static.hfc.comcastbusiness.net. [50.241.99.157])
        by smtp.gmail.com with ESMTPSA id o38sm1489382qko.82.2018.04.11.13.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 13:42:14 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] specify encoding for sed command
From:   Matt Coleman <cat.moleman@gmail.com>
In-Reply-To: <DB5A1CE2-7844-4CB6-A03E-6AAC4EC13D66@gmail.com>
Date:   Wed, 11 Apr 2018 16:42:11 -0400
Cc:     Stephon Harris <theonestep4@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mao-Original-Outgoing-Id: 545172131.460845-389c2ec53d32a26d9655c5cfccb57487
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FE7BFB6-769A-4F11-9C3B-86D681B3502F@gmail.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
 <87605616vr.fsf@evledraar.gmail.com>
 <DB5A1CE2-7844-4CB6-A03E-6AAC4EC13D66@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found another (possibly better) way to fix this:

> On Apr 10, 2018, at 3:18 AM, Matt Coleman <cat.moleman@gmail.com> =
wrote:
>=20
>> 1) What platform OS / version / sed version is this on?
> I'm experiencing this on macOS Sierra (10.12.6). The issue occurs with =
the OS's native sed, which is FreeBSD sed so the version number is kind =
of ambiguous.
>=20
> The error goes away if I set LANG=3DC or LC_ALL=3DC or change it to =
use GNU sed (installed via homebrew as gsed).

If I change it to use awk instead of sed, it works with mawk, gawk, and =
macOS awk:
unset $(set | awk -F '=3D' =
'/^__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*=3D/ {print $1}') =
2>/dev/null

I compared sed vs. awk on Linux and Mac and they all take about the same =
amount of time to run (within 0.002ms).=
