Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99ACC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbiCGP6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbiCGP6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:58:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4037D00F
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646668626;
        bh=x7AaAunOpqLM/cOz9K19Rh12UsClubMv8k9EsVApDUg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ihtysGlXdkjR0nrQHBZri1gaubVQMClM7tH+3dpwrZhJyDaMqmqlwupgoIyrURaeh
         UANp1SiO+/R88b6LHKI5VJDrYEwJE21GkBrA7zNLxN07bXDGv2k/RMCOUK/Kgfd2X+
         /DhD8IqNv+5JY3FWSG8A5Pwt/aKZf5JPbSkUfdO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1o66KE11NE-00h6Ay; Mon, 07
 Mar 2022 16:57:06 +0100
Date:   Mon, 7 Mar 2022 16:57:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com> <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-961277992-1646668626=:11118"
X-Provags-ID: V03:K1:3seiYPkqV+Xe7gpgiasfNlksW8V41wm9bGpEhmd3U+CwSH32C18
 n+/oZkDlOzt8dwSmvM9NpVWb3h+DmnPCbtQcLgHMfOCjfKgj2HkjrXxzPfX+K4EXAR+GTGS
 VdDrv4Pj58ecx/PXsutiSMvd5/BLdXpzZGc/rJc4tAJENcBjGepEYOcSf+iodEo6HnlZWVE
 r7X0tT73zkt9oBP02bUpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RAVLPmiTqRc=:lKdLEwQL6nzLceNNQiGLdO
 L0p6yrfWEt+Bo0YTSiB0pWe1AkP5FKl8ar0JUwjBXGwynPI/zUjBMx8orYHxiSYJ/HKsOH03c
 rHyKkaNz5bmAxndwdAu7LSB5QxvjTtwOXH1klKtjUBtl8NJ/wAADPIArvORooqHxdv+/EGpci
 DJf9sy8qB+Y0+3pshMK15olxCsOGsDaaxA3IG1f2hBF9XgVfoo/Bv35QMqDrjpH7d5cu950mi
 +yr6uUGbhkcOdWPz6n2pX5xAvhLLu3TJMKce9WDupdg0ls47I2Mn0vAb6aY35wVIVwOsRKCwh
 faHMeblbwrW/+P5wz/24yVxU63/HSW/IzpZdPufJU9XlzVPmCEYXC8PcAxek0vlrYKFuPmnap
 QQUce7RLdHwaP9MuYkMP6fS0aLh2eGBTkP8v1FJ7NPN8mLpsI+zP8LebnjyvuPNOz2nHvoQd2
 lQSoedqum3qVNsMl9u18Eyl02dtUhOA+YdpfnJ0xg27cBIdCCHQdocZCBrE2TxsJ/rDNmTNeY
 A4Bc2wdNBljEIzCuULwzXP6Dtc/VHn1xlwQ8PJTJA2SJOjjo7CDVXTBfNLKFs6VukEI8kCkrG
 iyQY38ioqEzlZ1QqfSmLNh/uVD7NGzZFgXrf6DTPo0RcBQ5jN3iPnfu0l7N69NJAQwDBYC9Gg
 uNR5hDp7EN8KFZSYqB1euO8+4xI+4CotPZ+gWbnPT4k5F+klvmK5WP5aBfEr3tJluDtzwoDkI
 wTMmmm7s1fcRaaQ4hA+4y2zi88LmtcyogEvBVry4HzJdUw9FkIKF0PJqxeNz/ws5XarE/Onz+
 lIOrRj1HnoVe8+2HHxfBZOZEzUS32lxGRTrgNVX0zy5dnsMvo01tmvqo6cqhnf1KUNqfOKvqs
 LfwUtFtWS0+zHjXO1VCzPoDKLt3yiyhQQeW6kJAiKw5BYC5w7kCsMVNHNlQsFffF2kqaSirNk
 xVlc/etZJ5rUvCQplv0heVCOahXS7L4gkX3uuwhRk0xWxXaZWgn4HlTRnYd1dVgQ+c4IcYdDj
 acAw3Kp5BZU5XsqT0bJ2GXpNf3IKmA9zmZttAIuuP0lBgOtsVnWXjKYS4t3AK9Sy1XFOA0CBC
 e4nDIutt+Quifw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-961277992-1646668626=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 2 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, Mar 01 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > Changes since v1:
> >
> >  * In the patch that removed MAKE_TARGETS, a stale comment about that
> >    variable is also removed.
> >  * The comment about set -x has been adjusted because it no longer app=
lies
> >    as-is.
> >  * The commit message of "ci: make it easier to find failed tests' log=
s in
> >    the GitHub workflow" has been adjusted to motivate the improvement
> >    better.
>
> Just briefly: Much of the feedback I had on v1 is still unanswered,

Yes, because I got the sense that your feedback ignores the goal of making
it easier to diagnose test failures.

> or in the case of the performance issues I think just saying that this
> output is aimed at non-long-time-contributors doesn't really justify the
> large observed slowdowns.

What good is a quickly-loading web site when it is less than useful?

I'd much rather have a slow-loading web site that gets me to where I need
to be than a fast-loading one that leaves me as puzzled as before.

Ciao,
Johannes

--8323328-961277992-1646668626=:11118--
