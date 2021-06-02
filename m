Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3630C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC88960720
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhFBLar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:30:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:46613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhFBLar (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622633335;
        bh=CJyUsj6LeXIboU3X/3DjBk9IPRe8r08Gb9IggPksab4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Lh+0cIB5Evqr+KotolI2yQANnQrYQuGxBYqcLk7bmgUiyht34WnGv93GoWO5wjsBN
         36TW/0ZO/D/3Ulgrv/rLhd/+37E0/kNjhn2HJJrl5+PHHjksy96yEsjovY7wChyTWf
         G66iAVOXDbe1Z4wjKrk0qQfPBV866BsXvaSMIWK0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiDX-1m1olc2xMl-00QChX; Wed, 02
 Jun 2021 13:28:55 +0200
Date:   Wed, 2 Jun 2021 13:28:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/28] Builtin FSMonitor Feature
In-Reply-To: <xmqqmtsh9bhl.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106021325070.55@tvgsbejvaqbjf.bet>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com> <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <xmqqmtsh9bhl.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MCvgiiL2z2UpEXdVo0sAvPgEYbzoEM2WrG22z/PpRTpDBoohyeN
 w9P675pDMEqT222W2wOw7u8zOY04It6H+28fWEupUWlhwon/EkMXM0Dux8HZjgt9IRtF0P5
 NvKr7kF3XeD1yUFe4z53hn3MMgDWUseXvT9ZXuDm46FkoGd2OboPPcQWaLvTXInij4pUM6B
 n8u3vzrknxV2ZAQozsHLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/oL2MwxKfok=:8qZz7b29tifZPbfyzyJA5d
 HWckk1spJHv7Jqq2VEBYmJwC9vON2NlsVjGIsPPHZcSjFpOILFivF5CbQHzeAh7FjZRby/Eoi
 OJDloZnOPBdN1xWb1iR4NuqCcD9xr0uJvXAfJ9grc++k+ilQAqj1IFl7JuIu7ieguxZq7ANyt
 uSJK2u0SGVEnWtnUvFZ2CA0a1D+xCUBC/krBcPXcFXpj4iwYIsw6mqyfQ6ywvWkpdZp8qvq9x
 mh+f/Z/FRVIgsTjSU5iEwzJolJnQ8uZ/eKDH9WpRe8O7I+eamVfx7GLDo5eyGLLTbVH7VnVGE
 i0ej8PPJlFdebe9Wip2LlJ5EJ02hYoCH92GyuV5cmo2z1aQOGoG+znnq7cv8cs5igAWIZpyqk
 W490Pifv0sYvPHFX2g4x2fRkWiIVtKx25KptTsyWvb4R46Dt7eaN7vAGH/1yd7QCRXWe44792
 oTdWGJFVqdaHkYiobCpbTSfeGkEIuB5UYh9ZkVScS2PBBjX/eG+LcaUHc6NcsQBZu+Nz6nw9i
 QhHhQD++iszCHF91/ilUDJl8J7UQDKxkAterBf74Z0WbXiKIP+mKuH4Hq5LiULPvlulcDGsib
 seJWoawnX9nwOc56mff32pE0oD8S7Ea03cqXhFO1gOcTqz+R5qDahqRXSkSd4tqJTWLOarvYD
 zQce15mHpF0k5CvOqtlbaswdj9CpftNgR+fEx/wasHj+lMW4r1xvRWT7nAdbknCVbBe6Tf+eD
 2xqUv/TAV0dhmhXW7m6h+cr2PHYALWu/PE6MNOiK4LB3jwrPG0tfHW485U3EJ4K87oajPoaWG
 sjsqKUtUhr6wRV6ZrSEEsqVWEhd7WwsbrZY4+/2oGqXVHXUccLhGhrT8J+TOAgB/X1mKVLY77
 ciI3rSshX34DwUdDzAGrM/1IF/n0B84hc5sVq8aYnGigVIAXCB1KmetGA+LViLLa2ELscZ014
 fOXT2KGJgMr51oWTmbQuuuY8OybganPpPbO0TPdlfCguG27v7W5MLhKl6VUT5nRI3ttxDHuan
 hC8nvMK/loZ+2GPqtI19oP8XNxswDxM6t/TGoSGGB1F5bigHu+1v26OSxM0j+MH1YEvpVAbmB
 XyiWc47T9WI/ibJghAGlYY4BxVKlATaJ0+Hbb5f9Idd6tjfBEQlP8p2Zg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 May 2021, Junio C Hamano wrote:

> These new global symbols are introduced by the series, but never
> used outside the file they are added to:
>
> fsmonitor-ipc.o        - fsmonitor_ipc__get_path
> fsmonitor-ipc.o        - fsmonitor_ipc__get_state
> fsmonitor-ipc.o        - fsmonitor_ipc__send_command
>
> Perhaps make them file-scope static?

Good idea!

By the way, GitGitGadget keeps getting confused by the fact that one of
Peff's patches looks very similar to the tip commit of this here patch
series, and mislabels Jeff's PR as being closed.

Would you terribly mind picking up v2 some time soon so that I do not have
to click "Reopen" on Jeff's PR all the time (I had to reopen it a couple
times already: https://github.com/gitgitgadget/git/pull/923, and I do lack
the time to teach GitGitGadget new tricks to avoid this mislabeling).

Thank you,
Dscho
