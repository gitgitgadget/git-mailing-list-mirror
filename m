From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: branch: mark strings for translation
Date: Sat, 13 Apr 2013 10:22:49 +0800
Message-ID: <d11a226dac05ea7e8ee1d6166a1be1acee360a03.1365819645.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.co>
X-From: git-owner@vger.kernel.org Sat Apr 13 04:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQq7Z-0005AE-D4
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 04:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3DMCXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 22:23:09 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56199 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab3DMCXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 22:23:08 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1695143pde.37
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=xKOuV5HaHSLd4nCYc/n5Kkw+EcgSBKGB/1+4yvT9I0k=;
        b=1HwLm7LtS9X8tmYeWjKMMzh20oFDcWjmbrUgCRdZOKfo2ZybUYxpfsgII9QD9se5su
         M3bRG8i5ZT4PkDKLOQ3ZXxAeEHJfjZLIpMIeyz0QosIw343TZEG8SvrpB3v7TbiwlZ98
         Db0PGRHN/xJFL/Yaiswyqnf6e4QYUjOxaMh7xFzzdookEKqQQKvVZKX/xIYbk+1WH2lW
         5HlzXVKUdn54xOmA8pI4Mmz/ebN4e/yvF/WZTQX/6tL7Nll4jIAuAQaP+igUTLX9FrrV
         GR7qPFV2tX/SAnoEMSlAP5fjwCFHjh1jyaGlboTKasneqHqhhB8eAwd2opJOIBbmh8uY
         jKFQ==
X-Received: by 10.68.197.195 with SMTP id iw3mr17565183pbc.177.1365819787686;
        Fri, 12 Apr 2013 19:23:07 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.32])
        by mx.google.com with ESMTPS id z8sm10701883pbt.23.2013.04.12.19.23.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 19:23:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.350.g76f6571.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221042>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 branch.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/branch.c b/branch.c
index 6ae6a..c8745 100644
--- a/branch.c
+++ b/branch.c
@@ -57,7 +57,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
-		warning("Not setting branch %s as its own upstream.",
+		warning(_("Not setting branch %s as its own upstream."),
 			local);
 		return;
 	}
@@ -79,26 +79,26 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (remote_is_branch && origin)
 			printf(rebasing ?
-			       "Branch %s set up to track remote branch %s from %s by rebasing.\n" :
-			       "Branch %s set up to track remote branch %s from %s.\n",
+			       _("Branch %s set up to track remote branch %s from %s by rebasing.\n") :
+			       _("Branch %s set up to track remote branch %s from %s.\n"),
 			       local, shortname, origin);
 		else if (remote_is_branch && !origin)
 			printf(rebasing ?
-			       "Branch %s set up to track local branch %s by rebasing.\n" :
-			       "Branch %s set up to track local branch %s.\n",
+			       _("Branch %s set up to track local branch %s by rebasing.\n") :
+			       _("Branch %s set up to track local branch %s.\n"),
 			       local, shortname);
 		else if (!remote_is_branch && origin)
 			printf(rebasing ?
-			       "Branch %s set up to track remote ref %s by rebasing.\n" :
-			       "Branch %s set up to track remote ref %s.\n",
+			       _("Branch %s set up to track remote ref %s by rebasing.\n") :
+			       _("Branch %s set up to track remote ref %s.\n"),
 			       local, remote);
 		else if (!remote_is_branch && !origin)
 			printf(rebasing ?
-			       "Branch %s set up to track local ref %s by rebasing.\n" :
-			       "Branch %s set up to track local ref %s.\n",
+			       _("Branch %s set up to track local ref %s by rebasing.\n") :
+			       _("Branch %s set up to track local ref %s.\n"),
 			       local, remote);
 		else
-			die("BUG: impossible combination of %d and %p",
+			die(_("BUG: impossible combination of %d and %p"),
 			    remote_is_branch, origin);
 	}
 }
@@ -115,7 +115,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
-		return error("Tracking not set up: name too long: %s",
+		return error(_("Tracking not set up: name too long: %s"),
 				new_ref);
 
 	memset(&tracking, 0, sizeof(tracking));
@@ -134,7 +134,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 		}
 
 	if (tracking.matches > 1)
-		return error("Not tracking: ambiguous information for ref %s",
+		return error(_("Not tracking: ambiguous information for ref %s"),
 				orig_ref);
 
 	install_branch_config(config_flags, new_ref, tracking.remote,
@@ -179,12 +179,12 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 			    int force, int attr_only)
 {
 	if (strbuf_check_branch_ref(ref, name))
-		die("'%s' is not a valid branch name.", name);
+		die(_("'%s' is not a valid branch name."), name);
 
 	if (!ref_exists(ref->buf))
 		return 0;
 	else if (!force && !attr_only)
-		die("A branch named '%s' already exists.", ref->buf + strlen("refs/heads/"));
+		die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
 
 	if (!attr_only) {
 		const char *head;
@@ -192,7 +192,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 
 		head = resolve_ref_unsafe("HEAD", sha1, 0, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-			die("Cannot force update the current branch.");
+			die(_("Cannot force update the current branch."));
 	}
 	return 1;
 }
@@ -247,7 +247,7 @@ void create_branch(const char *head,
 			}
 			die(_(upstream_missing), start_name);
 		}
-		die("Not a valid object name: '%s'.", start_name);
+		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
@@ -267,18 +267,18 @@ void create_branch(const char *head,
 		}
 		break;
 	default:
-		die("Ambiguous object name: '%s'.", start_name);
+		die(_("Ambiguous object name: '%s'."), start_name);
 		break;
 	}
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
-		die("Not a valid branch point: '%s'.", start_name);
+		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.sha1);
 
 	if (!dont_change_ref) {
 		lock = lock_any_ref_for_update(ref.buf, NULL, 0);
 		if (!lock)
-			die_errno("Failed to lock ref for update");
+			die_errno(_("Failed to lock ref for update"));
 	}
 
 	if (reflog)
@@ -296,7 +296,7 @@ void create_branch(const char *head,
 
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno("Failed to write ref");
+			die_errno(_("Failed to write ref"));
 
 	strbuf_release(&ref);
 	free(real_ref);
-- 
1.8.2.1.350.g76f6571.dirty
