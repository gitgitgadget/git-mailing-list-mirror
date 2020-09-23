Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3352EC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51CF2376E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AoolVXMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWU1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:27:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:55137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIWU1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 16:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600892840;
        bh=HgzSEBgo5MVHJdLxpigOnvi/f45MxdBdxfy4lb8Crg4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AoolVXMSLiw4ESLclSguiD6b7yPtvl7jkRoqYke0KD8gxRvvmueUvPm/XVeJ8Jhj+
         faR5cF+SM8IbFTjvPbh6O/Ksqzz2F6ysaUc5LFn1AbJ4xxEgQHuG+k+5UsuqoFSs5N
         FtQJ3hpYSltzKHjZwSUncmgDzZV8SaF5TQezCD/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1kn43G1nGU-00pJku; Wed, 23
 Sep 2020 22:27:20 +0200
Date:   Wed, 23 Sep 2020 22:27:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <xmqqr1qsjxgb.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com> <xmqqtuvwoyz5.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet> <xmqqft7fnlxr.fsf@gitster.c.googlers.com> <20200918155015.GA1837@danh.dev>
 <xmqq7dsrnjhi.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet> <xmqqr1qsjxgb.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:12TPPUzu5UzBLNOy9n0HmuYiNnmhRQ4jhjkRF/nWqu7laf6h7Jh
 9FUwXtenlfm0fVppI6DPor0nRJFoNb4ZLXzHpSM2LzaHRjwy+wiiWgFBFPbN5jDl2epJ1xo
 AtOI5W+yv2SR6nv1FB4TG4CRyl+8G8Kgm8dqdl85OIwa1vIWlLK/U6if+cnaIbxe3JWf8KL
 lrzveSqY22pX0+GNOD6UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUG65+NBHVI=:fT4rieaK8n1p86sT8HfVW1
 7+qbrarzIrUXglZ+mYo7KwFoN13DN7Rcmbb1Q50VSNVpYtS+u/14EMhZOcXNXc8Z5Rx2XJBjC
 vTBop95u68AG4A/zS24EsQOOaoD7GPlTH8zr5rrsNqxljBpEcB/YVanIx33A/SJS7vTWlOfnw
 BQgqN6Vmml1HB2eN2G2UAdOLo74qTJmG/5Y6ELk83MJ4SxdXJapfsJCxg4sitFyDLWXneYd3P
 14WJJ8oKiUmraFqulBTc9286nIf9xW/quvgRDDv2dHMRa2FjLn8aWiJ4GGSK3txhiZWVnROQJ
 tWy0uJTfZlg42WCysKL5ofDTwfzoL8bCkx2naApborwWWEPDvgbBuaPIsowp+jnPIWE3bqZPN
 xCEf5bWVhJSUku579dDz+hblRBeUoF5MhizCVAs+dLSY1+z1BPiHGHm9WQykW1JeCQhTH602O
 d9Y25dX4TaUuud3M7qnjy7Z5nSCRictL17J5W3FYODWZyhINjeeOt2JrdLEMYlO4LGcXk14PP
 O5rcCQTy7ZKyboSR/EqCajlcH8KdSqhMO8v3iq+jImoJ7OsxTrlXEmqu5yNKB7JAwQrw0ct6K
 gkNz5gBpv+1tVewLYAEeCdzffEtYdpFdj1zj0UFuiyOElLE9bE5l21LXEViNPwo2AmgB3lWR0
 ipcUemMZim/SQnACDYCDoSHDtfOdQLwRysxyb+g16aqHg+e3m6q3/8QdSCSHMdqPIDYeY4Q1a
 fBUtbDTZ8i5NM6kc7b+SAtH1D933hy18fBuG41JLloggJC3LI6SYUr9Yo9iyVIhYJabTEkuKt
 4cDrbc41ERzFw9B3A+8uGTdvBSyP7Crez2KsI3K1WYT5phj0sJ5oAXvWCqY/QGHyUv3heBwdG
 aZm2UhKNC1uAs2jK4izr/nMEuJIRLdaNcZUPorqoCtTiSib5BZSc/XCf6hTNjxnDNSDho89ge
 VeG+ntrUribNf4xnOdUzNIySbCAZ8u1mcQ4vLevXurX7FyiKgcMWx80I/3XGMCThFCn6NiAIH
 HZ4vrSWAmR6qm2NFgfv6MrsdduF4eRCSXhmeHSgAmrCqsxIcy7Sv1tYz+sLkpdKL1uOIOlXRr
 C8698xL0httEu8kpoF+yF7fdAVzvBYRhaSIDQPhOp70WF7FiwF/Tjma47mtc4KFUfTReYtd9M
 MST92Y8IvhaA0S8A+QCsW02EScZ3Uax+pS2hs09WnbXhN8pse0wVIrQvS6oHxjrL7BkpejtDh
 CMy6b8bRsMHXi7ilqV+bXh+kg9IPRI41wdUJI+g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > The change that Dscho suggested was meant for those people that run
