From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:01:35 +0300
Message-ID: <11250540952491-git-send-email-tv@debian.org>
References: <11250540952285-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:05:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8by6-0006zI-E1
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVHZLBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHZLBp
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:01:45 -0400
Received: from i1.inoi.fi ([194.100.97.46]:58013 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S932555AbVHZLBn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:01:43 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 89EFFFF9E0;
	Fri, 26 Aug 2005 14:01:49 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 61196FF9DB;
	Fri, 26 Aug 2005 14:01:49 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 9A459BA06B;
	Fri, 26 Aug 2005 14:01:35 +0300 (EEST)
In-Reply-To: <11250540952285-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7804>

Ignore more generated files.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit 91aeeed108292bb42f7b133da13ec6881cf84a9e
tree fd0dc430a655fde2a21a9634c914b22db0ee96ce
parent c1970992d81e2c26d2d85ad65b0e2e90fbeee7f1
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:07 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:07 +0300

 .gitignore               |    2 ++
 Documentation/.gitignore |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,3 @@
 cg-version
+build-stamp
+configure-stamp
diff --git a/Documentation/.gitignore b/Documentation/.gitignore
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,2 +1,3 @@
 *.html
 cogito.txt
+*.[1-9]
