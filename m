Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9EA2022D
	for <e@80x24.org>; Sun, 26 Feb 2017 14:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbdBZONu (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 09:13:50 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33605 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbdBZONs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 09:13:48 -0500
Received: by mail-wr0-f171.google.com with SMTP id m5so18104176wrm.0
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+uCIi4x6jjPrqy9hmQhUghhxQuM9FM2d8XWno12D0g=;
        b=j4Y9ON1QS+I1nQgE8QMsxW6m26rBHrqbV/O2UWTPpyvq8Qr9TDuzoYTB9dkAE+PDKb
         UcGRXKpxBYUbq2KizKTBFdPcaoJkm4GfGQNqRqdsKgmOyPVJfrtxAzrs+du863rZX/Vj
         o7/0pgPABMO840qU7lEHhJh4sAj6OTX2vq0fq05X+unXp7DKZYgqu9QXbdzXWPzFpR2R
         QLTnQexWYLw9yC4SiYWyhJMi0w8ppy5Fz28p2fD8ZQJ8va5aGE84URcUpvjYuuvAJTMK
         MHq6eacO34ZVZPVPbhyz5a2qIsLstz3akaeEb441adDvqqN+yHJ2SKBert/EztSQzGLC
         aeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+uCIi4x6jjPrqy9hmQhUghhxQuM9FM2d8XWno12D0g=;
        b=P4lkXnxKNgZcqEBr0JnygvUd4sCOY40oh89mvwa1KfGnwFmdz4lE3vc8f/vbzibGXu
         ejvqAJPZgpBD0YRQWh7cLIveYqu0Y9twZbPyFj8BY4+JGajG6dalPbPhHLF6WEukKam+
         8lKWFnmXKqjHGEvWVa3Ah+UkAXQ/DHMPgK8SdYoX/Db2SRokvDdFmI863HfsX2pB7xJf
         Sz3NJD/KtuQlMUxxZsECz1FBK/pi2YX1kSVAWvO6YXJ03Mo0gz19ZBSNk+slJta2mqBM
         VBtNxWPcUZ7B4Y5jtDDEj/sDlc6pI2l5Fibk6cO/wjSnpRQrJ8xdFiWl9YqjWvSlgq6C
         Eu5w==
X-Gm-Message-State: AMke39mZFyTx2GnMKVFVDKZl+gfKjMFlMeUCOTGGNbiS5166d2/AzmRm0zhMoLbQDBrExA==
X-Received: by 10.223.139.220 with SMTP id w28mr11072189wra.172.1488118352302;
        Sun, 26 Feb 2017 06:12:32 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB7AEC.dip0.t-ipconnect.de. [93.219.122.236])
        by smtp.gmail.com with ESMTPSA id y1sm10345312wme.15.2017.02.26.06.12.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Feb 2017 06:12:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] travis-ci: run scan-build every time
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAJZjrdXg=jTXO+Dox9gTby-_JX+Lw_deihbUmbHe8V92dWJ0tg@mail.gmail.com>
Date:   Sun, 26 Feb 2017 15:12:30 +0100
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71030110-EB19-4F54-95F1-443D3EAE5286@gmail.com>
References: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com> <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com> <CAJZjrdXg=jTXO+Dox9gTby-_JX+Lw_deihbUmbHe8V92dWJ0tg@mail.gmail.com>
To:     Samuel Lijin <sxlijin@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Feb 2017, at 03:09, Samuel Lijin <sxlijin@gmail.com> wrote:
>=20
> On Sat, Feb 25, 2017 at 3:48 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 24 Feb 2017, at 18:29, Samuel Lijin <sxlijin@gmail.com> wrote:
>>>=20
>>> It's worth noting that there seems to be a weird issue with =
scan-build
>>> where it *will* generate a report for something locally, but won't =
do it
>>> on Travis. See [2] for an example where I have a C program with a
>>> very obvious memory leak but scan-build on Travis doesn't generate
>>> a report (despite complaining about it in stdout), even though it =
does
>>> on my local machine.
>>>=20
>>> [1] https://travis-ci.org/sxlijin/git/builds/204853233
>>> [2] =
https://travis-ci.org/sxlijin/travis-testing/jobs/205025319#L331-L342
>>=20
>> Scan-build stores the report in some temp folder. I assume you can't =
access
>> this folder on TravisCI. Try the scan-build option "-o =
scan-build-results"
>> to store the report in the local directory.
>=20
> That occurred to me, but I don't quite think that's the issue. I just
> noticed that on the repo I use to test build matrices, jobs 1-8 don't
> generate a report, but 9-14 and 19-20 do [1]. I don't think it's an
> issue with write permissions (scan-build complains much more vocally
> if that happens), but it doesn't seem to matter if the output dir is
> in the tmpfs [2] or a local directory [3].
>=20
> [1] https://travis-ci.org/sxlijin/travis-testing/builds/205054253
> [2] https://travis-ci.org/sxlijin/git/jobs/205028920#L1000
> [2] https://travis-ci.org/sxlijin/git/jobs/205411705#L998

Scan-build somehow replaces the compiler. My guess is that you=20
tell scan-build to substitute clang but "make" is really using=20
gcc or something? I reported something strange about the compilers
on TravisCI some time ago but I can't find it anymore. I think I=20
remember on OSX they always use clang even if you define gcc.=20
Maybe it makes sense to reach out to TravisCI support in case=20
this is a bug on their end?

Based on your work I tried the following and it seems to work:
https://travis-ci.org/larsxschneider/git/jobs/205507241
=
https://github.com/larsxschneider/git/commit/faf4ecfdca1a732459c1f93c33492=
8ee2826d490

- Lars=
