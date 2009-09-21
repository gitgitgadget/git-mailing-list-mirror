From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] Remove '< >' from [<options>] since it's not necessary.
Date: Mon, 21 Sep 2009 14:12:48 -0400
Message-ID: <1253556768-4762-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 20:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpnOm-0007Xy-V3
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 20:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbZIUSNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 14:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZIUSNz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 14:13:55 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:36107 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbZIUSNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 14:13:54 -0400
Received: by qyk1 with SMTP id 1so2419486qyk.22
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=utwzqWaQMBZ7rgrZoW0W+QmN/O6m+KTDdHjoO/TeW4I=;
        b=NvUgmoh9Amrjf/3LiNrXIdrclD1LLsx0gH7B+at386AGX+I6Fd83cczBDXf4GpGrDa
         uOluRvL4p/C/vq2t1Xdjw28qJHSfIsSB5QD5DhnEoMhuPLPk2cwcmlVxOf0yXQ9wpMm1
         WRMZ8SKL2MjJ6uksnMTH5KcxH3hEPbuApdBpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EEavPT36RZsly/rGlPMblynHE91wHKphZ4KB2mDplMKZUo4CmE9LfqQdXGtTvL+799
         7M20j/dyvuqb9Ek5GEchgiNLG9EfBZDGf6Ory3msh4haxkbdbvLekHt9ADt4hBIyYmN0
         pPWjbtNcXCW9wU86THI9xpApAELysyaYi+72s=
Received: by 10.224.43.102 with SMTP id v38mr3820935qae.104.1253556838259;
        Mon, 21 Sep 2009 11:13:58 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 23sm152771qyk.11.2009.09.21.11.13.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Sep 2009 11:13:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.37.gf5c31.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128899>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Documentation/git-log.txt   |    2 +-
 Documentation/git-stash.txt |    4 ++--
 builtin-log.c               |    2 +-
 git-stash.sh                |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 3d79de1..985ffab 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -8,7 +8,7 @@ git-log - Show commit logs
 
 SYNOPSIS
 --------
-'git log' [<options>] [<since>..<until>] [[\--] <path>...]
+'git log' [options] [<since>..<until>] [[\--] <path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 3f14b72..8a6d85c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,7 +8,7 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git stash' list [<options>]
+'git stash' list [options]
 'git stash' show [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
@@ -64,7 +64,7 @@ from your worktree.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
-list [<options>]::
+list [options]::
 
 	List the stashes that you currently have.  Each 'stash' is listed
 	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1}` is
diff --git a/builtin-log.c b/builtin-log.c
index 25e21ed..1685546 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -28,7 +28,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage =
-	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
+	"git log [options] [<since>..<until>] [[--] <path>...]\n"
 	"   or: git show [options] <object>...";
 
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
diff --git a/git-stash.sh b/git-stash.sh
index 4febbbf..e5ab34a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -2,7 +2,7 @@
 # Copyright (c) 2007, Nanako Shiraishi
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="list [<options>]
+USAGE="list [options]
    or: $dashless show [<stash>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-- 
1.6.5.rc1.37.gf5c31.dirty
