Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098141F424
	for <e@80x24.org>; Tue, 10 Apr 2018 07:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeDJHSR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 03:18:17 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:37155 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeDJHSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 03:18:16 -0400
Received: by mail-qt0-f175.google.com with SMTP id w12so12174137qti.4
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RHaX44RKeWulYITcGS4jhc3rla0XjMG/WAxDc0lOfgg=;
        b=ALNNdCkURgf1zPgjMAalYJnuXLHdYpxHVfzoDTbe0YAVVFET55XVfz67KMZOX+JaOL
         9RgoCgBT5nfd4EhJwc7KiwA7Jaj5S2I5asDV+rYk9zNwV5IRZboKB0N09BsfMp1svSHM
         ngTOdc3Rw0GmK7Ka/7srPFQQ0GbHPBfMhrd0We4X7pvFkKQ3Wx1XhT/ohx9s16zpjU6A
         40atWj62X50lAboDpkcYXzhDCo0NHaf7PAybVtt4T13mGx+aMXa0XO9rl0ZuGAHzZZW8
         mWtBVduu3mJZJ7hybo7717jDmQN8CQsc5aEf3q1oux0pX61erbORZ+fWIZSoNtx4K7YI
         YgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RHaX44RKeWulYITcGS4jhc3rla0XjMG/WAxDc0lOfgg=;
        b=RYn9zx0Rh8kVAAhAj/l9wlHGy0goIiwZgwSR72xdReTUDP91zrx+TvE5R+R87uX4TC
         VczwH2oIZpY8PUrO2zX7vCg8fC+MlE3TkYoT5LBRKBTvFbkxWniE8I752JxQE7us3Mu5
         nrmMBQs1r289Su8XZsZL884JvBc8RXZ29ben45fRZjJXlzRbks8gFE2KFOrsNnyCr0YQ
         LdGEY6wQ1dRTFkNFN5MkITShQTRHHCZzmok7eg9Fagi0+2/whBI5l2bgbE9r5spiP33b
         KuWSkXCmUpSIRKUpr8rtSt239F2sBdwY4I/AkNYPX/Hfpd8uxSUEAPby+TAJ6hcsAWAB
         VEgw==
X-Gm-Message-State: ALQs6tDPLy7q53+0XZ8SaY4ZxKZM/19w0aS5isqHZXZzm3AgamFX8nZu
        jjpyl97+L9PP/7mXdr7vQUxyowMC
X-Google-Smtp-Source: AIpwx4+bg8ed3Gx0E82JNEBJFhtNhuBL+fg/pjz0asblFPTqp/pNUa1rWiWRAn7fFPcjcfhJnpas2A==
X-Received: by 10.200.115.11 with SMTP id x11mr28955074qto.290.1523344696216;
        Tue, 10 Apr 2018 00:18:16 -0700 (PDT)
Received: from [10.134.3.27] (50-241-99-157-static.hfc.comcastbusiness.net. [50.241.99.157])
        by smtp.gmail.com with ESMTPSA id c20sm1627471qke.38.2018.04.10.00.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 00:18:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] specify encoding for sed command
From:   Matt Coleman <cat.moleman@gmail.com>
In-Reply-To: <87605616vr.fsf@evledraar.gmail.com>
Date:   Tue, 10 Apr 2018 03:18:13 -0400
Cc:     Stephon Harris <theonestep4@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mao-Original-Outgoing-Id: 545037493.266098-f5fac9e2d486d1ab3044ca25fcc09417
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB5A1CE2-7844-4CB6-A03E-6AAC4EC13D66@gmail.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
 <87605616vr.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 1) What platform OS / version / sed version is this on?
I'm experiencing this on macOS Sierra (10.12.6). The issue occurs with =
the OS's native sed, which is FreeBSD sed so the version number is kind =
of ambiguous.

The error goes away if I set LANG=3DC or LC_ALL=3DC or change it to use =
GNU sed (installed via homebrew as gsed).

> 2) What's the output from "set" that's causing this error? Do we have =
an
>   isolated test case for that?
On my system, it's caused by whatever powerline is doing to Bash's PS1 =
variable:
$ set | grep ^PS1=3D | sed 's/foo/bar/'
sed: RE error: illegal byte sequence

