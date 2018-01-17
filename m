Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA891F404
	for <e@80x24.org>; Wed, 17 Jan 2018 05:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbeAQFOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 00:14:06 -0500
Received: from sodcd-04p2-40.ppp11.odn.ad.jp ([203.139.65.40]:63570 "EHLO
        sv-prius.atmark-techno.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750801AbeAQFOF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Jan 2018 00:14:05 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2018 00:14:05 EST
Received: from leno.local-network (unknown [192.168.10.190])
        by sv-prius.atmark-techno.com (Postfix) with ESMTP id 43891BF949;
        Wed, 17 Jan 2018 14:08:57 +0900 (JST)
From:   Yasushi SHOJI <yashi@atmark-techno.com>
To:     benpeart@microsoft.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes: fsmonitor: add a pointer to man page and the word itself
Date:   Wed, 17 Jan 2018 14:08:57 +0900
Message-Id: <20180117050857.10480-1-yashi@atmark-techno.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a pointer to git-update-index(1) and a bit more detail about
fsmonitor and watchman to help people following up the new feature.
---

Hi Ben and Junio,

Wouldn't it be nice to tell the world a bit more about "file system
monitor" we now support?  I think that "git status" and "watchman"
might not ring the bell for some, but adding a word "file system
monitor" may.

I know most of repos don't need fsmonitor but it's a cool feature to
have it. ;-)

WDYT?


 Documentation/RelNotes/2.16.0.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 919f3eb3e..0c81c5915 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -62,8 +62,11 @@ UI, Workflows & Features
  * The SubmittingPatches document has been converted to produce an
    HTML version via AsciiDoc/Asciidoctor.

- * We learned to talk to watchman to speed up "git status" and other
-   operations that need to see which paths have been modified.
+ * We learned to optionally talk to a file system monitor via new
+   fsmonitor extension to speed up "git status" and other operations
+   that need to see which paths have been modified.  Currently we only
+   support "watchman".  See File System Monitor section of
+   git-update-index(1) for more detail.

  * The "diff" family of commands learned to ignore differences in
    carriage return at the end of line.
--
2.15.1
