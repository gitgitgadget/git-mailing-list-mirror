Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919FD211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 10:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeK2WAb (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 17:00:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:58083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbeK2WAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 17:00:31 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lm7MT-1fsi2v0pNZ-00Zj8a; Thu, 29
 Nov 2018 11:55:32 +0100
Date:   Thu, 29 Nov 2018 11:55:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Morelle <paul.morelle@gmail.com>
cc:     Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
In-Reply-To: <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811291153550.41@tvgsbejvaqbjf.bet>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com> <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kWRqQCkKMJmbNSS1Qr2Qp4HrEPL7Mva2hDoD4ekXiXB3/Wt7HL1
 LfLOXkX6C0soRh0iZ7PnNFhEg72rWqXAVT439XvAk4wznMeNmRm5YfLT4tUU5h/4Xj+8NvK
 cUJzKpObRGsyqIOSp7C9l/bVybL0HgO/3Vkv8AeQJQVxiOskalRuJ1L0j6qpRWBSlfqr601
 FPmnsdKCwK+IiAGwMnulA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8PWoPwcdCI=:U8KmQd0lEbxjDNr4j5OLZ9
 3P3wrgg7m3YfdvIfeGTWhvs9nY+iKHnMwaE9z0ppcVD06hopLVhoR+/u6UbHVtBkeaqheMJtO
 NGp8bjy+giDKt0uSEwYqfJ59OCv/3x75bqlnnVaMmpKVFkDHjRabhfjdfME7ZoDRWYxJsa4vg
 9d7JvTT24lc5P2N38UEEHP64OHhlaqiJG8FhxEyuJaId/KeiBQzVuVJ1jsM9EWc2p9ZeLfuyQ
 1RjxfMoU9+61RbU7xh8/PpI/abw6u7SBn0XEZP3GfnwgrXMiWQVGCuvjyn1f0lSz7+WjKmKJX
 kdaoYyTzg9b2ZRo+dVX7u5Y1M/xDQSNBF2UWaQlqLE+KWD2b1vkMz3+MSQDH/m+ZSTm47OYP5
 oKIwThsOtdVLmkkU0f2SiWJzbppi8S2raX42KuyBNmE0gghgNgPL6MZ00qGuDRIcaqYd7j48F
 DEQ/kf74pRfnDrdC+rWfPEAfbYfAMjGZ4UJ8PhBAkiIVCGlMLiXHWhJmoRrB07Sh+tPTbglyU
 6AnyGiUqiMS8TZVXp/iLdqB9GliJSTDqH5CmdxUBxlWACTiaWv/Y2Njn40Khpnvz/GxiVuLiZ
 X2JdJsivGZbE8bzU+t+RPGwgvaA8TL6zwlcZ3DpwzHDhdnooQAUnlzi/ppqJh6BHnVTYq8ywc
 XWQrjwb002CCwqJBo0ZfmTc/+NANaVihUBLtJkgh2FMtylQbM+UlL1yRMEpPMpBsGN6rW4n2N
 3uhGf7il6V17+RBofZfqmhwgVppsYnb4su6B1ljuDDDStpIGXiZ6Bu+PcynmKtDudMP6OZewc
 dN2nVU+X0hDbt+I6oRPVJmuqFKNkjkuV5peFHkrCGCAP2RRAL9IrbCnqy/6oBA3VCh5hdUbZs
 +kqAfwHaREmjwSKODQizwzvWi7EIcSPUPScLHzPvesirVYtTLCkXuENsB5WCpMQLHjWoPnSQJ
 JcwY5rG9w6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Thu, 29 Nov 2018, Johannes Schindelin wrote:

> I already added a test... See the reschedule-failed-exec branch on
> https://github.com/dscho/git.

And now I put up a proper Pull Request, to be submitted via GitGitGadget
right after Git v2.20.0 will be released (technically, we are in a
feature freeze period right now, I just could no resist, as I found your
reasoning for rescheduling failed `exec` commands compelling, and there
were no `rebase` bugs for me to fix).

https://github.com/gitgitgadget/git/pull/90

Ciao,
Johannes
