From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/2] Documentation/git-init.txt: minor style and synopsis fixes
Date: Fri, 16 Jan 2015 00:16:14 +0600
Message-ID: <1421345774-4756-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, 0xAX <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:16:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoy3-00063d-Si
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbbAOSQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:16:26 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:64593 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbAOSQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:16:24 -0500
Received: by mail-lb0-f181.google.com with SMTP id u14so5192453lbd.12
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tbKttmpSMamFbDn/ArE/JUXD4jTyPkUGZIjxntuhsRg=;
        b=Rs79L9JAg9fh+DaGPJgtIyk7YJkz86T1iB5g6tRw3BirRA2kPugnqdyvbyHfX4Oqsw
         224XQma2Ii8XwRX50LDqb9panw5/zU1irLZIncIDx+UoHHkOkQl1JmhutGiXo61xbcm9
         DQg/DD2X5F/oVitiA8PyEihNvtuIYtKUtZ6Zd008//HdJtpfL7sI4+yO6c57MLO7qFCR
         VQDHeaNTqJC4xT49B7EdqK79WzO5LBC6ianI094RvBfO/ZqtA54oq8F2a1Xf2C3z05nI
         2jQjkAPh9s/ODryyBPbKmJfg+fXqxHwgwFeoO6uxUYMci7N2OmK4MLkSHM+AtFvG2/Kg
         ut0Q==
X-Received: by 10.112.72.197 with SMTP id f5mr11175842lbv.21.1421345783344;
        Thu, 15 Jan 2015 10:16:23 -0800 (PST)
Received: from localhost.localdomain ([95.59.93.191])
        by mx.google.com with ESMTPSA id wq1sm229721lbb.24.2015.01.15.10.16.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jan 2015 10:16:22 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.315.g0e14eda
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262497>

Signed-off-by: 0xAX <kuleshovmail@gmail.com>
---
 Documentation/git-init.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 369f889..f1f0599 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,9 +9,9 @@ git-init - Create an empty Git repository or reinitialize an existing one
 SYNOPSIS
 --------
 [verse]
-'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>]
-	  [--shared[=<permissions>]] [directory]
+'git init' [-q | --quiet] [--bare] [--template=<template-directory>]
+	  [--separate-git-dir <git-dir>]
+	  [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
@@ -50,12 +50,12 @@ Only print error and warning messages; all other output will be suppressed.
 Create a bare repository. If GIT_DIR environment is not set, it is set to the
 current working directory.
 
---template=<template_directory>::
+--template=<template-directory>::
 
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---separate-git-dir=<git dir>::
+--separate-git-dir=<git-dir>::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
@@ -108,7 +108,7 @@ By default, the configuration flag `receive.denyNonFastForwards` is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
-If you provide a 'directory', the command is run inside it. If this directory
+If you provide a <directory>, the command is run inside it. If this directory
 does not exist, it will be created.
 
 --
-- 
2.3.0.rc0.315.g0e14eda
