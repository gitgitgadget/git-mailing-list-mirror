Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829A21F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbeDYHlu (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:41:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:43363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDYHlt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:41:49 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lqi70-1eh7Ih1j3i-00eMA6; Wed, 25
 Apr 2018 09:41:45 +0200
Date:   Wed, 25 Apr 2018 09:41:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
In-Reply-To: <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1804250938370.4978@tvgsbejvaqbjf.bet>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org> <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com> <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fFZiooqD0l2VeDGiY2HQ6lEaiYPU3+lpdqLVKzfqczrKDvwJWNs
 kczjDM7BboicXcAgRlsmD7mcIbl4aky6ujejSAtJ+WlOLWcw/Ln8+teALFNTTvkIZ3UJTqg
 nk9jRTFMILsn48fnWnlhN3nPNxIoV1Abr4Cp7ezhxVd2AIz/mqdr5Y/gE1UQqk4OIjQCoTu
 v1FcB7Hd97k4a2nipagDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:soJfhat7rJ0=:dCGfcqE7yI9V/KstLIPWPs
 KWhoI+AsllwbWqEQ8563FPvyUcLkTd6KPr6v3fyJrboBIeFQge1zcFC/dmdbcDFC7dHtiNdsx
 SZTj57LhHx82W1BrOh8z6t0iA/ss16yp7CoEHNmgowyLxucexLyFWBcxfxmz8J6SiqO8R7mNw
 T8BkinBtoIMg0z1RFaNWV0iSaBXaS/uFfYZPZCSZMsEHxjqO+DKF9Hs4CCk+ebbAYvriryDIE
 KQP8uH2dtoBhcGmKboobA5zmwjBygaQYbWybo5G5AXZ9nK+8C02yRXpHbEOnOurcoo0f2HV4i
 DxmAAq9VXwHb/GGKpubR4sh/35jXn5/ibU8EL25bA4BmsJiOhsULsnnJtlOSYFHOfpw6Dk4eO
 isCSpnIokGLnr8SebmU4igIcsVOw02etJWUglSQA3pzNCTX6la8noledTs9HfVc99TZb9aACh
 vPLP5rYb3yAldXdC2ZGbRYdqtoHRMHbzpZKIBpBvJkDt8wrkB4h3wy0Et3kHWcoxw8whV/NO2
 eDyBwI70Nt9eFjvplnDNwSS9Jp/ip7FzwC9avHShCSdS4K5nzx8UFZohfJA4fvup+l0gTXPuI
 46y4FJQlDaSU84U5AX+vnEWMMoRfJt6SDOe5Yg8Kc4vGaS/FhUkxSOamicuG4pa9+P+IG1CJx
 KVLZiZK8HE8qRC/TVZ8yi/+PTOYs5hBFRHQQv2Yt5oALIvAZl+9DkOW/ETsnblnD1T4gMJSji
 6MTPOXj4Z9t1UEfrwdmnpPR944JJSuo4dED8f1yNangzinZTDQeu0q9IDAcg215zpTm1GApbS
 FGgd7tpr5mFrSaXGi+x9vQFqme9BKpCp7B4Z8Lc6SpA+9jaNxw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 25 Apr 2018, Johannes Sixt wrote:

> Am 25.04.2018 um 02:05 schrieb Junio C Hamano:
> > Johannes Sixt <j6t@kdbg.org> writes:
> > > It is not uncommon to request that the output remains visible in
> > > the terminal.

I ran `git log` and then hit `q`, and the latest screen contents were
still visible in all of these scenarios:

- in a Linux VM via SSH client

- in Git Bash on Windows

- in Git CMD on Windows

Granted, this is only the latest screen, but that is usually good enough
here.

Is anything different happening in your setups?

Ciao,
Dscho
