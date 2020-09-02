Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E0C433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3272087C
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 08:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gxqyVNyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIBIum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:50:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:41831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBIuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 04:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599036631;
        bh=v82v5OL3+8Z8ERs8Vfc7mRxFlKmva+rulav2a0kE+OM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gxqyVNycpy8X/mOkZary7cJpakNcYFkUrXm0LqI11+I9bYYOYHgsPlGHcNb/rmVTf
         9k0pyRFZMRz/xHmutgyr2i99/a5lR1u5FNnAVE8tq/l7QMOTDIbmLhp/+kHrmszIge
         ICZEtQ/ReTwgOflL8f81z33/2cv9a03Zsfmxj5do=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.253]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1kNr0H1kV8-00FxEh; Wed, 02
 Sep 2020 10:50:31 +0200
Date:   Wed, 2 Sep 2020 06:00:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git in Outreachy?
In-Reply-To: <20200828065609.GA2105118@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lq6XBnDEt6nw0lAEzmcNQByGFDvx6n0Uh4HtTUqyvK9iTIyHGYH
 2dJwQJt/2Xkm9A34AO+PB6X2V410HwHKZ4nZsVZYGHLA+WfgYXE5fjEwp7Gg0m9g/v0hroS
 PrJ3zpVKFV7rlAipg/u20zpcdplIuZHZ2uAPEtZ43sxPbGv7QZGIv8AmbxcWar1ABu7HYdV
 /8CoMcVQfwk6ROPsPyzeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zLjAlP112xw=:RA6eRzlIeR5mytqRj3ro20
 kpDjS1U4XqAEt00w/IFzwrYKYRrswzGFG7m6N4y6QhGDpG7hFxa/J3cP0KPye9vLLHnFEv7TZ
 T+Mdu8M3MJ8DGApA0/Rzn2vKWpGuNbxeBtH9BRoSWtSE4ysHsr2pT818PGv1OKm2Dmo2Mnme/
 PVglULWZJe9rLfk1ADeEGvP0wjFTOpCJ2EECEpGoRsufftPxgO9UkJWJ858O2/Vj8Jd5eobF2
 M/hXcGLJ032iU9yGJ/Ll7YO+kXxsBoUEpbarx8gMQ2Ex5nEmng2opQtMeJnAgyTflj5HnIv6u
 7R3cf63lqsrU8A3j9rkmC1ey/4brNp43JQ0Ilq1U19uZTqt5IQpz5ZN2SW0dImI2HtU+LUoHy
 9OaOKJMC2kAHBquGGgRso1ZqOAyMzSUmqAy/MSQGtXao//6LyU7X3SfjhT4qKgJkdLn2fNK+H
 5Cn1gflTZH0Af0bLaUft8AcfBOBEeOqHprZcNTD3lc0jek5VworMb4r9QHLjsMmoNa3d0rtNy
 WyCuDi1MEAVRrikfTbNR64yehHkzpsk8gVSyCb5wFqvJJaAxrnZ3InwMn5xpuBhkIu9nzM4uv
 9/1oZ1AMz9yALjceX/ukYUHvUnDptE+tXdz8OzktCx0BqJ2HW71pZVCc18prJXBx5KDGi379d
 s1WxiVftJa/nCFN7CqfLuWfvqp1yEN+EnAaqAi1IXPN9FwKaOT4fYc1QWO9TldrP3Is+CkbWM
 4lsqBZdTSDuzhYiPqmvYdX7Dou3OHe1PZB8c0uNv6nS1+kQkZmd9g0WKN9OTjOtEARkEMV9g9
 Hki+AvT6YhPAtbGt2j/0yzDdEfR9i/LJK6J7fH9yg7qnuWifP+qbY32KVP8IaGE7+Uf/OT3Ju
 pWU0XHeHqCqmD9tQE6y/nUiZvLcTxpYd0mrCReAsmUMoesBgYM/skd3kSRKDl0uNbtfRsQZDP
 Wf1rlAhuarZlt8+DWo73HCpqdU7I9et9W7cZnchAo2WBtMjFwnL3A+3BcyZiBPEIxIyO4pZ9e
 jUVAj+muDF8m+HhpuM6tH34Qz5pkF568hs1rFPomn+vaM7aY3k9/JjibPnYu2OvUe4FSvKxZ7
 4xylyqCc7rbn21qnbt4sATRLCln8xdutv+okvXeTyyCKN1xpCeMPEm7NU+C6u4JAhI7Uc0f6X
 Wd82lLC7JxJewGkzR5roDsnbq6+LnX6vO/hANQGo8uZ+ff6NcpXau7Od2zqMMam3jpfEFdxD1
 vHss3uMo4G/5mzNXdCJJq/s/4oZ56oexgsuiFOQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 28 Aug 2020, Jeff King wrote:

> Are we interested in participating in the December 2020 round of
> Outreachy? The community application period is now open.
>
> I can look into lining up funding, but we'd also need:
>
>   - volunteers to act as mentors
>
>   - updates to our applicant materials (proposed projects, but also
>     microproject / patch suggestions)

Thank you for thinking of me! While I am eager to help, I think I won't be
able to commit to a full term, though.

As to projects, I would like to believe that
https://github.com/gitgitgadget/git/issues has grown into a useful
resource.

Ciao,
Dscho
