Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE191F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeBLATM (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:19:12 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45826 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeBLATL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:19:11 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id l1pteISR1ykf2l1pve74zG; Mon, 12 Feb 2018 00:19:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B8mXLtlM c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=41AUjIt4wqzrzPBaGDwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] misc sparse updates
Message-ID: <56feb74c-2317-5665-3362-d730947c0395@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 00:19:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDczzrG20M0IC4f5GYcQ2ZTPa0IDIXm9V2/QvLgJVfm9DVzHBtnCoAOo3kud17zKooXaViU++HvqOikYeVVbHHrZ+7qHykrQR9tTKCCFq7cuP9/gFlM4
 RXib1Vm79sjH+YfxyRL+++R+1kFoU/JJ1g+l65NNm0GVGClZTgw4DhZwTb72mCnERj4RAh5IAXnuiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


These patches are based on v2.16, but a test merge to master, next and
pu are all clean.

Ramsay Jones (2):
  config.mak.uname: remove SPARSE_FLAGS setting for cygwin
  Makefile: suppress a sparse warning for pack-revindex.c

 Makefile         | 2 ++
 config.mak.uname | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.16.0
