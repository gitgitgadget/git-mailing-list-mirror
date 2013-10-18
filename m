From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] git-svn documentation: Use tabs consistently within the ascii doc
Date: Fri, 18 Oct 2013 21:56:10 +0200
Message-ID: <1382126170-8907-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 18 21:55:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXG8z-0007Jo-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab3JRTz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:55:26 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:55368 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710Ab3JRTzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:55:22 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so2372700eek.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xvO+XGmDXzUgjJJLCLg5YrT55Bb0RAtduz/Y52sn/Fg=;
        b=mWJbQmANia9uY5Uf+hSfSlNckIn8orYy7kMT9951S4+c/neexCHQ/kD36lUNuAo3eq
         EVBG8wyM/m8vuTXZpqb+LStxsXJ9HwfNNHbwFybNEWbfGwRWpZQcvdBQCfJFteOrkvgN
         dOgqTM1TUowAfn2xW0iNwlA7k8Set3P5sio74FqdQLPCucAXb24pNA0/pKv+9uFAOYF3
         7borx7L/edSFYJbEDDfdXGFw9EGYjixZo/9R7XSqL5B4yRno4clcM6wSHFdAkCiiXpP4
         F9hD0SShYTVWmOvw5G9EnnHgbSn2g7ZUHiWIuXzGOtRHxUu5VAnTurVuvpwvoSgZYdMx
         Yljg==
X-Received: by 10.14.107.68 with SMTP id n44mr6913136eeg.26.1382126121200;
        Fri, 18 Oct 2013 12:55:21 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id e13sm8549240eeu.4.2013.10.18.12.55.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 12:55:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.511.g52c26ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236368>

While I can understand 4 or 7 white spaces are fancy, we'd rather want
to use tabs throughout the whole document.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Documentation/git-svn.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 2a38476..58578ad 100644
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
-- 
1.8.4.1.511.g52c26ce
