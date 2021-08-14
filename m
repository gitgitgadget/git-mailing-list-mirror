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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F10C432BE
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1170760F48
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhHNWMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 18:12:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:43353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHNWMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 18:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628979089;
        bh=PO7XPwkPl+Jm1gTfoW2iqWEiWE8Zp7ty0zefZqtXKes=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XyY/M9ps5gU+Mx+4GHndEnih0CcyooX7WoUO10AtRezU1yoDaO6Ooy2lt76N4A8yn
         ycNejZ0NA20Au1Ee4zG4VBJWtz25tDtJ7ypdWsx9gFHEAlYUQNBwOuVlwgR6nMy8s3
         WmFpteuoNsGcIP6rLepEjXq5qDJ0E0FBgx/YIm3s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1mYLB92mhi-00JKuS; Sun, 15
 Aug 2021 00:11:29 +0200
Date:   Sun, 15 Aug 2021 00:11:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Gerhard Buch <Gerhard.Buch@web.de>
cc:     git@vger.kernel.org
Subject: Re: Git GUI does not start
In-Reply-To: <trinity-1ab86a7f-c1b8-4934-9b31-861a78e15889-1628689643260@3c-app-webde-bap05>
Message-ID: <nycvar.QRO.7.76.6.2108150004430.59@tvgsbejvaqbjf.bet>
References: <trinity-1ab86a7f-c1b8-4934-9b31-861a78e15889-1628689643260@3c-app-webde-bap05>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HEhRGDSAmS3sjNeH8/I6RSNMRnTXnd2xMI9vI0Vv9QvWfE35nAe
 xxQa/Z8x3bLeE5tKvJ6fVq8OOuU/+Al1aNvQUfiIvV/ha4ZYotAXZRESk37rW5bv4S1btao
 E1CmUGLu6iUkHrQWGxGgHDhjw9Kg7PVBaQ92XS6MWh55uObkE9pqU9HxVgpNwYFQ8WOsktJ
 kmlb2nrX5t2s1ObZGpXYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uzj+QmHEmT4=:g9HQMjO1wBsjmTYf37iCD+
 LWQttNZ/V44hHWJdzI2ZbW3E6Ju+knlVRm94WHGvIF0U81vClpBgOY0GHUWOEEHtFXgfV2Ela
 xx0h6NB6TdO5vmL1T+urzVSSx4eXkUwPD6ZT6QuQPK0/siIv79VtkPGMMIwOQmyvGC2KcNJZI
 zGvp0DNHktZnnLWZ9u5u3e8Nx0Uscw4kPDjIWUd1+1CuN9gEOAjnDwwo9S3IBaZFE4jd1RM6T
 jbmoPJJMR3Wxhh3VRUFVlinUC6XgJtZTL3yJ9gBRnHeGGt45RTM6n8bcUApIoediLmtqtrFhZ
 Wa3Jp3NP2FcEGnW0KV2r+DguHGMl23mMOaBcNVdBjZ8SIQK1WcRC4ybvdA1jDx932MgzoQEMh
 yDGWhJ62CZEJzDig9wL3J3tLS2lYtogMghTQxwzfsaLYPyTmcWqM2ky/+JPwkhhHNeB7u5szq
 hyRoWP9Uo7mOx6/Y9pW6OdAhnETf21oPpcKk+7o+S3pEbpEMqlvlQ2e8F5uDslAcJVF624cv7
 MUlsDp5UBT/bBkZW8cS9rw9cgvM+eaLsgiWwdjt706QBpkAfjJE4rP2mtZjGg9I9LaYT2x3yF
 YGJBGKg2/K5M6IW976gjZZtNkNbmpd3Fupd3NgygC5qPtwlQM0ab27uC9xJiSUNKeAb7lCFgn
 p1VFSNFUjJt80UtXQqEiIm3SdgSSY+EZ2G5quXprh0u8XZFo7/PrWbVdbD7FZQGPCwoK+EcKQ
 SkE+GXy0Hirq0IG9WfQBsOKzPvlBx+L7R0AppYFYQN7sjCH3/oWDxCCvg6mLZIpzm1GX/ZalO
 yMztHOh01w45lfzjdMqBJRpub4NDMOIaSfVAeCtTw/GuHTzrNdKmCTa59Rop4UIHq1xpVjZV8
 /J0TCRhZ0o2YHsiVtk6cHsvCk325/6VZSvyJwm/9OMX9rHSTrqAVytLC+FThAIorvunL8+Xhx
 p9nPkSofyLAY6BWRzIDgC17oq869kuZBhHLFa9ZQ/ndorYqSMDTXK27GBoRWW/qmUwI3eo3xV
 awNWTBzZfLNk/f6Jz0Gmr1OeHjXZ2Q0mv9LR3pemZsxXP96RZKU69D4g51occ2oSQ7RVaR41a
 tFDplvVyoCdxhTqmiXJ3YI+YFLWZh0kdw6iEPoFP0qNyTfJvC3FbNbRjw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gerhard,

On Wed, 11 Aug 2021, Gerhard Buch wrote:

> Git GUI does not start any more and I'd like to share the bugreport
> below.

Since bug reports easily get lost on the mailing list, I have a preference
for Git for Windows reports to be opened at
https://github.com/git-for-windows/git/issues/new. That method also
provides a more helpful bug report template.

I have to admit that I am somewhat surprised by your bug report because I
specifically verify that Git GUI starts whenever releasing a new Git for
Windows version.

> Any idea how I can get diagnostic information to find die
> problem?

Since you reported this for your Windows setup, it would be good to know
what your Windows version is.

Having said that, the most obvious difference between v2.28.0 and
v2.32.0(2) with regards to Git GUI is that Tcl/Tk was upgraded from
v8.6.10 to v8.6.11.

If you could test with v2.30.0 (which still has the old Tcl/Tk) and with
v2.30.1 (which has the new one), that could help pinpoint the issue.

Ciao,
Johannes

>
> best regards
>
> Gerhard
>
>
> --------------------------------------------
> What did you do before the bug happened? (Steps to reproduce your issue)
> Open Git GUI -> choose open existing projekt
> It worked with the previsous version 2.28 before. Before posting the bug=
report I updated to the most recent version to be at the latest version.
>
> What did you expect to happen? (Expected behavior)
> That Git GUI opens...
>
> What happened instead? (Actual behavior)
> Git GUI icon appears in task bar, but not the usual Git GUI window.
> On left click on the task bar icon, the top entry says Wish Application.=
 On choosing this entry two Windows appear.
> One is empty. The second is titled "Konsole" and has (System32) 1% in th=
e field below the menu bar.
> What's different between what you expected and what actually happened?
> Git Gui does not start and there is no indication on possible reasons fo=
r this.
>
> Anything else you want to add:
> I've checked the project directory with git cmd:
> git status:
> On branch <branch name>
> nothing to commit, working tree clean
>
>
> [System Info]
> git version:
> git version 2.32.0.windows.2
> cpu: x86_64
> built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 17763
> compiler info: gnuc: 10.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
> [Enabled Hooks]
>
>
