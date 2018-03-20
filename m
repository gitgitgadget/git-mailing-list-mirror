Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CF91F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeCTPgs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:36:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:34427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeCTPgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:36:47 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1fHtb62lhp-00K9Hi; Tue, 20
 Mar 2018 16:36:41 +0100
Date:   Tue, 20 Mar 2018 16:36:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] rebase --keep-empty/--root fixes
In-Reply-To: <nycvar.QRO.7.76.6.1803201634260.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <nycvar.QRO.7.76.6.1803201635580.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180320100315.15261-1-phillip.wood@talktalk.net> <nycvar.QRO.7.76.6.1803201634260.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ho8mcFUuK/AMAYGF4vqjkc0CwCzqT2eysK9sCMdYlT0eE9sPHhQ
 RW42iDVNR4CVJETWaXwlTOf3RN7Ra21JWgzpMhuscDdLGPJPYKlkSN6HqNwWpNkusf5vY9L
 MABC0zAyQJzaSphhRLbOXRa44apkK1ZQeOf3SItnSEzUCA1+tk/pwDmYhLiRanOT/ZlUtsk
 MgvXnFi2+izbREuppyIjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3ojhMJjDwcc=:BvVXeo4OKy4aQhn6qmc8qe
 OAVWAdWgPsr86w8tc9J3l9g6WHGTR00FEMjaSOza3RzPfAX5bluh2hR8NIO3InjtFR62zWlkp
 tYd05oqr1eznhXyAQq91wyvuJPmkRdrsSMVFlGECQQa2KcNB0u4CdgqiLDWymml0voEtDhNMB
 4tmh6rFz0tEBDi2qyi3qenlf7Ksak2I8IVkG51ISS/11yu5AC8gVzzKY8jUmk1W3w5Fw8gJi5
 xMG573SE3Z6bbzJCM4y4QOtnVBOjHyCmFaZ9IoyN00pRt0J17CgBi8hELtnmsy+ThVdBPEpEf
 XH/rFL5vGjJGCoySnMoiI6SmRUrURslQYpPvbVBRhwaMrvos7NiZO0PQH+1m3RQKZfKE738HF
 5O9tIltoiR3iqWLhYxNrCmo+rAmrPs84/sqzoUY5NxubxjwQfsy0oGfCRe6Du9IWU+tAVGdO/
 QNFK4Shv3NK0C96lyBzPm9X1ays2pAwE+J4phdoUWZjbqCO4nw9GHXKx7VGHgpiMGTx0gWz7C
 Yya+Q/L7dzC7YJ7xL8TkfsMtM9cxLGdzjJdoRNrpp69dbljtRN5Uwxuw8c9twe9J2oS2zzsqo
 wT8rdytVR3yWG1Q0MgtH2DD3EtFZIvXynNk2ixI2oT12r4kUetE8e0uouy4ERgSC5JBKhTMSd
 KGgfCnfTBESryLGiQNJqToAcKx3qLNw1+uvS0m1jk59IExkiQM3sEZlMCqOQ6B77/ONv9sYCS
 zj7AtTpKtfNYsHB0ExtFQM1GRM7dAcXLRY4mV7VaL74KGi1Em9NvgqZ0cZbzVi7IaOqq20Jb4
 Fod/UhdTnhzvP1b8pQs+I0mspTzWM5P06vTejgBKogh5da9cYk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... and now also Cc:ing the list and Junio...


On Tue, 20 Mar 2018, Johannes Schindelin wrote:

> Hi Phillip,
> 
> On Tue, 20 Mar 2018, Phillip Wood wrote:
> 
> > Phillip Wood (3):
> >   rebase --root: stop assuming squash_onto is unset
> >   rebase -i --keep-empty: don't prune empty commits
> >   rebase: respect --no-keep-empty
> 
> Those patches look good. I offered a suggestion to 2/3 to avoid indenting
> a code block, but I would also be okay to leave it as-is.
> 
> Thanks,
> Dscho
> 
