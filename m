Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630FC1F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394095AbeKWWBQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:16 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:17414 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbeKWWBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:05 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9STg6d1v; Fri, 23 Nov 2018 11:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971833;
        bh=qqFQ+xCJS9aU6J8Ue54V4ZLPmxVZ8s0QOfEFPfm5aeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Dg3X6LeTg5ARHSpuajfK23nwejIkXnqbhdx6aIBnF9iNYiBKOarcEiCC2zTNHtsgt
         LTW2lGYSx5vP7MJeQDbMc8NSC+MHZg1sXzN8v9JvNHpQYxkpyXa5Dj8b+utBVl8rJ3
         lUeoHyrUBkPW4TEg0WV1xvYZbnp4WedofeFIBNq0=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=yw5fJXnJMgFpwyS4Pf0A:9
 a=f9aCmhBTQ53VgKac:21 a=2m-_gztBrrVWL3ml:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/9] Use "whitespace" consistently
Date:   Fri, 23 Nov 2018 11:16:51 +0000
Message-Id: <20181123111658.30342-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEY3G6n8ycEBsdxHzH/SEtNYCamnEOCutBxmZBSf5WvgqCBUNuQVreqfYlYIIEI+QyYHprXc036Yhdxb6jcuzkmFZssDLaX3uIvDjNDZoKUYCodGjCij
 x+t9YjvmHP/5bLAXlf1GVyqeobhdzZ/aLkijL0U8VV01zXaj5tZONEYHOHXhhtbpGxEejptPvea32IoVXPdSmmMniCh5GJkTDzj8iy7MzFWl1nIqiwW3OU2j
 KI/bdMy1Hhj5V6VfLvEAaPYQBk3/lxM9YIDk/+rQQdjIJ5qDowobYuKfh3L31Lrz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Most of the messages and documentation use 'whitespace' rather than
'white space' or 'white spaces' convert to latter two to the former for
consistency.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/diff-options.txt | 4 ++--
 Documentation/git-cat-file.txt | 8 ++++----
 diff.c                         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 151690f814..57a2f4cb7a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -298,7 +298,7 @@ dimmed-zebra::
 	settings. It is the same as `--color-moved=no`.
 
 --color-moved-ws=<modes>::
-	This configures how white spaces are ignored when performing the
+	This configures how whitespace is ignored when performing the
 	move detection for `--color-moved`.
 ifdef::git-diff[]
 	It can be set by the `diff.colorMovedWS` configuration setting.
@@ -316,7 +316,7 @@ ignore-all-space::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
 allow-indentation-change::
-	Initially ignore any white spaces in the move detection, then
+	Initially ignore any whitespace in the move detection, then
 	group the moved code blocks only into a block if the change in
 	whitespace is the same per line. This is incompatible with the
 	other modes.
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 74013335a1..9a2e9cdafb 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -23,8 +23,8 @@ In the second form, a list of objects (separated by linefeeds) is provided on
 stdin, and the SHA-1, type, and size of each object is printed on stdout. The
 output format can be overridden using the optional `<format>` argument. If
 either `--textconv` or `--filters` was specified, the input is expected to
-list the object names followed by the path name, separated by a single white
-space, so that the appropriate drivers can be determined.
+list the object names followed by the path name, separated by a single
+whitespace, so that the appropriate drivers can be determined.
 
 OPTIONS
 -------
@@ -79,15 +79,15 @@ OPTIONS
 	Print object information and contents for each object provided
 	on stdin.  May not be combined with any other options or arguments
 	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by white space.  See the
+	also need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
 --batch-check::
 --batch-check=<format>::
 	Print object information for each object provided on stdin.  May
 	not be combined with any other options or arguments except
 	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by white space.  See the
+	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
 --batch-all-objects::
diff --git a/diff.c b/diff.c
index c29b1cce14..78cd3958f4 100644
--- a/diff.c
+++ b/diff.c
@@ -320,7 +320,7 @@ static int parse_color_moved_ws(const char *arg)
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
 	    (ret & XDF_WHITESPACE_FLAGS))
-		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+		die(_("color-moved-ws: allow-indentation-change cannot be combined with other whitespace modes"));
 
 	string_list_clear(&l, 0);
 
-- 
2.19.1.1690.g258b440b18

