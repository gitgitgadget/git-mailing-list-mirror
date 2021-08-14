Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E185C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737F560F48
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhHNWDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 18:03:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:60329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHNWDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 18:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628978574;
        bh=eK23s3SCQNO3wUq9VJaTpmQAeY796jm1dImfylWq2XI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UbfDE1rC340SSIcly/dohzFRhA8D7TU8ehfZoja3nbtNhhRwGikkOQzUN711WcyA8
         NKH0dCOhAP+xVsTGrfHqnUm6rAeuRNhZA22nIWnTvtZphMZy8661SQ8L1iqVk3ijY+
         AmQW6GggF/GYQxvex7sPsvyi2jm7u0f2HPSvLDD0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1mCooY3Eeu-002Cr7; Sun, 15
 Aug 2021 00:02:54 +0200
Date:   Sun, 15 Aug 2021 00:02:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, mjcheetham <mjcheetham@github.com>
Subject: Re: Re: [QUESTION]Is it possible that git would support two-factor
        authentication?
In-Reply-To: <0d301aeafc0b11ebb27d0024e87935e7@oschina.cn>
Message-ID: <nycvar.QRO.7.76.6.2108150001480.59@tvgsbejvaqbjf.bet>
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>,         <9b199de2faab11eba548a4badb2c2b1195555@gmail.com> <0d301aeafc0b11ebb27d0024e87935e7@oschina.cn>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1786597639-1628978574=:59"
X-Provags-ID: V03:K1:yoFm80aSq/UIXNuqC8Cg3zMea+im4DMpwyzK1ZdM1pCcgfuWcTP
 ouwPCyqWSwjTTQNuU4goo5mdKbN14xckdkjGeXh0hCrfkJLGCSszz84zMogaKn3Gh1FvvKO
 Hjyq039/VryGcHvvlDqwS0PWo0dX13lMhC7avoDeud4Id4BqJFIR5iozURLtT+aISO+ybx3
 P3Ogm/h7nNdAg+irbthqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xi/a4qVyTP4=:PdCdQC2DqB3vO84T3roocx
 2pAV7B0sff4dqm2/Bn9enCO+87pWFqy3OKoBHClAtZEEp/2kAyRhKsXq1LRhwFacrPK2ALSOD
 FRG8qPWTN3OskBN5fFwja0R2s84ifYevUxIgR+ZcR7B5Ijdd+2b9MZthtjzsCqPotqmMDrhkw
 HybKoGaT7Ev0h/5We0fEvrLEF0oQgCDnl6izD+Qg36o/1acc1kiaKDPpFLVb1QzhMV5awVDvh
 bwxa3wpu4Utctg0f5opLwRMDnzqtjiEb2RyOWgnlqbEzFLIpDTWt9tFNI/XmI9PyRItjAiIRq
 2Y3C4Fr4oBCXtiNktEBGHKdvUhjbyZrMVg1EX8kKCxIQTU0bSFqjd2pL7L+OulbudnhEnr51A
 FPNHnHVsxgEXD+FK0chgarDsudM/rOCz/4qMoLx49yG7L5SV02ctYzEFaShsZ/Im46kjcEGZ0
 uwK/QLrDVULeKoBnWzCDeQ5+0vKquK2K4ioC1t3am5MNdQAp1eRwz2a9kk8tV2NP3psK5+L3o
 Cr/WSMovbSQiS/5i9632I2D6KhE8sg+h2SC/ulcIkixnAoWjiElikcnjhutCbOdtC3NS0kOAy
 YxGMrcYUiwTVlfyjkjKtuGiKbhczfwcYxdJNzRlcz3Hitxz6kkFQZEvKqAXz8t/g5PCdonKIA
 BYsGtZD9xKTvZ6KagZjxhGySBHPKBF444X3B20GDuKnAj99dtFoPSR4bebWX/Q8HB18hUekL+
 q0k8tYKgpwlEEQXXGPR1GevLL/OEfFNrgkcOuUfgZAHSBMByZSEl2Nmiq562ieuYPLKWlfV8r
 D9ga835sKoWge/OnIlVm3oL2CPngVq9RyBPZwpZU9CNrgzxYxY4rmD/T0ko7saRFqRVwwpkqA
 PoSh+wu81XxuFs3wRUPQQz4/E7bamf906gnIAbZSmDL3LrrHpCAar6evrAyBcjBQrNPfz2w9N
 m874lvf57YInqdlQ+qI4mIRB/slomuak7F55CmYOie4R+Dr/Zty1C1k8sI85XI//dPSWXEO9s
 ZzvZAsl1yUXZH1rhhnDqZ6oGLhpJhMAUJCKc7CCZBSnOPiOPQKf8UtGdbjjo1p3cszEPlBF+d
 wF4ncGwpPJRiBLI8BKVQ1vnuwavMBXLafimL9MzZcUamf5QLFsfJ08r2A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1786597639-1628978574=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 13 Aug 2021, lilinchao@oschina.cn wrote:

> >On 8/11/2021 7:00 AM, lilinchao@oschina.cn wrote:
> >> Many websites support two-factor authentication(2FA) to log in, like =
Github, I wander if we can support it in application layer.
> >> When client clone something, they need =C2=A0input username and passw=
ord, it is like a website login process. For=C2=A0security, we can
> >> enable =C2=A02FA during this process.
> >
> >Typically, this is handled at the credential helper layer, which
> >is a tool outside of the Git codebase that can more closely work
> >with such 2FA/MFA requirements. For example, GCM Core [1] supports
> >2FA with GitHub, Azure DevOps, and BitBucket.
> >
> >[1] https://github.com/microsoft/Git-Credential-Manager-Core
> >
> >The mechanism is that Git attempts an operation and gets an error
> >code, so it asks for a credential from the helper. The helper
> >then communicates with the server to do whatever authentication
> >is required, including possibly performing multi-factor auth.
> >All of these details are hidden from Git, which is good.
> >
> Indeed, this is good, I've experienced this tool these days at WSL and W=
indows,
> but finally I hope these features can be supported by Git itself, and th=
en the user end can easily configure it.

The problem here is that 2FA is highly provider-specific. And that's why
Git itself refuses to implement it. Hence the credential helper layer.

Ciao,
Johannes

--8323328-1786597639-1628978574=:59--
