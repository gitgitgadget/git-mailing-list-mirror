From: "Tor Arntsen" <tor@spacetec.no>
Subject: [PATCH] Change C99 comments to old-style C comments
Date: Fri, 04 Jun 2010 11:32:11 +0200
Message-ID: <4C08C81B.3000404@spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 11:39:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKTMm-0003IJ-CQ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab0FDJi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 05:38:58 -0400
Received: from puck.spacetec.no ([192.51.5.29]:38981 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755043Ab0FDJi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:38:57 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 05:38:57 EDT
Received: (qmail 12431 invoked from network); 4 Jun 2010 09:32:15 -0000
Received: from citadel.spacetec.no (10.10.2.22)
  by puck.spacetec.no with SMTP; 4 Jun 2010 09:32:15 -0000
Received: from [10.10.1.233] (ringworld4.spacetec.no [10.10.1.233])
	by citadel.spacetec.no; Fri, 04 Jun 2010 11:32:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Iceowl/1.0b1 Icedove/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148392>

Signed-off-by: Tor Arntsen <tor@spacetec.no>
---
AIX 5.1 compiler 5.0 chokes on C99 comments.
Diff is against master.

 builtin/blame.c        |    2 +-
 builtin/for-each-ref.c |    4 ++--
 remote.c               |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..4dd4c3f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1589,7 +1589,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 	printf("%s%c%d %d %d\n",
 	       hex,
-	       ent->guilty ? ' ' : '*', // purely for debugging
+	       ent->guilty ? ' ' : '*', /* purely for debugging */
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3a97953..a2b28c6 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -552,10 +552,10 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 		grab_person("committer", val, deref, obj, buf, sz);
 		break;
 	case OBJ_TREE:
-		// grab_tree_values(val, deref, obj, buf, sz);
+		/* grab_tree_values(val, deref, obj, buf, sz); */
 		break;
 	case OBJ_BLOB:
-		// grab_blob_values(val, deref, obj, buf, sz);
+		/* grab_blob_values(val, deref, obj, buf, sz); */
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
diff --git a/remote.c b/remote.c
index 0f073e0..ea2323b 100644
--- a/remote.c
+++ b/remote.c
@@ -478,7 +478,7 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (default_remote_name) // did this already
+	if (default_remote_name) /* did this already */
 		return;
 	default_remote_name = xstrdup("origin");
 	current_branch = NULL;
-- 
1.7.1
