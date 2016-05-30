From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/13] refs: remove unnecessary "extern" keywords
Date: Mon, 30 May 2016 09:55:22 +0200
Message-ID: <fa9460fbe5c8ecc9636752919adea36acd5457ed.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3N-0001DC-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbcE3Hzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:55:50 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53201 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658AbcE3Hzt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:55:49 -0400
X-AuditID: 1207440f-8bbff700000008e4-e1-574bf204230d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E7.0D.02276.402FB475; Mon, 30 May 2016 03:55:48 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRq032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:46 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqMvyyTvc4N8WDov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4M45//cdY8Duh4v7SpSwNjHsDuhg5OSQETCRe/NjKCGILCWxllJjS
	IdzFyAVkn2SS6Gh6zA6SYBPQlVjU08wEYosIREg0vGphBCliFtjHKHFy3XyWLkYODmEBR4kb
	P51BalgEVCW2bPgD1ssrECWxufcBK8QyOYnL0x+wgdicAhYSE2e9Y4JYbC6xbOZJ5gmMPAsY
	GVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5ihIQT/w7GrvUyhxgFOBiVeHgL
	NL3DhVgTy4orcw8xSnIwKYnyunEAhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwvn0MlONNSays
	Si3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfAKfwRqFCxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAdFQHwxMAZAUjxAe/d/ANlbXJCYCxSFaD3FaMxxZP+9tUwc8ybt
	OsYkxJKXn5cqJc5rD1IqAFKaUZoHtwiWSF4xigP9LczrCnIPDzAJwc17BbSKCWiV2TkvkFUl
	iQgpqQbGAP9FBzyZ1Cf6usnYHvvxf8/hi9nSyY1SPf65L1O+LnpvtPvuhe/nfJiy5PKf2UyO
	PGK3Y+LGu1v+Tf/wq61rneXthyudmxeq2qzj4N4481j9u8LA4IUXvsyTmpz87DMf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295857>

There's continuing work in this area, so clean up unneeded "extern"
keywords rather than schlepping them around. Also split up some overlong
lines and add parameter names in a couple of places.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 132 +++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 72 insertions(+), 60 deletions(-)

diff --git a/refs.h b/refs.h
index 9230d47..21874f0 100644
--- a/refs.h
+++ b/refs.h
@@ -52,19 +52,19 @@
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
-extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-				      unsigned char *sha1, int *flags);
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags);
 
-extern char *resolve_refdup(const char *refname, int resolve_flags,
-			    unsigned char *sha1, int *flags);
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags);
 
-extern int read_ref_full(const char *refname, int resolve_flags,
-			 unsigned char *sha1, int *flags);
-extern int read_ref(const char *refname, unsigned char *sha1);
+int read_ref_full(const char *refname, int resolve_flags,
+		  unsigned char *sha1, int *flags);
+int read_ref(const char *refname, unsigned char *sha1);
 
-extern int ref_exists(const char *refname);
+int ref_exists(const char *refname);
 
-extern int is_branch(const char *refname);
+int is_branch(const char *refname);
 
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
@@ -74,24 +74,25 @@ extern int is_branch(const char *refname);
  * Symbolic references are considered unpeelable, even if they
  * ultimately resolve to a peelable tag.
  */
-extern int peel_ref(const char *refname, unsigned char *sha1);
+int peel_ref(const char *refname, unsigned char *sha1);
 
 /**
  * Resolve refname in the nested "gitlink" repository that is located
  * at path.  If the resolution is successful, return 0 and set sha1 to
  * the name of the object; otherwise, return a non-zero value.
  */
-extern int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1);
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
  * full_name according to the rules defined by ref_rev_parse_rules in
  * refs.c.
  */
-extern int refname_match(const char *abbrev_name, const char *full_name);
+int refname_match(const char *abbrev_name, const char *full_name);
 
-extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
-extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
+int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
 /*
  * A ref_transaction represents a collection of ref updates
@@ -182,38 +183,45 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
-extern int head_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
-extern int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken);
-extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
-extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
+int head_ref(each_ref_fn fn, void *cb_data);
+int for_each_ref(each_ref_fn fn, void *cb_data);
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
+			unsigned int broken);
+int for_each_tag_ref(each_ref_fn fn, void *cb_data);
+int for_each_branch_ref(each_ref_fn fn, void *cb_data);
+int for_each_remote_ref(each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(each_ref_fn fn, void *cb_data);
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+			 const char *prefix, void *cb_data);
 
-extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+int for_each_ref_submodule(const char *submodule,
+			   each_ref_fn fn, void *cb_data);
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data);
-extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+int for_each_tag_ref_submodule(const char *submodule,
+			       each_ref_fn fn, void *cb_data);
+int for_each_branch_ref_submodule(const char *submodule,
+				  each_ref_fn fn, void *cb_data);
+int for_each_remote_ref_submodule(const char *submodule,
+				  each_ref_fn fn, void *cb_data);
 
-extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+int head_ref_namespaced(each_ref_fn fn, void *cb_data);
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn fn, void *cb_data);
+int for_each_rawref(each_ref_fn fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
 }
 
-extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
-extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
+void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
+			   const struct string_list *refnames);
 
 /*
  * Flags for controlling behaviour of pack_refs()
@@ -245,13 +253,13 @@ int pack_refs(unsigned int flags);
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *refname, unsigned int flags,
-		       unsigned long at_time, int cnt,
-		       unsigned char *sha1, char **msg,
-		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+int read_ref_at(const char *refname, unsigned int flags,
+		unsigned long at_time, int cnt,
+		unsigned char *sha1, char **msg,
+		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
-extern int reflog_exists(const char *refname);
+int reflog_exists(const char *refname);
 
 /*
  * Delete the specified reference. If old_sha1 is non-NULL, then
@@ -260,21 +268,25 @@ extern int reflog_exists(const char *refname);
  * exists, regardless of its old value. It is an error for old_sha1 to
  * be NULL_SHA1. flags is passed through to ref_transaction_delete().
  */
-extern int delete_ref(const char *refname, const unsigned char *old_sha1,
-		      unsigned int flags);
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags);
 
 /*
  * Delete the specified references. If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
  * an all-or-nothing transaction).
  */
-extern int delete_refs(struct string_list *refnames);
+int delete_refs(struct string_list *refnames);
 
 /** Delete a reflog */
-extern int delete_reflog(const char *refname);
+int delete_reflog(const char *refname);
 
 /* iterate over reflog entries */
-typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
+typedef int each_reflog_ent_fn(
+		unsigned char *old_sha1, unsigned char *new_sha1,
+		const char *committer, unsigned long timestamp,
+		int tz, const char *msg, void *cb_data);
+
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
@@ -282,7 +294,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
-extern int for_each_reflog(each_ref_fn, void *);
+int for_each_reflog(each_ref_fn fn, void *cb_data);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
@@ -295,16 +307,16 @@ extern int for_each_reflog(each_ref_fn, void *);
  * allow a single "*" wildcard character in the refspec. No leading or
  * repeated slashes are accepted.
  */
-extern int check_refname_format(const char *refname, int flags);
+int check_refname_format(const char *refname, int flags);
 
-extern const char *prettify_refname(const char *refname);
+const char *prettify_refname(const char *refname);
 
-extern char *shorten_unambiguous_ref(const char *refname, int strict);
+char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
+int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-extern int create_symref(const char *refname, const char *target, const char *logmsg);
+int create_symref(const char *refname, const char *target, const char *logmsg);
 
 /*
  * Update HEAD of the specified gitdir.
@@ -313,7 +325,7 @@ extern int create_symref(const char *refname, const char *target, const char *lo
  * $GIT_DIR points to.
  * Return 0 if successful, non-zero otherwise.
  * */
-extern int set_worktree_head_symref(const char *gitdir, const char *target);
+int set_worktree_head_symref(const char *gitdir, const char *target);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
@@ -463,7 +475,7 @@ int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr);
 
-extern int parse_hide_refs_config(const char *var, const char *value, const char *);
+int parse_hide_refs_config(const char *var, const char *value, const char *);
 
 /*
  * Check whether a ref is hidden. If no namespace is set, both the first and
@@ -473,7 +485,7 @@ extern int parse_hide_refs_config(const char *var, const char *value, const char
  * the ref is outside that namespace, the first parameter is NULL. The second
  * parameter always points to the full ref name.
  */
-extern int ref_is_hidden(const char *, const char *);
+int ref_is_hidden(const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,
@@ -522,11 +534,11 @@ typedef void reflog_expiry_cleanup_fn(void *cb_data);
  * enum expire_reflog_flags. The three function pointers are described
  * above. On success, return zero.
  */
-extern int reflog_expire(const char *refname, const unsigned char *sha1,
-			 unsigned int flags,
-			 reflog_expiry_prepare_fn prepare_fn,
-			 reflog_expiry_should_prune_fn should_prune_fn,
-			 reflog_expiry_cleanup_fn cleanup_fn,
-			 void *policy_cb_data);
+int reflog_expire(const char *refname, const unsigned char *sha1,
+		  unsigned int flags,
+		  reflog_expiry_prepare_fn prepare_fn,
+		  reflog_expiry_should_prune_fn should_prune_fn,
+		  reflog_expiry_cleanup_fn cleanup_fn,
+		  void *policy_cb_data);
 
 #endif /* REFS_H */
-- 
2.8.1
