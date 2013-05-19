From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/17] revision: split some overly-long lines
Date: Sun, 19 May 2013 22:27:03 +0200
Message-ID: <1368995232-11042-9-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADJ-0004Pr-EN
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab3ESU2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:13 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:42287 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714Ab3ESU2J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:09 -0400
X-AuditID: 12074413-b7f226d000000902-49-519935d85845
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.16.02306.8D539915; Sun, 19 May 2013 16:28:08 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5R026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:06 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHvDdGagwfc+DouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xY+kN9oJFehUHNvxgaWB8rtrFyMEhIWAi8bKnqouRE8gUk7hwbz1bFyMXh5DAZUaJ
	Xx+3s0A455kkWiceYAKpYhPQlVjU0wxmiwjISnw/vJERxGYWmMAosbS/EMQWFrCVWDblDBuI
	zSKgKtH1egU7iM0r4CJxZslmFohtChKXZ61hBrE5BVwltrTvYgWxhYBq/vXfZp3AyLuAkWEV
	o1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkhICe9g3HVS7hCjAAejEg9vw4fp
	gUKsiWXFlbmHGCU5mJREed+ZzAwU4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7Rwgox5uSWFmV
	WpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4HUHGSpYlJqeWpGWmVOCkGbi4AQR
	XCAbeIA23Acp5C0uSMwtzkyHKDrFqCglznsRJCEAksgozYMbAIv+V4ziQP8I8x4BqeIBJg64
	7ldAg5mABrNemwoyuCQRISXVwLi+fdn3D3mn/2ruuhfLJ/zBadnc/c/XnrtwY/K1T2sW3fPl
	mS3093DdtXIjo7C9b7LvPU29p39gVgJn3pG+aavT46MfbJH3Ocl44P2/A38kt7882qAo8mzB
	gkDxJ5X6x+r75NZ7RYkoRa9oqF/v4rRoY+bmrwkvDjRMPrsydJ973fs1pWeKvlc6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224910>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 20 ++++++++++++++------
 revision.h | 32 +++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index 25e424c..8ac88d6 100644
--- a/revision.c
+++ b/revision.c
@@ -70,7 +70,8 @@ static int show_path_truncated(FILE *out, const struct name_path *path)
 	return ours || emitted;
 }
 
-void show_object_with_name(FILE *out, struct object *obj, const struct name_path *path, const char *component)
+void show_object_with_name(FILE *out, struct object *obj,
+			   const struct name_path *path, const char *component)
 {
 	struct name_path leaf;
 	leaf.up = (struct name_path *)path;
@@ -186,7 +187,9 @@ void mark_parents_uninteresting(struct commit *commit)
 	}
 }
 
-static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
+static void add_pending_object_with_mode(struct rev_info *revs,
+					 struct object *obj,
+					 const char *name, unsigned mode)
 {
 	if (!obj)
 		return;
@@ -209,7 +212,8 @@ static void add_pending_object_with_mode(struct rev_info *revs, struct object *o
 	add_object_array_with_mode(obj, name, &revs->pending, mode);
 }
 
-void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
+void add_pending_object(struct rev_info *revs,
+			struct object *obj, const char *name)
 {
 	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
 }
@@ -226,7 +230,9 @@ void add_head_to_pending(struct rev_info *revs)
 	add_pending_object(revs, obj, "HEAD");
 }
 
-static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
+static struct object *get_reference(struct rev_info *revs, const char *name,
+				    const unsigned char *sha1,
+				    unsigned int flags)
 {
 	struct object *object;
 
@@ -247,7 +253,8 @@ void add_pending_sha1(struct rev_info *revs, const char *name,
 	add_pending_object(revs, object, name);
 }
 
-static struct commit *handle_commit(struct rev_info *revs, struct object *object, const char *name)
+static struct commit *handle_commit(struct rev_info *revs,
+				    struct object *object, const char *name)
 {
 	unsigned long flags = object->flags;
 
@@ -368,7 +375,8 @@ static void file_change(struct diff_options *options,
 	DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
-static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct commit *commit)
+static int rev_compare_tree(struct rev_info *revs,
+			    struct commit *parent, struct commit *commit)
 {
 	struct tree *t1 = parent->tree;
 	struct tree *t2 = commit->tree;
diff --git a/revision.h b/revision.h
index 01bd2b7..9628465 100644
--- a/revision.h
+++ b/revision.h
@@ -195,19 +195,23 @@ struct setup_revision_opt {
 };
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *);
+extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
+			   struct setup_revision_opt *);
 extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
-				 const struct option *options,
-				 const char * const usagestr[]);
+			       const struct option *options,
+			       const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
-extern int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt);
+extern int handle_revision_arg(const char *arg, struct rev_info *revs,
+			       int flags, unsigned revarg_opt);
 
 extern void reset_revision_walk(void);
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
-extern char *get_revision_mark(const struct rev_info *revs, const struct commit *commit);
-extern void put_revision_mark(const struct rev_info *revs, const struct commit *commit);
+extern char *get_revision_mark(const struct rev_info *revs,
+			       const struct commit *commit);
+extern void put_revision_mark(const struct rev_info *revs,
+			      const struct commit *commit);
 
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
@@ -220,15 +224,19 @@ struct name_path {
 
 char *path_name(const struct name_path *path, const char *name);
 
-extern void show_object_with_name(FILE *, struct object *, const struct name_path *, const char *);
+extern void show_object_with_name(FILE *, struct object *,
+				  const struct name_path *, const char *);
 
 extern void add_object(struct object *obj,
 		       struct object_array *p,
 		       struct name_path *path,
 		       const char *name);
 
-extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
-extern void add_pending_sha1(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags);
+extern void add_pending_object(struct rev_info *revs,
+			       struct object *obj, const char *name);
+extern void add_pending_sha1(struct rev_info *revs,
+			     const char *name, const unsigned char *sha1,
+			     unsigned int flags);
 
 extern void add_head_to_pending(struct rev_info *);
 
@@ -238,7 +246,9 @@ enum commit_action {
 	commit_error
 };
 
-extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
-extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
+extern enum commit_action get_commit_action(struct rev_info *revs,
+					    struct commit *commit);
+extern enum commit_action simplify_commit(struct rev_info *revs,
+					  struct commit *commit);
 
 #endif
-- 
1.8.2.3
