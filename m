Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFEF1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 13:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeHTQZJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 12:25:09 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:55061 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeHTQZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 12:25:08 -0400
Received: by mail-it0-f41.google.com with SMTP id s7-v6so20430520itb.4
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VXJnfiJVGxTc7vEIJ6JJIeLTyOpMGvIDk1OtL8PhwzY=;
        b=dWOUWC3CVpJ7nBbmUChgv7DxvebvkwR8LqjnUDhEHi+XUHi+0fsV9kQrrkwYBdWHME
         3Cy8LpRADBxzvpR5hRizBSCPdTKA3IyudFoOXMDb18ohsN12zVqiwNVQ5aH9umYkZz2b
         /VuUQfP4o1HAdNq+66LpVSDK6M7Ej/kGwm5uBb+kS6fV//tng2N2AhZNOND+z03/ENqY
         5IozEaUjuKHcbSA5fBOLgyYLJHwpDPO81OENVgqCoAS9ymL1asdvfz9PWOASruSlqYUb
         ixp5nczhTsBuA1X695qkRaPR9hKf+WEt0cFsJzk4kRztSd9kaoZpR94xBOpE/v3E93Rm
         KREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXJnfiJVGxTc7vEIJ6JJIeLTyOpMGvIDk1OtL8PhwzY=;
        b=BPj+ZkqSn4BsllShMXmlp1J9A2EqcR+5h0JCQ+3gRR1DNOjiiFOcRCL35TtpkZyO0a
         gw6ENaqV7F1Z+WtBYNNIk9rWWSJXRaZYj2mixFVh2Xus01lHY0sEF97YIXhEvPX5a7EN
         3f1qjtw1q1zwSAi5zik4ICGZ8NOvdUbZiJUz+YgIc8oaZ6vS4hJNJFfTmMBaT9ybpgRP
         sEkPqyY1etSN1Hq/JSgnbp0Q2vJaUCF0OGtEv0Lzrq460HHEcWUkBfIji/kr5UkECQB7
         jTC2tOKqpWKq91CYmCFiFYCmB21XrvBy4wf4cwlNHecUtKCxicuZAf/IplrCK+Xp9iWW
         NmnQ==
X-Gm-Message-State: AOUpUlEDgnbaA7+FOi0vBijHoI+K6EeCPk4YdGoY81HqQJggWwd20vc7
        H7cwn81sadJYWPg43zYLupNsMI1H5Zx0DGckTEQL4aYN
X-Google-Smtp-Source: AA+uWPy5yoZr6cG3OhkBviM2HqLVy5tbL7/gPEgILU+YuB2/og6u2AjtiUzl+EOucvIviqa08L8/fW+4I4K8bDZDJxU=
X-Received: by 2002:a24:70b:: with SMTP id f11-v6mr12948724itf.137.1534770572977;
 Mon, 20 Aug 2018 06:09:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d3:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 06:09:32
 -0700 (PDT)
In-Reply-To: <20180816224138.GA15490@sigill.intra.peff.net>
References: <20180816224138.GA15490@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Aug 2018 15:09:32 +0200
Message-ID: <CAP8UFD3agHbDuDtjs7SsOaLx5A6vZ=HUxkCWYTwTSw1x5Zvbyw@mail.gmail.com>
Subject: Re: Git Project Leadership Committee
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 12:41 AM, Jeff King <peff@peff.net> wrote:

> So here are the nominations I came up with. If you'd like to nominate
> somebody else (or yourself!), please do. If you have opinions, let me
> know (public or private, as you prefer).
>
>  - Christian Couder
>  - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

Thanks for nominating both!

> Both are active, have been around a long time, and have taken part in
> non-code activities and governance discussions. My understanding is that
> Christian freelances on Git, which doesn't quite fit my "volunteer
> representative" request, but I think contracting on Git is its own
> interesting perspective to represent (and certainly he spent many years
> on the volunteer side).

Yeah, I am freelancing since October 2015 mostly for GitLab,
Booking.com and Protocol Labs as can be seen on my LinkedIn profile:

https://www.linkedin.com/in/christian-couder-569a731/

I feel lucky to be considered mostly like a regular employee
especially by GitLab and Protocol Labs. Both of these companies employ
a high ratio of remote developers from around the world, who often
have some kind of freelance legal status, so they give them as much as
possible the same kind of perks or incentives (like stock options) as
regular employees.

GitLab is a very open and transparent company. The way it works is
described in details in its Handbook
(https://about.gitlab.com/handbook/). Its informal policy regarding
Git has been to use regular released versions of Git in GitLab. If
possible GitLab should use a recent version of Git to benefit from the
latest improvements, though it should be compatible with old versions
of Git, as this can be useful for example to people who want to build
GitLab from source on top of a regular Linux distro that comes with an
old Git.

So for GitLab my work on Git has to be integrated upstream. I have
been working on remote odb related things, which I haven't managed to
get merged yet, and on a few other small things like delta islands for
which things have been going better so far.

I also do some Git support at GitLab (for Git users, GitLab
developers, customers, sales people, ...). I am sponsored by them to
participate in or give presentations at conferences (like FOSSASIA
2017, GSoC Mentor Summit, Bloomberg Hackathon, Git Merge, GitLab
Summit, ...). And sometimes I do other marketing, security, developer
relations or sales (like meeting a few French customers) related
things.

=C3=86var already talked in details about Booking.com and my work for them.

I have been working much less for Protocol Labs than for GitLab or
Booking.com since I started working for GitLab around 2 years ago.

As with Git I had started working on my free time on IPFS
(https://ipfs.io/) before I became a freelance working on it. So for
Protocol Labs I have been using Sharness
(https://github.com/chriscool/sharness/, which was created in 2011 by
extracting t/test-lib.sh from Git) to add and maintain end to end
tests to go-IPFS and other IPFS related projects.

Around one year ago Protocol Labs made a successful ICO (Initial Coin
Offering) for Filecoin (https://filecoin.io/) and since then things
have become a bit more like in a regular company (which is not
necessarily bad).

I have also had a few consulting contracts from various French
companies for a few days each about consulting or teaching Git/GitLab.
