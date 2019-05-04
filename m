Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193FF1F45F
	for <e@80x24.org>; Sat,  4 May 2019 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfEDSwm (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 May 2019 14:52:42 -0400
Received: from avasout01.plus.net ([84.93.230.227]:45529 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDSwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 May 2019 14:52:41 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 May 2019 14:52:41 EDT
Received: from mailserver ([209.93.137.151])
        by smtp with ESMTP
        id MzenhFgxk5kiLMzeohiKW0; Sat, 04 May 2019 19:45:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=RJbN4Lq+ c=1 sm=1 tr=0
 a=KJbuI3aomR4quJUoMUZhOg==:117 a=KJbuI3aomR4quJUoMUZhOg==:17
 a=x7bEGLp0ZPQA:10 a=YbTMELGUhT8A:10 a=pGLkceISAAAA:8 a=jOLVHZT_bX6jI0kz7RkA:9
From:   Chris Mayo <aklhfex@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] notes: correct documentation of format_display_notes()
Date:   Sat,  4 May 2019 19:45:07 +0100
Message-Id: <20190504184507.4405-1-aklhfex@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJww72fzr1CIq40HLpUeQG9rtWySC2BiC0mpLTYicIXubMJ01hXf+Q8Xtfg7A0/s1eGVujM3YoQV80x9TkvPyx1VRY+dVUBB4qXWKop+UqQ8NGP0Pkx4
 1Xw0xWJoDCIH1S4g1x6HByy/oixKUoUroiXhva295riXNNk5BQz9YcZj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'flags' parameter was replaced by 'raw' in commit:
76141e2e62 ("format_note(): simplify API", 2012-10-17)

Signed-off-by: Chris Mayo <aklhfex@gmail.com>
---
 notes.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/notes.h b/notes.h
index 414bc6855a..76337f2384 100644
--- a/notes.h
+++ b/notes.h
@@ -276,12 +276,10 @@ void init_display_notes(struct display_notes_opt *opt);
 
 /*
  * Append notes for the given 'object_sha1' from all trees set up by
- * init_display_notes() to 'sb'.  The 'flags' are a bitwise
- * combination of
+ * init_display_notes() to 'sb'.
  *
- * - NOTES_SHOW_HEADER: add a 'Notes (refname):' header
- *
- * - NOTES_INDENT: indent the notes by 4 places
+ * If 'raw' is false the note will be indented by 4 places and
+ * a 'Notes (refname):' header added.
  *
  * You *must* call init_display_notes() before using this function.
  */
-- 
2.21.0

