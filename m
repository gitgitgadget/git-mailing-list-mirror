Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9784D1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 18:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfAUSWw (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 13:22:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:46199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfAUSWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 13:22:52 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1hOILq2XCu-00esvo; Mon, 21
 Jan 2019 19:22:46 +0100
Date:   Mon, 21 Jan 2019 19:22:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
In-Reply-To: <nycvar.QRO.7.76.6.1901211916400.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1901211921540.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <20181211161139.31686-6-newren@gmail.com> <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet> <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901211916400.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RHfEivb7NaSmrX5aZCClrsaVacmi/EmopyDq6kcs8XbeofA4K3d
 QLuVOQwZ56dXEBzj0b7d1u8GpFnTZ6vLiaHXt70V8C4s2+mifXBRslR62b3B21fzb3sCP3w
 NmNZKJSqIKJ8a3UbG6sV8P5/kDdfD2gwPADtlSfpM6dvfx2Hui8BLJYwBE+zoqP/4K0RDjl
 CizKVct9t9ycDyMHtDE7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8/qtbnv96q4=:n+h0jvVVtGEUWm6rkepVvJ
 DFuTc1SQvEWKDcMPZY0JS6i4OLsDDbF/5JnhZ7DyUTwx3wWBXmT0QAIOEbTzGXuDVGk45VXia
 JQcuxBYjQxtByZetDVdDHwUdBC7u+mLe1Il7v+7KYZXm5lv00Ps9XGnO9T09MBe76rS5pUp71
 S7RpdK8qLzvas7HiFV/LoPPGf1mQY9guHD/GAFV+B7R/rTyEtJCG55D30vQ5XfeEITSUMJi6u
 LRrIQWH9eYPoFPyRfuNNXbJp83rZXUMvnAUmld1EGqQMMf6O2dv8p3pByvoSe9Gv8i3fPRH6I
 2ne2aGph94AyK67JomBg/vmUtwjx/zGPqBKQQfUz1zew9V/Pz4QyBiZ/t0byNxjj2MildSAfB
 xvQnSHpUt2+ZJRhoYJby7+G9u6B6ZZFAkgTRVNzs1wHuCTcpA3WcjXDbeo6wqOJ15dXgPTqsX
 7m3LqhJrGnh+6rwHBCz473nVVLulpI7iz0yLTfw09//u7/FnSblgghInFnk8gw27q6dDNTyfN
 X6zBW7ofwulfsxahHqvLdXBxfWq7fGGHpEiVh3QeGJXxzCZE1N4PnYPEd4FHP/10yVlZtyaOX
 l/LmQTE9zFtKYZ9/R7X2cXsgd7U/bBHD1/aigQD11NCBieqjaFGS34rbEIn8rW/4ke6+ZT7OR
 wXmlYju3Z+tcqp15GpPviD9Z+pqwb//0xxuIsJVllCahbOnQLPlItn13Edkh/k/hPW/Dz43zL
 cyP5ntJz6htM95W+//89v+5Xs31DKPo2QDdxQT6mfXXj+UFQp8f+qW07YnC0F3ePyE5FOHAhn
 kpe/gdkk58T6ejyyRscUHaz2S1aJTGU+We6lxt4S9sfnVgYuqJ/1EiWZhJp4JFz36TDVLlj18
 kI+0sdVm8X2B/LJPdGuB9jDdfZD3Kl/fEyaEasZD4HZG3csf1qMDhoXUUOdwGDJB7YJ7jlBkW
 YYq20Hh1bYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Jan 2019, Johannes Schindelin wrote:

> Maybe, just maybe, if you submit another iteration (and only if), could
> you add a little paragraph for future Dscho to understand that this
> clean-up was slipped in?

Oh wow. I guess I should learn how to read. The last paragraph says
exactly that. For some reason, I missed that earlier.

Sorry for the noise,
Dscho
