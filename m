From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Typofixes outside documentation area
Date: Wed, 03 Feb 2010 21:31:05 -0800
Message-ID: <7v636dr2hy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 06:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcuJB-0006uU-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 06:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab0BDFbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 00:31:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab0BDFbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 00:31:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B918196115;
	Thu,  4 Feb 2010 00:31:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=zazm
	FNFFn7+ZiV8eadQK7i3BaE8=; b=eLgVjTzUvXMmkufbD36HBmL98rO2YcRgpsBi
	c7meENw96Q4rm96NDGhFnbPl8QQitH4fP2VI+KHJVU/7ah2pGyoPRffdhMeSWrq6
	adlNMeUAcAO0zBLu+eT9NO1TowSgLUb/W/b82BMaW1a53faQMB71YC3HSAOpj2HV
	tjLqIWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=uYg
	vz7wSTLd6DnVbdI5C2mw6SAkwb6QB5EJbNDxwWTzmnjWuzRbUaQXT3wG5bHXU4J0
	tID3M546tcispAa9UrGzJ/bcaQFj66TaaZq2eUTRNdPWzGfbpWx4MvOv93i/kLEf
	7kVG+XJcqIhpsB3ZcWdudh2nuo4PyDvnZSuSO1gI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A68A496114;
	Thu,  4 Feb 2010 00:31:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0CDA96112; Thu,  4 Feb
 2010 00:31:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F600670-114E-11DF-9549-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138950>

    begining -> beginning
    canonicalizations -> canonicalization
    comand -> command
    dewrapping -> unwrapping
    dirtyness -> dirtiness
    DISCLAMER -> DISCLAIMER
    explicitely -> explicitly
    feeded -> fed
    impiled -> implied
    madatory -> mandatory
    mimick -> mimic
    preceeding -> preceding
    reqeuest -> request
    substition -> substitution

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c                             |    2 +-
 builtin-cat-file.c                          |    5 +++--
 builtin-log.c                               |    2 +-
 builtin-prune.c                             |    2 +-
 builtin-show-branch.c                       |    2 +-
 compat/win32/pthread.c                      |    2 +-
 connect.c                                   |    2 +-
 contrib/fast-import/import-directories.perl |    2 +-
 daemon.c                                    |    2 +-
 diff.c                                      |    2 +-
 levenshtein.h                               |    2 +-
 path.c                                      |    2 +-
 perl/Git.pm                                 |    4 ++--
 refs.c                                      |    2 +-
 setup.c                                     |    2 +-
 test-chmtime.c                              |    2 +-
 transport-helper.c                          |    2 +-
 17 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2a1004d..3af4ae0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2006,7 +2006,7 @@ static int find_pos(struct image *img,
 		return -1;
 
 	/*
-	 * If match_begining or match_end is specified, there is no
+	 * If match_beginning or match_end is specified, there is no
 	 * point starting from a wrong line that will never match and
 	 * wander around and wait for a match at the specified end.
 	 */
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 5906842..a933eaa 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -219,9 +219,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			    "exit with zero when there's no error", 'e'),
 		OPT_SET_INT('p', NULL, &opt, "pretty-print object's content", 'p'),
 		OPT_SET_INT(0, "batch", &batch,
-			    "show info and content of objects feeded on stdin", BATCH),
+			    "show info and content of objects fed from the standard input",
+			    BATCH),
 		OPT_SET_INT(0, "batch-check", &batch,
-			    "show info about objects feeded on stdin",
+			    "show info about objects fed from the standard input",
 			    BATCH_CHECK),
 		OPT_END()
 	};
diff --git a/builtin-log.c b/builtin-log.c
index 8d16832..e0d5caa 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1089,7 +1089,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * We cannot move this anywhere earlier because we do want to
-	 * know if --root was given explicitly from the comand line.
+	 * know if --root was given explicitly from the command line.
 	 */
 	rev.show_root_diff = 1;
 
