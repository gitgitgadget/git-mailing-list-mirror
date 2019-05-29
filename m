Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C87C1F462
	for <e@80x24.org>; Wed, 29 May 2019 09:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfE2Jkl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:40:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:49035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfE2Jkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559122839;
        bh=zJ+jPRQqpqF46PO9oLfog22IypGFl9QEsEhnAQBsjWU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=brXDz8WfzgJpTqIEXpuFXcS9fr5Kca9PhsXYBj/P3sNB8ySoarvMzOOFpMw3k7JKn
         S0fTirKbz/RJY1AK+yMNI3EQyKvRUDPqwSwEcPgeccpTFLOMObaf9M5ba42vrEF4Gm
         keocxyv/irWOztdVgQ0GaWvGZfdt0beQyfOF+Gmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMmA-1glLn32JtS-00kvPF; Wed, 29
 May 2019 11:40:39 +0200
Date:   Wed, 29 May 2019 11:40:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little
 projects
In-Reply-To: <nycvar.QRO.7.76.6.1905291137070.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1905291139460.44@tvgsbejvaqbjf.bet>
References: <87in9ucsbb.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1905291137070.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2027595769-1559122839=:44"
X-Provags-ID: V03:K1:n2IFIfGd2s9kM6nS9/s7vN0k/QYrubS3oeFWzWp4HMjVdtTF3jq
 LLcs1bO8TF/hH7B7XdPJSrNl3v8IQehrGlGVsO8tsEz/w74/fwQbSXt/eQaDHNEGUkkTSlL
 hifztdEiZvJm9T2ilx6SE0wF6i/KZWpCKlvimpOA2ds0PBT2DiRQ0nlBEwbs9KdPleUDm4S
 eDQiq2actl3aMCoMOAizw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsPvUAHHocc=:2qGsgNsymt/HfKBvxyaW+W
 JituMdq6Mf6l+nTlx53cOOxzfr+KbSj38tYxZsQEbXnOPdqnRecipMsBWUiUp7EiOS30I/RI0
 jRCFsXGo5YEe1D5dnAaZ316mAx/uKMXaA4Kdc/uIEaru74S7tNrrTUQlJYoIp7H4XZuojeWRC
 iMQ7pC4F73K/ZDaEnVLAN9T6mf01JSia0zXUMLxPBgJWRSZ7RxUd8FTxW5FdphrMGq6nQXBy6
 ZYafXg6ea0r6bkeX5Vg6F8kCsNzIq2lJ6yU5aXRYXzeQPx5GxGkU1s2j8StFyPRlx/VYOU/59
 v3wXXLFv+VpwCu/ObfKvTNgsApKjXAB2qFD4g7bqWgNqwUu30YeGJ7b+9ZRhGSy/IQxUswCeG
 QGzavnokUACV3b3XPOz/Ek2NDB31IPKDDAt1UBKNaoPlGMlBiA108heX61BQLawqVYMd1Vq10
 Rwv3Le/JCGZ/TqF4bqHOS74TdnwFNrFKvYr59v1sOX74Z9Urxjyatd5S47Q0uATBxEl6byZPm
 6yinXtOsBhYxZ0T4xIEHfXFntIH8hTSPUbF6MUt5QjtmAz/hpZazVZX7gW8NRIWXIIbFtS9iX
 PfdqJbJwwS3zbdK2jo9/djsyTOV36P0GhV7SgeQEenPQsl1dFtNv6se4AqHFFrRy+30r/K87O
 hQTluygHhF8BHKh1HbPSI/qRw0d3xWWUo3vAqvz0kLXxY048Ts7Jmx99s6VfyeCvLYrq1oJrm
 cUpprUV3D3jaP95EyVmefUyvCGy6sS4AscwTWduyZC91wnq4uvRTc/ZMAMRo7WdvHHPbLTegC
 5H0C/PZGa4iD60y2/4cj8xNHmhg0PGLwL33Us1fsclbrnt5DmgfwOanN2VTUTMJx4lhFXWmYw
 bHYL3DFynJDYPCOPnBkiBHiq0N3nJD8bnjMzGGQtxdIEaPvrdJHsdFes95tueJM3Hh3pG85+Y
 iw55+2UpVgrdwLDcMSCHWIA2AZI1dF8lVRTi7vZAh5f6dx7LpC2Zk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2027595769-1559122839=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 29 May 2019, Johannes Schindelin wrote:

> On Sat, 17 Mar 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > In lieu of sending a PR to https://git.github.io/SoC-2018-Microproject=
s/
> > I thought I'd list a few more suggestions, and hopefully others will
> > chime in.
>
> I am in the same camp, and figured that GitGitGadget (which *already*
> augments the Git mailing list-centric workflow via GitHub's convenient U=
I)
> would make for a fine location for these small left-over bits. So I adde=
d
> them to https://github.com/gitgitgadget/git/issues/234 (except the

Of course, I added them to https://github.com/gitgitgadget/git/issues/,
with #234 being the last from this email.

Ciao,
Dscho

> "git-unpack-*" idea, as I think that should be done as a test helper
> instead, and it should be done in the context of a new test case that
> actually needs this).
>
> Ciao,
> Dscho

--8323328-2027595769-1559122839=:44--