I'm not sure exactly which character is bad here:
$ xxd <<<$PS1
00000000: 5c5b 1b5b 303b 3338 3b32 3b32 3535 3b32  \[.[0;38;2;255;2
00000010: 3535 3b32 3535 3b34 383b 323b 303b 3133  55;255;48;2;0;13
00000020: 353b 3137 353b 316d 5c5d c2a0 6d61 7474  5;175;1m\]..matt
00000030: c2a0 5c5b 1b5b 303b 3338 3b32 3b30 3b31  ..\[.[0;38;2;0;1
00000040: 3335 3b31 3735 3b34 383b 323b 3838 3b38  35;175;48;2;88;8
00000050: 383b 3838 3b32 326d 5c5d ee82 b0c2 a05c  8;88;22m\].....\
00000060: 5b1b 5b30 3b33 383b 323b 3230 383b 3230  [.[0;38;2;208;20
00000070: 383b 3230 383b 3438 3b32 3b38 383b 3838  8;208;48;2;88;88
00000080: 3b38 383b 316d 5c5d 7ec2 a05c 5b1b 5b30  ;88;1m\]~..\[.[0
00000090: 3b33 383b 323b 3133 383b 3133 383b 3133  ;38;2;138;138;13
000000a0: 383b 3438 3b32 3b38 383b 3838 3b38 383b  8;48;2;88;88;88;
000000b0: 3232 6d5c 5dee 82b1 c2a0 5c5b 1b5b 303b  22m\].....\[.[0;
000000c0: 3338 3b32 3b32 3038 3b32 3038 3b32 3038  38;2;208;208;208
000000d0: 3b34 383b 323b 3838 3b38 383b 3838 3b31  ;48;2;88;88;88;1
000000e0: 6d5c 5dc2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2  m\].............
000000f0: a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2  ................
00000100: a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2  ................
00000110: a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2  ................
00000120: a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2  ................
00000130: a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a0c2 a05c  ...............\
00000140: 5b1b 5b30 3b33 383b 323b 3438 3b34 383b  [.[0;38;2;48;48;
00000150: 3438 3b34 383b 323b 3838 3b38 383b 3838  48;48;2;88;88;88
00000160: 3b32 326d 5c5d c2a0 ee82 b25c 5b1b 5b30  ;22m\].....\[.[0
00000170: 3b33 383b 323b 3135 383b 3135 383b 3135  ;38;2;158;158;15
00000180: 383b 3438 3b32 3b34 383b 3438 3b34 386d  8;48;2;48;48;48m
00000190: 5c5d c2a0 3230 3138 2d30 342d 3130 5c5b  \]..2018-04-10\[
000001a0: 1b5b 303b 3338 3b32 3b39 383b 3938 3b39  .[0;38;2;98;98;9
000001b0: 383b 3438 3b32 3b34 383b 3438 3b34 383b  8;48;2;48;48;48;
000001c0: 3232 6d5c 5dc2 a0ee 82b3 5c5b 1b5b 303b  22m\].....\[.[0;
000001d0: 3338 3b32 3b32 3038 3b32 3038 3b32 3038  38;2;208;208;208
000001e0: 3b34 383b 323b 3438 3b34 383b 3438 3b31  ;48;2;48;48;48;1
000001f0: 6d5c 5dc2 a030 333a 3136 c2a0 5c5b 1b5b  m\]..03:16..\[.[
00000200: 306d 5c5d 205c 5b1b 5b30 3b33 383b 323b  0m\] \[.[0;38;2;
00000210: 3135 383b 3135 383b 3135 383b 3438 3b32  158;158;158;48;2
00000220: 3b34 383b 3438 3b34 386d 5c5d c2a0 c2a0  ;48;48;48m\]....
00000230: 5c5b 1b5b 303b 3338 3b32 3b34 383b 3438  \[.[0;38;2;48;48
00000240: 3b34 383b 3439 3b32 326d 5c5d ee82 b0c2  ;48;49;22m\]....
00000250: a05c 5b1b 5b30 6d5c 5d0a                 .\[.[0m\].=
