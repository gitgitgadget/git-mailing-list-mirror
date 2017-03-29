Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B61C20958
	for <e@80x24.org>; Wed, 29 Mar 2017 23:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbdC2X0Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 19:26:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:59522 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753411AbdC2X0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 19:26:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS1g6-1citPq2xIo-00TGOp; Thu, 30
 Mar 2017 01:26:12 +0200
Date:   Thu, 30 Mar 2017 01:26:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sebastian Schuberth <sschuberth@gmail.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2] travis-ci: build and test Git on Windows
In-Reply-To: <CAHGBnuPdve_5Xrmde6cjbXBjSWfZLrT5eT90hayG0jfbBTkq6Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703300119310.4068@virtualbox>
References: <20170324113747.44991-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703241242210.17768@tvnag.unkk.fr> <CD7E9F8C-77CA-44D4-AEC8-CEACD0528E3A@gmail.com> <CAHGBnuPdve_5Xrmde6cjbXBjSWfZLrT5eT90hayG0jfbBTkq6Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HCJjrb2NRD9RkePtAvHImZb7/FJc3CfPjA00mXMQ06pN9qNHuMB
 OrN7ZSqBV+VPJ8STiItL99xVjYQZi6eEXaiSSw6SqFYn7DMy6DhxOOithJV6BJgcZR2R7Zz
 eDLc08kROlcTKY7Dg90X6mr+H57b7Fr/3mvPbL7jZvE4c5gMqf0NPVObzNtTGa7XRSpB+WJ
 3K6iRtQwI8GfyYZuQEy4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z/y+Yb3UpmY=:XxbmZS7Q8+AqsIeOIbsBAl
 S/0edLUSuweDxKFphOhnZNhJA5AKfrIt7A4p0EywsuwfC/qyPYGasC+LoR/GY0oiN9Xotqrd/
 3VFDZzcaM/U/hE2BhN5cX6QZHgZ/g84F6eAmQQH1eGXBoDW1OBKHZwotLPAbfmz7/S+GGc+By
 b2QAqfXCA2ZAbuCrqk6JbGBib9dcey71DhKNlKWVH14C4uO9Kyk4iY2xs/oEgPJnBq/S/5zDY
 siLNpjXgVd6mxAgXr77hfD0ItXT02pzV2GS38oi9FnGXCeRylLicHlqTC8LfsUTKntQQqMBcb
 fnfMy/WWZR3BUg4+q7URQYXsUDy5Q84hm/EdZtoCAJo9c3jVRX2SlotgEU853Syj+5yn1J1eP
 /vYUdYt7GzenL640SySYzkoxcBSJaEpumltB4HPIxw7zA75nYkcag3lQqSnk6IWb3hlheHOjz
 xX1amYniPvuKjVoXAGK1wvLhlXcsFWnUHVOM4d/uVQ/RZ0tcHMeFU9d6TSOX9JyaS+OMea/qr
 T9cgr/esFZTFNx27cSO/2/f3/QI1xDAYzNCgw9zj6JLdP6xVOUFn3VmGue9tPEeYaTi/uh21o
 UpgkqEgF7AulQLlhxqfCi/oh5upY9284hwsWYbZ0UaHLSSohLWoh2eetmOedEiaSM/3W5eXoO
 p8kOcrsMEPK9t5zH2xExeZ3i3+1e4z/6nDS1qEs8fFALbtzOvXeQS9n8ev/eHXrm2iHREp7dH
 C8gwcYqn3/9AcL+whQEANDZwRJ39eIZCjfJS7hCPznzUSu0cco9PpzOL92j2l3k+2bUyTvnKv
 32/9i0/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 24 Mar 2017, Sebastian Schuberth wrote:

> On Fri, Mar 24, 2017 at 1:35 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
> 
> >> 1. use appveyor.com, as that is a Travis-like service for Windows. We do our
> >>   windows-builds in the curl project using that.
> >
> > The Git for Windows build and tests are *really* resources intensive and they
> > take a lot of setup time. AFAIK we would run into timeouts with AppVeyor.
> > Maybe Sebastian or Dscho know details?
> 
> At lot of setup time, in terms of installing the Git for Windows SDK,
> could probably be saved by only installing the required packages on
> top of MSYS2 that's already installed in AppVeyor nodes [1].
> 
> [1] https://www.appveyor.com/docs/build-environment/#mingw-msys-cygwin

And that is indeed what Git for Windows' Git fork has configured. Sadly,
the job timed out too often for me, even if I disabled the tests.

As of recent, things turned more green, with the build taking only about 3
minutes. Of course, re-enabling the tests would let us run smack into the
20 minutes time out, *and* we still would have to disable the tests that
fail because MSYS2's maintainer ignored the PRs trying to integrate Git
for Windows' patches to the MSYS2 runtime.

Example for a green job:
https://ci.appveyor.com/project/dscho/git/build/1.0.676

Ciao,
Johannes
