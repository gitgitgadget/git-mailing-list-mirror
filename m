From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] Documentation/init-db.txt: minor style and synopsys fixes
Date: Thu, 15 Jan 2015 16:31:58 +0600
Message-ID: <1421317918-11677-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 11:32:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBhir-0004tw-8n
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 11:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbbAOKcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 05:32:12 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:35092 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbbAOKcK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 05:32:10 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so12766632lab.9
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 02:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4+LaP+EFWlF4NJrtUPBBpL2qu8IAN+YdtJs0r+QWHa8=;
        b=MvXYFimDOO/4K/3jID1Eqyj+V4mROyjihwm0EwYvcYmADMVSp7bXmX5sYIPsxnIvfG
         KuH9uoyeIPMTVqA2qZptewmH2CpP9DQJXceU8cFdMrKoc9klRINQFa/r+muhby3y4vOr
         tPUNvVSTbM3R7ODZu2RTBf+a7+frxXEctzB2dl1c/cddKivDs4TYt/MHKOLsPv9COk7g
         flhjDgam1KZ18qRSsE9ovKp177tDSRZUsP7qE0mx9qD5hlr1weMx2jYynflr33eW8Jxs
         tKhqAFuZ5/UMbQInx7VQ8oGXHSDfo4OmnVWywM3cMzicaA1EtZ7r3iwDogMTypUYoYK6
         WS3w==
X-Received: by 10.112.131.1 with SMTP id oi1mr8856433lbb.2.1421317929557;
        Thu, 15 Jan 2015 02:32:09 -0800 (PST)
Received: from localhost.localdomain ([95.59.100.94])
        by mx.google.com with ESMTPSA id qk4sm449407lbb.4.2015.01.15.02.32.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jan 2015 02:32:08 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.314.g170a664.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262473>

This patch constists of two minor changes:

* line-wrap 'git init-db' synopsis

* last possible argument '[<directory>]' was missed

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-init-db.txt | 5 +++--
 Documentation/git-init.txt    | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..2c77aaa 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,8 +9,9 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
-
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
+	     [--separate-git-dir <git-dir>]
+	     [--shared[=<permissions>]] [<directory>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 369f889..25412ac 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>]
-	  [--shared[=<permissions>]] [directory]
+	  [--separate-git-dir <git-dir>]
+	  [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
@@ -108,7 +108,7 @@ By default, the configuration flag `receive.denyNonFastForwards` is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
-If you provide a 'directory', the command is run inside it. If this directory
+If you provide a <directory>, the command is run inside it. If this directory
 does not exist, it will be created.
 
 --
-- 
2.3.0.rc0.314.g170a664.dirty
