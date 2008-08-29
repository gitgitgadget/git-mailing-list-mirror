From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Replace "git-" with "git " in *.[ch] comments and notifications
Date: Sat, 30 Aug 2008 02:47:51 +0300
Message-ID: <20080829234751.GA2396@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEDs-0003gc-FS
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYH3AUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYH3AUj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:20:39 -0400
Received: from zakalwe.fi ([80.83.5.154]:57199 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbYH3AUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:20:36 -0400
X-Greylist: delayed 1964 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Aug 2008 20:20:36 EDT
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 442912BC68; Sat, 30 Aug 2008 02:47:51 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94338>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 archive.c                  |    2 +-
 builtin-apply.c            |    8 ++++----
 builtin-archive.c          |    8 ++++----
 builtin-blame.c            |    6 +++---
 builtin-branch.c           |    2 +-
 builtin-bundle.c           |    4 ++--
 builtin-cat-file.c         |    4 ++--
 builtin-check-ref-format.c |    2 +-
 builtin-checkout-index.c   |   20 ++++++++++----------
 builtin-clone.c            |    2 +-
 builtin-commit-tree.c      |    4 ++--
 builtin-fetch-pack.c       |    4 ++--
 builtin-fetch.c            |    6 +++---
 builtin-grep.c             |    2 +-
 builtin-http-fetch.c       |    4 ++--
 builtin-init-db.c          |    2 +-
 builtin-ls-files.c         |    6 +++---
 builtin-pack-objects.c     |    4 ++--
 builtin-read-tree.c        |    2 +-
 builtin-rev-list.c         |    2 +-
 builtin-rm.c               |    6 +++---
 builtin-send-pack.c        |    2 +-
 builtin-show-ref.c         |    6 +++---
 builtin-tar-tree.c         |   18 +++++++++---------
 builtin-unpack-objects.c   |    2 +-
 builtin-update-index.c     |   24 ++++++++++++------------
 builtin-verify-pack.c      |    2 +-
 builtin-write-tree.c       |    2 +-
 connect.c                  |    4 ++--
 diff-lib.c                 |    2 +-
 diff.c                     |    2 +-
 entry.c                    |   22 +++++++++++-----------
 environment.c              |    2 +-
 fsck.c                     |    2 +-
 http-push.c                |    2 +-
 imap-send.c                |    2 +-
 index-pack.c               |    2 +-
 merge-index.c              |    8 ++++----
 mktag.c                    |    2 +-
 mktree.c                   |    2 +-
 patch-id.c                 |    4 ++--
 quote.h                    |    2 +-
 read-cache.c               |   12 ++++++------
 receive-pack.c             |    2 +-
 shell.c                    |    2 +-
 tree-diff.c                |    2 +-
 tree.c                     |    2 +-
 unpack-file.c              |    2 +-
 unpack-trees.c             |    2 +-
 upload-pack.c              |   22 +++++++++++-----------
 50 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/archive.c b/archive.c
index e2280df..042f587 100644
--- a/archive.c
+++ b/archive.c
@@ -282,7 +282,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "remote", &remote, "repo",
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
-			"path to the remote git-upload-archive command"),
+			"path to the remote git upload-archive command"),
 		OPT_END()
 	};
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 2216a0b..1e14904 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -274,7 +274,7 @@ static void say_patch_name(FILE *output, const char *pre,
 static void read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die("git-apply: read returned %s", strerror(errno));
+		die("git apply: read returned %s", strerror(errno));
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -506,17 +506,17 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		name = orig_name;
 		len = strlen(name);
 		if (isnull)
-			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
+			die("git apply: bad git diff - expected /dev/null, got %s on line %d", name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len))
-			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
+			die("git apply: bad git diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
 		return orig_name;
 	}
 	else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die("git-apply: bad git-diff - expected /dev/null on line %d", linenr);
+			die("git apply: bad git diff - expected /dev/null on line %d", linenr);
 		return NULL;
 	}
 }
diff --git a/builtin-archive.c b/builtin-archive.c
index 22445ac..5ceec43 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -47,18 +47,18 @@ static int run_remote_archiver(const char *remote, int argc,
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
 	if (!len)
-		die("git-archive: expected ACK/NAK, got EOF");
+		die("git archive: expected ACK/NAK, got EOF");
 	if (buf[len-1] == '\n')
 		buf[--len] = 0;
 	if (strcmp(buf, "ACK")) {
 		if (len > 5 && !prefixcmp(buf, "NACK "))
-			die("git-archive: NACK %s", buf + 5);
-		die("git-archive: protocol error");
+			die("git archive: NACK %s", buf + 5);
+		die("git archive: protocol error");
 	}
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
 	if (len)
-		die("git-archive: expected a flush");
+		die("git archive: expected a flush");
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1, 2);
diff --git a/builtin-blame.c b/builtin-blame.c
index e4d12de..1bf7b2d 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1787,7 +1787,7 @@ static int prepare_lines(struct scoreboard *sb)
 
 /*
  * Add phony grafts for use with -S; this is primarily to
- * support git-cvsserver that wants to give a linear history
+ * support git cvsserver that wants to give a linear history
  * to its clients.
  */
 static int read_ancestry(const char *graft_file)
