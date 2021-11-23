Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709FC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhKWQRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:17:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:56281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234340AbhKWQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637684068;
        bh=ekDdREAfd+oBQPTdgmddBR8AQcVqg6KuPCeTblwNszE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X0sCrotYeo3Ae6fCPFS10lxxThoX/nZGpcfwO9G5QRry4h2mpzqstEHWfIhzY9z/I
         i4YGJrKuvcRRY9CdSMGKnNrs6ndgKjNi5Fdi7sZeKerJ4PX7TwsVeD2ndvNLgENTqj
         P4wVi3wXGui/j5NeUDCuZp6EWQgYuV5C2cXB3FRk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1mKMc62OMI-00oJ0r; Tue, 23
 Nov 2021 17:14:28 +0100
Date:   Tue, 23 Nov 2021 17:14:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Marcos Alano <marcoshalano@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: "format-patch" command doesn't support SSH signing
In-Reply-To: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231712510.63@tvgsbejvaqbjf.bet>
References: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jLkj6hZYzN08BLBI96d0y6KuE4yeVVDHDe/KMl6MqwWBmPpsdmB
 Ou+Umcosl0sz3vPsrEf+vuDGuV/K27cAUjGAlPwN2p14+U9Yh+2BrCm6gAOhMMPTRshn/Ha
 0leJXbuT3C+GCPQQsL0ncODD6iGSBAM4tXb58qjseyLH64JInQooZOC6lvD4Q7tGkxc2NJW
 /C2MrFtS74Udcb4DYQKbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SXEVvcCYGRU=:/Ow34+5c7VZ1j7NpqASRyf
 +/y/SesWv3h+nMdb91DoDpiL85ItFbaLrkxUvOvX/e3bv7O/TODVCBcttqBwo7gSGkeOOj4nS
 Wk3WQ6fcJP+OvN2U6bshkxnjtFW/P9CJQRF0DkR4DvJHNis/46XMwpfd2l3r3nokafyQSg/51
 HriHsK4sIctD2B8USoPocs5WgSSv8muEZPCneejBMnrV3/1QDEQA5i8qgOF6U4fT+FaIQ37au
 cjtQXb30tBDnBUUImPBqW1F/k/Y9UyBPJX1CTdsOzPYwTnqOzFQH+dHYBjGcSBGhv5SHf/3x0
 wTOH2KySniBp9Mga4L6H6GuzoursIGu9t2Jx9Fu4LLDC4yRMngi0gECemvaAsuvDpIeDF636w
 0Zrdk+MJ4Rq13tBum3ybqWWSkP+0k6OA/jBIdw5fF9ZCwzNBO1LFFd2kfehr2UU6Qfrrd6QXV
 bRNEWmOxSrwMd2jMNpLszRTOw48Ze/B7z/J7NjB3oaFspRqbylh/A7ibVOYPnJO4A+MQ2vHBe
 YES8gumWHc9qzFbawMel8E6U/CGYyiwjtkZMD9FnKfOkSskMro7rjdPn98QaTwWeIE1aqILQ0
 2MY8vAf4aRQFsnB0XCgAgJeiQ5D8wT6MW4T+z6RJXxqcaBwAfncfQhqWAI8dkleG+RfsuuvfH
 w2uVB1UJ2SusRawONhXk85Z0Wq/wixrKCkhVwcev1c64mN5hyX5bOKKdo1zhxXj2O1LhMRDN3
 5sIbw2IQndU3z8d5o1b79TpooAtNW269Az/Lw86rw3cN76odAD4T3ymjoD+lUcqcBudkY1q41
 3IhydjfBniUmVeDdrwgIzUbY5jB63T41ppPUmoEXHpNKKbiFDfNkZAIRWd7qKYAcPN7d1uhMD
 JTpgtUqVBcs/MF9/dT6qzaeVEpd60r6w17WI+ZBKOoCCAgq+yBmvrtcbHVYysdCpK/SWZp9ks
 M1odSxwtoTzR8JoaKKl7AGX1yoaAMnnUlENXnf1Xo5ZNisg794la5Rvvc0Zv5/xlgkD43kXHt
 TB/89jdwiFwLgR/cgycc1x6EapUhwSWeC4tHbhNhOrcSTeYOUi9ibfUMo1yhC8FugRJiIdIAC
 i2AT8/WZ8jq+5s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marcos,

On Tue, 23 Nov 2021, Marcos Alano wrote:

> I was trying to generate a patch to send to a project (Linux specifically) but
> when I generate the patch using "format-patch" I saw there was no "Signed-Off"
> line, but my commit is signed using SSH. My git version is the latest, 2.34.

A "Sign-off" is a convention for the commit message, but _signing a
commit_ is a cryptographic signature. They are two different things.

You can add the "Signed-off-by:" trailers via `git format-patch`'s
`--signoff` option:
https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.txt---signoff

Ciao,
Johannes
