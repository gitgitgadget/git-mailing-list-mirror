Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3661F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfFYLk0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:40:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:42073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbfFYLk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561462821;
        bh=QlS7o1ex8kb8ojMh/SL4jTFwbKLg0pR0Q1hEaLv9Bio=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jn1acQDECTqjZwBTsfbM/mPoRkmrKaAo9b2tEdrwiY88awcS1ekTA/4/YODxQZMjg
         kkxcOu8bzvL1V2sKbje/ypOfbiIvsCAT7qF0GtxLMuHUTarvRCSgQOyFWHB8UBtIX4
         ET8uKW1zKPZZYM+EZ7oMSEdid1ExExw823YsJd2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwrwO-1idNs50e1Q-016SAI; Tue, 25
 Jun 2019 13:40:21 +0200
Date:   Tue, 25 Jun 2019 13:40:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Catalin Criste <cris_linu_w@yahoo.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] doc: fix form -> from typo
In-Reply-To: <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251339050.44@tvgsbejvaqbjf.bet>
References: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com> <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1595391619-1561462842=:44"
X-Provags-ID: V03:K1:/fW324SrLDVHyAW5H86WsqJMoLnktwAxzRjKHE0/WFh+MfVkgKx
 ZfYvq/6DOSM/bI79+Nr7YkWLyTkTZIv/bpEQlz4PRgPK8sx1lBRUpRXCw3WorrdBB8rHkI4
 r8ROtrqj7N5tZf6OIe4kSHwqN275ONEpfT9onDVkWNHnYr2E1dFM22TaEp9KX6geX99a/Vz
 koF9bgJKEoxf1AtvqzYXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8zIhAjLOTVA=:Mqk1sBCbvAQniIoWtytmZI
 065jSyplfqGqD+5ZLyKiXmK3drdjia/w2FypgrTeZ9O1KB+ZR4HW9rBbBEZTDN5PEGhL3b+YU
 kXRe1CYORobrznEgD0pMcv2t3IYofQwDRV6zvd/4R/V0nMO1U7h+snyJJHakdpH1PBHDR9+D8
 Tzclt37wcqmIYKqbiW6S6dRHM6vk5MRJ2HS/DMSlYD50v5gsH8p3BO6rVeem55uipLx3Uco8u
 7rEq+3MvCExy0+7hwtcthFHvLCzFvLiWa30lum25IvKUcf98oHAXLF9ety1kdSD8WUxaFve19
 AnFuEJaBGwvo7ghcdBye8WE10FC9x7ZUOTeQ3S7eVkX5sv+ZpFE9TA9wy3ugSJ0KWUkNDEthi
 pRB47TUu1O6flfQmotRGGtILWW2QGdsvA7EYnGkDAfyC+hziPh3qgLeilEyMeSAeQg6EYKvqe
 9dx0gHrX9YBMSI1XT9IRpvgBcnPtH/8qrQuDORydUnfJEVz9EecocM5p4rc4pspECNNX4zD9R
 gMJXdYNxkn2QQKH+MdVITV8/1V6l7N2Oyhc18xwrrs8++yHq3DWNHThrSCCh2DughwIpP7Oke
 GYebXOQsdm3ta3ESxh6bED/82O34pf1VMjPhcw6GNR4xPoEd1VBEsudQfdaPG6pp+Mmk1dGz5
 /i1TrFvceaLQxQorVOcJ6YmoUNUQomrhtb6Vrh2D9RkzP56CU4bd005Q43cKpLEJw9fD7V9/o
 rdmgOSKExvGNzMsK9Ivmc9FLWAghCG0DC9K+rJ/Kr2PUuEoculoQhEqaJuUMsYdqKfYijHpqF
 2HqCqLofqTJrwfncc0GSSHCJ1umUGgjFWo2s8gnUYoLE6rftcj2P5LRGA3lZUl4B8T5mHmcVD
 NhMTj7yH5/jtXaeejoTHpnWFJPfjrglQTQmKSCYXnaUqc4MkXR2hssQNN/PfT2rbR0wzo6Frt
 8ilGUN7UPByNBQcPpDPkMfyML661lRyUvKoB3OY4t9bRDbFOCEB1/e0DmSPsGmfWD3HICF1m9
 ydd3u18Fy1rnM6QNlTqnA4YsyO1Vcwla+M/DaTL/C5ha1iY1WNLYl9vWGHhCR+13EQHhV74aI
 yMNFV62jOTBfecXX+cDGUiNhh7qiywRBAZx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1595391619-1561462842=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Tue, 25 Jun 2019, Martin =C3=85gren wrote:

> On Tue, 25 Jun 2019 at 09:43, Catalin Criste <cris_linu_w@yahoo.com> wro=
te:
>
> > @@ -88,7 +88,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--inclu=
de-untracked] [-a|--all] [-q
> >
> >         This option is deprecated in favour of 'git stash push'.  It
> >         differs from "stash push" in that it cannot take pathspecs,
> > -       and any non-option arguments form the message.
> > +       and any non-option arguments from the message.
>
> I think this is actually intended as "form". It took me a couple of
> readings, but what this paragraph wants to say is that any non-option
> arguments will be used to form (construct) the message.

You're right! I totally misread this, too.

> Do you have any suggestions as to how this could be made clearer?
> There are at least two of us that have stumbled on this. :-)

Make that three.

Maybe something like

	This option is deprecated in favour of 'git stash push'.  It
	differs from "stash push" in that it cannot take pathspecs;
	Instead, all non-option arguments are concatenated to form the stash
	message.

?

Ciao,
Dscho

--8323328-1595391619-1561462842=:44--
