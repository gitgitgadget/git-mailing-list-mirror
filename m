Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3356203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 14:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754825AbcLSOKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 09:10:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:61729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753990AbcLSOKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 09:10:14 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LevUh-1cwgph00yt-00qhhn; Mon, 19
 Dec 2016 15:09:38 +0100
Date:   Mon, 19 Dec 2016 15:09:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 00/34] Teach the sequencer to act as rebase -i's
 backend
In-Reply-To: <9d399b83-92c6-44e9-8415-7695e690e8be@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612191508510.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <9d399b83-92c6-44e9-8415-7695e690e8be@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aF6A476fxF2pjMGrpUoq96KdDqMYsjM7S2OA70aBGAgEO4z4nCa
 8Wj4EXc+DQoPNOY8CZHulh4i4JGvvZG8C5T243Pch2dPnEw6zIfWg6aGohNZMWqD/s27GyQ
 zQkJ9edQ/CfnRLNjdrcoDtKcfyrQ8oHJqslCEEOdBxwWcOVARPXe4xrJrGYVGdMdeHBfS1Z
 JXJD1smsgyeXfQDdBFchA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z6/4xsAWtsg=:I2nYMTOK9f9s1bUudWlYCj
 t7mXYWWZpOCW+skwn3cKyLtRMnCljMtw669nuWQ/S5aRafz80XXRc2/vqwNyt8kK05d0efiS1
 sp0ckcokkvELxvdvJtNHz2P4ZRxV6Yc9yxR1KR19ph14l2nzPuSaPP8h9bnTy4Lc9yHjz14Ll
 BDaGyfcz0Hi+HJB9/mDqXdRZ5smfjiHO0kkHoyRFRCZzaSL6/rLgm6GoiiAmGsorCED3Pzh6h
 JoL9gJOIQPZe9pmYvfe2SP7RVEs7RT0aex49b/+k93zx6TI8AmNf5S+f1Sp1wCDp0M/Q+vaLy
 cS26tWfGIqhGeXBCsiESI6FSO2y/yaPa5KGgKvIpagYvpBLwn6MeMGvPXqtuT0PSjt/BX1Ifg
 JNtyLq0BYRcVtDFXwTIZXEDI9aTMQlSe6rTla3L7WBA/o0OspFYjWExpWhHnj7+GY4IHzZ9bY
 lwf1eI3hrxU0DUvW5DQ36QH7+waXebe2Lz6E6IYb3uxazdewBt9O02p7yplkr1OHpkF7T9weM
 +2d4r8ES8vpXmO2LYE32hZUrI3UJLVyWEZqgjoQhSYaoyQNjLSiKs2n867x70VZrEdJ4tc+s2
 QC7P/DrfNlT3z7tCsOTeaoQkRr5cSCQIpo0TbfWILAw5Pej1752Za6rqhR1s6aivztcSVmMFw
 QVLs18evsn+SwB7GDiSfhiVcyPAxmGuifhL2szarJgrtdzwM4dLraJH1qmzMiSCqm7ybaVlJB
 RGP6AAhZIX6HjSfm9p7VVoergF05RP9+tnIoh79vyL3j/Iap7he8H/gsQ4+3C7q1R27J5m05T
 874Cesn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 14 Dec 2016, Johannes Sixt wrote:

> Am 13.12.2016 um 16:29 schrieb Johannes Schindelin:
> > base-commit: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
> > Published-As: https://github.com/dscho/git/releases/tag/sequencer-i-v2
> > Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-i-v2
> 
> Thank you so much!
> 
> I would appreciate if you could publish a branch that contains the end game so
> that I can test it, too. Currently I am still using
> 
>  git://github.com/dscho/git interactive-rebase (fca871a3cf4d)

That's the one. Unless I forget, I use the Git garden shears to update
'interactive-rebase' whenever I update 'sequencer-i', too.

Ciao,
Dscho
