From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/3] Add documentation for git-send-email-script
Date: Sun, 31 Jul 2005 04:17:25 -0400
Message-ID: <112279784541@foobar.com>
References: <11227978451100@foobar.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ryan@michonline.com
X-From: git-owner@vger.kernel.org Sun Jul 31 10:19:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz91x-00013u-LG
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 10:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVGaISf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 04:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGaIS0
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 04:18:26 -0400
Received: from mail.autoweb.net ([198.172.237.26]:4841 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261846AbVGaIRb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 04:17:31 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dz90l-0005mT-8m; Sun, 31 Jul 2005 04:17:31 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dz9AL-0004n2-00; Sun, 31 Jul 2005 04:27:25 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1Dz90f-0006Xf-Jo; Sun, 31 Jul 2005 04:17:25 -0400
In-Reply-To: <11227978451100@foobar.com>
X-Mailer: git-send-email-script
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/git-send-email-script.txt |   61 +++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-send-email-script.txt

799a6320d3b07347869093beec303afbc005cf26
diff --git a/Documentation/git-send-email-script.txt b/Documentation/git-send-email-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-send-email-script.txt
@@ -0,0 +1,61 @@
+git-send-email-script(1)
+=======================
+v0.1, July 2005
+
+NAME
+----
+git-send-email-script - Send a collection of patches as emails
+
+
+SYNOPSIS
+--------
+'git-send-email-script' [options] <file|directory> [... file|directory]
+
+
+
+DESCRIPTION
+-----------
+Takes the patches given on the command line and emails them out.
+
+The header of the email is configurable by command line options.  If not
+specified on the command line, the user will be prompted with a ReadLine
+enabled interface to provide the necessary information.
+
+The options available are:
+
+  --to
+	Specify the primary recipient of the emails generated.
+	Generally, this will be the upstream maintainer of the
+	project involved.
+
+   --from
+	Specify the sender of the emails.  This will default to
+	the value GIT_COMMITTER_IDENT, as returned by "git-var -l".
+	The user will still be prompted to confirm this entry.
+
+   --subject
+   	Specify the initial subject of the email thread.
+
+   --in-reply-to
+	Specify the contents of the first In-Reply-To header.
+	Subsequent emails will refer to the previous email 
+	instead of this.
+	When overriding on the command line, it may be necessary
+	to set this to a space.  For example
+		--in-reply-to=" "
+
+Author
+------
+Written by Ryan Anderson <ryan@michonline.com>
+
+git-send-email-script is originally based upon
+send_lots_of_email.pl by Greg Kroah-Hartman.
+
+Documentation
+--------------
+Documentation by Ryan Anderson
+
+GIT
+---
+Part of the link:git.html[git] suite
+
