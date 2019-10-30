Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E7B1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfJ3WXd (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:23:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:49939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfJ3WXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572474208;
        bh=8nRarcC1DyH/ylG14NJHfnsSW4WFC6y6wwjgjsC0gj0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HvDYzOWxwnbtsX0c41ZthHr3aaAjkdFvax3Sze5LHX4hfC91jnLvH+6DLs4JvuTVF
         hrBZSSGIP3MWGV4xPWsjKwq0w8xQIxVq3PJRQAh/KsePuStDDEw4d4pw5gfVliJSle
         8thgP46refFds6xuTOBZoZjI5wU1xOuG//OxPRuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1iXjJc1WjE-00Tjcl; Wed, 30
 Oct 2019 23:23:28 +0100
Date:   Wed, 30 Oct 2019 23:23:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.24.0-rc2, was Re: [ANNOUNCE] Git v2.24.0-rc2
In-Reply-To: <xmqqblty3dtx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910302317430.46@tvgsbejvaqbjf.bet>
References: <xmqqblty3dtx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4IIlcwMqOBRB/nRk2A4a9HkSD+VWa9p0/9rkmMqmudngSDQuIB2
 hvQwUaur0LalL9brQBAcQkeg9yqParSOBqk8lR1VhyPq1W0H6gpVbBp5Z4u31wUmFkfe4FV
 1ZLxbP+FxFThJeAmdhRwV3e222dC/vr42zXR+tescNTU1HEbL7KnoMGtzkG1tF+0Vj1zsNA
 j8+3CNtLYOaW0NnYfPIVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EXYNI6JueE4=:wNMQwqVTXTmYF8kXNq/KCG
 vWGzgilXct4/ome+Qgu+wfvbzcQz1oFedgIllQTW9lrxojtXwYZCow4LOC8sB6eTSz8fXdW4g
 t9I6ZRlrGAP5LJA6WNPafo88jodqtz3H5TqYEHU+x3cv7xoSC+/0SxhOLglTxIoH/vnmhsENt
 VbSC81d5lipuTaNoMe7oSpHZHEZSc4S/gwd9eXGzJCS4jogq5pGkEcF3P1/Q2q2pVcHFBn9sZ
 G/SD0AsVk4YVWcmS6+Ggjyo018hVtqeZQpIBe8gO7kOmfupBGRYBTHfj4N7AM01al179olHRO
 EURyVi1aMdGu8v/egmGEKukm5/2od1b3huId0EgjKhOllNegRo5DiZggsIZwQSwDvW40YtJ9r
 +PSmVetxth8sES1V9un16PaMMTgSYaN5axjIroLXMzi3WbpUAHNKYnvgYK/CHre9DV7d88vmr
 6beJa+g8+hRLmpUCY6sXs/6wpOhamw2JoSb9lOGGIj+WaQMUQXkNIq6z1vNtJtvqJZ2OVdkYw
 NrMTr6FeF99SaVrTdRRnuZ5tPWgBOywcUtJ7+E9h2gEWDCm1SaFJYRJtlwVl8iua2H3Es+V4c
 Nis1qmIW3KDpHzU/wyVTBKL2e3qFSJ9WbZf1qRmDbxsveOtP8e+AoMPEkfKdn0zomcc+XtrpL
 /tX6erH1X7zmnO7SKg4EaFmC72rPzo6mEOlstdcJ216+Ua818c/ss0RSx/0lrZg2SLh9D45IX
 IFakFAHV5f7weIsm8/yazDUocfxoNX0YKRjAAHvcxzXPuKi1xBHqiRxHkrDTjo/kBkdQY1wtp
 +JAtDBcoh8R366/ZaF2qpdwWciYM5tYGfRd0/oLGLATRSbMLGPUCKbh4YVmrN3v5+ezhhMEcN
 btyLNrtbP2TJ0rzgEJLfLKO/k20rjSNDlsT7123dUJK5eScwxo629i8/XxXxOhJ1C7n3mQRv5
 bxWdGkMCDVKoa0g6aDeUp+Y9ItaVrLx1c9ZKiyhvEqDP5ui6kvoPEt5D1EYQVx1VOysSwMnbC
 Cl5nK+PXbK/ym9XDPlNgnguPgAseefriiXQpjFe3sr4tDHX+3scHUpcWTqtWVX931xjdMGMXF
 lEK6IuUXAyHlGkFsjIgUDEMe9AKbx9gtXijKyZBWjTG9G1gGWbSH0SSKRkvdDQWJNGLIyy0uw
 lawI/4828bK5Ec6gy5LoJ/pmszFmfpkr/A8+47iHs7SsMc2nWetYHdJMwGshZ67wKFKA4tOmU
 Nco7MpMK3uXvSp1b90j2Zp4Dv+EqMkIFHA8SBkZLtfk7ntD4PG8RcxfpUJWI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Wed, 30 Oct 2019, Junio C Hamano wrote:

> A release candidate Git v2.24.0-rc2 is now available for testing
> at the usual places.  It is comprised of 515 non-merge commits
> since v2.23.0, contributed by 67 people, 18 of which are new faces.

The corresponding Git for Windows pre-release can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.24.0-rc2.windows.1

In addition to rebasing to v2.24.0-rc2, I also integrated three PRs
since -rc1:

- The `sendpack.sideband` config setting was re-introduced (I had
  dropped this by mistake, thinking that it was no longer necessary
  because the commit message failed to mention that this config setting
  is necessary to work around issues when pushing via `git://`).

- I also merged the current version of my fix for the flaky t5516 test.
  This will save me some time, as I currently have to re-run a couple of
  CI/PR builds per day due to those failures.

- The current iteration of the patches that fix `git stash` with
  skip-worktree items (where they sometimes would be recorded as
  _deleted_ by mistake) was also integrated. This will most notably
  benefit VFS for Git users, as most of the files are marked as
  skip-worktree there.

As always, thank you all for testing!

Ciao,
Johannes
