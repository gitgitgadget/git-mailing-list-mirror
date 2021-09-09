Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B37C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ABA60E94
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhIILOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:14:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:38517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235270AbhIILOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631186005;
        bh=PfYdSK8QrcatPN2EJGFVnYZf5fijOKF9cR38NmDUu98=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LvAtxDQP1i5JXdxTlZByq20g8Bg2t9hF4GuB4VRtUv6LXE7J76KHC5NzUfoP4+Z73
         1RVWz8KJErNwHVTB219ZgDRc0HhPcnjTJuoTWgPJNxebXQ+ARDvVpulJ8MBIz3qhn4
         Vka7kDlGrrYfyj2eLuUPDOFUxEQHGlcqJEWOZpDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1n1wSE2Vtr-0150f9; Thu, 09
 Sep 2021 13:13:25 +0200
Date:   Thu, 9 Sep 2021 13:13:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: lh/systemd-timers, was Re: What's cooking in git.git (Sep 2021, #02;
 Wed, 8)
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091312240.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-542889223-1631186006=:59"
X-Provags-ID: V03:K1:E0iXHAGjvapnFRrbjWEzi81q5SIjXwVp5owrH8oOjc9RqADcyzj
 YTmRD/PBy2GhNly9ImCCxxctamAGxKJhQZcMxpxHJdgGSExXrnBvaMtoq5+8szNeQhI1Q9I
 1EnGT4jbi7S/8wm6CF2WJtk4xvpwmRHuDOy23i+nAW1xa8RJIaLL+btHwubnA2fkTprtasv
 XiNac+OR3BDqoQVd/VB8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3qBmyodZs6w=:r8PVytNcaqkoW7AOX2LQYY
 kO4HKYl0kjRaCs81OHE+Qhcq6vp5TOBRW7Cdu9w5s3GvB4HQgb2Z7fielri2WawlhfOJyHbaO
 qXRduWIMDopmHt9vc6WTDFhADl+rYx1r63mJEa1naBNLGFT75dsw+OM5fZGausHPIlWzOKr3m
 9GGuN8Dh4R+ipb8rOuymHGPKYEbnHqN42Lgqv08TmYFIehmnDicanzDaasXBK7GtX9DPYObov
 3lT3qjHzt9QUA/7Q+qibHnymxCdLEsuohsqE2gqCULBrnqwAMcKn8J2AdxmlkMjJtBJ3KoLJi
 SDuNCDfxG7j8tC5nB4PPBbzlOAwzjxMr7II2v+D0grxIjgQV73/ttFeOu//FxlUAItLyMqhXy
 V8s2CVqL3SyRnZEwVXhPfrEopeCzo0BTwAipe6dV0xxVQc9W1E6l1G+tpPNVu6aGKEo5oFWgM
 UHFf67scJirwC9538mXAgJRTG7XH6qmPstSWmlMRx3mT0Lc1HicU4iKkUN0kTllXBrxY4sSMh
 dZWwGul0536wgbVCzvo+RlI7kkqaH8gJjT5AD4M2Rlll/W0hym8M5UFa+rV/Q+oLzVDmXh+87
 vYfQWXVD7HPlWOe1VVLnGlLj9gtKnITvK7XAXkqIKxJLcK7U2R8y7nnqwNLt30LAiF1U8fEny
 Miggr6z7Q0gTX3U4uT7nobaJXJhKE8f8cVvkpriwvImCtP2NVBJtOVXze9NLEmi76S37dNUjT
 SCjaTvcYVfGnQssrowCp0j4QarF2xwoaMpJQlmT/bj/8QgJKFMDtEOxzWkUDNECKumJMhTuWZ
 B4y69PY60tYnrvFSLf/y6XdlDylDakuWHDmW191CNG3Pv8t2AFB5ZUnDudFz+hVwR/bB9LKXG
 QGbgP8i26otNsxF8KjbYhehUlUE02Nex9Qfq7XPeH1lo2vBo/eOs9OztcL6Xmy+kIFNs7UZsX
 mFiAotQTGJU+JH0pErxa72n3vvNQb6SFgTY356yA+i8d17LLuAmR3TjMJPMfNdGjXRdqexUpZ
 bQOXg9ZR844eQv2udkA4tPXfEORWuS78nk6+xDnJfC8V0ivOZgeZEAxC6G5I5eVNC2+m22u0G
 3BtuC3uICrwFSU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-542889223-1631186006=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> * lh/systemd-timers (2021-09-07) 3 commits
>  - maintenance: add support for systemd timers on Linux
>  - maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>=
`
>  - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" functio=
n
>
>  "git maintenance" scheduler learned to use systemd timers as a
>  possible backend.
>
>  Will merge to 'next'.

Yes!

And since you merged down `js/maintenance-launchctl-fix` to `master`
already, I guess I won't be rebasing it on top.

Ciao,
Dscho

--8323328-542889223-1631186006=:59--
