Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9AE81F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 23:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbcJKXqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 19:46:19 -0400
Received: from avasout02.plus.net ([212.159.14.17]:40631 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbcJKXqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 19:46:19 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id uPmD1t0020zhorE01PmEAJ; Wed, 12 Oct 2016 00:46:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Ebfs84XDKe5vKNb_tawA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] convert: mark a file-local symbol static
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Message-ID: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
Date:   Wed, 12 Oct 2016 00:46:11 +0100
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

Hi Lars,

If you need to re-roll your 'ls/filter-process' branch, could you
please squash this into commit 85290197
("convert: add filter.<driver>.process option", 08-10-2016).

Thanks.

ATB,
Ramsay Jones

 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index fe68316..cf30380 100644
--- a/convert.c
+++ b/convert.c
@@ -568,7 +568,7 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *
 	free(entry);
 }
 
-void stop_multi_file_filter(struct child_process *process)
+static void stop_multi_file_filter(struct child_process *process)
 {
 	sigchain_push(SIGPIPE, SIG_IGN);
 	/* Closing the pipe signals the filter to initiate a shutdown. */
-- 
2.10.0
