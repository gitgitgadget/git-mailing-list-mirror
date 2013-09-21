From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] build: add default configuration
Date: Sat, 21 Sep 2013 06:47:16 -0500
Message-ID: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
Cc: David Aguilar <davvid@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 13:52:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNLjx-000873-Jz
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 13:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab3IULwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 07:52:41 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35025 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab3IULwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 07:52:40 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so1804122obc.18
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ec7VVfuUAmLpgV3IfFJgF866jYbzJpP71hvKrL5i2k0=;
        b=mIbJitAehit/mbvFVR9Y4bjCzuDsLknqIxw4F4m9VC5omn57GCUhXRoX4mOh+RYDc6
         iQx3axznsX/uByEvMm6Mk/6QOjUME5AwAY2+tn44RC3BoKsDWZk7asnJyulzf1F9WXuy
         TsyUJciKBqEsGUPepE54Be7BWEGajkiKx4WVtkiO0HibaJNOJkB2LYXiWbiiKPkDhmc/
         jEKmNo1RWTnk2lIClu20o+StNkT9FOZrkIv90937WD7SUCMsXAGgNfB+1Z8eC/DFxHkd
         9rN30mPRy02ZsWawAo3kdBuJWMEW2rpxjp6FIc5LzNtQsBlrOEM3OO4sE38nRoaZPQzu
         F7Ig==
X-Received: by 10.60.93.67 with SMTP id cs3mr10451276oeb.12.1379764360455;
        Sat, 21 Sep 2013 04:52:40 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm7229426oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 04:52:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.9.g218b36e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235097>

For now simply add a few common aliases.

  co = checkout
  ci = commit
  rb = rebase
  st = status

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-checkout.txt | 5 +++++
 Documentation/git-commit.txt   | 5 +++++
 Documentation/git-rebase.txt   | 5 +++++
 Documentation/git-status.txt   | 5 +++++
 Makefile                       | 5 ++++-
 gitconfig                      | 5 +++++
 6 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 gitconfig

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca118ac..7597813 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -14,6 +14,11 @@ SYNOPSIS
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
 
+ALIAS
+-----
+
+git co
+
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..8705abc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -15,6 +15,11 @@ SYNOPSIS
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
 
+ALIAS
+-----
+
+git ci
+
 DESCRIPTION
 -----------
 Stores the current contents of the index in a new commit along
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6b2e1c8..69b192d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -14,6 +14,11 @@ SYNOPSIS
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --edit-todo
 
+ALIAS
+-----
+
+git co
+
 DESCRIPTION
 -----------
 If <branch> is specified, 'git rebase' will perform an automatic
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9046df9..30ecd25 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -11,6 +11,11 @@ SYNOPSIS
 [verse]
 'git status' [<options>...] [--] [<pathspec>...]
 
+ALIAS
+-----
+
+git st
+
 DESCRIPTION
 -----------
 Displays paths that have differences between the index file and the
diff --git a/Makefile b/Makefile
index 3588ca1..18081bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1010,7 +1010,7 @@ ifndef sysconfdir
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
 else
-sysconfdir = etc
+sysconfdir = $(prefix)/etc
 endif
 endif
 
@@ -1586,6 +1586,7 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
+sysconfdir_SQ = $(subst ','\'',$(sysconfdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -2340,6 +2341,8 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)'
+	$(INSTALL) -m 644 gitconfig '$(DESTDIR_SQ)$(ETC_GITCONFIG_SQ)'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/gitconfig b/gitconfig
new file mode 100644
index 0000000..c45d300
--- /dev/null
+++ b/gitconfig
@@ -0,0 +1,5 @@
+[alias]
+	co = checkout
+	ci = commit
+	rb = rebase
+	st = status
-- 
1.8.4.9.g218b36e.dirty
