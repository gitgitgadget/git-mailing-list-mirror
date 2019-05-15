Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3E01F461
	for <e@80x24.org>; Wed, 15 May 2019 08:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEOI0g (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:26:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:54443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfEOI0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557908790;
        bh=ptGfXy666qSL/QyxtKxeoqsZcQ2NkLYneclg4beLQ9U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jmQDWTtuHmHZC2gn0k9BZI4edKAKabuausCZE58FJtycTTQHXKQdi74oqrEPzlKM8
         CMOwwP8nuE+z7u6DiLGjUxxgt/XzcvjPOfcs1th0EqS9HQAELIf5OKt2BFQl2njn5M
         ATPd5fHajqhrHNo/RP/pkIaK1tm9IeAtyYEwedw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1hExYL0XG7-00TTOB; Wed, 15
 May 2019 10:26:30 +0200
Date:   Wed, 15 May 2019 10:26:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] stash: document stash.useBuiltin
In-Reply-To: <CAPig+cRoyOJrEuVY109NKafTCUc399p9tk64L9sZok=AOZ1MPg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905151025580.44@tvgsbejvaqbjf.bet>
References: <pull.193.git.gitgitgadget@gmail.com> <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com> <CAPig+cRoyOJrEuVY109NKafTCUc399p9tk64L9sZok=AOZ1MPg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fId8j4LG0XWoZPfFVOx80NKdnsZ3bbKmL0GN4g6Ej04WSEDtd6l
 agMcDmYnCMDrECK2BvmC+KxOkKfezeMzNhjL1nCTvRvtlq0VqDLJQ6eXNN0uEgDPGMGx+JL
 W11FFx4xhqV1Bug3Gx9hjZYeInWaiM/KVKnRHM+um6vjvaEpD7c8akFirWpFD5lXsqMpCEi
 +0CN9jqV1TalPDX/Fuq2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42+7PbJLLYU=:kx6APZke7a+vIJNONiuVx4
 rw5Gdo+TLeQCu+bxvMvhTUjOzWHZ9g2Yf1IxyIDXuiEC1uv8/VOLUxwsXH+06KzgZV0mu2tzO
 0ewyHPOBuSE9eoVioIhuxIDwL7ixjKR7cz/Le9XGr0K+vL/XOZ0FIwxgPuj1rTnXifNAfUalt
 ZwDze0l2Lie8Y0kzzxMT6+K0QKuKKSKockfyzzNy2Pu0vL0GYeX0shzdnjlXCU7MHcxxXpMu6
 8UbifvP63a74xeBnUX+QYuUq46EJBSuXhscfCnfZ1ktgNSNdWzaTfNNX1T/NtTkJvCeNlSAHD
 EpYtbYoOZMbSwgb0AziYVrTRRTZaKc5/FUdst4yfgAsZgCWDEqMUPFMN4XUa3AiwqCbG0BtMF
 qkYB3cdm2tV/8eSuIXiaI0tiFICi0xexSn7vUrXRGsONXL8MAGn1iOv/fWNWIvl1Agvig00T1
 XgShRVQtz2vP4cYhhlJOeWhTfp63TTsxoVnop88NyKiseTcy0Bi8Xan3YC7aWAiRGEDpQVNS6
 wUTlmah2Zg17QNRzAQ5RnNkMq2ElYRj2o38ulLFCIcffUWdZVK6KHbc2/Ibr1Ldxf9hcbokmy
 uor4YPo4sDY/agMBCi/SajgUox8uiSftRbYKwDCVgRHabB/XRHrkTStJnQi5VXe3yhCXCyErl
 rDjSneoFvh9AWMCjYh9eu87o/iVD3lrjsGrHrPVZOpFmAyxgofUtr+A2ebaAEv81YkLi8MHjn
 bUYeNPyYSq4CL8k9gkvXNcHwzAJ0n4igkvvjFF6+B2GHFdkffw5rAQEK5qXzucgo1cMEth9a6
 929vNof2lcxuA5I8azFEh6C/rrgwkdc6BIH3ZAHc3SmDX1rM1GKi6JhyPLnSgp1bXH8ypQJL6
 dqyGQBix7MBOJZl3Tc+l4HDv2ehQs7BKuZoTLHN63o0q7Moxq5AL7leU+/MiDiwF+qvmei5na
 yETacH6OvzA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 14 May 2019, Eric Sunshine wrote:

> On Tue, May 14, 2019 at 5:19 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The stash.useBuiltin variable introduced in 90a462725e ("stash:
> > optionally use the scripted version again", 2019-02-25) was turned on =
by
> > default, but had no documentation.
> >
> > Let's document it so that users who run into any stability issues with
> > the C rewrite know there's an escape hatch, and spell out that the
> > user should please report the bug when they have to turn off the
> > built-in stash.
>
> See a few nits below, none of which are necessarily worth a re-roll.

Thanks!

Junio, do you agree, do you want to fix it up on your side?

Ciao,
Dscho

>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/config/stash.txt b/Documentation/config/sta=
sh.txt
> > @@ -1,3 +1,18 @@
> > +If you find some reason to set this option to `false` other than
>
> s/`false`/&,/
>
> > +one-off testing you should report the behavior difference as a bug in
>
> s/testing/&,/
>
> > +git (see https://git-scm.com/community for details).
>
> s/^git/Git/
>
