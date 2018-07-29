Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79601208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 22:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeG3ARB (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 20:17:01 -0400
Received: from avasout06.plus.net ([212.159.14.18]:47904 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbeG3ARB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 20:17:01 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id juQkfZ496WLW2juQlfC8Q8; Sun, 29 Jul 2018 23:44:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=hX4uBdC1sfJZ_g8Si2IA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     alban.gruin@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin.h: remove declaration of cmd_rebase__helper
Message-ID: <36bfb2da-f163-67b9-4ddd-398ce137f85f@ramsayjones.plus.com>
Date:   Sun, 29 Jul 2018 23:44:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLP1spIb0Js+y3a5SrGdQ0O/SQaGPBxAmo870FQKa7oxsz6gUzh7HC9qo/pvCqMSUidzHw4vZ5vW+yneQyPQe/IJMMUwyY/ofOq0xZL43YV+lXA0jsrs
 CzhVFBObURRyh9mWDiuBSxRjhT/EuYK1VWgmDFT5JnF54cKAiLg3gMy8QfQKtfQxkdqv5zIG3XjitA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 94d4e2fb88 ("rebase -i: move rebase--helper modes to
rebase--interactive", 2018-07-24) removed the definition of the
'cmd_rebase__helper' symbol, but forgot to remove the corresponding
declaration in the 'builtin.h' header file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Alban,

If you need to re-roll your 'ag/rebase-i-in-c' branch, could you
please squash this into the relevant patch (commit 94d4e2fb88).

Thanks!

ATB,
Ramsay Jones

 builtin.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index aac8f5f340..6538932e99 100644
--- a/builtin.h
+++ b/builtin.h
@@ -206,7 +206,6 @@ extern int cmd_range_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
-extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
-- 
2.18.0
