From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH v2] git-svn docs: Use tabs consistently within the ascii doc
Date: Mon, 21 Oct 2013 21:36:06 +0200
Message-ID: <1382384166-7331-1-git-send-email-stefanbeller@googlemail.com>
References: <87ob6mxcpb.fsf@gmail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, keshav.kini@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 21 21:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYLGy-0008Ob-4A
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 21:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab3JUTgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 15:36:11 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:58093 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab3JUTgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 15:36:10 -0400
Received: by mail-ee0-f53.google.com with SMTP id t10so3929392eei.12
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pe7F4QERR8sVbsfYfge37eMR1XGopsijhE1f6zkhXDc=;
        b=ES8q0z4aNxMD/8xzxZIFy1pOZcTs5T8GF1amwWBio+mtTn7IZbH7KAqsnyRQKuxDq0
         O8iIeIxXzbJKps+35EHWym/qGFpo8hOTdnaSI3U2Mmip1wSPzT6FjipfRJVOReXMI5Wv
         F33sI8tdzSsd/VXKbLNzLoSEZvS5IYyLPmtnAQLT7fr4M6UmVfc9SEEr//PPJiAxPHqU
         yU+BV5KlK/JeJ6EZy7QjfjLa78CSt10htdhKjbumzLcF7jBDkEPYakKaHEEI6vKy46CD
         wAFCc7dwohz769omsOxBZ5/oH+cVprsfi9hBZXvEEnkAFu0Lxiw9niiVulGWL3CRvRJZ
         gueg==
X-Received: by 10.15.31.9 with SMTP id x9mr4301789eeu.53.1382384168470;
        Mon, 21 Oct 2013 12:36:08 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id e13sm47393397eeu.4.2013.10.21.12.36.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 12:36:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.511.g52c26ce
In-Reply-To: <87ob6mxcpb.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236448>

While I can understand 4 or 7 white spaces are fancy, we'd rather want
to use tabs throughout the whole document.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---

Keshav, thanks for the review.
I am answering late, because my mails regarding git are sorted 
automatically, whether these include me personally or just the mailing
list, and apparently you replied to just the list. 
No need to worry, I also included lines 278 and 833 in this version.

Thanks,
Stefan

 Documentation/git-svn.txt | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 2a38476..dcad890 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -175,11 +175,11 @@ Skip "branches" and "tags" of first level directories;;
 	precedence over '--include-paths'.
 
 --log-window-size=<n>;;
-    Fetch <n> log entries per request when scanning Subversion history.
-    The default is 100. For very large Subversion repositories, larger
-    values may be needed for 'clone'/'fetch' to complete in reasonable
-    time. But overly large values may lead to higher memory usage and
-    request timeouts.
+	Fetch <n> log entries per request when scanning Subversion history.
+	The default is 100. For very large Subversion repositories, larger
+	values may be needed for 'clone'/'fetch' to complete in reasonable
+	time. But overly large values may lead to higher memory usage and
+	request timeouts.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
@@ -275,7 +275,7 @@ first have already been pushed into SVN.
 	For each patch, one may answer "yes" (accept this patch), "no" (discard this
 	patch), "all" (accept all patches), or "quit".
 	+
-       'git svn dcommit' returns immediately if answer is "no" or "quit", without
+	'git svn dcommit' returns immediately if answer is "no" or "quit", without
 	committing anything to SVN.
 
 'branch'::
@@ -366,12 +366,12 @@ environment). This command has the same behaviour.
 Any other arguments are passed directly to 'git log'
 
 'blame'::
-       Show what revision and author last modified each line of a file. The
-       output of this mode is format-compatible with the output of
-       `svn blame' by default. Like the SVN blame command,
-       local uncommitted changes in the working tree are ignored;
-       the version of the file in the HEAD revision is annotated. Unknown
-       arguments are passed directly to 'git blame'.
+	Show what revision and author last modified each line of a file. The
+	output of this mode is format-compatible with the output of
+	`svn blame' by default. Like the SVN blame command,
+	local uncommitted changes in the working tree are ignored;
+	the version of the file in the HEAD revision is annotated. Unknown
+	arguments are passed directly to 'git blame'.
 +
 --git-format;;
 	Produce output in the same format as 'git blame', but with
@@ -830,7 +830,7 @@ Tracking and contributing to an entire Subversion-managed project
 # View all branches and tags you have cloned:
 	git branch -r
 # Create a new branch in SVN
-    git svn branch waldo
+	git svn branch waldo
 # Reset your master to trunk (or any other branch, replacing 'trunk'
 # with the appropriate name):
 	git reset --hard svn/trunk
-- 
1.8.4.1.511.g52c26ce
