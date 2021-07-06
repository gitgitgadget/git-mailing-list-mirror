Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C368C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C1D61C84
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 13:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhGFNPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:15:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:48297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhGFNPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 09:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625577134;
        bh=6kSvE6so76lHYcBRHaWLv6Yfsarvnxv1yzpIDIiSFFE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bBUk0e6mbCjKIwgStxgnCGeUHPs+dBUt+xm1FbhSKFEj+UK4l30kBGNS9m6LYf4Ts
         L8u/XtrH+X9HqmqKq5/z0ZA2kFjOL+RucOEFwwN04QxCTndGUrXAuR0mYqFgfKhPx5
         +cZCz1KZjC73VzpO2IC6foFHTYSISNgX0aHLXRDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1m5gYZ3SRm-0051KD; Tue, 06
 Jul 2021 15:12:13 +0200
Date:   Tue, 6 Jul 2021 15:12:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
In-Reply-To: <874kd874qv.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107061508510.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <87fswyc4dz.fsf@evledraar.gmail.com> <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com> <87czs1d6uy.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet> <874kd874qv.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-564533832-1625577133=:8230"
X-Provags-ID: V03:K1:XjpDA2fBm4geU0gpYsg8DZE4YHiNlfO05vpAas44uji7bVE3Bla
 PMWQpNfqBn+YnGkmeLwQrGhH/E+XtzrFDHKXih/N6seE4loVaq3ntNLmG3zpReCKgKMo1YT
 KxfqMKhf8LfINdvRZzSOxCnchj31wjvVn/GVYF/EBzWShION51i0ZPnSSuwgODLX0HNiNQy
 uqwiloMcS7kzmKMnVQhzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0zsC2C0c8VM=:AV0g1x69oswRh6MUCpf1g5
 S2W1Cylm3w01Q1ux0FRVGX8bsNiT4y4330+Jh5Nz/nOfyV0efU93v0ST6SPb82qy8vKFYEmgU
 ibloxu3HKREF0e3n6bmlQUIEYQgvglfHUAK20NmyNlbDRIpqPDdI51R8d3ZoQIxH5JA4Q5vD5
 T1ZsQRmotWmFkSOJVwuGzwOtb9Fy4GqC5Tn5M6NC0ecSn9v6ehMnuv9LdoTEewET4yhHVKMYX
 qVI9hjzEoXkH4mZ8mDf5b+Iur2XTUVxd5TGWAURr06r0CTsa99u2X7vsRQANqyI11bXU81IlY
 7u8Hjexa70cNb5Z9+A+gfEHBU0UK5wlMEToSf/SqV2wcGjQWUpWbqpaaRxuGmsxdBXFIPRQQ9
 5VP/W76zFDCSnhKpr9jGfLGTzo50Bvn5Lfqrg3AWJ+eWWzhLBVaaOLvKPVY1vVtwQ7R1YizJT
 XJiDSQHGHfW9U+XbeYdQohWXfUXdeUVWj/zerOgdxt4Dw/dGdB9Sjm+zM6QQUGsZt3KIYWVDl
 EzNofxPL80NL0kBdsOnCj+IVfBltHk3ejQo1EkOLF9LeWAsc3dhisN+5woh9ap6nOm2HTFswT
 4Q036XAb8246uVAqrWAMh2LUbYEEMbu1eo5oxR5m70g2L2IoBm0KBWhvvT3cBkF7H9AHWU385
 /nqMuGfhWCY700lnN6QeufZwoTnvTLHKigVrfb2ByIzyvopNk2b0p27yCwFV0XXqYYD+sUuqN
 dSix46L8o0USOHy6yzMWHQUi1K45MqjBVu/as3WA/pGHRjnrKfNudLBTQ76opYIIAoYSWeAXO
 gnvKmCfq2F3Ada6pzVhH5TCezgvbnXP5MO44fLy1BMPD+tNNmBUsDmHB8xmUoB4DS9faXIXXT
 pL8rRnQ7ZXntsGseMv8rf95H6LW1mGooc9rfnEFutipd+PZLsKyHbKoFd/xp2ubDbZJQqIooI
 XdDKeA5wxZOw43uiD138/0apUOtfd/6CTeZFyHmObgWwVWzPJoevpa5F8OFYcl95roa2/xfYZ
 q1Ufd6nlhZGG1gG6IfvgxtHBlktc01lfWMqc0qgj+g5WnSaw+xPb0n4yBGkSHUN58EZgjKlIt
 re19vqlOPdE9+tkLH2hWmTxs0eQEbdH5LfqL2te4B0i1sXI4F0lhiix6Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-564533832-1625577133=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 6 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I think we just disagree. I wouldn't call my opinion "unhelpful" any
> more than yours.

You still misunderstand. This is not about any "opinion" of yours, it is
about your delay tactics to make it deliberately difficult to finish this
patch series, by raising the bar beyond what is reasonable for a single
patch series.

And you keep doing it. I would appreciate if you just stopped with all
those tangents and long and many replies that do not seem designed to help
the patch series stabilize, but do the opposite.

Ciao,
Johannes

--8323328-564533832-1625577133=:8230--
