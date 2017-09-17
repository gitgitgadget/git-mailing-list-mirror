Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C5D2090B
	for <e@80x24.org>; Sun, 17 Sep 2017 22:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdIQWyD (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:54:03 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55173 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdIQWyC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:54:02 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Amtz1w00F0M91Ur01mu1BK; Sun, 17 Sep 2017 23:54:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=i031Ur5dpBupbI53Kq4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] minor PIPE prerequisite updates
Message-ID: <63afaaa4-2c9d-ed2a-9740-7d13ae7e179e@ramsayjones.plus.com>
Date:   Sun, 17 Sep 2017 23:53:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


These patches were developed on top of 'pu', but should apply cleanly on top
of the 'rj/test-ulimit-on-windows' branch.

Ramsay Jones (2):
  test-lib: use more compact expression in PIPE prerequisite
  t9010-*.sh: skip all tests if the PIPE prereq is missing

 t/t9010-svn-fe.sh | 55 ++++++++++++++++++++++++++++---------------------------
 t/test-lib.sh     | 10 ++--------
 2 files changed, 30 insertions(+), 35 deletions(-)

-- 
2.14.0
