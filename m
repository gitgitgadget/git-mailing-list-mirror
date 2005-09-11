From: martin@catalyst.net.nz
Subject: [PATCH 2/5] archimport documentation tidyup
Date: Sun, 11 Sep 2005 21:26:05 +1200
Message-ID: <1126430765435-git-send-email-martin@catalyst.net.nz>
References: <11264307651299-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:27:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO6a-00067Y-DK
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVIKJ0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVIKJ0V
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:26:21 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:9427 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964833AbVIKJ0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:26:20 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 8D8028A72C;
	Sun, 11 Sep 2005 21:26:05 +1200 (NZST)
In-Reply-To: <11264307651299-git-send-email-martin@catalyst.net.nz>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8285>

New "merges" headline, clarified some parts that were not easy to understand.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Documentation/git-archimport.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

da341e8530b0d852c9b6910778df6b41cdee3e54
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -3,7 +3,7 @@ git-archimport(1)
 
 NAME
 ----
-git-archimport - Import an arch repository into git
+git-archimport - Import an Arch repository into GIT
 
 
 SYNOPSIS
@@ -16,8 +16,8 @@ DESCRIPTION
 Imports a project from one or more Arch repositories. It will follow branches
 and repositories within the namespaces defined by the <archive/branch>
 parameters suppplied. If it cannot find the remote branch a merge comes from
-it will just import it as a regular merge. If it can find it, it will perform
-a merge whenever possible. 
+it will just import it as a regular commit. If it can find it, it will mark it 
+as a merge whenever possible (see discussion below). 
 
 The script expects you to provide the key roots where it can start the import 
 from an 'initial import' or 'tag' type of Arch commit. It will follow and import 
@@ -34,8 +34,9 @@ know about the repositories you pass to 
 For the initial import `git-archimport` expects to find itself in an empty 
 directory. To follow the development of a project that uses Arch, rerun 
 `git-archimport` with the same parameters as the initial import to perform incremental imports.
-of a project using Arch.
 
+MERGES
+------
 Patch merge data from Arch is used to mark merges in GIT as well. GIT 
 does not care much about tracking patches, and only considers a merge when a
 branch incorporates all the commits since the point they forked. The end result
