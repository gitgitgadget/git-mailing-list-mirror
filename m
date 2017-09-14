Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B07209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 13:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdINNt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 09:49:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:50112 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdINNt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 09:49:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfVU3-1e3IOd0rIh-00P2nX; Thu, 14
 Sep 2017 15:49:16 +0200
Date:   Thu, 14 Sep 2017 15:49:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] merge-base --fork-point fixes
In-Reply-To: <cover.1505394278.git.git@grubix.eu>
Message-ID: <alpine.DEB.2.21.1.1709141547100.4132@virtualbox>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu> <cover.1505394278.git.git@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/EaDAPYaKPeodgzwcCzStlRxrquAmqNmceMez5oHNYsvaPz51hs
 pOJYVIvcktKV2geyep9GijWsvl3427PJ6wcZJuFsTZCW0i/hkD4mVfz2/DpHlzSCLFV+ONv
 0sL51ak3RJCC1z0i1ufe0H2OUi8W6hlzmES3FSUfwDZiFQkkiX3jjmJSTBjtrSD+6cwZ8PG
 pMbXCXYpk6CUqOqIHKccg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tXH985R5/6s=:HgGRE7Kvr1O1J6BfM9kRS9
 e4RG5rSEpyxmsglOcuMqsYIBy0IF5+ZwYpc/cUrCMMm0cRzV/4WYNvfHULBoiJlO7pAIUaHkg
 gtTaCeN7/0ne8rBRi1lyC+xYRMAHE/QEmbt+REKOJ1ofX1JR7vfMIT6Yk6JpACWYhd9RF05ED
 suGnr1SZ7lUAOK3e52AKqywZsw0C0ElSxZFOJjy1e8pao6CkGqYcm1xyPNFbjIiLDifiqWAPs
 0JgThQuJfmpzYSsqKNv7ltbyxUggr1xCwWKh2oHpSXSMJHH9A9p4zYTPx09ZZHtBFTZOLCgGg
 scVTHVPWcyU4+XBBB0Og6IQGrzAhaVLPxZzty3CDwsR6goDP5T0AhmaTQFYWgXMZzPa+iDtYL
 zM5hyv7Dhq7QbyKXiFIUGeSt4NkjNBuW21QOTBLlu39bvU9nC6Ralulu9wnCy6gCBEDxIxkNB
 pbXdIjgo6l1KTRBaAHm0NZLPlnJd5LuPk3/RgZ2MGLzAQ3jUjh3RvCBPaFjKyCGku3zjDdnll
 4oeBP7+waa45GZ6EttZEcrJEOemPmKkpZC3WFYgn98GxtBODpimuGuRPQKL47+AA+s3zn/SAH
 kwFumPdVG0wZVLRwxr0iikffD06Pc7w4ZWi/xzrV36FMWGfijiKRWxB59V9BhrkUl72ZZ2FsA
 YzQFRpmb9oSDquKNeDSGa+EcPhi08f6I3arPnWumA5cBTjPgTC/ejR4YiwLQsj3SRlsMcnvck
 klvJwYnr74J48OcPhqSInH15r8CIhzqvaeNLBitoojJhQ4ZZlFCnmKWKgJTqlpWBwRkJckSaT
 llcWIXwGXUstBs6qNBT0YCRKotvxeV1MSmBwVJ3lpwhYqPmU5c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 14 Sep 2017, Michael J Gruber wrote:

> merge-base --fork-point does not quite work as advertised when the
> reflog is empty or partial. This series brings it in line with the
> documentation and, hopefully, with the original intent.

Thank you so much for working on this. I recently tried to use
--fork-point in a script of mine and it failed in this surprising way,
too. So here's hoping for this patch series being accepted quickly (and
sorry in advance for not having time to review...).

Ciao,
Dscho