> >> > CMake in same directory of source dir, which is mostly discouraged
> >> > in CMake land.
> >
> > It is discouraged, but not disallowed.
> > ...
> >> > I think the original CMake proposal didn't touch .gitignore because
> >> > they run in a separated build-dir.
> >>
> >> If so, not only my "do we need a matching change to CMakeLists to
> >> teach how to clean crufts?" becomes unnecessary, but the original
> >> patch that started this thread to touch .gitignore at the top level,
> >> does, too.
> >>
> >> I wonder what led Dscho not to follow the "create a 'build' dir and
> >> do things there" practice.  Judging from the fact that the "because
> >> they run in a separate build directory" assumption did not hold to
> >> somebody as experienced as Dscho, it is likely others would do the
> >> same.
> >
> > That's because Dscho does not like the separate build directory, even =
if
> > they know that in the CMake world, it is kind of expected.
>
> Sorry, but that does not sound like a convincing excuse because ...
>
> > It's just that it would be super convenient for Visual Studio users to
> > just generate their project files in-place. That's why I started down =
that
> > road.
> > ...
> > Ideally, we would tell Visual Studio users to "just install CMake, sta=
rt
> > its GUI, direct it to the Git source, configure and generate". Alas, i=
t is
> > not that easy:
> >
> > - The `SH_EXE` is not found by default (`C:\Program Files\Git\bin\sh.e=
xe`
> >   should be used in the vast majority of the cases),
> > - If the build directory is left unspecified, the non-writable `C:\Pro=
gram
> >   Files\CMake\bin` directory is used,
> > - The `compat\vcbuild\vcpkg` system is not initialized automatically, =
and
> >   even if the user initialized it, the dependencies (such as expat, zl=
ib)
> >   are still not found.
>
> ... if the build directory needs to be specified anyway, there don't

It doesn't need to be specified.

> seem to be a big difference between telling them to create an empty
> build place and use it and telling them to point at the source tree
> itself, so ...
>
> > I would like to make things easier, and forcing users to use a separat=
e
> > build directory (that needs to be outside of the Git source tree becau=
se
> > our `.gitignore` does not handle it well) would go the other direction=
, I
> > fear.
>
> ... the above sounds like the argument concentrates too much on
> where the build directory is (i.e. between "in place" and "a
> throw-away directory next door"), which sounds like much smaller
> point compared to the other things that needs to be improved in the
> VS users.  And making a choice against what is recommended as best
> practice...?  I dunno.

All I want is for the CMake support to be easier to use, yet we go in the
opposite direction: instead of allowing to use CMake under more
circumstances (which actually *works*, we just don't have the appropriate
patterns in our `.gitignore` yet to avoid adding and committing the
generated files), we now seem to intend to require a separate build
directory.

That's the opposite direction of making things more convenient for Visual
Studio users.

Ciao,
Dscho
