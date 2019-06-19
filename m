Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51551F462
	for <e@80x24.org>; Wed, 19 Jun 2019 11:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFSLR6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 07:17:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:45777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfFSLR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 07:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560943060;
        bh=+V8WIiFvTFjQhwH+58HfDBg1D9L76XP3xPQm/JDfGbQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NhlX4rVz1GNM6KnuiIcZ9aD+qGkmy2RXkWL/ZwY/1nR/KymiAiV57wQv7eA/uzjYq
         Syu6BxoDsEykPgfpxHlKxuxXKSvPn/DQviYy75WooGussco3CZ9SIMb4VL1HBdDKhS
         wahMY+t1wGU+nCFClA+ulN3w7mlZFVg6t8fRd0DQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1iRnpu1IR0-00tiOk; Wed, 19
 Jun 2019 13:17:40 +0200
Date:   Wed, 19 Jun 2019 13:17:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
In-Reply-To: <CAPUEspi-G7abt-zuLbw0iuyXN0gtrM_6Vy6d+9f-=6FpRsoV4A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906191316210.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com> <CAPUEspi-G7abt-zuLbw0iuyXN0gtrM_6Vy6d+9f-=6FpRsoV4A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PdZ49Wg5L8gQ59yJftSzwyZB3/JdTh1c5nCNxo0ngt7ueMbYwz1
 t9l/R6WbpH8u4uzz7A/ggXImP0XSpAqn+zuG1QVdMFKWRemVtqqARVN7arQeqK93nWgIYi1
 ebNCnmZfpYYmSezlE26HefYy75xhbBoIxMyzu6hOhOglI+bqmygV2Tc5GOK59v6yno93cSx
 lqqes2tUYGw2TQz3K75PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4GYvxnX57D4=:q66GdAr0YxnQzK2dFJrRyd
 qyK0USPPbuREWR4KOf/t2Mz+PPCua85uDBmI8dji/6jDwtvBFeqsmmnEG7jh6W9Atlsy7AMco
 MZDMO/RLJMt/EPaAGI5plywEg86b123WEUtS2GUOFwwmCUkD54yetGIsw0BXchi+oexg3kw5N
 PufXw5i/k5bfAfrlo2wprGf86MKTUR5dcN4F9RKBPfjI3PU3/UlaJk4BgRAlkMZw0myzm1aTh
 YhUStLpfT7M9iotLYAfxMYkX7DMFrcLHwqhOwwObFHXrE2JNedVdyhKxSe8dJZa+ddv+Ix7dy
 5/+V9c8EPF4uN2JUW/GXjdOTULOd3oplJH0h3pcSsachn9Yc1maRQNDMgYrrd2kePIrKWpsk8
 i+3WOYtJiStZTdkehMGxdEmKT6+O+0izepqPw3oiEBmGS0asVqvdhZRohCH63839uw23rbt4A
 FheotgHkc75quV7bnDvHx71bOCHv79KcRpvjO95UGC9nTADNPi8lZFwDykTqAj8y0DzKID+yH
 KDloSqOgs+53CKKh9ttt/mhK9WQXN4XnDCppf2JQi9Z+oMlmGpu5PzNM95aG9lvt9x+LqqsMO
 LTJkTqvhJ5/tvmjpbBKF8wnb/2lDzMQWRAsuy/nA6S0/XvmDFG0m++U4KK5Ie+HLoiS7P2q5Z
 gh2VbvjFZamzY9pPbsBI7lpnm2sZcuejqfZU7k+cRz1jkud3wfJZZUZjt5uBOMjb77tge/YLy
 B25S73DE4TmcxmA9FFlLTou6e//vSfxBos+IElmj7CduoSprmVxMPiwpIBL3QEnouo9TiA9vk
 DxUDWCTa5sDcW6ZD9akyprdyP6DioE11OG1xI0K8eLCsnp/0h0bKqeiivdu78RjhCYaxzKZFJ
 lj/qZcEHuBShtKNnxTkM3Ydwa2kAD3Zrw/08tvE4phPCZyYljBzNRuwTTG+2E2dgi+YKyJx/w
 r13IrqtpZQhuhdXRo4QVKrbUJ4NiZ2tdMIGWOpvr06R05SS2FiPdK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Tue, 18 Jun 2019, Carlo Arenas wrote:

> shouldn't this also be a problem with builtin/blame.c?

Sharp eyes!

It does not *really* matter as much here, as that file defines that
`DEBUG` constant if it has not yet been defined, but yes, it assumes that
*if* it is defined, then it is set to `1`. Which is the case, but it is
fragile.

I changed it locally already, and it will be part of the next iteration.

Thanks,
Johannes
