From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/25] revision: split some overly-long lines
Date: Sat, 25 May 2013 11:08:07 +0200
Message-ID: <1369472904-12875-9-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:11:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAVH-0006EK-Io
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab3EYJK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:10:58 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58127 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900Ab3EYJJG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:06 -0400
X-AuditID: 12074411-b7f286d0000008e8-f8-51a07fb135dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 60.22.02280.1BF70A15; Sat, 25 May 2013 05:09:05 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gui000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:04 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLuxfkGgwe+X2hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzrix9AZ7wSK9igMbfrA0MD5X7WLk5JAQMJF4uLqHGcIWk7hwbz1b
	FyMXh5DAZUaJF9vPskI4F5gk+qdcZgOpYhPQlVjU08wEYosIOEqceHAdrIhZoJdR4uGj72AJ
	YQEHid8TT7KD2CwCqhKvnsxkBbF5BVwkGpuWs0KsU5C4PGsN0GoODk4BV4m3JzhBwkJAJc8/
	nWOdwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIoAnuYJxxUu4Q
	owAHoxIPr0D5/EAh1sSy4srcQ4ySHExKorz8tQsChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	MqQA5XhTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKErx764AaBYtS01Mr
	0jJzShDSTBycIIILZAMP0IazIIW8xQWJucWZ6RBFpxgVpcR5b4IkBEASGaV5cANgKeEVozjQ
	P8K8C0CqeIDpBK77FdBgJqDBN3PngwwuSURISTUwMsZsql37N3RtXeunW4s07vJPXpiUcbhS
	ZDbLqbfbxZZeOMuxxbSdt886puBZ30RmTqt5mgvqN17u37YqlH+ClaAtywV7udJlz+SeH5y1
	239mocBi50UNXO2JwVkdNWYWCzznp36cfJJf+uDq+/XJcu/b/Bfmm1pcn3bt9+c3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225516>


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
