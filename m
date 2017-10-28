Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570292055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdJ1RUt (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:20:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:53305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbdJ1RUs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 13:20:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgsVY-1dmY3g2thQ-00M193; Sat, 28
 Oct 2017 19:20:44 +0200
Date:   Sat, 28 Oct 2017 19:20:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision.h: introduce blob/tree walking in order of
 the commits
In-Reply-To: <20171028004506.10253-2-sbeller@google.com>
Message-ID: <alpine.DEB.2.21.1.1710281917260.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com> <20171028004506.10253-2-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8nCiOLIAwcThq9QAhnKsGrebmpz5GM/DN2kaqG6DYviGXr+4vW4
 GOKLMMdAtRDFUFawHPm/VJI8U9Ja7BFik2X+j1JF8YgnGZka4sNQoh1EtSFdeSK3SU8jMmI
 KPjXUDgIpfShBtN0YK7C0VxELD4D9fOLK2A1c4pn9mCW1v80n7auSbprUv7V7Z6uIpBG0eu
 bkE0yNCEmYhIjsvcDEmjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/R7YgMq2QZo=:AVu9B4h8niWXrKOSTDFsuN
 tA50+1PN0Ahm4JFE3YT1mALt1LDu7Grgaqteubuafur32J9GL9JdBDySDIfV3IRyorK31gvpr
 uWrPHLxsPUHAJbB+5MKGIPUvEQ91LFJNVdmFX4qXqrctZwo22K0WV5d1n/uYthYM4xMrVZ0w8
 ysj58wwbhrYuLyopUq1Ms7RJpyySHwBnIkuUv915i8y7lOV87QY+0KTpmo7FGQyTaIc0ruTBo
 eWzQwy/6SrFwWwmqVQ6ETBWLyDNwFCvp47c6V4xjPSU/g9D2YYiIO/ue+kTvnZnyFHoKKCB0N
 OH6JKikJio5+2b1PzD/sZ5leNuGE+SNSCvJrO0tku1ycgOMPnRmWe7L9mefkgkHf8AyWrXCMO
 eBW8Py7Rj8k2J1Lz+Qb5ilMRk+fF9sOfpGDMCfnBI0FPrEKRJJQtkIxLFLiPeeXEVyMGb2uJ3
 bQ8mBb0AAhh28WT/V/hIzXJpktaDUGMWI3o6UtwNtpMaSL8y36vPAuh7Wki7hTq+Kwa0ciu1w
 ax/nS6ZtsIWo5B9wLONnnL+74meCRcNfMST4XMk1u9v62jaUSp26qJVCnD8C/KojdSDA6GKp4
 s9BCnL80K0ahZ+nzrYiUUDwlpXFW1rgCem0XBLctweFXNlIJOEebbSiJ+LtA+fTA/LQRLPb99
 j4zVf7PAI4czNVxN8eEomnJO+c4umycR5JR2ux3zEu9Lbk1KPFYy7/7BZH6ZX/byzEl0KoBkv
 V2QiJIXxgsxrldcHzPAGzdzCccwQH7NJXGahpxxDPGbrL4SoqpGFu2FFCWgwENlCWODGXKK/k
 uKD7KGW95DoQO5+sbHVIQHlItqBNr+WB0eTj+N07/omlJRKk0Vzy8MCh2eIMJNDqNDQEkMy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 27 Oct 2017, Stefan Beller wrote:

> This will be useful shortly.

Something tells me that I will hate you in the future when I read this
commit message and lack the context (e.g. when blaming, where I cannot see
the child commits let alone the comment in the Merge commit).

How about:

	The functionality to list tree objects in the order they were seen
	while traversing the commits will be used in the next commit,
	where we teach `git describe` to describe not only commits, but
	trees and blobs, too.

The diff itself is amazingly easy to review, and obviously correct.

Ciao,
Dscho
