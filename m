From: Olaf Klischat <olaf.klischat@gmail.com>
Subject: [PATCH 2/2] git-add: -s flag: documentation added
Date: Mon,  1 Oct 2012 09:15:00 +0200
Message-ID: <1349075700-26334-3-git-send-email-olaf.klischat@gmail.com>
References: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org, olaf@sofd.de
X-From: git-owner@vger.kernel.org Mon Oct 01 09:15:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIaE9-0002ed-9H
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2JAHPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 03:15:17 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39603 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab2JAHPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 03:15:15 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so4702522bkc.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NlQp+gmP5yC5/NYzZDHUmaljWiQJQontl3RKwwgBbiU=;
        b=h8HhVtqunA5NVtbxMiyU4ZyfQ7mvi9TN76BubYxFNRoZQcF0EzpU5CvUNWISR63HiD
         NizDlxiKGZyL0vd77J9/gXE94Ljh13QhUxL2Mt/7srMGo40YRya1FPlemkyVHsVxL4lH
         GpI2In2l15pXW01UVnXSXvESd205Ot2/B3sIz4SLF/YH94CYooY0Ulbehb26EtuX+QTq
         Gcrq8QWbjSBhsbmBme/vOQaAvxE2c4mVTvAIxJT/v8jgSuxyw1Bw8jjEpmnQf0f1U16l
         YMa0ucVlCPp54QSMhi/hrBldXJK9O44YxkdCJXZkzTebaejSBSm9LAPWl9NKLoWP1fL3
         LyAA==
Received: by 10.204.148.202 with SMTP id q10mr5527029bkv.55.1349075715055;
        Mon, 01 Oct 2012 00:15:15 -0700 (PDT)
Received: from tack.home.local. (e178068083.adsl.alicedsl.de. [85.178.68.83])
        by mx.google.com with ESMTPS id e13sm5851880bkw.12.2012.10.01.00.15.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 00:15:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206721>

Signed-off-by: Olaf Klischat <olaf.klischat@gmail.com>
---
 Documentation/git-add.txt |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index fd9e36b..a5a1cd1 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -38,10 +38,12 @@ files have changes that are staged for the next commit.
 
 The `git add` command will not add ignored files by default.  If any
 ignored files were explicitly specified on the command line, `git add`
-will fail with a list of ignored files.  Ignored files reached by
-directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The 'git add' command can
-be used to add ignored files with the `-f` (force) option.
+will fail with a list of ignored files unless the `-s` (silent-ignore)
+option was given.  Ignored files reached by directory recursion or
+filename globbing performed by Git (quote your globs before the shell)
+will always be silently ignored.  The 'git add' command can be used to
+add ignored files with the `-f` (force) option (which is mutually
+exclusive with `-s`).
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
@@ -69,6 +71,11 @@ OPTIONS
 --force::
 	Allow adding otherwise ignored files.
 
+-s::
+--silent-ignore::
+	Don't fail if ignored files were specified explicitly; ignore them
+	silently and continue.
+
 -i::
 --interactive::
 	Add modified contents in the working tree interactively to
-- 
1.7.10.4
