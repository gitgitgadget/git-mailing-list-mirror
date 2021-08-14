Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC8BC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0759460F11
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 22:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhHNWn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 18:43:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:47633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhHNWnx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 18:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628981001;
        bh=927QbYNRGMDoAL5wmU9ZElRPhjR+OBNogDCcoXyYoIs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=axB/B8l7IHEppXTbgg5nlpJaMWuPQvLN9+nQDibQC4dcFxceBmDvRfr0aQ2Kjvuk8
         Uf9ktoC2M3ZlXMLKPew9dXO/bapKdbiUV/gfwT5SsfVvNN5rJzrTL+bTrJ4WEKp1Pc
         BB5wpBNmtiTiTLpYpjShL0EGOgKpOFYal8xQOfU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1mWZFw3xMO-00Hii0; Sun, 15
 Aug 2021 00:43:21 +0200
Date:   Sun, 15 Aug 2021 00:43:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/4] rebase -r: some merge related fixes
In-Reply-To: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108150042250.59@tvgsbejvaqbjf.bet>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2037663009-1628981001=:59"
X-Provags-ID: V03:K1:SXMWEWtgs/TS/hDNYNet0yXdRtKb7ZkJLlwNPW14vOZuROuurEh
 h52RAZ06U1zsiKJbC+ShQ6JSMXglfbCWrDXhJnSnRQVSd7TCvrY6S4oSLmoUPVpJZrVAaID
 lI+h3cv1Mamdmse60T1rfT/ifEBq0v6yl0VITzCpBsHwaZQoKlnPp62rQW+U3ZNECI0nGTm
 EemCcx8kFcHzjlCNBy2Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nDpWizCV0s=:ha8p0nt9aOVpSD5ndwZnT0
 kv9y/ASC48Hk80PFy5eSSz9qtebo2S0mdghLcXKDAv0cQophd32xEdwBnSGOqL4BpceGN1FBe
 vcH/6Gkd99FA32VzwGAvGL0knaGGyZvkgseJABeZLGU6RxojJwcYqx+YR8+5ix1WDTqoepYSs
 O9GVtYXRcWHwSc025xd+GcWstoAAOhoHgtB5qBalLLRn9m72LsqqqTPjSUSCTs+Qv7EzNbMWZ
 7OzWLlwQlvNkX+gO87EvTbdg9sBGx3u8ysuYF0MZm4CJHVONHfQrDVmbtFDvDsGVVZICPZzXM
 oRosatZ+PIV5TrPpUZZZuT+gb2BuoAfiFZLlGbbvYUkhGcOSZq8JoIuF2QtXnSdSDbneFuqmG
 Gdy1AX+5xlNG7zL18RDnBm/CdACKs4vUhHjtQhKmTb8RpXJLMfN2AiV7jxPBCPu86+4oAFK9v
 INcWVJqR7V175H6/GlbjEh8n0k5KFlSPBi97gob292B5GE+Zsk7MIm4EMKZpvZNI61IQhYRYr
 wNN6KX8HwaeS5ZSFdhd5B4Q1FDkKsikF9gdJqyDDd5jYeMIh4B0lRDBHX9xmRBeMOousYrCu2
 GU2iXowKck412JnQ+ugdR57hyp7TQYuGHZ/Q2Hq43hBcbMEn+5h5/dZ1A0sh9bCKZkE8auWtG
 dxSCXWM2N4ZTivG+5aAE7obbHrYSowiPN+7DFER8Ca+FWzdeKIB5q2/z5+lJUjDSRSX5tK1YR
 MUvq3xoDzJ26djN0yPsVxTnrfe4AyGBC5SHdIKz1kZePXV76IfvAM4KFqBXNP7XdFACpy1LnK
 suR8pHaWfz6owzyVS4u+vEz3MZxjAmQyx2JJV6Z91Elo+2oM+ruGcWKYdHRXeQ1zPlGO7E+V3
 /4QHqGYZF842L1wE5vPa38CnQRpkRet83If36ZRDB/GzV2NNOmDMy4ZBon8NMdSF/KjVLdUp1
 mJr4XTXi28JLBtoXfxwcu+xEqp4W1PIET+Wsfs6PvoiERXCbWzgLRYQ5NQe0A0rZiS57hG6ub
 MojlDuypJtzTDMpsCJ47p6F0kLiW/Ulm2A8ViC9/SIc/TG+WUP5A9fmbzqy6GKOLzuDcsCg2l
 tysL4VJUBZZePiDRWbMcsDg7Fr8u3PXDUS9fwfgSO9R83GbmbLOinHBrw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2037663009-1628981001=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Fri, 13 Aug 2021, Phillip Wood via GitGitGadget wrote:

> This is a collection of merge related fixes for rebase -r
>
>  * Make merge -c behave like reword.
>  * When fast-forwarding a merge don't leave .git/MERGE_MSG around (repor=
ted
>    by G=C3=A1bor)
>  * Make merge -c work when with --strategy
>
> Phillip Wood (4):
>   rebase -r: make 'merge -c' behave like reword
>   rebase -i: Add another reword test
>   rebase -r: don't write .git/MERGE_MSG when fast-forwarding
>   rebase -r: fix merge -c with a merge strategy

I reviewed all four patches (the first one took the most time, obviously)
and it was quite the pleasant read. I am in favor of integrating them
as-are.

Thank you,
Dscho

>
>  sequencer.c                   | 106 ++++++++++++++++++----------------
>  t/lib-rebase.sh               |  56 ++++++++++++++++++
>  t/t3404-rebase-interactive.sh |  13 +++++
>  t/t3430-rebase-merges.sh      |  38 +++++++++---
>  4 files changed, 155 insertions(+), 58 deletions(-)
>
>
> base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1015%2=
Fphillipwood%2Fwip%2Fsequencer-merge-c-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1015/phil=
lipwood/wip/sequencer-merge-c-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1015
> --
> gitgitgadget
>

--8323328-2037663009-1628981001=:59--
