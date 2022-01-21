Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60705C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 22:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiAUWh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 17:37:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:53967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbiAUWh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 17:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642804645;
        bh=0t2/lq3QSr4LAo9s/+fTz5PmIMYouCNbpLf3wtwm7mM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZGRSb/yIfZd5truqy19i6afIzKsNGazROTZ/WrVAlZujKRsH8lcewLp2PnmJVp0gu
         1/9rN2p0Dg39eD/ygOpwmKNojNf42J4Fjyn88MakxX8ZoprU45TadVxGIo9qVyRASJ
         QcqNZXoCoW+IUz6eOv7XIEpvkTJytUkOWtqSiqhE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1mdcfH04Ec-00gXHv; Fri, 21
 Jan 2022 23:37:25 +0100
Date:   Fri, 21 Jan 2022 23:37:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Newcomer] Suggestions for microprojects
In-Reply-To: <e176d1b3-482b-899b-af24-ac03c65d103d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201212330280.2121@tvgsbejvaqbjf.bet>
References: <e176d1b3-482b-899b-af24-ac03c65d103d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JVTmWKG+aZ9lkOIqVnrGJnzhva0+fXLpYrgAOCHsOKbNWvl0RT9
 pt48hh3+rVd6qaikkrYaAlymtaJPl0Xfb86DqHU9vdCZgVUgbJhEm66uiSVs5HoLOOnvT+/
 hi3Oe2JcwSk/E6X7SP6x1EddGAKm+CVBeJ8qDk9BODmyQd1CG4HDUGhqGx5zSRIm+U2U3kW
 XpXxW397uSHBrTyKo+Ddg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D1GsKogxsX4=:HGVcNIjo4DxbWXRhaKF3Cm
 FbncTff2qwSpOhIc9DAOxJLn5lFUZS09vGfx6xXTY48cElFhnXG76XlOZV6P6yPZY4JRg41zy
 jCBTQ60Vnmqs8joIiRfLguuBdALHYjZ543PeasI1bHMg5e9KmwQBvyLYiFMmUnMXju8igSSbo
 7kYkhsPKB9OwCOxLp3gfmVZYfEAMl+yQKKj/e0wIvYsgeEqmB63dF4oX2E5SMQqjbunk6300g
 BvDFBl//ZF54Epttn6AN5je2dPITMfysoozcLDiNDAe4pavsYa3x/+LZodLGyXOWsIcoA4kLa
 W8JldnaRb+fg2vyp6ApNW7uypjcuNJ82RHTKoWKpLkH3SJaCj4J9Yo1lFNLxqn69vXfkAbIUX
 Fv59mhKKfZIDm0gAPnXvBf4j1ZAos9EK8CmSePnWz54tz3/Nx20h1YVQse7EDglMm+ew5aIiz
 CkvsLUoBz4BwB7onW3TXz0ZrgdmQqDYHBWI0NelXuPCpcgRO0n+0hHg8tjRhr++lWaqXdw7tb
 h9eO1wyKshQbYs4YKbwjC5EJfVv9fbwgK1Ip4JOGKgz/tS7U5DSOEfXGXygDoptVsgGXS4g5l
 xRBW6NanpYbjbYtUPRdeba5A5Q5dp75lXco7RWot1s/1L/hY47tD9+W1pAbdulYy71ex9Jqyx
 Z0bxiPOnkzFBBCEl8HvlLehzUqnLO4CK8FiwwySYTG9JfiCDKS7o7MlFYN/PVQUazH8gRND+n
 ma12L5rKf+btzpHbt433e7crYmuD1SltqghNxk2At83arcd/D7fg0SBI8C54UL8ifT7W4zMZ+
 yrGd/JyrroFWjPOfzkoODbg3OMcDNEATJDvdur59+5Plv67CfP2v6j2fF0k+sV3xL8jaQwS8H
 aSbGYUfnGF/TTeqBfWxwBMcZCb03pj07CtHPCCZ3rNXgq9cpR6we/wdIoYSSAoXSu25+ccbNl
 KgB7jhK7BVu6KEseHHhvFWnjagpOOQ+Da0Mxj75Sk2u/+rx5mGiMcAiV/0cyDKtisJVEJFNjs
 oPZ+unFXXUpdAxYEg9saw2ebAyzU2lpHuKdd+e4Jl5Hr5Aq9JWWQFkaRlAetIhK0WdU4QNRdP
 6fo5+/AxnMQAOc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jaydeep,

welcome to the project!

On Mon, 17 Jan 2022, Jaydeep Das wrote:

> I want to starting contributing to the git project but can't decide
> where to start.

In general, I would recommend to pick a project that is of personal
interest to you. If you have used Git for more than a week, I am _certain_
that you found things you wish Git did better. That would be the kind of
project that I'd think would be ideal.

> I have read the coding-style and contributing guidelines stuff from the
> website and am eager to start writing code. Is there any small patches
> that I can make in the codebase that could help me get started with it?

There are two public bug trackers for the Git project, although I must
make clear that neither has been officially accepted by the Git project as
authoritative. The official bug tracker is the Git mailing list (which
lacks any tooling, of course, to find all reported and still unfixed
bugs). The two aforementioned bug trackers can be found here:

	https://github.com/gitgitgadget/git/issues

and

	https://crbug.com/git

If you want some easy project, I would suggest to look at the first bug
tracker because some tickets in there are labeled with "good first issue",
e.g. this one:

	https://github.com/gitgitgadget/git/issues/636

Ciao,
Johannes
