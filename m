Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA484C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD2E20704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hLLvPiQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgDYNN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:13:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:57975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDYNN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 09:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587820433;
        bh=XCnnayme1k1ApLYca69/HwdxtPPvbZf7kQ8+EaT6+q0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hLLvPiQ4qExq1iktRNoU4JJtwtERRVUT72+m1Iew5NedbIVQVByThr2y2UOqlE1y4
         sFg4zHLTS33Plk8wwdC2TRUioCELCQbjyza8ECsli8NYYJQ4iMtgv4qZkkXyIBa6+z
         nycQn2JFBcsb74EOZUvYoS1s059IGbN1v4N8E45w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVvPD-1jaKs00CsX-00RmDo; Sat, 25 Apr 2020 15:13:53 +0200
Date:   Sat, 25 Apr 2020 15:13:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] fix make sparse warning
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004251511550.18039@tvgsbejvaqbjf.bet>
References: <cover.1587648870.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-559739335-1587820434=:18039"
X-Provags-ID: V03:K1:0l4o8Nj6D57qPf2oWZ0wE1MT5T1CmP+7Dcwpel7MHZ0HDefn20T
 yEVfPYYBwRfDlrbx07g81dUTUBypB9UwgW0d2GrWdhLIF0C3KsquXlVECwKa0tJ4+QkHtU6
 COI6hlA0EO+KayW+aMTdAdz/P4udJ4rpMZoTjXxWdHqIHdjnnkvuviNwhfIpScFTW4YTx3z
 Hc77Bbp0vPa25+BDOoapQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LR5OALGxHNc=:6TmK81wF6x4bznZh4C24PY
 r4Ax/LuAk+vDn7XNLSJWN9WXqDwYdxk/gNiOVrf4czSoYY70GwLwUzfPgxUknPzGuuSUX81pj
 ZyR7axGxZVTN84T2XiXyydGbCq1l+80JVC3egUO/r9nSgTulMkMKSQHK+VbwVnuzQ2BP/exA4
 wvHXOkCZyokorsmIVwf5EThpNmsTTQ0XzTtfOWnQIFI1m9y5AryhKw5KarTA0LiLmnGwW6B1Z
 wDHpF4B7hI/vz9pqra6PaQrFlyJEj7qfNURd5Y+ePS1KgdEwsSD9iVyUpXfSS1bvi31UNd3R+
 9VYlJnLJMC6Avj/xMMjlNiFeR/O0Xjir9ni2Eqm2MYo1a2mYQfn5D+175YL8Q6KCkbUQsbhus
 fWrrlJfsOnX90us6Ht2bTnNLiA+SruWha7wyAiz3egBjLyhKBO6vnYua2PsN4QsUvII8qayre
 2rC0QqaZT2/mFGfadvHoTmbs0N2jowgFAOfYbPJn1JkjOA47A7i8I9z20lVN/M8HyyFkGVwYh
 GEXatAaz3pO0Ng9yxiqnn7+T3VFoG4rLbRbHkNQZkCir/aqs+Y9Xb6EFHxZdPHsMOYnVCiwb7
 1FjOltXQx1hO3AqG7dSQT32GT8sjlSlod9plzWpXCbDHhOxN9H/T4EXIOJlF5OSjmEqkERB/V
 nNLKBoT9hLtQeAkY1f31AJwnyfckf01cNJRpFLL2G7G3OWct9OCx8Utir9BGUSsLQpuc4Q5nE
 rTAadUrYlcUCouqhrk4JjvJUN7zjNoQD5f80CypoiOW/3zj1CSRePqT3Z28dKQObIN0MGyJ0+
 UCKemtdjpp9CRrpfbL2H5M8SRJBX/WhqVW1CWbUWuiEhzx5uhsiE0+qW7YpAiAC/yr3gU+7kv
 YDAFMiy2jBWV9NrcQnKiVwEiDmM1DzYVxI+H/44nfXXg0+X6hV4wJM/3+WC7zVpZbJDTzOtNc
 FV2fXHVubExEhSbrhVi+2HppUJlzp8YcDwNoh9aOgbAr7aEmY20mQgXo9rAww6E8wDbY7qMf1
 IqgH/pwFT2DZGpsCAk9DxFKKO2jHrcrErL9vLel+sS6VqQH1Uq66VjwOdt5xDyZ82LjeITusl
 OH//Ult9AmflpaYrudNkjxrmqvR2uW3YB9G4IV4vD2Fpi3GnPF7SF5PEF9fsmMBjn58e2GVLB
 6xAidnv6NjaxZPI9XSJrFoDX7EUFSK+btnwacBAggok74UZrjY8nlI4cQ/Nil6MfBghfLryNR
 zDC4HTHSuqqsSRepi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-559739335-1587820434=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Thu, 23 Apr 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> It's happened that I tried to run make check on project that support aut=
oconf.
> Git's Makefile told me to run `make sparse` instead.
>
> I /think/ if we have a rule in Makefile, we should adhere to it.
> I also fix another change in ds/blame-on-bloom, which I think it's worth=
 to
> fix, see: <20200423133937.GA1984@danh.dev>

FWIW there is still an Azure Pipeline building `sparse` for Ubuntu every
two weeks: https://dev.azure.com/git/git/_build?definitionId=3D10&_a=3Dsum=
mary

I created this Pipeline in order to support the proposed project at
https://github.com/gitgitgadget/git/issues/345 which is: teach our CI
builds to run `make sparse`.

Maybe it is time to tackle that?

Ciao,
Dscho

--8323328-559739335-1587820434=:18039--
