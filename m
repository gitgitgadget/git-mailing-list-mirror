Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63E61F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 00:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbcJLANO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 20:13:14 -0400
Received: from avasout02.plus.net ([212.159.14.17]:43229 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcJLANN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 20:13:13 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id uQCb1t0010zhorE01QCcaD; Wed, 12 Oct 2016 01:12:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=AWDxOmMq-T39jaN36QYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: mark a file-local symbol static
Message-ID: <376d8514-fe01-cc37-691d-6e101af564a5@ramsayjones.plus.com>
Date:   Wed, 12 Oct 2016 01:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Johannes,

If you need to re-roll your 'js/prepare-sequencer' branch, could you
please squash this into commit 53f8024e ("sequencer: completely revamp
the "todo" script parsing", 10-10-2016).

Thanks.

ATB,
Ramsay Jones

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d662c6b..aa65628 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -880,7 +880,7 @@ static void todo_list_release(struct todo_list *todo_list)
 	todo_list->nr = todo_list->alloc = 0;
 }
 
-struct todo_item *append_new_todo(struct todo_list *todo_list)
+static struct todo_item *append_new_todo(struct todo_list *todo_list)
 {
 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
 	return todo_list->items + todo_list->nr++;
-- 
2.10.0
