Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B5D1F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 01:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdB1BYp (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 20:24:45 -0500
Received: from avasout04.plus.net ([212.159.14.19]:48243 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdB1BYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 20:24:25 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id q1Ns1u00122aPyA011NtKB; Tue, 28 Feb 2017 01:22:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=faj2egs8X6Q1Jet4ikYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] remove unused 'mkstemp(s)' code
Message-ID: <10ae63f8-329c-2750-5e7f-822e8b9a4186@ramsayjones.plus.com>
Date:   Tue, 28 Feb 2017 01:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I promised the first of these patches on 18th June last year! ;-)
(In response to Jeff's 'jk/gpg-interface-cleanup' branch).

Ramsay Jones (2):
  wrapper.c: remove unused git_mkstemp() function
  wrapper.c: remove unused gitmkstemps() function

 Makefile          |  5 -----
 cache.h           |  3 ---
 config.mak.uname  | 17 -----------------
 configure.ac      |  6 ------
 git-compat-util.h |  5 -----
 wrapper.c         | 24 ------------------------
 6 files changed, 60 deletions(-)

-- 
2.12.0
