From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] git bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:00:05 +0300
Message-ID: <11250540043045-git-send-email-tv@debian.org>
References: <11250540041041-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:04:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bwi-0006bq-Vk
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbVHZLAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVHZLAU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:00:20 -0400
Received: from i1.inoi.fi ([194.100.97.46]:55709 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751523AbVHZLAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:00:17 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 125D9FF9E6;
	Fri, 26 Aug 2005 14:00:19 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id C7A49FF9E0;
	Fri, 26 Aug 2005 14:00:18 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 5386EBA06C;
	Fri, 26 Aug 2005 14:00:05 +0300 (EEST)
In-Reply-To: <11250540041041-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7800>

Ignore generated files.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit de5b995a65645ecf09bfebff2ba7dc325979e4b3
tree 6a48d6719178c7e0d81cae7683e5b7294ee92781
parent 56bb91cb027a0e0dc8d896d26906597088ee6372
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:33 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:33 +0300

 .gitignore               |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/.gitignore |    5 +++++
 debian/.gitignore        |    6 +++++
 templates/.gitignore     |    1 +
 tools/.gitignore         |    2 ++
 5 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
new file mode 100644
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,51 @@
+git-apply
+git-build-rev-cache
+git-cat-file
+git-checkout-cache
+git-clone-pack
+git-commit-tree
+git-convert-cache
+git-daemon
+git-diff-cache
+git-diff-files
+git-diff-helper
+git-diff-stages
+git-diff-tree
+git-export
+git-fetch-pack
+git-fsck-cache
+git-get-tar-commit-id
+git-hash-object
+git-http-pull
+git-init-db
+git-local-pull
+git-ls-files
+git-ls-tree
+git-merge-base
+git-merge-cache
+git-mktag
+git-pack-objects
+git-patch-id
+git-peek-remote
+git-prune-packed
+git-read-tree
+git-receive-pack
+git-rev-list
+git-rev-parse
+git-rev-tree
+git-send-pack
+git-show-branch
+git-show-index
+git-show-rev-cache
+git-ssh-pull
+git-ssh-push
+git-stripspace
+git-tar-tree
+git-unpack-file
+git-unpack-objects
+git-update-cache
+git-update-server-info
+git-upload-pack
+git-var
+git-verify-pack
+git-write-tree
diff --git a/Documentation/.gitignore b/Documentation/.gitignore
new file mode 100644
--- /dev/null
+++ b/Documentation/.gitignore
@@ -0,0 +1,5 @@
+*.xml
+*.html
+*.1
+*.7
+howto-index.txt
diff --git a/debian/.gitignore b/debian/.gitignore
new file mode 100644
--- /dev/null
+++ b/debian/.gitignore
@@ -0,0 +1,6 @@
+git-core
+git-tk
+*.debhelper
+*.substvars
+build-stamp
+files
diff --git a/templates/.gitignore b/templates/.gitignore
new file mode 100644
--- /dev/null
+++ b/templates/.gitignore
@@ -0,0 +1 @@
+blt
diff --git a/tools/.gitignore b/tools/.gitignore
new file mode 100644
--- /dev/null
+++ b/tools/.gitignore
@@ -0,0 +1,2 @@
+git-mailinfo
+git-mailsplit
