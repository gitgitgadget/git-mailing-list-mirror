Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC8DC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CCC2075A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c/u5GySp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFV1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:27:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:55687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgEFV1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 17:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588800440;
        bh=2OtpB0KcNLCOf5lhQfDEl5q88EHNM3Kr/5o2ff9jMWA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c/u5GySpPbpIse4TY9M0hxbDIJEpGXos812iZKSNn+1B5s7AwAPR0ldGW/KbPD/Ru
         RJ5OQfT4u3vlbPSIYEypy5MlclJEXRSFV6/54XcnnP7c5qKtIE+J2DU1o62gtsGfkJ
         jIcpNShXEGBXp9ILQBiqaN55s0lmfl6Y0LNfiflg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([89.1.213.224]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1jjjGC1Pf6-00M0LH; Wed, 06
 May 2020 23:27:20 +0200
Date:   Wed, 6 May 2020 23:27:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <CAKiG+9WzQdFa1qM4dKUu8O7k+Q8JGsDMGQg-2GRJr=AJye6wJg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005062326350.56@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet> <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net> <20200428135222.GB31366@danh.dev>
 <20200428210750.GE4000@coredump.intra.peff.net> <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com> <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet> <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
 <xmqq4ksyl4mz.fsf@gitster.c.googlers.com> <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com> <xmqqsgghhr32.fsf@gitster.c.googlers.com> <689741588534833@mail.yandex.ru> <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
 <848941588629532@mail.yandex.ru> <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com> <xmqqwo5qc3ec.fsf@gitster.c.googlers.com> <CAKiG+9WzQdFa1qM4dKUu8O7k+Q8JGsDMGQg-2GRJr=AJye6wJg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RtrDWYZYhPOxbD24uRPN4co9McD8oVGOCpSol6iYCMYoSINX87O
 kYtMfCPSAXKJKZg6EdSMB+vhPuzaDmJmHZ9W/BZWxISDmlCv2VU5RLo6hxpGR17jyZ0lhMG
 L9cecLySA18PKvZDK9f1oavqW4Js2a2w2JZA5eGKEYCDunDkkLqPbScV7jzCPh8Y2fFcmf9
 WoMhfvlKhtrGq4gouGbPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VV9gogMn77I=:qVdMzYDBiA72ml4jW5WX8b
 X6o9xgbgRzh2AGp/zVgNmfDFXq95PaO1b4Fa/PYOiU3D9FPnSKTfYATJhQlIs64m73Twf+BdX
 Ay9dW0QAynqbE0lI2qYlcIn4ACgPEfDXmk/F2yLdDnTPskb+AgwJYT4jUgu5t5uErVRYVJ9FS
 Oul6K7UowpefBu3kXnS7ektoS/tvgAdcNEt/okTCXasHqNUyY/cFNlQShnF7CvBNLU0A7V8dS
 f08VPOePLvA+9ya+4Yw77T4vmGQBryaB6UT1GG+g6JjGjDYvWt8uMzGAZVDTFpa4HmWzxWzCp
 rEK84HY7bDLqNMsXeolO0/jKnP65hzePyiG5Al+voidL8uAeFE5zl+c1sa3HQT5A4RDMV//LA
 MC6R27jvheftxW+GBRebvKpTc3jjOJ2MMbEDc2RznBz4izgPvytgTxfsOlnUN+4mIfWipLOO7
 S+kwviKI7nWgrW7lwaLLhbyZvCndq1bJc6DWv0CnNbZql6qrvzkwEHnBMgmRxnX/KKM2V7JTk
 G7e6urrW6UYVPiu5puzR9vUEqY7IJQ9TdD78Gpgvx9HI8Vt5jsZqoU157LirO+I18iaEwNbsY
 Te27fXiK7Uy2PoNhCK8pOMcGnr/b6FPNGsq4K6gA0MMSvxHKKl9guMnbOzqM5gFqgJjFw6erR
 edGO11bgtrS1YdtxIAmnrUuN8c2bySsbZdZsj0fcBknFpF4Kj1PIDW+H2SqXmdqu5p8JGkFot
 XB/LABk0txE9ifDVpcjEuQZ2+86+HPYOGf/JDEGx2NUg0I93CXV5nrQN9FMgDyHwc/VsaCr0t
 SihcmnH5gUzYZEI3f1Sn8bMTeFgqlkfSUhZBtCK/Cjqe/rYoGfzw1fVvBeAgbMpVedM5WqqVw
 QE8B+BAiUxpXnrLpw6aTLZUXPIpvxfjktELN397kkHIkRT43Pg9M1tNHjYeRud3Eehc72737/
 vNP45MoYWJWEZxYVmYKWr6dRkGlCc3ndHf71ssNy/feIDxvTRRron4hB9egTbdzKozvslm6Hk
 ckSYIh3V9MzKDKfbd1VSLG5Fa8V2M/E1MinXkGwVLWp9iWYnNZUHklHcy0LjEQux2i2xdoq/J
 crA9Zp3DwrUoEuKAJOdNvknLX66DPUK2Kr0hDMQPjqpNyLtct2k2IvSq99mKYrxLTbiW+wjf8
 Z0V1hGarP7xPd/owXdtKkkt63BCuYDMTkLDnXRFjAlUNUYBW4YQJBQ3Qck+E4uqHT85CeG1H6
 cYv4dH/BZzbPp/ebk
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Tue, 5 May 2020, Sibi Siddharthan wrote:

> Hi there,
>
> I have made the following changes as suggested:
> 1) The CMake script works from contrib/cmake now.
> 2) The CMake script parses the Makefile for
> SCRIPT_SH
> SCRIPT_PERL
> TEST_BUILTINS_OBJS
> LIB_OBJS
> BUILTIN_OBJS
> XDIFF_OBJS
> VCSSVN_OBJS
> 3) Philip suggested to change the error message if sh/bash was not
> found on windows.
> 4) CMake now tests for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT.
>
> Regarding the commits, since 1,2,4 are additions to the script, is it
> acceptable for those changes to be staged in the next commits?
> Regarding the workflow file(main.yml), I modified the vs-build and
> test steps, should I drop the commit or should I keep the changes(a
> modification is further needed if CMake is going to be used for
> vs-build)

Yes, I think it will be crucial to use CMake for vs-build, to keep the
CMake support functional.

Ciao,
Dscho
