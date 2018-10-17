Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072B91F453
	for <e@80x24.org>; Wed, 17 Oct 2018 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJRGLM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 02:11:12 -0400
Received: from avasout03.plus.net ([84.93.230.244]:56075 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRGLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 02:11:11 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id Cu4Eg28nUO2g2Cu4Ggc2XF; Wed, 17 Oct 2018 23:13:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5vPtxjDGDqfxd3Dcu84A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] headers: normalize the spelling of some header guards
Message-ID: <b33346d2-88bb-989a-356b-43a7c357a7dd@ramsayjones.plus.com>
Date:   Wed, 17 Oct 2018 23:13:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBaAJvmuTA4WaKuWWPLBvGBQi6kCTzy5y2kRVW/Llg52m19BPouE43WgZQrX0Q+jf2M33+MkCS4PG6JmzRisgkWeM2khnYmT7nb57EJ6IwiDI+FXeN66
 WKCYZtUmw6m587jB2TpW1O8RAkb/7nByEB/efRBOp139t677gMZHCT4/9UvtkRt+zSkOlLZA+jxhHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Since I didn't get any adverse comments, this version has the RFC
label removed. Also, given that it seems the vcs-svn directory is
not going away soon, I have included those headers this time as well.

[Note: my email client (thunderbird) was updated yesterday to 60.2.1.
As a result of recent reports, I sent this patch to myself and applied
it with 'git am' and ... the results seem to be fine! ;-) Famous last
words!]

Thanks.

ATB,
Ramsay Jones

 alias.h                  | 4 ++--
 commit-reach.h           | 4 ++--
 fetch-negotiator.h       | 4 ++--
 midx.h                   | 4 ++--
 t/helper/test-tool.h     | 4 ++--
 vcs-svn/fast_export.h    | 4 ++--
 vcs-svn/line_buffer.h    | 4 ++--
 vcs-svn/sliding_window.h | 4 ++--
 vcs-svn/svndiff.h        | 4 ++--
 vcs-svn/svndump.h        | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/alias.h b/alias.h
index 79933f2457..aef4843bb7 100644
--- a/alias.h
+++ b/alias.h
@@ -1,5 +1,5 @@
-#ifndef __ALIAS_H__
-#define __ALIAS_H__
+#ifndef ALIAS_H
+#define ALIAS_H
 
 struct string_list;
 
diff --git a/commit-reach.h b/commit-reach.h
index 7d313e2975..122a23a24d 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,5 +1,5 @@
-#ifndef __COMMIT_REACH_H__
-#define __COMMIT_REACH_H__
+#ifndef COMMIT_REACH_H
+#define COMMIT_REACH_H
 
 #include "commit-slab.h"
 
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index ddb44a22dc..9e3967ce66 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -1,5 +1,5 @@
-#ifndef FETCH_NEGOTIATOR
-#define FETCH_NEGOTIATOR
+#ifndef FETCH_NEGOTIATOR_H
+#define FETCH_NEGOTIATOR_H
 
 struct commit;
 
diff --git a/midx.h b/midx.h
index ce80b91c68..ee83702309 100644
--- a/midx.h
+++ b/midx.h
@@ -1,5 +1,5 @@
-#ifndef __MIDX_H__
-#define __MIDX_H__
+#ifndef MIDX_H
+#define MIDX_H
 
 #include "repository.h"
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e4890566da..71f470b871 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,5 +1,5 @@
-#ifndef __TEST_TOOL_H__
-#define __TEST_TOOL_H__
+#ifndef TEST_TOOL_H
+#define TEST_TOOL_H
 
 #include "git-compat-util.h"
 
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 60b79c35b9..9dcf9337c1 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -1,5 +1,5 @@
-#ifndef FAST_EXPORT_H_
-#define FAST_EXPORT_H_
+#ifndef FAST_EXPORT_H
+#define FAST_EXPORT_H
 
 struct strbuf;
 struct line_buffer;
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index ee23b4f490..e192aedea2 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -1,5 +1,5 @@
-#ifndef LINE_BUFFER_H_
-#define LINE_BUFFER_H_
+#ifndef LINE_BUFFER_H
+#define LINE_BUFFER_H
 
 #include "strbuf.h"
 
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
index b43a825cba..189c32d84c 100644
--- a/vcs-svn/sliding_window.h
+++ b/vcs-svn/sliding_window.h
@@ -1,5 +1,5 @@
-#ifndef SLIDING_WINDOW_H_
-#define SLIDING_WINDOW_H_
+#ifndef SLIDING_WINDOW_H
+#define SLIDING_WINDOW_H
 
 #include "strbuf.h"
 
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index 74eb464bab..10a2cbc40e 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -1,5 +1,5 @@
-#ifndef SVNDIFF_H_
-#define SVNDIFF_H_
+#ifndef SVNDIFF_H
+#define SVNDIFF_H
 
 struct line_buffer;
 struct sliding_view;
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b8eb12954e..26faed5968 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,5 +1,5 @@
-#ifndef SVNDUMP_H_
-#define SVNDUMP_H_
+#ifndef SVNDUMP_H
+#define SVNDUMP_H
 
 int svndump_init(const char *filename);
 int svndump_init_fd(int in_fd, int back_fd);
-- 
2.19.0
