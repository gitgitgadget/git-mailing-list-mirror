Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB1121841
	for <e@80x24.org>; Mon, 30 Apr 2018 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeD3Lbx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 07:31:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:36341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbeD3Lbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 07:31:52 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQNFY-1enhLl141c-00TlfA; Mon, 30
 Apr 2018 13:31:49 +0200
Date:   Mon, 30 Apr 2018 13:31:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tiago Botelho <tiago@gitlab.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
In-Reply-To: <CAF2GuqtooOo0P3nGXNEEu=j2XSuNZ2KRwEOAz82mMC3t3v7bXQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804301330230.79@tvgsbejvaqbjf.bet>
References: <20180411225534.48658-1-haraldnordgren@gmail.com> <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com> <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com> <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
 <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804121341590.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAF2GuqtooOo0P3nGXNEEu=j2XSuNZ2KRwEOAz82mMC3t3v7bXQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1615127228-1525087910=:79"
X-Provags-ID: V03:K1:6+SkuUzpbWBdVTYyNe1YBR/lNCZ3lYNV0sw3sINLqHtwt2LtIqR
 MLnuXpj9PxBAcZrDF80R/WziKs3p6cv0BWcMhqRODn5/kWYKF9xijMTcKHxBA8YsxVY9aNq
 hEeWY8sG4rLZhol7gc34LfBJlbPq2cJSXNwLxXZYENDo82BkN4p0Vw5V+wBXF6NIBlb9ORB
 mNwTm3GKuKVlfgCcSIuUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u11JCh7q+wQ=:v1afnZAGuKf3UQ9PI8oYWn
 DCsnTlFFgmJumJZ9v7ArYIMNWZ3jPCgLy87TItTL4l5MbdIA6T0wKzh9cBS0UqWQP2CtjNO2S
 SgZ92fSdG29QSBqdyR3nmI031gWJmGwpgHzTpkCC7uvx/pwP43z21YmsVF3wHtiVmj0MiHU/E
 oUcA2B3EkSr4/rAlGKIVa79z/oHkGG1PYvUsMtVz8j6U25WnC2FkZ4yI5vi1y+k5mUHbJVXwl
 6IpuE+vwnH3VhU4gSbI5FSYeJTNzaE2F4h6gkb1FFWjiDWlh+zwbHc0QNbGMLBXLR5g9kgP5R
 lDivTT/q44s/zNCgDIWnx384Dns3n2fG9SMvFklixlP1EKCcHhaKrFOg80dmCbiDDjAE+iD0M
 GJqtPrv1yWtlw7mKks0Ltg8w0nBccjJPTm7UXW9OZXOWGeCX80zJ0yaqM0aOS7ry7TOby8k4y
 opvibm4C+AyeRqH375g8kIKojYcRnYTNzgtxp7twctCjM51bE8JZptC+n89MD5dIyHbF9LlYk
 Jku+bs/x+ykLxj55BOrAWlb1yFQm5fvDpTe257BgAkB9obCIR/KYkIV5yLcsMWZUH+1N7B+js
 KiHOKGGy7MgOd1Lz1nJ6Ok9KNRvgMV1hJpp8S0jNgCZta523C3RhfpJKhkHvSNonsXuOtz6YM
 2GDQF2uOwXkziE/bJLxGAYVCuzSCs09WYQ2I6zD9fE1KyDDAYNJhEydC8rvWXRJOq47vIZMKq
 purApbjO7snEfEjj6r8NLDkhRv+5PhdJhmA8O96fuCgIChXEDA+turAmEh5vJLmjTxFjUYh4K
 AErrYuh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1615127228-1525087910=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tiago,

> > On Thu, 12 Apr 2018, Tiago Botelho wrote:
> >
> >> On Thu, Apr 12, 2018 at 9:58 AM, Christian Couder
> >> <christian.couder@gmail.com> wrote:
> >> > On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
> >> > <haraldnordgren@gmail.com> wrote:
> >> >> I think it looks similar. But if I'm reading that thread correctly
> >> >> then there was never a patch created, right?
> >> >
> >> > (It is customary on this mailing list to reply after the sentences w=
e
> >> > reply to. We don't "top post".)
> >> >
> >> > On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas/) =
we
> >> > have been suggesting "Implement git bisect --first-parent" and there
> >> > are the following related links:
> >> >
> >> > https://public-inbox.org/git/20150304053333.GA9584@peff.net/
> >> > https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
> >> >
> >> > Tiago in Cc also tried at a recent London hackathon to implement it
> >> > and came up with the following:
> >> >
> >> > https://github.com/tiagonbotelho/git/pull/1/files
> >> >
> >> > I tried to help him by reworking his commit in the following branch:
> >> >
> >> > https://github.com/chriscool/git/commits/myfirstparent
> >>
> >> Thank you for the cc Christian, I=E2=80=99ve been quite busy and was n=
ot able
> >> to work on the PR for quite some time.
> >>
> >> I intended to pick it back up again next week. If it is ok with
> >> Harald I would love to finish the PR that I started, since it is
> >> quite close to being finished (I think it was just specs missing if I
> >> am not mistaken).

It is now well after "next week". Are there any news? Or could you unblock
Harald by stating that you won't come back to it any time soon (in
particular since the PR is not quite as finished from my reading as you
made it sound...)?

Ciao,
Johannes
--8323328-1615127228-1525087910=:79--
