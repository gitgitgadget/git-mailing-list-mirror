From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] git bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:00:04 +0300
Message-ID: <11250540041041-git-send-email-tv@debian.org>
References: <11250540043384-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:05:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bwh-0006bq-4T
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbVHZLAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVHZLAT
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:00:19 -0400
Received: from i1.inoi.fi ([194.100.97.46]:55965 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751530AbVHZLAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:00:17 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id E78A4FF9DF;
	Fri, 26 Aug 2005 14:00:18 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id A74B5FF7F9;
	Fri, 26 Aug 2005 14:00:18 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id DB37BBA06B;
	Fri, 26 Aug 2005 14:00:04 +0300 (EEST)
In-Reply-To: <11250540043384-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7805>

Generate docs for gitk. Install them in the right deb package.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit 56bb91cb027a0e0dc8d896d26906597088ee6372
tree 6be1279d6a87b42e9b726ee7883ebe4e81d1fd01
parent f4d2a91b2946330c4bf240cf73e64684cba43ddf
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:29 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:29 +0300

 Documentation/Makefile |    2 +-
 debian/git-tk.files    |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,4 @@
-MAN1_TXT=$(wildcard git-*.txt)
+MAN1_TXT=$(wildcard git-*.txt) gitk.txt
 MAN7_TXT=git.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
diff --git a/debian/git-tk.files b/debian/git-tk.files
--- a/debian/git-tk.files
+++ b/debian/git-tk.files
@@ -1 +1,3 @@
 /usr/bin/gitk
+/usr/share/man/man1/gitk.*
+/usr/share/doc/git-core/gitk.*