@@ -2299,12 +2299,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('f', "show-name", &output_option, "Show original filename (Default: auto)", OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, "Show original linenumber (Default: off)", OUTPUT_SHOW_NUMBER),
 		OPT_BIT('p', "porcelain", &output_option, "Show in a format designed for machine consumption", OUTPUT_PORCELAIN),
-		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git-annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
+		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
 		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
 		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
-		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
+		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
diff --git a/builtin-branch.c b/builtin-branch.c
index b1a2ad7..8efc828 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -526,7 +526,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		},
 		OPT__ABBREV(&abbrev),
 
-		OPT_GROUP("Specific git-branch actions:"),
+		OPT_GROUP("Specific git branch actions:"),
 		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
 		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
diff --git a/builtin-bundle.c b/builtin-bundle.c
index ac476e7..7bf12f5 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -6,10 +6,10 @@
  * Basic handler for bundle files to connect repositories via sneakernet.
  * Invocation must include action.
  * This function can create a bundle or provide information on an existing
- * bundle supporting git-fetch, git-pull, and git-ls-remote
+ * bundle supporting git fetch, git pull, and git ls-remote
  */
 
-static const char *bundle_usage="git-bundle (create <bundle> <git-rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
+static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 7441a56..3fba6b9 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -137,11 +137,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		break;
 
 	default:
-		die("git-cat-file: unknown option: %s\n", exp_type);
+		die("git cat-file: unknown option: %s\n", exp_type);
 	}
 
 	if (!buf)
-		die("git-cat-file %s: bad file", obj_name);
+		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
 	return 0;
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index fe04be7..701de43 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -9,6 +9,6 @@
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 2)
-		usage("git-check-ref-format refname");
+		usage("git check-ref-format refname");
 	return !!check_ref_format(argv[1]);
 }
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 71ebabf..55b7aaf 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -5,26 +5,26 @@
  *
  * Careful: order of argument flags does matter. For example,
  *
- *	git-checkout-index -a -f file.c
+ *	git checkout-index -a -f file.c
  *
  * Will first check out all files listed in the cache (but not
  * overwrite any old ones), and then force-checkout "file.c" a
  * second time (ie that one _will_ overwrite any old contents
  * with the same filename).
  *
- * Also, just doing "git-checkout-index" does nothing. You probably
- * meant "git-checkout-index -a". And if you want to force it, you
- * want "git-checkout-index -f -a".
+ * Also, just doing "git checkout-index" does nothing. You probably
+ * meant "git checkout-index -a". And if you want to force it, you
+ * want "git checkout-index -f -a".
  *
  * Intuitiveness is not the goal here. Repeatability is. The
  * reason for the "no arguments means no work" thing is that
  * from scripts you are supposed to be able to do things like
  *
- *	find . -name '*.h' -print0 | xargs -0 git-checkout-index -f --
+ *	find . -name '*.h' -print0 | xargs -0 git checkout-index -f --
  *
  * or:
  *
- *	find . -name '*.h' -print0 | git-checkout-index -f -z --stdin
+ *	find . -name '*.h' -print0 | git checkout-index -f -z --stdin
  *
  * which will force all existing *.h files to be replaced with
  * their cached copies. If an empty command line implied "all",
@@ -107,7 +107,7 @@ static int checkout_file(const char *name, int prefix_length)
 	}
 
 	if (!state.quiet) {
-		fprintf(stderr, "git-checkout-index: %s ", name);
+		fprintf(stderr, "git checkout-index: %s ", name);
 		if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
 		else if (checkout_stage)
@@ -258,9 +258,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		const char *p;
 
 		if (all)
-			die("git-checkout-index: don't mix '--all' and explicit filenames");
+			die("git checkout-index: don't mix '--all' and explicit filenames");
 		if (read_from_stdin)
-			die("git-checkout-index: don't mix '--stdin' and explicit filenames");
+			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p, prefix_length);
 		if (p < arg || p > arg + strlen(arg))
@@ -271,7 +271,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		struct strbuf buf, nbuf;
 
 		if (all)
-			die("git-checkout-index: don't mix '--all' and '--stdin'");
+			die("git checkout-index: don't mix '--all' and '--stdin'");
 
 		strbuf_init(&buf, 0);
 		strbuf_init(&nbuf, 0);
diff --git a/builtin-clone.c b/builtin-clone.c
index c0e3086..ba2b99a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -60,7 +60,7 @@ static struct option builtin_clone_options[] = {
 	OPT_STRING('o', "origin", &option_origin, "branch",
 		   "use <branch> instead or 'origin' to track upstream"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
-		   "path to git-upload-pack on the remote"),
+		   "path to git upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
 
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index f773db5..f2684bb 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -24,7 +24,7 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -121,7 +121,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (strbuf_read(&buffer, 0, 0) < 0)
-		die("git-commit-tree: read returned %s", strerror(errno));
+		die("git commit-tree: read returned %s", strerror(errno));
 
 	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 273239a..85509f5 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -609,7 +609,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "warning: no common commits\n");
 
 	if (get_pack(fd, pack_lockfile))
-		die("git-fetch-pack: fetch failed.");
+		die("git fetch-pack: fetch failed.");
 
  all_done:
 	return ref;