diff --git a/builtin-prune.c b/builtin-prune.c
index 8459aec..4675f60 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -106,7 +106,7 @@ static void prune_object_dir(const char *path)
 /*
  * Write errors (particularly out of space) can result in
  * failed temporary packs (and more rarely indexes and other
- * files begining with "tmp_") accumulating in the object
+ * files beginning with "tmp_") accumulating in the object
  * and the pack directories.
  */
 static void remove_temporary_files(const char *path)
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 9f13caa..35a709e 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -567,7 +567,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		/*
 		 * default_arg is now passed to parse_options(), so we need to
-		 * mimick the real argv a bit better.
+		 * mimic the real argv a bit better.
 		 */
 		if (!default_num) {
 			default_alloc = 20;
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 5fc1670..0f949fc 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
  *
- * DISCLAMER: The implementation is Git-specific, it is subset of original
+ * DISCLAIMER: The implementation is Git-specific, it is subset of original
  * Pthreads API, without lots of other features that Git doesn't use.
  * Git also makes sure that the passed arguments are valid, so there's
  * no need for double-checking.
diff --git a/connect.c b/connect.c
index 20054e4..a37cf6a 100644
--- a/connect.c
+++ b/connect.c
@@ -504,7 +504,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 
 	/*
 	 * Don't do destructive transforms with git:// as that
-	 * protocol code does '[]' dewrapping of its own.
+	 * protocol code does '[]' unwrapping of its own.
 	 */
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
index 5782d80..3a5da4a 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -344,7 +344,7 @@ sub parsekeyvaluepair
 
 Key and value strings may be enclosed in quotes, in which case
 whitespace inside the quotes is preserved. Additionally, an equal
-sign may be included in the key by preceeding it with a backslash.
+sign may be included in the key by preceding it with a backslash.
 For example:
 
  "key1 "=value1
diff --git a/daemon.c b/daemon.c
index 6c2bd97..3769b6f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -407,7 +407,7 @@ static void parse_host_and_port(char *hostport, char **host,
 
 		end = strchr(hostport, ']');
 		if (!end)
-			die("Invalid reqeuest ('[' without ']')");
+			die("Invalid request ('[' without ']')");
 		*end = '\0';
 		*host = hostport + 1;
 		if (!end[1])
diff --git a/diff.c b/diff.c
index 381cc8d..9038057 100644
--- a/diff.c
+++ b/diff.c
@@ -3642,7 +3642,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 		struct diff_filepair *p = q->queue[i];
 
 		/*
-		 * 1. Entries that come from stat info dirtyness
+		 * 1. Entries that come from stat info dirtiness
 		 *    always have both sides (iow, not create/delete),
 		 *    one side of the object name is unknown, with
 		 *    the same mode and size.  Keep the ones that
diff --git a/levenshtein.h b/levenshtein.h
index 0173abe..4105bf3 100644
--- a/levenshtein.h
+++ b/levenshtein.h
@@ -2,7 +2,7 @@
 #define LEVENSHTEIN_H
 
 int levenshtein(const char *string1, const char *string2,
-	int swap_penalty, int substition_penalty,
+	int swap_penalty, int substitution_penalty,
 	int insertion_penalty, int deletion_penalty);
 
 #endif
diff --git a/path.c b/path.c
index 79aa104..e166d53 100644
--- a/path.c
+++ b/path.c
@@ -610,7 +610,7 @@ int daemon_avoid_alias(const char *p)
 	/*
 	 * This resurrects the belts and suspenders paranoia check by HPA
 	 * done in <435560F7.4080006@zytor.com> thread, now enter_repo()
-	 * does not do getcwd() based path canonicalizations.
+	 * does not do getcwd() based path canonicalization.
 	 *
 	 * sl becomes true immediately after seeing '/' and continues to
 	 * be true as long as dots continue after that without intervening
diff --git a/perl/Git.pm b/perl/Git.pm
index e8df55d..970fe43 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -204,14 +204,14 @@ sub repository {
 			$dir = $opts{Directory};
 
 			unless (-d "$dir/refs" and -d "$dir/objects" and -e "$dir/HEAD") {
-				# Mimick git-rev-parse --git-dir error message:
+				# Mimic git-rev-parse --git-dir error message:
 				throw Error::Simple("fatal: Not a git repository: $dir");
 			}
 			my $search = Git->repository(Repository => $dir);
 			try {
 				$search->command('symbolic-ref', 'HEAD');
 			} catch Git::Error::Command with {
-				# Mimick git-rev-parse --git-dir error message:
+				# Mimic git-rev-parse --git-dir error message:
 				throw Error::Simple("fatal: Not a git repository: $dir");
 			}
 
diff --git a/refs.c b/refs.c
index 503a8c2..f3fcbe0 100644
--- a/refs.c
+++ b/refs.c
@@ -706,7 +706,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 
 	has_glob_specials = strpbrk(pattern, "?*[");
 	if (!has_glob_specials) {
-		/* Append impiled '/' '*' if not present. */
+		/* Append implied '/' '*' if not present. */
 		if (real_pattern.buf[real_pattern.len - 1] != '/')
 			strbuf_addch(&real_pattern, '/');
 		/* No need to check for '*', there is none. */
diff --git a/setup.c b/setup.c
index 710e2f3..fac34f7 100644
--- a/setup.c
+++ b/setup.c
@@ -206,7 +206,7 @@ int is_inside_work_tree(void)
 }
 
 /*
- * set_work_tree() is only ever called if you set GIT_DIR explicitely.
+ * set_work_tree() is only ever called if you set GIT_DIR explicitly.
  * The old behaviour (which we retain here) is to set the work tree root
  * to the cwd, unless overridden by the config, the command line, or
  * GIT_WORK_TREE.
diff --git a/test-chmtime.c b/test-chmtime.c
index fe476cb..92713d1 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -1,7 +1,7 @@
 /*
  * This program can either change modification time of the given
  * file(s) or just print it. The program does not change atime nor
- * ctime (their values are explicitely preserved).
+ * ctime (their values are explicitly preserved).
  *
  * The mtime can be changed to an absolute value:
  *
diff --git a/transport-helper.c b/transport-helper.c
index 1077428..f822972 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -171,7 +171,7 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (mandatory) {
-			die("Unknown madatory capability %s. This remote "
+			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.\n",
 			    capname);
 		}
-- 
1.7.0.rc1.199.g9253ab
