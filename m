Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1BA1202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 16:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdGFQAO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 12:00:14 -0400
Received: from avasout06.plus.net ([212.159.14.18]:47528 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGFQAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 12:00:14 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id hU0B1v00218PUFB01U0CAo; Thu, 06 Jul 2017 17:00:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=FG1MOFLUOxquYV2kBJAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] reflog-walk: mark a file-local symbol as static
Message-ID: <fc3e4da5-a432-3038-eb97-42a4f2afe766@ramsayjones.plus.com>
Date:   Thu, 6 Jul 2017 17:00:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

When you re-roll your 'jk/reflog-walk' branch, could you please squash
this into the relevant patch (commit beafb2c629, "reflog-walk: stop using
fake parents", 05-07-2017).

Thanks!

ATB,
Ramsay Jones

 reflog-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index a7644d944..8effe722b 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -284,7 +284,7 @@ int reflog_walk_empty(struct reflog_walk_info *info)
 	return !info || !info->nr;
 }
 
-struct commit *next_entry_in_log(struct commit_reflog *log)
+static struct commit *next_entry_in_log(struct commit_reflog *log)
 {
 	while (log->recno >= 0) {
 		struct reflog_info *entry = &log->reflogs->items[log->recno--];
-- 
2.13.0
