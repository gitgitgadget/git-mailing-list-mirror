Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C90201A4
	for <e@80x24.org>; Tue, 16 May 2017 15:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdEPPzz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 11:55:55 -0400
Received: from avasout08.plus.net ([212.159.14.20]:52128 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdEPPzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 11:55:51 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id M3vj1v0051keHif013vk97; Tue, 16 May 2017 16:55:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=MsxBiUeEA0oiKaxfdEsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t5545: reduced test coverage
Message-ID: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
Date:   Tue, 16 May 2017 16:55:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I noticed, when comparing the test-suite output from v2.12.0
versus v2.13.0-rc0 on cygwin, that t5545-push-options.sh was
no longer being run. (Well, now being skipped because it can't
find a web-server). Prior to commit 438fc68462 ("push options:
pass push options to the transport helper", 08-02-2017), this
test file ran three tests on 'local remotes'.

[I used to test with apache on Linux, but during an OS upgrade
(some time ago) I decided not to install apache just for the
git test-suite. (I used to run webgit and cgit, but no more!)]

I suppose it is not a major reduction in test coverage, but I
don't recall any discussion about it and I wondered if it was
by accident or design.

ATB,
Ramsay Jones

