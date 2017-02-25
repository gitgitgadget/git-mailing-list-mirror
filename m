Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150EA201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 23:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdBYXLX (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 18:11:23 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38523 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdBYXLW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 18:11:22 -0500
Received: by mail-wm0-f46.google.com with SMTP id r141so38281816wmg.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G5jeqluO6AMJj3JrOUn4FckENNygiHfVEf+WWlt8MNU=;
        b=pKv0ZIch0yGNwtjFceFB6nmxQNdJn7i2TYVq4ocWEAnFRbiQZo1EUUGJ3lO4UL3Jw3
         t6fdeYnB4Dr8ntc0dhNqn5t7G8q8rngxa2P4AgISKFxqT+NBvRblgFSPm+Dwmqlv+mGt
         QG9Mlhj9nr//Ec3ekkAqeq3q6CGRsN2kkuI/IbsENFs2HT9qfAi5GR2iXo3izIFLr9Zv
         +T9OiX+wGwysGVXfHqnF8jgpG/201OJBQJKqLgNy7gAxzIqAS4m4LU+rcgphyW7djceW
         ceLJ00TgKbEE8bB3b381lvkbPo+CvSkHnfcqckzH0tPSWznYa/9CbvQjiTa8iPCXJx9r
         ah6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G5jeqluO6AMJj3JrOUn4FckENNygiHfVEf+WWlt8MNU=;
        b=PXb9YmSJQFNwgNHFU618gj0b8OoMrYAB45+DKQUQkfJDqokOrLDR2pIJz5Xre7sfcA
         TPL0I3DwEby+sER1pyVZ1g47AdxZgdHhCoJITZSZinj3XDZBfoAumLKAaHKS0JbP7ada
         Hx8i17EOpQwCkLoat+GpqqmuGCLf8s6cmIjgzwbZw7olXTAdePsbzsrjXPcEWEnfVL70
         u1vrmfzevDjjUYzpc66gT2zw6PgEiiVNfWx5TqeCqMqYqMavm5aC7shEM9P56dt8UBrC
         HywFu4KTVF9zFZ/kicOCfltXcP1rDBTEmBYLqEu7oqK7EmxSlE/koGKrmqKZKAm32q5/
         fcEA==
X-Gm-Message-State: AMke39kbVLk85RRTA60PiP1aQQAwXKZN5pDGVexz1vyExI+VWXj92ntx35O+PZBclCkrpA==
X-Received: by 10.28.154.7 with SMTP id c7mr4762950wme.119.1488063755078;
        Sat, 25 Feb 2017 15:02:35 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB48D9.dip0.t-ipconnect.de. [93.219.72.217])
        by smtp.gmail.com with ESMTPSA id j80sm8039733wmd.14.2017.02.25.15.02.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Feb 2017 15:02:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] travis-ci: run scan-build every time
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170225223146.ixubnwqkfol5q2gn@sigill.intra.peff.net>
Date:   Sun, 26 Feb 2017 00:02:33 +0100
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70DA368F-97FB-4492-811D-CCDF4F237939@gmail.com>
References: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com> <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com> <20170225223146.ixubnwqkfol5q2gn@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Feb 2017, at 23:31, Jeff King <peff@peff.net> wrote:
>=20
> On Sat, Feb 25, 2017 at 10:48:52PM +0100, Lars Schneider wrote:
>=20
>>=20
>>> On 24 Feb 2017, at 18:29, Samuel Lijin <sxlijin@gmail.com> wrote:
>>>=20
>>> Introduces the scan-build static code analysis tool from the Clang
>>> project to all Travis CI builds. Installs clang (since scan-build
>>> needs clang as a dependency) to make this possible (on macOS, also
>>> updates PATH to allow scan-build to be invoked without referencing =
the
>>> full path).
>>=20
>> This is a pretty neat idea. However, I think this should become a
>> dedicated job in a TravisCI build (similar to the Documentation job =
[1])
>> because:
>> a) We don't want to build and test a scan-build version of Git (AFAIK
>>    scan-build kind of proxies the compiler to do its job - I don't if
>>    this has any side effects)
>> b) We don't want to slow down the other builds
>> c) It should be enough to run scan-build once on Linux per build
>=20
> Yeah. I am all for static analysis, but I agree it should be its own
> job. Especially as it can be quite noisy with false positives (and I
> really think before any static analysis is useful we need to figure =
out
> a way to suppress the false positives, so that we can see the signal =
in
> the noise).
>=20
> Fully a third of the problem cases found are dead assignments or
> increments. I looked at a few, and I think the right strategy is to =
tell
> the tool "no really, our code is fine". For instance, it complains
> about:
>=20
>  argc =3D parse_options(argc, argv, ...);
>=20
> when argc is not used again later. Sure, that assignment is doing
> nothing. But from a maintainability perspective, I'd much rather have =
a
> dead assignment (that the compiler is free to remove) then for =
somebody
> to later add a loop like:
>=20
>  for (i =3D 0; i < argc; i++)
>          something(argv[i]);
>=20
> which will read past the end of the rearranged argv (and probably
> _wouldn't_ be caught by static analysis, because the hidden dependency
> between argc and argv is buried inside the parse_options() call).
>=20
> So there is definitely some bug-fixing to be done, but I think there =
is
> also some work in figuring out how to suppress these useless reports.

That makes sense. I suspected that this assignment was intentional
but I wasn't sure why. I didn't know about the rearrangement of argv.

Apparently an "(void)argc;" silences this warning. Would that be too
ugly to bear? :-)


> Turning off the dead-assignment checker is one option, but I actually
> think it _could_ produce useful results. It just isn't in these cases.
> So I'd much rather if we can somehow suppress the specific callsites.
>=20
>> I ran scan-build on the current master and it detected 72 potential =
bugs [2].=20
>> I looked through a few of them and they seem to be legitimate. If the =
list agrees
>> that running scan-build is a useful thing and that these problems =
should be fixed
>> then we could:
>>=20
>> (1) Add scan-build check to Travis CI but only print errors as =
warning
>> (2) Fix the 72 existing bugs over time
>> (3) Turn scan-build warnings into errors
>=20
> If they are warnings socked away in a Travis CI job that nobody looks
> out, then I doubt anybody is going to bother fixing them.
>=20
> Not that step (1) hurts necessarily, but I don't think it's really =
doing
> anything until step (2) is finished.

Agreed.


- Lars=
