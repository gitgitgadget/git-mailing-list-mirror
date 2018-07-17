Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB451F597
	for <e@80x24.org>; Tue, 17 Jul 2018 09:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeGQKR6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:17:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:57157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbeGQKR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:17:58 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhTjQ-1gRZPd3g4e-00mcS8; Tue, 17
 Jul 2018 11:46:01 +0200
Date:   Tue, 17 Jul 2018 11:45:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <20180710222005.GP14196@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1807171144350.71@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet> <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet> <20180709195822.GA9000@sigill.intra.peff.net> <20180710035635.GA13459@sigill.intra.peff.net> <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net> <20180710222005.GP14196@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5ZsO8+GyIHnYBi7NLTsduxoJB4w3i00T8vJMj9HQmuW3K2Iscas
 wO9tZhSfv+0eUexIAAgT89iLEeq+JHmg7sX00oOEM+UUAGITkGABv8SM/hSkV8ScG9s32Ln
 sSduiJPkyqVftUNi8MjMsjup/DGrZ8KHlcRtQj9IBsk1l1S6Qk5YoVPcGYkVluR+y+sDG2m
 QQ2dum3H8yUhg3H4rPZdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1ndyF3EB2gs=:HRrd2bmDJyPpZ4URnA75cE
 MUE6fviyu8GgvzZ68gAH4Hx7YT0iz6FqhN6SZGnW+NtlJfLwPf0TrBkKhTS4St7PCGb27keIX
 R+ANQejpsjgjVf2JzoDtM+c7iVbxEVMwaZLEVNXNCx/RKIVmqDCl7j7wKaR9BcYbU3nDFB4oy
 oBvPZNaPPtgYRW0qokNm3SuFFrfliOFo4dYMrcdYZDDLndkPCOgkgF/CPDf3mWCZMQf4vgkz0
 /dQH1q93csaNj52VT8u4HK0rdhraf3sprw2rdc0/d4JG+4uvqepTWFFPIqB0umAqUj1Ez3slG
 1+h6DF1IAnsMxLNjGIm7lN+K0CdQluGbEy8hi764Q0igUV4USMnB648nMG4LFo6mxBOHstbCX
 e9Uedy6br4vXmfh7yQPElYpTolGUBburLnxbw4vjemTthlyX1Cz28qeDytn4nPzTPNq9e4EJ2
 2TvoItNz7OyeOpjKQD2D8+yrgX+hGLMAfGbxC19csjufq42bHWVvXjrrp/2wihqp1Hfe3Wsxb
 Lblp2ky5TPdsumWo8fzoJf09yPnFtEe9zbVDbuWo3C5YO7g6+OIqsQOyjq/XruBAijapH8+du
 ZOhH7AbvXOkUodrzwZbTUvKw+/G9f6FHvpmGFeZ/y4EcWS8s3d/6JYi+iY5A9P93NQLC/ay9Q
 0Syo/c16dL1c7WCcAfZVZpprNH+5eZVxivN1NkaIvdBUxj8TdgG1yOwJZuCyyB1KtPP9cndva
 R0p8Ief5bu8sJO9wvyRgS0L8OluwyY0ch6gNm4wL/wt+aBYYU2LddZ+CrpdvrM6yfQEQUGPNm
 HxLoP1x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

[had to drop Perry Hutchinson, as the email address is apparently invalid,
and I only realized now that I never sent this out.]

On Tue, 10 Jul 2018, Jonathan Nieder wrote:

> If this [/proc issue] is the main obstacle to enabling RUNTIME_PREFIX by
> default, one option would be to make RUNTIME_PREFIX fall back to a
> hard-coded path when and only when git is not able to find the path from
> which it was run.

That is already the case. Look for FALLBACK_RUNTIME_PREFIX in the code.

Ciao,
Dscho
