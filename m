Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD16C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABFA60FD8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFJKdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:33:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:42779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhFJKdb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623321092;
        bh=7SLGt18NJ5VVamswmxDeAi1f7Fy5RLiFM4Uai7GilbM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Sre9cGEKU1e/9c9j4e5Ly5ZoCNqapfCJcsD5EQMuBC34pqOU+Y+UCGhABKzxY7ZtT
         P2gXAyGItBPdQLz6he5Ld5VhQ4rBxJWGVEWi/tRD8MMSVtDK47oWy5RwnA9hygULCM
         ZF6Z16va2VgVOvciViFg5G6bc8LdAGVAJUQEndRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1l3JBR0VcT-00uXXd; Thu, 10
 Jun 2021 12:31:32 +0200
Date:   Thu, 10 Jun 2021 12:31:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] multimail: stop shipping a copy
In-Reply-To: <pull.977.git.1623313765122.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106101230340.57@tvgsbejvaqbjf.bet>
References: <pull.977.git.1623313765122.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7fszZXGGmRHla/t5OU8DVbjovaVa9FvgrhqjVJg6a//vT3KgZ3x
 CBsRnklnzDAq0sxf+HRenygA0izrTRuU6UTtOtNmpbzGABzCbFXQaG8ieVAtQX2kvPH4wZW
 JzdUz/f+iDytZtEiAY8r20JtAdxLV8zgp4tkbGPfeoGjjFzZ7ZvtF67udRjARrOUcAzIsVK
 SFd0HmbzESIduZXX9+Uuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Pe37iR2cBE=:Mtnf9NfY5EH8HVdv3n0zPz
 cxtPog0Us0yzvIvGLI7TSc3ar+5Kh6+Xi/YDHnsDmN5DtN+IsG6EG6Q79qu9qGv+YPs+QeoPX
 aMSD/IBi+zKrpWv28AfMSB9ZP52WXhMoWByMCZqrJl5eFcny99InGXPMvAczFjwQB1r8oh9ZP
 72MDSh58Y1N2G7rdkR1Za1uW9it6PQ1VH/wFm5GWWopLlrDnK1xm9DeyMmu3felVqoIV/htT5
 gpwPF/lMbrJqc32GZpeRGP75B2oLjTF2AseIvCsHmkwjFTvb0bOFHPn0oClz/pssLwlafb5eG
 x1wiDBPd0F+p5VTiM4c4FsO0rMq2/DZImCsbMgzQbCkqLIjr0f3kgJot8LrHpDeKPcUrQs2Gq
 UX/80i+YepFkWgbojuU2iE527hqCfMgDOELgLtzjDQqAd3ZHLSkBT1SQa/ipYtpTNpSgWr1dO
 EYjFaC8hIQzZuCyOlp+zWio/SfYgwbJ7V61Yw701K3+d1vE5tGr+zHdEv2OZbzwlP4FxBHrW2
 WEp+/Fag3dDvrX6PF3IOAh6YrRpiAjs+7ctLOl2rVmVhmk0BKuyfF3IW3tRZm+/75IfijPJry
 mLSeTugGnsAkGdz8I7UCXCAzrVOX8dOzZPUS2BIcNRmZaRxtcy5Jy2SUnvm/gMN9+BLUCCSeQ
 1l9MekjW0sTVKIMiYK9p98clY+KCGdNtWIUBzUsPEfuo6YWXsLXCdWXZkM0OhHo+m9AWDwzU5
 ph3BK+Zops8RCDRgIpcpuGM5LAe5+FXtLK+WCbSHPFA5t/kax0nsgwsFjAYGw6jUkBhh5xzpN
 MXQqDye9tfTLV8sT7ShwFLSSfGXrJuRqy+Fs8xLbADWAJKvuTYFJB+Ehnqqkcn9obX/WD87ZY
 AnwJFBhrEXO6GXSnYFsdsHtgfRF2Sq0kLdA176jtEz+Qm3EsezVAHIDjs02HFaXmDZ0rc0tn1
 SJk4rLioIbbK6sHynMh9+b7AMHU2IBtwDawbgoGCRXK7bionuICPk0HwAy+c9wfshgeTD/6qX
 aD24c2VQmkIMVeQ0LlD/zzZbghga8dDG4dKr9uonENQ+zXcm/y3NZOvBDhWSujAidlStx4U9w
 10jZMEzsgV7XRVg/Te2J61jyac9/fQdz5iWgQIU1rHOyhr+wmbj+KMn2g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 10 Jun 2021, Johannes Schindelin via GitGitGadget wrote:

>  contrib/hooks/multimail/README.Git            |   12 +-

I should point out that this could easily get lost between all those
deleted files... The diff looks like this:

> diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimai=
l/README.Git
> index 044444245d09..c427efc7bd8e 100644
> --- a/contrib/hooks/multimail/README.Git
> +++ b/contrib/hooks/multimail/README.Git
> @@ -1,15 +1,7 @@
> -This copy of git-multimail is distributed as part of the "contrib"
> -section of the Git project as a convenience to Git users.
>  git-multimail is developed as an independent project at the following
>  website:
>
>      https://github.com/git-multimail/git-multimail
>
> -The version in this directory was obtained from the upstream project
> -on January 07 2019 and consists of the "git-multimail" subdirectory fro=
m
> -revision
> -
> -    04e80e6c40be465cc62b6c246f0fcb8fd2cfd454 refs/tags/1.5.0
> -
> -Please see the README file in this directory for information about how
> -to report bugs or contribute to git-multimail.
> +Please refer to that project page for information about how to report
> +bugs or contribute to git-multimail.

Ciao,
Dscho
