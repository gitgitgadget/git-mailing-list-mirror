From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 01/40] Add compat/regex.[ch] and compat/fnmatch.[ch].
Date: Wed, 27 Feb 2008 19:54:24 +0100
Message-ID: <1204138503-6126-2-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURRT-0000Km-Nd
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbYB0SzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbYB0SzG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:06 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40413 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYB0SzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:05 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 402EF9735D;
	Wed, 27 Feb 2008 19:55:04 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75247>

We don't have fnmatch and regular expressions on Windows. We borrow
fnmatch.[ch] from the GNU C library (license is LGPL 2 or later) and
GNU regexp (regexp.c[ch], license is GPL 2 or later). Note that regexp.c
was changed slightly to avoid warnings with gcc.

We make the addition of these files an extra commit so as not to clutter
the next commits.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 This patch is intentially broken.  There's no need to comment on the
 details of the files that it adds.

 -- Hannes

 compat/fnmatch.c |  488 ++++++
 compat/fnmatch.h |   84 +
 compat/regex.c   | 4927 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/regex.h   |  490 ++++++
 4 files changed, 5989 insertions(+), 0 deletions(-)
 create mode 100644 compat/fnmatch.c
 create mode 100644 compat/fnmatch.h
 create mode 100644 compat/regex.c
 create mode 100644 compat/regex.h

diff --git a/compat/fnmatch.c b/compat/fnmatch.c
new file mode 100644
index 0000000..1f4ead5
--- /dev/null
+++ b/compat/fnmatch.c
@@ -0,0 +1,488 @@
This patch is intentionally broken.
diff --git a/compat/fnmatch.h b/compat/fnmatch.h
new file mode 100644
index 0000000..cc3ec37
--- /dev/null
+++ b/compat/fnmatch.h
@@ -0,0 +1,84 @@
This patch is intentionally broken.
diff --git a/compat/regex.c b/compat/regex.c
new file mode 100644
index 0000000..1d39e08
--- /dev/null
+++ b/compat/regex.c
@@ -0,0 +1,4927 @@
This patch is intentionally broken.
diff --git a/compat/regex.h b/compat/regex.h
new file mode 100644
index 0000000..408dd21
--- /dev/null
+++ b/compat/regex.h
@@ -0,0 +1,490 @@
This patch is intentionally broken.
-- 
1.5.4.1.126.ge5a7d
