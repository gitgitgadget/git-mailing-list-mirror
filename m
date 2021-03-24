Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF2C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD8A619D3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 13:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhCXNik (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:38:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:34103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235262AbhCXNiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616593095;
        bh=Nc1TDjVs11kaGp0Vj43kMpnZd8PuT/W0TcIzI3Mmwh8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KoRAGJVs+ylY+avDUxHrZfRXATZPgAy8RZZEGzX6vOfMMm7iULz2qgUt7jNSXB3Iu
         t/z3NMF3Mxdzhf6bpHTOlDkAHsLh7HShWkxUkddSsfWKUFaheBA5dGmiNCl+Q/yeTr
         uy3B5GpBpxpsW9cPP+1pCLse49/FL8hYI8JUI/Gk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1lOElQ2XIp-000qxl; Wed, 24
 Mar 2021 14:38:15 +0100
Date:   Wed, 24 Mar 2021 12:50:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] rebase: don't override --no-reschedule-failed-exec
 with config
In-Reply-To: <cover.1616411973.git.avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103241243000.50@tvgsbejvaqbjf.bet>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com> <cover.1616411973.git.avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-966751398-1616586655=:50"
X-Provags-ID: V03:K1:woe+AUm8K7eS6nQPCi50nkRDrBRWktRrBkTxxwgL9UC2mVXBvXS
 r1DvBt6Stnmv1p6/p4k1NbPS7KKcjQ7e4i57jqiFClJQAuJ4zm+To6093XOSn/QVKLPvbGc
 XBdOXULmlB0bvIv7NfKvoOYESVgNj4wWQbSRevyv1nGDLlTYKBG61NUILfJ3amufGmIcXpD
 c8fAvhUL1GNaenO8QbN9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3bw/tQ9a8t0=:XS5g5NBk1ilSw+A9kpDfMN
 9i/EI6nT1zddw0GU2CLgTfPyGNUeKTcBmhkyQHAmwe/YhQrLV7sR1rlM2loZLvFovsFCkCOyl
 qowHK0ToZSIrmwoAkqPDhKDj49D8SEueI5VGr9dHCa4AooEoZg9Nthg4SD7Ou5c9y27nznJqB
 Kv/id4hAhzapo8aJzRutnDscxR3wq9AF0EgoA5HstTWju3grQ2fhUmFenJ3l4+WAfd9dUP6SR
 WQDFvEm5g6i3Hq4NPHrQ+qU9lpLh1cfLrDcyi3n6SbxXakNXoUzkdJDVcpWrGy67RKuQxp0WU
 G3oleVTuG2/ACjKSpb1qoj3D/wkDmpCCitSScOruL5KuEJsmgZ/QII+m2rdXepHfObDzm5HBd
 JkqkH+dGemV16QjAuIqRwpnR6T4TJIUH2wobB0CBNxOEBW9igv4uHV0Hq85qMdKGSsjOa8JWU
 uHK75SZcOBBjQrlyMjmTAQNhZqCYUXxREiKD+uTupDAuZZO/vrhmTD2aKQFarXSoaarjdoXPu
 F09qdmmRRkgNlDegAoo4FS8CzEzUL6JYde6Bf+ZTw9LuCOidjd+ujZj0TfAK9LkpXJxzaUjYU
 ydH/eOUHbNqha7eIemGgDJctFkerDbr104hS+yj3O+NxkAG7qlInzq+jnrTRFbrJFTWMT580b
 tOKBhYPLOSaom3yip318IAhjg5s+1GX1Ws2eK33OrsbK/ZEU+WM4phvnTcgbybliZ/p5gOBbD
 hPM8PNFaw6Won7kw5D7+A/Qv/HcSIDJYzVi/EEKxqiQu+EiKSXsscYb4XCcySnD3Rc/rScQ7c
 DkAuBVgi6127Q35dUEbcM5Rer9mfr0hFdkjbI83UJmOaG/bK4+MNf7AlRYymvhvivKHg+frB8
 OlwCU1asOldFWgESS+V7hyH1iI47pvBLkRCUDyN+0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-966751398-1616586655=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 22 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I recently started using rebase.rescheduleFailedExec=3Dtrue and noticed
> this bug in its implementation.

Okay, there is a bug. "This bug". Let's read on to find out what it is.

> It's conceptually a relatively simple fix,

Wait, hold on, there is a fix, but what is the bug?

> but as noted in 3/3 rebase being a "start this operation, run other
> command verbs later" has an unintuitive interaction with our usual
> "command-line options override config".

Oh, so there is a detailed analysis of the bug, whatever it is, in the
third patch in this patch series.

But what is the bug.

> !README FIRST!
> Everthing after this line has no relevance to this series, it's just a
> side musing on another (mis-)feature of --reschedule-failed-exec.
> !/README FIRST!

Hold on! I should read this first? Why is this not on top of the cover
letter, then?

Oh, and wait, everything after that has no relevance to this series? Then
where is the high-level description of the bug, a motivator to read this
patch series?

;-)

I guess I will find out when I have set aside some time to read the patch
series, which is on my back burner because nothing I read so far makes
this more urgent than other tasks I had planned on addressing this week.

Or maybe you could enhance the cover letter by skipping the rant, and by
giving a very rough overview of the bug at the top of the cover letter?
Think of the cover letter as an elevator pitch to make me want to spend
time on reviewing your patch series.

Ciao,
Dscho

> [... snip rant about the odd progress counting when rescheduling todo
> commands ...]

--8323328-966751398-1616586655=:50--
