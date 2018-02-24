Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EEB1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 01:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeBXBSs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 20:18:48 -0500
Received: from avasout01.plus.net ([84.93.230.227]:39385 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeBXBSs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 20:18:48 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id pOU9epk8eH3zXpOUAeyomc; Sat, 24 Feb 2018 01:18:46 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IJQs9DnG c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=ypW6AC0rABo2RKNsKAwA:9
 a=QEXdDO2ut3YA:10 a=u09W0hvIdLUA:10 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 0/2] test_i18ngrep
Message-ID: <b15b53b2-8aab-8cad-ebc7-6ed3f53d7718@ramsayjones.plus.com>
Date:   Sat, 24 Feb 2018 01:18:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMBoDrHxNHoiAZSF4JVOAGq796erCir2l3izDgrNysDQhD3kU4o0+pz2Isty8T3P0h95mAhXdYPi7L3OveHbB5bFUdAxA7IdBP0Lmi41Wg+2vN0f9bCI
 u6mm9Mg6V9l1ohq4KuOpzrFJsiR6GrzP6YHtSs6uJcmMIK2AI1q9wfhzzaXoaR0+RVFMX4e10WCvyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Since 'sg/test-i18ngrep' has now graduated to master, unlike v1, these
patches are built on top of current master (@e3a80781f). In addition,
the second patch has been replaced with the patch from SZEDER Gábor[1].

[Hopefully, I have included that patch correctly! If not, please amend
as required. Thanks!]

[1] https://public-inbox.org/git/%3C20180213100437.15685-1-szeder.dev@gmail.com%3E/

Ramsay Jones (2):
  t4151: consolidate multiple calls to test_i18ngrep
  t5536: simplify checking of messages output to stderr

 t/t4151-am-abort.sh        |  5 ++---
 t/t5536-fetch-conflicts.sh | 22 ++++------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

-- 
2.16.0
