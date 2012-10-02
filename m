From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] Documentation: move diff.wordRegex from config.txt to diff-config.txt
Date: Tue,  2 Oct 2012 22:21:06 +0530
Message-ID: <1349196670-2844-2-git-send-email-artagnon@gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:52:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5he-0007bu-RC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab2JBQvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:51:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61183 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2JBQvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:51:32 -0400
Received: by pbbrr4 with SMTP id rr4so8944010pbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xJjc8+FnQEQrv/B30l/6d+mKruswdyV7Jp3RmunvmdE=;
        b=MmcDaY7E5oYgK8sk0BiGmPG88qdte52xtJccQGg9EzWi7y2KgMt+UrmZeIv/MF0whV
         AvGbfbFx8Qnup6z/XGpLv2lXh2Au5RRSKTMDdza+uU0wsog1ZHQbUR8KIRUIjvayRZSY
         LQIZ/FU2Lq0zk2wm9rBmUw9Mb769vhWZOr+07HYa/3/QTZkVs19egwBM+mtPdZxYx7ww
         a6SeHFlsG2jUUWZbzw332/4xwsvaWgzr1tO/VOyGnjGcm7Xj3l/KCDsjJYuMrZAddRam
         4rqPIKCl3PRaz4YJbGY7wYfYqm5i99pv7D0u+Q/m+SY4CVqusf8T1M8ZdCVEzfrO+Nmp
         2iFA==
Received: by 10.66.88.40 with SMTP id bd8mr45538872pab.36.1349196692164;
        Tue, 02 Oct 2012 09:51:32 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id qd9sm1151524pbb.31.2012.10.02.09.51.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:51:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206814>

19299a8 (Documentation: Move diff.<driver>.* from config.txt to
diff-config.txt, 2011-04-07) moved the diff configuration options to
diff-config.txt, but forgot about diff.wordRegex, which was left
behind in config.txt.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt      |    6 ------
 Documentation/diff-config.txt |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 11f320b..d1de857 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -962,12 +962,6 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
-diff.wordRegex::
-	A POSIX Extended Regular Expression used to determine what is a "word"
-	when performing word-by-word difference calculations.  Character
-	sequences that match the regular expression are "words", all other
-	characters are *ignorable* whitespace.
-
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 67a90a8..c2b94f9 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -103,6 +103,12 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
+diff.wordRegex::
+	A POSIX Extended Regular Expression used to determine what is a "word"
+	when performing word-by-word difference calculations.  Character
+	sequences that match the regular expression are "words", all other
+	characters are *ignorable* whitespace.
+
 diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
-- 
1.7.8.1.362.g5d6df.dirty
