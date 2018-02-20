Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDC21F404
	for <e@80x24.org>; Tue, 20 Feb 2018 15:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeBTPPf (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 10:15:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:33873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752401AbeBTPPd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 10:15:33 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LoEcP-1eHXdy1UPR-00gK99; Tue, 20 Feb 2018 16:15:31 +0100
Date:   Tue, 20 Feb 2018 16:15:29 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Tim Mayo <Tim.Mayo@ubisense.net>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Stackdump from stash save on Windows 10 64-bit
In-Reply-To: <3859F9D06DD39A44AB88A072AD53704DD08E9925@CAM1MAIL01.ubisense.local>
Message-ID: <nycvar.QRO.7.76.6.1802201408190.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <3859F9D06DD39A44AB88A072AD53704DD08E9925@CAM1MAIL01.ubisense.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QoWgBRi8nzKTr/a6LK3DnNsWBkdYd7YwwLa1t0iMw4DU3xDm9du
 dlIrZQJZHBZ4puhnifiDN/mCKF4EdnTA6j8YYn1W+DGkRu+nBjOr56cMDRJE611VmXch0zI
 2TH3+8ZBrJqJzRic8L7YQIoWuLpjoVnbAuIMkZksDiDfsmmEjyzYG7NdzgqqFvTPX9YhH4Y
 mAHKK/8C4ifo9oy+2NOOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TH/YNmy37YU=:rTcLkZzf9Y8wptZXD323bc
 yqwbQRwOwyipJCVuQ4FV1I386BdzTfax+JUHmt2ZbznQ5nmABCnUWf9IPyBAwgasuLGC9aiT7
 HwBqXD3ls/VOsqCUapwHwFV7nuszO5+sULNhh8qc/gMuN4WDYonlAH7Pm0QUxnqTbg0MPhhed
 WVykxU6BzLuMOktR4CveYeeWETjdEhE0j8i3xIZosE3WeObZd+EXkZCtD3rUlTXjUTZn6PCMw
 81GuFZCQA6xER2pCH/zptVAOyNd5qL+x8eyPML2K6HNVmHHHbIlNf/B8xggTccRoQ+WUDIpDo
 4Nmj5N9t/Sl/EjUJho0HlBu2XO0nx9P6sccyoob47QcJ6ciRm7GQq3YAkTFXrfK1MGiMZU8BW
 YlfVt1MCgHVe3hK94p5QAZfhK4YrhtvbOSsP/FVc5aAjaqFbf6rFF0ob9FaRvI3qj1hza/l13
 iIA+Mcauz7cLTBI2cOx4nSvZ5YL9lP4xcMBKarZ6e6DanM8YPUlbdrDmkuO0SC/9upyLlxQ40
 WFszm2FptKXNtqhnWP4Ly/CFqPJ5LIfKf/3p6ih1MmWfJjG1g28luUOw1NiEHjy1yxPI2TYlF
 LoOOgtUa+ad0JUCHjpM3x7Ab/QFmiSG3V0n8PZjeJnDIst53xioXnGKH6RJspnP7Ch4ZKQlB9
 NeX62VRJK4PcvPpJLZM1SCtRiUOTg/XwxhXSiUZeYewjn7qqiC+LxBYf166vBncBivqY7LR6Z
 8rx2ElfJUwiOqs6LSNsv7xe6B9cTFS/iuS2+BVzCqIwwC3cLTlN5efiwippCLLpswYLLgRU0G
 IyVzesyA3YAPNFusnfQbJs9nXxu1ER8tVngZ8X4omMahu7Nrf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tim,

On Tue, 20 Feb 2018, Tim Mayo wrote:

> As of yesterday, stash save stopped working on my Windows 10 box - I get:
> 
>        > git stash save
>        Cannot save the current worktree state
> 
> and a stackdump file (see below).  This is with the 64-bit version of 2.16.1.  Switching to the 32-bit version resolved the problem for me.

Can you please test with v2.16.2 (you can use the 64-bit Portable Git if
you want to keep your current installation), and if the problem still
persists please open a ticket here:

	https://github.com/git-for-windows/git/issues/new

Ciao,
Johannes
