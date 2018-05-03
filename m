Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAD7200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeECPbL (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:34805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeECPa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:56 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lx4dh-1eGlkK1LFB-016hTY; Thu, 03 May 2018 17:30:53 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/18] branch-diff: do not show "function names" in hunk headers
Date:   Thu,  3 May 2018 17:30:52 +0200
Message-Id: <9810869ced952dbed3cb0972d1d1abd65cf14b0e.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1Dd9x/yNzO5dHDysVi8EUjGtiXyaGzHjdQRu0Ll8iPeqmBvKCuQ
 /aBJ1eayB/l9SzQ7OIcNJATXgpL5Pqs9Y94OtVAHFUz9Lh52QeusG5NKpn135ho/Qoa7UEE
 XbklYHWi8xah/rIg1dkvYAg/sp9v2LVABRzkq6CX2NvrMsHIYDFeCWNthp6C8u6EGN2wROW
 aVvFPLU+agpCyQrTlBtjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nkpzuCKWHI4=:DOD45+caM4UCZeXak13uUb
 YTV3pEL96+vZUcDhidj/4IX5oQ1zGkpSixVyTB4kMSPGXJEXgZGYl4Tv9SO7OIMj6wEFVZoW+
 NkZoY/BZQtFO7Z4t5CAUkyzXRRecNCsXLKXf+8SEyzwORP6N7KgqiUjZvBBH/Suad/+Nn+lqh
 Zi5ER5tLHvOTl3xQAsv/jrKjFIE6sGAeuc3bIKfkJP0iS0Hpw7QuAJZSgU05phme6eCI08Ta7
 ruBL7QUyxkub38Vw3IE05WkHPEF1SwttP9B0XVJc2mWOPddwn/cK8dL8J+Fbn6HeJjxtr5fOQ
 +pmPcv+kAxXNrG51p6ph8hl63PCPl+8Is6Ulo8l5DPfWF9daWf3U8fIP7SBYDWC/76e3e2CpU
 +3nB7aWo0QK6VENlF0MrB2Xu6T6YftEq3HBX/5N5VmpQ+iChSsPdXegNKLkVb/dRAiHij4jGA
 SWXxWkQx9JMaHFs3j9dUqjb1t+Rz9W0p39mIcOeiGmFhd0foy6nXub3RyT9um5S11B76/U7YT
 7uPXtNu79SJpwQ2wWg01tnkW0GnUhWHPJiZQ7iSm6hJzWWX8K0h6YVRxrINeaP0BbgBnXAQDk
 M5hlX+yRi7Aza/nga/MeakaAJ3C3xnW6yTUzoewpiLfENTkudBmNqzWmia3LXvmhqrFQTyPgO
 QR+bYQtoXxBYbXUOaTlv4QPNZU0qjAt2TT+RDFJUiXtGpaI04tpkH5qauxFWrbqPggLO9T85F
 3G0nzNdomW+z/i6JJFdSap8vrMQ9fzjPjdXvAHwtXvZDku0vHBs4ti0kPX+On7SEG7urVIKf4
 nGCvOR2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are comparing complete, formatted commit messages with patches. There
are no function names here, so stop looking for them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 0a0564b8ec2..7625da09e6f 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -10,6 +10,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "pretty.h"
+#include "userdiff.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
@@ -327,6 +328,10 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 	return data;
 }
 
+static struct userdiff_driver no_func_name = {
+	.funcname = { "$^", 0 }
+};
+
 static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
@@ -336,6 +341,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
+	spec->driver = &no_func_name;
 
 	return spec;
 }
-- 
2.17.0.395.g6a618d6010f.dirty