@@ -750,7 +750,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
-		 * Otherwise, 'git-fetch remote no-such-ref' would
+		 * Otherwise, 'git fetch remote no-such-ref' would
 		 * silently succeed without issuing an error.
 		 */
 		for (i = 0; i < nr_heads; i++)
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7eec4a0..2b7fddc 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -86,10 +86,10 @@ static void add_merge_config(struct ref **head,
 		/*
 		 * Not fetched to a tracking branch?  We need to fetch
 		 * it anyway to allow this branch's "branch.$name.merge"
-		 * to be honored by git-pull, but we do not have to
+		 * to be honored by git pull, but we do not have to
 		 * fail if branch.$name.merge is misconfigured to point
 		 * at a nonexisting branch.  If we were indeed called by
-		 * git-pull, it will notice the misconfiguration because
+		 * git pull, it will notice the misconfiguration because
 		 * there is no entry in the resulting FETCH_HEAD marked
 		 * for merging.
 		 */
@@ -396,7 +396,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
  * The refs we are going to fetch are in to_fetch (nr_heads in
  * total).  If running
  *
- *  $ git-rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
+ *  $ git rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
  *
  * does not error out, that means everything reachable from the
  * refs we are going to fetch exists and is connected to some of
diff --git a/builtin-grep.c b/builtin-grep.c
index 631129d..f59f95f 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -774,7 +774,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			/* Make sure we do not get outside of paths */
 			for (i = 0; paths[i]; i++)
 				if (strncmp(prefix, paths[i], opt.prefix_length))
-					die("git-grep: cannot generate relative filenames containing '..'");
+					die("git grep: cannot generate relative filenames containing '..'");
 		}
 	}
 	else if (prefix) {
diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index 3a06248..be188fd 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -42,7 +42,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 		arg++;
 	}
 	if (argc < arg + 2 - commits_on_stdin) {
-		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
+		usage("git http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
 		return 1;
 	}
 	if (commits_on_stdin) {
@@ -75,7 +75,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 		fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
 "a false '404 Not Found' error message sent with incorrect HTTP\n"
-"status code.  Suggest running git-fsck.\n");
+"status code.  Suggest running git fsck.\n");
 	}
 
 	walker_free(walker);
