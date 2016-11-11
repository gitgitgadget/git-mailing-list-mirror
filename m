Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA422021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966024AbcKKJNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:13:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34071 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965988AbcKKJNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:13:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so8053493wme.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x/7Pn0pZFaFItzMmvl3uC3yGIqmN0qhugBpLRZGRw30=;
        b=zsb3oS0l2yuOIBRQiknBjMsYRJPuBFbVS+T74FaaupgN/GHtxynt2BwT2L6Yij0mYX
         yfZhrDMMYg8658JMcWTFfY+fhwQsw3ofsHlxzqH+XjwFK5Ar3NYgU5x9SjpQh+y6r7fi
         HiKTLSZt0E2h+5okNpd0abx6SM5gPObEBlZ+S0sVE/TX9OOsTdHBGhDQvmOJhHMFca1N
         MS7qdO8/+beikPUMjeNV/4DIBNfMhTTUhpYV8SoaVQ01ViOsB0+M3ma2j0UnlPM1zzp8
         7eDr+iwB3INQcw8tX91do+f0XKrv72U7o+2mWqCXDfFN/Mw1t0vCjrdZCWsCEpkskR8v
         Wq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x/7Pn0pZFaFItzMmvl3uC3yGIqmN0qhugBpLRZGRw30=;
        b=dL8BNrRuoKAKjfZ+qxbFY93AW/mXT1ZbqkQCSoXudeVcuSEDsqXR9WDSobfUMPB8IV
         d778YjzhbccUtn9n7kYotJzuVnlHeDap4uy416BhzdgzH9V3fkZLDV7lf4CA47bHWX5f
         UHGGeeKorT7UC1Sk9pOEtV/p6hBi2AANq8Wb9l/WsY746D/64kVogMbqqrKZNXZN0CVj
         0RRl//q7XLjBjLDICSFSvNfN2rSj7u7/NPo50vnoL1svlBP8D7Mv5I5/K0C3QLb+a6mz
         kf/xoLFY4VaSD6YZ0qGnPsYe+U16Bt68/J7Gk6716SL8zfIlBNK4nBw876Jgpnp+xapr
         NuWg==
X-Gm-Message-State: ABUngvcDwDiQVLf1thE3mJpiQPZ0ZNJP3WI3lv9kouniFJmbf9ErTzzulo+0YD0NdyrHMQ==
X-Received: by 10.194.31.167 with SMTP id b7mr9355001wji.168.1478855626961;
        Fri, 11 Nov 2016 01:13:46 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4736.dip0.t-ipconnect.de. [93.219.71.54])
        by smtp.gmail.com with ESMTPSA id d85sm17738288wmd.17.2016.11.11.01.13.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 01:13:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161111084725.jkdsdt4yslzsuh6d@sigill.intra.peff.net>
Date:   Fri, 11 Nov 2016 10:13:44 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>, hvoigt@hvoigt.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAB2E4AE-7241-4991-A993-A60DBA75092B@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-3-larsxschneider@gmail.com> <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com> <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net> <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com> <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net> <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com> <20161111084725.jkdsdt4yslzsuh6d@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11 Nov 2016, at 09:47, Jeff King <peff@peff.net> wrote:

> On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:
>=20
>> There would be an alternative way to approach the problem:
>> Someone (GitHub?, BitBucket?, GitLab?, ...) could setup a bunch of =
webservers
>> with popular configurations and a way to reset a clean test =
environment. Then=20
>> the TravisCI client tests could go against these servers.
>>=20
>> I realize that this idea is probably unrealistic because too much =
setup and
>> maintenance work would be required.
>=20
> Yeah, it seems like it adds a lot of complexity for little gain. Plus =
it
> creates a network dependency on running the tests. I know you care
> mostly about Travis, but I am much more interested in all of the =
people
> (developers and not) who run "make test" on their own platforms.
>=20
> If you did want to have a more real-world network-based test, I think
> the right solution is not for GitHub to set up a bunch of mock =
servers,
> but to design client-side tests that hit the _real_ GitHub (or GitLab,
> or whatever) and perform some basic operations. OTOH, people running
> "master" (or "next", etc) are doing that implicitly every day.

That is actually a neat idea. We could setup a test repo on each of the =
major=20
Git hosting sites and then the TravisCI run could clone a repo and push
changes to it. That shouldn't take long and would probably be a good =
real
world test.

The credentials of these repos could be stored encrypted in Travis CI =
[1].

Where would such a test repo live on github.com? On github.com/git or =
would
you prefer a separate organization? (no worries, I am not going to =
tackle this
anytime soon -- too many things in my backlog already).

BTW: I just noticed https://github.com/git/hello-world ... is this =
legitimate
or did someone hack github.com/git? :)

Cheers,
Lars


[1] =
https://docs.travis-ci.com/user/environment-variables/#Defining-encrypted-=
variables-in-.travis.yml

