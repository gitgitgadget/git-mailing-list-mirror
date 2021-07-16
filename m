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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED8C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C4613F5
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhGPO3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:29:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:38169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhGPO3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626445580;
        bh=p15ZusEC7xLhJw0DJ7LJfIMGyv2Jaqo48DeLyQn1sPQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ytuzcp14mTyngbmRYcuczix73Td8A5ek2bDu+VHOudtLfbWPj3/lDHEfN/hqTAaR5
         NMt0sDRF7M0GaciZEc3SRCWx0/S+1EA2c5tJxITOaQJgS41SQVsbLxtwfyKaFPxWbO
         OLEI1LU8fCyqiEj/J7g2xqIuv8vZK61qujYuiRZM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1m7QWn1ocP-003aQP; Fri, 16
 Jul 2021 16:26:20 +0200
Date:   Fri, 16 Jul 2021 16:26:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Aleksandr Shevchenko <AlexShevchenko@mail.ru>
cc:     git <git@vger.kernel.org>
Subject: Re: Typo in english github-git-cheat-sheet.pdf
In-Reply-To: <f098c3d0-beca-c78d-9852-b222111e8873@mail.ru>
Message-ID: <nycvar.QRO.7.76.6.2107161625400.59@tvgsbejvaqbjf.bet>
References: <f098c3d0-beca-c78d-9852-b222111e8873@mail.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M1wgcnk36Gnnw61v++m5DJoTTba/gVcISv4HslKY6IdgH/p5+43
 2iiZiecoeFLkz4DjPdMRFN9h8mcMfZeed5VxoYKKKx4sTXnnEV+3m9Z2Sh/Fixe28p0W9TH
 dRe/AXgh9QSfKtCSzZQglQ35pw4A1m3zrxRLjoLWRiyhkb5M4CCthH4wvt6abTnh07hoFQQ
 X6oG9CSYr2+iqVZJ7xcLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4nCM4LLBM/A=:sQXOnvR7H/upm4fbStqZDW
 bg+neMMgdjy4YSNI6wD3HSBr89QwQNPnVl9LsRS03x9lZGnNLOfiH7yRJCRj8KZhiA11ybV7T
 g2ZSK7Yyvvz5EW0DnNg/4cAGBrnlutE9E4sSg13W+y8xyc6rnF1kj7fwphxdvVuFoIxji4n+B
 d/5cQCC3iA8fLyZ/pHMUNoegRuIyYWaYyfAGD5k28s/Ffm+k3xfeLW6ipE+6b3zzvhotCXFzQ
 etNa+8YHyDqTTQ6LsTZyTiNvAa+DM/BgIrfw5eDyGKzLZEANsZ79mF4xG3TADFgWA+4qnbKrd
 dyroqXattoxQbP+LsC0USMCTiLyuF8OyHAQrmuXTSnkH55It3EiP3hRYM4Tqww4BCsWFUUnTH
 tpwDDLLBgvwpRd9WGMCS22FE+H1a2WL1huG2KYrTdSVRshpJEuu84lpiw+a8mY24WwZ2f8OYv
 k39Qp7ryIu546/E7Kp9dyoxt0K606Du+M89YgA9p8Ql2K61me6KuOKaXlniufTuYsc1RjRn9M
 DeLmuc634LDkWyC7bquCX/oY6ZUOnolnPtt0F7qK1su0148+q6pm+jBzPMtxKBjQwbJXlQlUE
 tVsXIUO6NyeY5DbfV9Y1zyoZswW554NoxGQmoaa2ba92nUAJh0c9xqcqPpfX2J0Lu324jAsPr
 181RDMXQmlSyX5GmtV+nI76VliZsUG8Ujrg//ndZQXyFsw4e0OgIVhmRqD89LAubRmAOlYw1t
 Mw6iL9Q74hKTFnnRjEaD6yMsBDjeZgzK51CI/+Uescxn/icziqIlYlbS7c6E4hs1+QADXVPQh
 +1071F5VuVBKVDMJd3m3sDWEa3PXouxEMep31CZ+hnx42GJmPJP/zcZGEIWSRKLYItxWebQ8Q
 qWRcyZDrCH1ryXjBpii8kbJeuPqCKl56lsukrHicIrNqRrI+9p9ig+/pLPQ2H05Ym79YrFTPq
 bNqyPuRZOVvcMYZXQWvzb5AhyUNHI+O1/JkbPOJ64kBKvILQwrPR6Tr/1Y8s4VxZKuOHCA46O
 7kSw49gEAUsoe9yOAKMJw417tsbwYphTWOxslde3RSshx5ifkPbhUfUvWu82Zx39iHqeLU0fB
 c58ZkEHcJPSELG7xAqLbUHM7dvQwWKP/D8GW/XV0e5CcQlM3apzAJ1HXg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aleksandr,

On Fri, 16 Jul 2021, Aleksandr Shevchenko wrote:

> https://training.github.com/downloads/github-git-cheat-sheet.pdf
>
> The .gitgnore file
> -->
> The .gitignore file

This seems to be tracked at
https://github.com/github/training-kit/issues/810

Ciao,
Johannes
