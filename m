From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add git-annotate(1) and git-blame(1)
Date: Mon, 6 Mar 2006 06:24:44 +0100
Message-ID: <20060306052444.GC6487@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 06:24:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG8DG-0001PA-8x
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 06:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWCFFYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 00:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWCFFYs
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 00:24:48 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:54502 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751245AbWCFFYr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 00:24:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9CCA3770069;
	Mon,  6 Mar 2006 06:24:46 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04909-11; Mon,  6 Mar 2006 06:24:45 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id F35F7770068;
	Mon,  6 Mar 2006 06:24:44 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 57DEB6DF835; Mon,  6 Mar 2006 06:23:26 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E19BA61D58; Mon,  6 Mar 2006 06:24:44 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17271>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/git-annotate.txt |   44 ++++++++++++++++++++++++++++++++++++++++
 Documentation/git-blame.txt    |   31 ++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-annotate.txt
 create mode 100644 Documentation/git-blame.txt

c280414507b072689afd3061a2d43527ebab292e
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
new file mode 100644
index 0000000..1cfc3e3
--- /dev/null
+++ b/Documentation/git-annotate.txt
@@ -0,0 +1,44 @@
+git-annotate(1)
+===============
+
+NAME
+----
+git-annotate - annotate file lines with commit info
+
+SYNOPSIS
+--------
+git-annotate [options] file [revision]
+
+DESCRIPTION
+-----------
+Annotates each line in the given file with information from the commit
+which introduced the line. Optionally annotate from a given revision.
+
+OPTIONS
+-------
+-l, --long::
+	Show long rev (Defaults off).
+
+-t, --time::
+	Show raw timestamp (Defaults off).
+
+-r, --rename::
+	Follow renames (Defaults on).
+
+-S, --rev-file <revs-file>::
+	Use revs from revs-file instead of calling git-rev-list.
+
+-h, --help::
+	Show help message.
+
+SEE ALSO
+--------
+gitlink:git-blame[1]
+
+AUTHOR
+------
+Written by Ryan Anderson <ryan@michonline.com>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
new file mode 100644
index 0000000..bdf28d9
--- /dev/null
+++ b/Documentation/git-blame.txt
@@ -0,0 +1,31 @@
+git-blame(1)
+============
+
+NAME
+----
+git-blame - blame file lines on commits
+
+SYNOPSIS
+--------
+git-blame revision file
+
+DESCRIPTION
+-----------
+Annotates each line in the given file with information from the commit
+which introduced the line. Start annotation from the given revision.
+
+OPTIONS
+-------
+No options.
+
+SEE ALSO
+--------
+gitlink:git-annotate[1]
+
+AUTHOR
+------
+Written by Fredrik Kuivinen <freku045@student.liu.se>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.2.4.g9201

-- 
Jonas Fonseca
