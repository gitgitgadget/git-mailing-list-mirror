Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E072B1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeC3Mir (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:38:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:47397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbeC3Miq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:38:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lm7MT-1eT6Vu3b4D-00Zcyp; Fri, 30
 Mar 2018 14:38:36 +0200
Date:   Fri, 30 Mar 2018 14:38:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 3/9] t1300: avoid relying on a bug
In-Reply-To: <20180329194313.GD2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301438120.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <385674162d2853f6aea153d9d30482034d9fa3df.1522336130.git.johannes.schindelin@gmx.de> <20180329194313.GD2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KWsmlp7j4erfcIzH3pi4Be2vLFRNH7AKvoycE3R0QRbTdS7AQct
 Siy6izdoLv601u0M16JF8WmzlymsgqiWyWdVPkhJKuRNWu5cu7hJOQo3X3C31b8OkkiNHwV
 TnL94vAJ+hLbcl1grW2HiOEyX1g3La9xjQD7D0/IK098cEdbML4+jlkc9YOFWsXlNDX2ItB
 Gb9CVSng2+FXGvduz4mpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6zLjP30a1XA=:k8ug1uy+mh78lKJ/NymGvU
 D/5hNu0oqNE/9TgBkbg3cfwOfNHuJm8MJF/0CGZPAwFqPHB+TYHYiY4xI5SwGBU5EIq+Q/eg+
 NlJiTYS7f7gA4Q2jBEE3q+tRb4GJOs79DGy/OkpUzZKGik8e9Uv+ck1D5OlBJX7xutvzaqXU8
 VMrbwrWhjK4OHOKjxHHv6Jap9+fuFuPSIAc39boU1FP11DB9GWXWIAN2NH2q6ZojQtpqwmIt/
 jp2kcaz8+KBYWycPMe3GWSmHUVCFkvHPj7q9h7LdQtnmJXx/6Y9k3nwFndUKFq4USz5HlfCWv
 0UQYjUsL+rBLHjmFIKt3h1fU8qDH2Q/6Aon4QY24Zy7wQkiO+ucwYB+QnyCXzaeM6Hwmku0EX
 MP1BPX/RNF5wMgDdfOFiSEqKginej5lC/wIBbHSsK9gBY7SAnOIm5d8Zrz8tnLuXki4QlbkF0
 AQnNrmbF/L0onET91bbuDXfTxQkl4v0yGkyGSxh/tZ7T6ZTUZpWAW5OLXV8hGPNKLb9DEfb4/
 5bf/xqX4175fHrGNbooSm5fu5hvm+Nu1h/7+sM3jtudvFW5zwyUukhExEa25NZponqBl1jBf9
 WUqqA//BlMxJxWmjCpiwnUoCjeTCTSSoLxFRXARWdgpDUJ4vBQgXNl9m8jCOoq/9fWsom6i2T
 V+a0afRK0JAdSRURGzGDGlArPuqH8CsU74KSoNpetwyx9axliH2hPmp60ps4iHcQEw+pgw8zv
 jTXVcF21+048S2NCL4zU9POqfGO0XtkDN/PuF5ledvbkNeeuSl2gyqtbZg+IoPfbEdd/SURL2
 QCA9CaRQJ5QkYS28r7MA1J5/GRmYyQchb9HI/A8B991nI8r8s0ZXSgqkeVltiRpaiyxeD4x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:18:45PM +0200, Johannes Schindelin wrote:
> 
> > The test case 'unset with cont. lines' relied on a bug that is about to
> > be fixed: it tests *explicitly* that removing the last entry from a
> > config section leaves an *empty* section behind.
> > 
> > Let's fix this test case not to rely on that behavior, simply by
> > preventing the section from becoming empty.
> 
> Seems like a good solution. I don't think we care in particular about
> testing a multi-line value at the end of the file.

... and if we did, we should have documented that.

Ciao,
Dscho