diff --git a/builtin-init-db.c b/builtin-init-db.c
index baf0d09..81aa822 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -37,7 +37,7 @@ static void copy_templates_1(char *path, int baselen,
 
 	/* Note: if ".git/hooks" file exists in the repository being
 	 * re-initialized, /etc/core-git/templates/hooks/update would
-	 * cause git-init to fail here.  I think this is sane but
+	 * cause git init to fail here.  I think this is sane but
 	 * it means that the set of templates we ship by default, along
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e8d568e..068f424 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -78,7 +78,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	int offset = prefix_offset;
 
 	if (len >= ent->len)
-		die("git-ls-files: internal error - directory entry not superset of prefix");
+		die("git ls-files: internal error - directory entry not superset of prefix");
 
 	if (pathspec && !pathspec_match(pathspec, ps_matched, ent->name, len))
 		return;
@@ -183,7 +183,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	int offset = prefix_offset;
 
 	if (len >= ce_namelen(ce))
-		die("git-ls-files: internal error - cache entry not superset of prefix");
+		die("git ls-files: internal error - cache entry not superset of prefix");
 
 	if (pathspec && !pathspec_match(pathspec, ps_matched, ce->name, len))
 		return;
@@ -319,7 +319,7 @@ static const char *verify_pathspec(const char *prefix)
 	}
 
 	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
-		die("git-ls-files: cannot generate relative filenames containing '..'");
+		die("git ls-files: cannot generate relative filenames containing '..'");
 
 	prefix_len = max;
 	return max ? xmemdupz(prev, max) : NULL;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d394c49..1fff31d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -23,7 +23,7 @@
 #endif
 
 static const char pack_usage[] = "\
-git-pack-objects [{ -q | --progress | --all-progress }] \n\
+git pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--max-pack-size=N] [--local] [--incremental] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
@@ -1869,7 +1869,7 @@ static void mark_in_pack_object(struct object *object, struct packed_git *p, str
 
 /*
  * Compare the objects in the offset order, in order to emulate the
- * "git-rev-list --objects" output that produced the pack originally.
+ * "git rev-list --objects" output that produced the pack originally.
  */
 static int ofscmp(const void *a_, const void *b_)
 {
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 72a6de3..b9d50fb 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -64,7 +64,7 @@ static void prime_cache_tree(void)
 
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c023003..9e95f38 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -178,7 +178,7 @@ static void finish_object(struct object_array_entry *p)
 static void show_object(struct object_array_entry *p)
 {
 	/* An object with name "foo\n0000000..." can be used to
-	 * confuse downstream git-pack-objects very badly.
+	 * confuse downstream git pack-objects very badly.
 	 */
 	const char *ep = strchr(p->name, '\n');
 
diff --git a/builtin-rm.c b/builtin-rm.c
index 0ed26bb..6f82420 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -104,7 +104,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 				     "from both the file and the HEAD\n"
 				     "(use -f to force removal)", name);
 		else if (!index_only) {
-			/* It's not dangerous to git-rm --cached a
+			/* It's not dangerous to git rm --cached a
 			 * file if the index matches the file or the
 			 * HEAD, since it means the deleted content is
 			 * still available somewhere.
@@ -221,7 +221,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			printf("rm '%s'\n", path);
 
 		if (remove_file_from_cache(path))
-			die("git-rm: unable to remove %s", path);
+			die("git rm: unable to remove %s", path);
 	}
 
 	if (show_only)
@@ -244,7 +244,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!removed)
-				die("git-rm: %s: %s", path, strerror(errno));
+				die("git rm: %s: %s", path, strerror(errno));
 		}
 	}
 
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 7588d22..2af9f29 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -43,7 +43,7 @@ static int pack_objects(int fd, struct ref *refs)
 	po.out = fd;
 	po.git_cmd = 1;
 	if (start_command(&po))
-		die("git-pack-objects failed (%s)", strerror(errno));
+		die("git pack-objects failed (%s)", strerror(errno));
 
 	/*
 	 * We feed the pack-objects we just spawned with revision
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index add1600..572b114 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -62,7 +62,7 @@ match:
 	 * ref points at a nonexistent object.
 	 */
 	if (!has_sha1_file(sha1))
-		die("git-show-ref: bad ref %s (%s)", refname,
+		die("git show-ref: bad ref %s (%s)", refname,
 		    sha1_to_hex(sha1));
 
 	if (quiet)
@@ -82,12 +82,12 @@ match:
 	else {
 		obj = parse_object(sha1);
 		if (!obj)
-			die("git-show-ref: bad ref %s (%s)", refname,
+			die("git show-ref: bad ref %s (%s)", refname,
 			    sha1_to_hex(sha1));
 		if (obj->type == OBJ_TAG) {
 			obj = deref_tag(obj, refname, 0);
 			if (!obj)
-				die("git-show-ref: bad tag at ref %s (%s)", refname,
+				die("git show-ref: bad tag at ref %s (%s)", refname,
 				    sha1_to_hex(sha1));
 			hex = find_unique_abbrev(obj->sha1, abbrev);
 			printf("%s %s^{}\n", hex, refname);
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f4bea4a..1cd35ff 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -9,19 +9,19 @@
 
 static const char tar_tree_usage[] =
 "git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
-"*** Note that this command is now deprecated; use git-archive instead.";
+"*** Note that this command is now deprecated; use git archive instead.";
 
 int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 {
 	/*
-	 * git-tar-tree is now a wrapper around git-archive --format=tar
+	 * git tar-tree is now a wrapper around git archive --format=tar
 	 *
 	 * $0 --remote=<repo> arg... ==>
-	 *	git-archive --format=tar --remote=<repo> arg...
+	 *	git archive --format=tar --remote=<repo> arg...
 	 * $0 tree-ish ==>
-	 *	git-archive --format=tar tree-ish
+	 *	git archive --format=tar tree-ish
 	 * $0 tree-ish basedir ==>
-	 * 	git-archive --format-tar --prefix=basedir tree-ish
+	 * 	git archive --format-tar --prefix=basedir tree-ish
 	 */
 	int i;
 	const char **nargv = xcalloc(sizeof(*nargv), argc + 2);
@@ -53,8 +53,8 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	nargv[nargc] = NULL;
 
 	fprintf(stderr,
-		"*** git-tar-tree is now deprecated.\n"
-		"*** Running git-archive instead.\n***");
+		"*** git tar-tree is now deprecated.\n"
+		"*** Running git archive instead.\n***");
 	for (i = 0; i < nargc; i++) {
 		fputc(' ', stderr);
 		sq_quote_print(stderr, nargv[i]);
@@ -76,7 +76,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 
 	n = read_in_full(0, buffer, HEADERSIZE);
 	if (n < HEADERSIZE)
-		die("git-get-tar-commit-id: read error");
+		die("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
 	if (memcmp(content, "52 comment=", 11))
@@ -84,7 +84,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 
 	n = write_in_full(1, content + 11, 41);
 	if (n < 41)
-		die("git-get-tar-commit-id: write error");
+		die("git get-tar-commit-id: write error");
 
 	return 0;
 }
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index a891866..40b20f2 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,7 +13,7 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
+static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 434cb8e..bbd50ac 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -14,7 +14,7 @@
  * Default to not allowing changes to the list of files. The
  * tool doesn't actually care, but this makes it harder to add
  * files to the revision control by mistake by doing something
- * like "git-update-index *" and suddenly having all the object
+ * like "git update-index *" and suddenly having all the object
  * files be revision controlled.
  */
 static int allow_add;
@@ -265,7 +265,7 @@ static void chmod_path(int flip, const char *path)
 	report("chmod %cx '%s'", flip, path);
 	return;
  fail:
-	die("git-update-index: cannot chmod %cx '%s'", flip, path);
+	die("git update-index: cannot chmod %cx '%s'", flip, path);
 }
 
 static void update_one(const char *path, const char *prefix, int prefix_length)
@@ -283,7 +283,7 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 
 	if (force_remove) {
 		if (remove_file_from_cache(p))
-			die("git-update-index: unable to remove %s", path);
+			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		goto free_return;
 	}
@@ -313,18 +313,18 @@ static void read_index_info(int line_termination)
 		/* This reads lines formatted in one of three formats:
 		 *
 		 * (1) mode         SP sha1          TAB path
-		 * The first format is what "git-apply --index-info"
+		 * The first format is what "git apply --index-info"
 		 * reports, and used to reconstruct a partial tree
 		 * that is used for phony merge base tree when falling
 		 * back on 3-way merge.
 		 *
 		 * (2) mode SP type SP sha1          TAB path
-		 * The second format is to stuff git-ls-tree output
+		 * The second format is to stuff git ls-tree output
 		 * into the index file.
 		 *
 		 * (3) mode         SP sha1 SP stage TAB path
 		 * This format is to put higher order stages into the
-		 * index file and matches git-ls-files --stage output.
+		 * index file and matches git ls-files --stage output.
 		 */
 		errno = 0;
 		ul = strtoul(buf.buf, &ptr, 8);
@@ -354,7 +354,7 @@ static void read_index_info(int line_termination)
 		if (line_termination && path_name[0] == '"') {
 			strbuf_reset(&uq);
 			if (unquote_c_style(&uq, path_name, NULL)) {
-				die("git-update-index: bad quoting of path name");
+				die("git update-index: bad quoting of path name");
 			}
 			path_name = uq.buf;
 		}
@@ -367,7 +367,7 @@ static void read_index_info(int line_termination)
 		if (!mode) {
 			/* mode == 0 means there is no such path -- remove */
 			if (remove_file_from_cache(path_name))
-				die("git-update-index: unable to remove %s",
+				die("git update-index: unable to remove %s",
 				    ptr);
 		}
 		else {
@@ -377,7 +377,7 @@ static void read_index_info(int line_termination)
 			 */
 			ptr[-42] = ptr[-1] = 0;
 			if (add_cacheinfo(mode, sha1, path_name, stage))
-				die("git-update-index: unable to update %s",
+				die("git update-index: unable to update %s",
 				    path_name);
 		}
 		continue;
@@ -629,12 +629,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				unsigned int mode;
 
 				if (i+3 >= argc)
-					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
+					die("git update-index: --cacheinfo <mode> <sha1> <path>");
 
 				if (strtoul_ui(argv[i+1], 8, &mode) ||
 				    get_sha1_hex(argv[i+2], sha1) ||
 				    add_cacheinfo(mode, sha1, argv[i+3], 0))
-					die("git-update-index: --cacheinfo"
+					die("git update-index: --cacheinfo"
 					    " cannot add %s", argv[i+3]);
 				i += 3;
 				continue;
@@ -642,7 +642,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (!strcmp(path, "--chmod=-x") ||
 			    !strcmp(path, "--chmod=+x")) {
 				if (argc <= i+1)
-					die("git-update-index: %s <path>", path);
+					die("git update-index: %s <path>", path);
 				set_executable_bit = path[8];
 				continue;
 			}
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 25a29f1..0ee0a9a 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -107,7 +107,7 @@ static int verify_one_pack(const char *path, int verbose)
 	return err;
 }
 
-static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
+static const char verify_pack_usage[] = "git verify-pack [-v] <pack>...";
 
 int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 52a3c01..6b1e9dc 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -16,7 +16,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	int missing_ok = 0, ret;
 	const char *prefix = NULL;
 	unsigned char sha1[20];
-	const char *me = "git-write-tree";
+	const char *me = "git write-tree";
 
 	git_config(git_default_config, NULL);
 	while (1 < argc) {
diff --git a/connect.c b/connect.c
index 574f42f..dd96f8e 100644
--- a/connect.c
+++ b/connect.c
@@ -97,7 +97,7 @@ int get_ack(int fd, unsigned char *result_sha1)
 	int len = packet_read_line(fd, line, sizeof(line));
 
 	if (!len)
-		die("git-fetch-pack: expected ACK/NAK, got EOF");
+		die("git fetch-pack: expected ACK/NAK, got EOF");
 	if (line[len-1] == '\n')
 		line[--len] = 0;
 	if (!strcmp(line, "NAK"))
@@ -109,7 +109,7 @@ int get_ack(int fd, unsigned char *result_sha1)
 			return 1;
 		}
 	}
-	die("git-fetch_pack: expected ACK/NAK, got '%s'", line);
+	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
 }
 
 int path_match(const char *path, int nr, char **match)
diff --git a/diff-lib.c b/diff-lib.c
index e7eaff9..ace0310 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -486,7 +486,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	struct oneway_unpack_data unpack_cb;
 
 	/*
-	 * This is used by git-blame to run diff-cache internally;
+	 * This is used by git blame to run diff-cache internally;
 	 * it potentially needs to repeatedly run this, so we will
 	 * start by removing the higher order entries the last round
 	 * left behind.
diff --git a/diff.c b/diff.c
index 135dec4..11a66ee 100644
--- a/diff.c
+++ b/diff.c
@@ -126,7 +126,7 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 
 /*
  * These are to give UI layer defaults.
- * The core-level commands such as git-diff-files should
+ * The core-level commands such as git diff-files should
  * never be affected by the setting of diff.renames
  * the user happens to have in the configuration file.
  */
diff --git a/entry.c b/entry.c
index 222aaa3..3126738 100644
--- a/entry.c
+++ b/entry.c
@@ -111,7 +111,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	case S_IFREG:
 		new = read_blob_entry(ce, path, &size);
 		if (!new)
-			return error("git-checkout-index: unable to read sha1 file of %s (%s)",
+			return error("git checkout-index: unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
 
 		/*
@@ -132,7 +132,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 			fd = create_file(path, ce->ce_mode);
 		if (fd < 0) {
 			free(new);
-			return error("git-checkout-index: unable to create file %s (%s)",
+			return error("git checkout-index: unable to create file %s (%s)",
 				path, strerror(errno));
 		}
 
@@ -140,12 +140,12 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		close(fd);
 		free(new);
 		if (wrote != size)
-			return error("git-checkout-index: unable to write file %s", path);
+			return error("git checkout-index: unable to write file %s", path);
 		break;
 	case S_IFLNK:
 		new = read_blob_entry(ce, path, &size);
 		if (!new)
-			return error("git-checkout-index: unable to read sha1 file of %s (%s)",
+			return error("git checkout-index: unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
 		if (to_tempfile || !has_symlinks) {
 			if (to_tempfile) {
@@ -155,31 +155,31 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 				fd = create_file(path, 0666);
 			if (fd < 0) {
 				free(new);
-				return error("git-checkout-index: unable to create "
+				return error("git checkout-index: unable to create "
 						 "file %s (%s)", path, strerror(errno));
 			}
 			wrote = write_in_full(fd, new, size);
 			close(fd);
 			free(new);
 			if (wrote != size)
-				return error("git-checkout-index: unable to write file %s",
+				return error("git checkout-index: unable to write file %s",
 					path);
 		} else {
 			wrote = symlink(new, path);
 			free(new);
 			if (wrote)
-				return error("git-checkout-index: unable to create "
+				return error("git checkout-index: unable to create "
 						 "symlink %s (%s)", path, strerror(errno));
 		}
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("git-checkout-index: cannot create temporary subproject %s", path);
+			return error("git checkout-index: cannot create temporary subproject %s", path);
 		if (mkdir(path, 0777) < 0)
-			return error("git-checkout-index: cannot create subproject directory %s", path);
+			return error("git checkout-index: cannot create subproject directory %s", path);
 		break;
 	default:
-		return error("git-checkout-index: unknown file mode for %s", path);
+		return error("git checkout-index: unknown file mode for %s", path);
 	}
 
 	if (state->refresh_cache) {
@@ -208,7 +208,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
-				fprintf(stderr, "git-checkout-index: %s already exists\n", path);
+				fprintf(stderr, "git checkout-index: %s already exists\n", path);
 			return -1;
 		}
 
diff --git a/environment.c b/environment.c
index 0c6d11f..429ff86 100644
--- a/environment.c
+++ b/environment.c
@@ -91,7 +91,7 @@ static int git_work_tree_initialized;
 
 /*
  * Note.  This works only before you used a work tree.  This was added
- * primarily to support git-clone to work in a new repository it just
+ * primarily to support git clone to work in a new repository it just
  * created, and is not meant to flip between different work trees.
  */
 void set_git_work_tree(const char *new_work_tree)
diff --git a/fsck.c b/fsck.c
index 797e317..9276ed7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -124,7 +124,7 @@ static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, con
 	c2 = name2[len];
 	if (!c1 && !c2)
 		/*
-		 * git-write-tree used to write out a nonsense tree that has
+		 * git write-tree used to write out a nonsense tree that has
 		 * entries with the same name, one blob and one tree.  Make
 		 * sure we do not have duplicate entries.
 		 */
diff --git a/http-push.c b/http-push.c
index 6805288..f5d401d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2221,7 +2221,7 @@ int main(int argc, char **argv)
 	}
 
 #ifndef USE_CURL_MULTI
-	die("git-push is not available for http/https repository when not compiled with USE_CURL_MULTI");
+	die("git push is not available for http/https repository when not compiled with USE_CURL_MULTI");
 #endif
 
 	if (!remote->url)
diff --git a/imap-send.c b/imap-send.c
index af7e08c..53ef74e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1,5 +1,5 @@
 /*
- * git-imap-send - drops patches into an imap Drafts folder
+ * git imap-send - drops patches into an imap Drafts folder
  *                 derived from isync/mbsync - mailbox synchronizer
  *
  * Copyright (C) 2000-2002 Michael R. Elkins <me@mutt.org>
diff --git a/index-pack.c b/index-pack.c
index 728af7d..f291ffa 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -842,7 +842,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		write_or_die(1, buf, len);
 
 		/*
-		 * Let's just mimic git-unpack-objects here and write
+		 * Let's just mimic git unpack-objects here and write
 		 * the last part of the input buffer to stdout.
 		 */
 		while (input_len) {
diff --git a/merge-index.c b/merge-index.c
index 7491c56..a6e1921 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -27,7 +27,7 @@ static int merge_entry(int pos, const char *path)
 	int found;
 
 	if (pos >= active_nr)
-		die("git-merge-index: %s not in the cache", path);
+		die("git merge-index: %s not in the cache", path);
 	arguments[0] = pgm;
 	arguments[1] = "";
 	arguments[2] = "";
@@ -53,7 +53,7 @@ static int merge_entry(int pos, const char *path)
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
 	if (!found)
-		die("git-merge-index: %s not in the cache", path);
+		die("git merge-index: %s not in the cache", path);
 	run_program();
 	return found;
 }
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git-merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
 
 	setup_git_directory();
 	read_cache();
@@ -117,7 +117,7 @@ int main(int argc, char **argv)
 				merge_all();
 				continue;
 			}
-			die("git-merge-index: unknown option %s", arg);
+			die("git merge-index: unknown option %s", arg);
 		}
 		merge_file(arg);
 	}
diff --git a/mktag.c b/mktag.c
index 0b34341..79e21a4 100644
--- a/mktag.c
+++ b/mktag.c
@@ -157,7 +157,7 @@ int main(int argc, char **argv)
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
-		usage("git-mktag < signaturefile");
+		usage("git mktag < signaturefile");
 
 	setup_git_directory();
 
diff --git a/mktree.c b/mktree.c
index e0da110..c2969ca 100644
--- a/mktree.c
+++ b/mktree.c
@@ -61,7 +61,7 @@ static void write_tree(unsigned char *sha1)
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
-static const char mktree_usage[] = "git-mktree [-z]";
+static const char mktree_usage[] = "git mktree [-z]";
 
 int main(int ac, char **av)
 {
diff --git a/patch-id.c b/patch-id.c
index 9349bc5..20b381d 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -56,7 +56,7 @@ static void generate_id_list(void)
 		if (!patchlen && memcmp(line, "diff ", 5))
 			continue;
 
-		/* Ignore git-diff index header */
+		/* Ignore git diff index header */
 		if (!memcmp(line, "index ", 6))
 			continue;
 
@@ -72,7 +72,7 @@ static void generate_id_list(void)
 	flush_current_id(patchlen, sha1, &ctx);
 }
 
-static const char patch_id_usage[] = "git-patch-id < patch";
+static const char patch_id_usage[] = "git patch-id < patch";
 
 int main(int argc, char **argv)
 {
diff --git a/quote.h b/quote.h
index c5eea6f..cba61f4 100644
--- a/quote.h
+++ b/quote.h
@@ -17,7 +17,7 @@
  * would be appropriate.  If the system() is going to call ssh to
  * run the command on the other side:
  *
- * sprintf(cmd, "git-diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
+ * sprintf(cmd, "git diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
  * sprintf(rcmd, "ssh %s %s", sq_quote(host), sq_quote(cmd));
  *
  * Note that the above examples leak memory!  Remember to free result from
diff --git a/read-cache.c b/read-cache.c
index 5150c1e..3a97800 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -260,7 +260,7 @@ int ie_match_stat(const struct index_state *istate,
 
 	/*
 	 * Within 1 second of this sequence:
-	 * 	echo xyzzy >file && git-update-index --add file
+	 * 	echo xyzzy >file && git update-index --add file
 	 * running this command:
 	 * 	echo frotz >file
 	 * would give a falsely clean cache entry.  The mtime and
@@ -268,7 +268,7 @@ int ie_match_stat(const struct index_state *istate,
 	 *
 	 * We could detect this at update-index time (the cache entry
 	 * being registered/updated records the same time as "now")
-	 * and delay the return from git-update-index, but that would
+	 * and delay the return from git update-index, but that would
 	 * effectively mean we can make at most one commit per second,
 	 * which is not acceptable.  Instead, we check cache entries
 	 * whose mtime are the same as the index file timestamp more
@@ -810,7 +810,7 @@ static int has_dir_name(struct index_state *istate,
 /* We may be in a situation where we already have path/file and path
  * is being added, or we already have path and path/file is being
  * added.  Either one would result in a nonsense tree that has path
- * twice when git-write-tree tries to write it out.  Prevent it.
+ * twice when git write-tree tries to write it out.  Prevent it.
  *
  * If ok-to-replace is specified, we remove the conflicting entries
  * from the cache so the caller should recompute the insert position.
@@ -927,7 +927,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
  * file that hasn't been changed but where the stat entry is
  * out of date.
  *
- * For example, you'd want to do this after doing a "git-read-tree",
+ * For example, you'd want to do this after doing a "git read-tree",
  * to link up the stat cache details with the proper files.
  */
 static struct cache_entry *refresh_cache_ent(struct index_state *istate,
@@ -1367,11 +1367,11 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 		 * that it can break with this sequence:
 		 *
 		 * $ echo xyzzy >frotz
-		 * $ git-update-index --add frotz
+		 * $ git update-index --add frotz
 		 * $ : >frotz
 		 * $ sleep 3
 		 * $ echo filfre >nitfol
-		 * $ git-update-index --add nitfol
+		 * $ git update-index --add nitfol
 		 *
 		 * but it does not.  When the second update-index runs,
 		 * it notices that the entry "frotz" has the same timestamp
diff --git a/receive-pack.c b/receive-pack.c
index d44c19e..387a595 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -7,7 +7,7 @@
 #include "commit.h"
 #include "object.h"
 
-static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
+static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
 static int deny_non_fast_forwards = 0;
 static int receive_fsck_objects;
diff --git a/shell.c b/shell.c
index e339369..ecbd8ae 100644
--- a/shell.c
+++ b/shell.c
@@ -27,7 +27,7 @@ static int do_cvs_cmd(const char *me, char *arg)
 	};
 
 	if (!arg || strcmp(arg, "server"))
-		die("git-cvsserver only handles server: %s", arg);
+		die("git cvsserver only handles server: %s", arg);
 
 	setup_path();
 	return execv_git_cmd(cvsserver_argv);
diff --git a/tree-diff.c b/tree-diff.c
index bbb126f..9f67af6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -303,7 +303,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 			update_tree_entry(t2);
 			continue;
 		}
-		die("git-diff-tree: internal error");
+		die("git diff-tree: internal error");
 	}
 	return 0;
 }
diff --git a/tree.c b/tree.c
index 03e782a..a6c36aa 100644
--- a/tree.c
+++ b/tree.c
@@ -156,7 +156,7 @@ int read_tree(struct tree *tree, int stage, const char **match)
 	 * call it with stage=1 and after making sure there is nothing
 	 * at that stage; we could always use read_one_entry_quick().
 	 *
-	 * But when we decide to straighten out git-read-tree not to
+	 * But when we decide to straighten out git read-tree not to
 	 * use unpack_trees() in some cases, this will probably start
 	 * to matter.
 	 */
diff --git a/unpack-file.c b/unpack-file.c
index bcdc8bb..75c5f51 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -26,7 +26,7 @@ int main(int argc, char **argv)
 	unsigned char sha1[20];
 
 	if (argc != 2)
-		usage("git-unpack-file <sha1>");
+		usage("git unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index ef21c62..83e0888 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -807,7 +807,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 		return 0;
 
 	/* Under the new "aggressive" rule, we resolve mostly trivial
-	 * cases that we historically had git-merge-one-file resolve.
+	 * cases that we historically had git merge-one-file resolve.
 	 */
 	if (o->aggressive) {
 		int head_deleted = !head && !df_conflict_head;
diff --git a/upload-pack.c b/upload-pack.c
index c911e70..426283e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,7 +11,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 
-static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
+static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=nn] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
@@ -81,7 +81,7 @@ static void show_commit(struct commit *commit)
 static void show_object(struct object_array_entry *p)
 {
 	/* An object with name "foo\n0000000..." can be used to
-	 * confuse downstream git-pack-objects very badly.
+	 * confuse downstream git pack-objects very badly.
 	 */
 	const char *ep = strchr(p->name, '\n');
 	if (ep) {
@@ -157,7 +157,7 @@ static void create_pack_file(void)
 	/* .data is just a boolean: any non-NULL value will do */
 	rev_list.data = create_full_pack ? &rev_list : NULL;
 	if (start_async(&rev_list))
-		die("git-upload-pack: unable to fork git-rev-list");
+		die("git upload-pack: unable to fork git rev-list");
 
 	argv[arg++] = "pack-objects";
 	argv[arg++] = "--stdout";
@@ -177,7 +177,7 @@ static void create_pack_file(void)
 	pack_objects.argv = argv;
 
 	if (start_command(&pack_objects))
-		die("git-upload-pack: unable to fork git-pack-objects");
+		die("git upload-pack: unable to fork git pack-objects");
 
 	/* We read from pack_objects.err to capture stderr output for
 	 * progress bar, and pack_objects.out to capture the pack data.
@@ -271,7 +271,7 @@ static void create_pack_file(void)
 	}
 
 	if (finish_command(&pack_objects)) {
-		error("git-upload-pack: git-pack-objects died with error.");
+		error("git upload-pack: git pack-objects died with error.");
 		goto fail;
 	}
 	if (finish_async(&rev_list))
@@ -291,7 +291,7 @@ static void create_pack_file(void)
 
  fail:
 	send_client_data(3, abort_msg, sizeof(abort_msg));
-	die("git-upload-pack: %s", abort_msg);
+	die("git upload-pack: %s", abort_msg);
 }
 
 static int got_sha1(char *hex, unsigned char *sha1)
@@ -300,7 +300,7 @@ static int got_sha1(char *hex, unsigned char *sha1)
 	int we_knew_they_have = 0;
 
 	if (get_sha1_hex(hex, sha1))
-		die("git-upload-pack: expected SHA1 object, got '%s'", hex);
+		die("git upload-pack: expected SHA1 object, got '%s'", hex);
 	if (!has_sha1_file(sha1))
 		return -1;
 
@@ -440,7 +440,7 @@ static int get_common_commits(void)
 			packet_write(1, "NAK\n");
 			return -1;
 		}
-		die("git-upload-pack: expected SHA1 list, got '%s'", line);
+		die("git upload-pack: expected SHA1 list, got '%s'", line);
 	}
 }
 
@@ -485,7 +485,7 @@ static void receive_needs(void)
 		}
 		if (prefixcmp(line, "want ") ||
 		    get_sha1_hex(line+5, sha1_buf))
-			die("git-upload-pack: protocol error, "
+			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 		if (strstr(line+45, "multi_ack"))
 			multi_ack = 1;
@@ -512,7 +512,7 @@ static void receive_needs(void)
 		 */
 		o = lookup_object(sha1_buf);
 		if (!o || !(o->flags & OUR_REF))
-			die("git-upload-pack: not our ref %s", line+5);
+			die("git upload-pack: not our ref %s", line+5);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
 			add_object_array(o, NULL, &want_obj);
@@ -577,7 +577,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-		die("git-upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
 	if (capabilities)
 		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
-- 
1.5.6.3
