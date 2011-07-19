From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: [PATCH] gitignore: add top level patch ignore rule
Date: Wed, 20 Jul 2011 01:17:57 +0300
Message-ID: <1311113877.2643.2.camel@vitaliy-Vostro-1400>
Reply-To: vitalivanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Vitaliy Ivanov <vitalivanov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 20 00:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjIcC-0005z2-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 00:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1GSWSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 18:18:02 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59472 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1GSWSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 18:18:01 -0400
Received: by fxd18 with SMTP id 18so587219fxd.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Bt2n+UjXKvFLCOWnKkLj18lQXQb9+rrzb2LV2ySvYQY=;
        b=MDhZO6D9x4BRMakSWMNEULhTwZWiKHY0CQfDxz+XqGFwRtbP1p8bd+iFoVq9cw/2e1
         Ma/zT2qoNuMWQ5iJfjF+tXO3WmB9WAoAlP62s/frtiw4kDzEew4lmxkMrmMf9FKvUsky
         a2butk/DR/Pyuo+Mtj5Hw5WZ9A2oyEIIXqloA=
Received: by 10.223.24.17 with SMTP id t17mr12422296fab.143.1311113879789;
        Tue, 19 Jul 2011 15:17:59 -0700 (PDT)
Received: from [192.168.0.101] ([194.44.123.233])
        by mx.google.com with ESMTPS id 9sm255042far.13.2011.07.19.15.17.58
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 15:17:59 -0700 (PDT)
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177512>

Add top level ignore rule for patches created by format-patch command.
On the way, reorganize ignore rules and add comments.

Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
---
 .gitignore |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8572c8c..47afe77 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,15 @@
+#
+# NOTE! Don't add files that are generated in specific
+# subdirectories here. Add them in the ".gitignore" file
+# in that subdirectory instead.
+#
+# NOTE! Please use 'git ls-files -i --exclude-standard'
+# command after changing this file, to see if there are
+# any tracked files which get ignored after the change.
+
+#
+# Top-level files
+#
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
@@ -187,21 +199,10 @@
 /test-svn-fe
 /test-treap
 /common-cmds.h
-*.tar.gz
-*.dsc
-*.deb
 /git.spec
-*.exe
-*.[aos]
-*.py[co]
-.depend/
-*.gcda
-*.gcno
-*.gcov
 /coverage-untested-functions
 /cover_db/
 /cover_db_html/
-*+
 /config.mak
 /autom4te.cache
 /config.cache
@@ -213,6 +214,24 @@
 /tags
 /TAGS
 /cscope*
+/Debug/
+/Release/
+/*.patch
+
+#
+# Normal rules
+#
+*.tar.gz
+*.dsc
+*.deb
+*.exe
+*.[aos]
+*.py[co]
+.depend/
+*.gcda
+*.gcno
+*.gcov
+*+
 *.obj
 *.lib
 *.sln
@@ -222,5 +241,3 @@
 *.user
 *.idb
 *.pdb
-/Debug/
-/Release/
-- 
1.7.4.1
