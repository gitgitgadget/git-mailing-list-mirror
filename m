From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 02:45:04 -0700
Message-ID: <1300700704-22674-2-git-send-email-bebarino@gmail.com>
References: <1300700704-22674-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 10:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bg9-0003iu-U1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab1CUJpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:45:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54939 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1CUJp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 05:45:28 -0400
Received: by iyb26 with SMTP id 26so6204553iyb.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=mK2L1BmtIPSFExV/zDsaz9BHS9h2c/NgUeaRi6IWsiI=;
        b=sTLqvky17LiByS0az9ybtI0vMkTFO0xscZnylF+tlq349M1in2AtE08sW8oyeBdjcR
         FwmDJNji5ab+tBegbmFzAwZMCZSAeABg85NmfsNk3lkbqaDFhPnIiPJesjU5esUxau7l
         L0xLAMvbUbawXHx+Rzo2yxipcm59JBfiU2j/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b1PKRhHPolKbbEFjWubj91p9rWGsdqGP9iBpUvpV/k4hzW/m3rFH4vjPPXSs1sfJbg
         qusL1dcPua25FXiyo50N4nsDj/1/oxYkTbi8cRAOzzjNYFhJL4DwZtaPnzh5c904GOEh
         nzJXbyrpd9SFlQRDr4qotxVSREnuiYDxKDFe0=
Received: by 10.231.39.130 with SMTP id g2mr3943231ibe.118.1300700728002;
        Mon, 21 Mar 2011 02:45:28 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id gy41sm2459599ibb.56.2011.03.21.02.45.25
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 02:45:27 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 21 Mar 2011 02:45:22 -0700
X-Mailer: git-send-email 1.7.4.1.343.ga91df
In-Reply-To: <1300700704-22674-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169568>

Fix warnings from 'make check'.

diff.c:631:25: warning: symbol 'diff_words_styles' was not declared.
Should it be static?
notes-merge.c:362:73: warning: Using plain integer as NULL pointer
parse-options.c:564:6: error: symbol 'usage_with_options' redeclared
with different type (originally declared at parse-options.h:158) -
different modifiers
parse-options.c:571:6: error: symbol 'usage_msg_opt' redeclared with
different type (originally declared at parse-options.h:161) - different
modifiers
replace_object.c:92:21: warning: symbol 'lookup_replace_object' was not
declared. Should it be static?
submodule.c:12:20: warning: symbol 'config_name_for_path' was not
declared. Should it be static?
submodule.c:13:20: warning: symbol
'config_fetch_recurse_submodules_for_name' was not declared. Should it
be static?
submodule.c:14:20: warning: symbol 'config_ignore_for_name' was not
declared. Should it be static?
trace.c:78:6: warning: symbol 'trace_printf_key' was not declared.
Should it be static?
transport.c:195:29: warning: Using plain integer as NULL pointer
transport-helper.c:79:12: warning: symbol 'remove_ext_force' was not
declared. Should it be static?
unpack-trees.c:19:12: warning: symbol 'unpack_plumbing_errors' was not
declared. Should it be static?
url.c:3:5: warning: symbol 'is_urlschemechar' was not declared. Should
it be static?
url.c:18:5: warning: symbol 'is_url' was not declared. Should it be
static?
url.c:104:6: warning: symbol 'url_decode' was not declared. Should it be
static?
url.c:117:6: warning: symbol 'url_decode_parameter_name' was not
declared. Should it be static?
url.c:123:6: warning: symbol 'url_decode_parameter_value' was not
declared. Should it be static?
url.c:129:6: warning: symbol 'end_url_with_slash' was not declared.
Should it be static?
url.c:136:6: warning: symbol 'str_end_url_with_slash' was not declared.
Should it be static?
usage.c:49:6: error: symbol 'usagef' redeclared with different type
(originally declared at git-compat-util.h:239) - different modifiers
usage.c:58:6: error: symbol 'usage' redeclared with different type
(originally declared at git-compat-util.h:238) - different modifiers
usage.c:63:6: error: symbol 'die' redeclared with different type
(originally declared at git-compat-util.h:240) - different modifiers
usage.c:72:6: error: symbol 'die_errno' redeclared with different type
(originally declared at git-compat-util.h:241) - different modifiers
thread-utils.c:21:5: warning: symbol 'online_cpus' was not declared.
Should it be static?
thread-utils.c:48:5: warning: symbol 'init_recursive_mutex' was not
declared. Should it be static?
builtin/clone.c:364:5: warning: symbol 'cmd_clone' was not declared.
Should it be static?
builtin/fetch-pack.c:797:5: warning: symbol 'cmd_fetch_pack' was not
declared. Should it be static?
builtin/fmt-merge-msg.c:34:6: warning: symbol 'init_src_data' was not
declared. Should it be static?
builtin/hash-object.c:78:5: warning: symbol 'cmd_hash_object' was not
declared. Should it be static?
builtin/index-pack.c:210:13: error: symbol 'bad_object' redeclared with
different type (originally declared at builtin/index-pack.c:207) -
different modifiers
builtin/merge-index.c:69:5: warning: symbol 'cmd_merge_index' was not
declared. Should it be static?
builtin/merge-recursive.c:22:5: warning: symbol 'cmd_merge_recursive'
was not declared. Should it be static?
builtin/merge-tree.c:341:5: warning: symbol 'cmd_merge_tree' was not
declared. Should it be static?
builtin/mktag.c:156:5: warning: symbol 'cmd_mktag' was not declared.
Should it be static?
builtin/notes.c:426:5: warning: symbol 'notes_copy_from_stdin' was not
declared. Should it be static?
builtin/notes.c:822:64: warning: Using plain integer as NULL pointer
builtin/pack-redundant.c:596:5: warning: symbol 'cmd_pack_redundant' was
not declared. Should it be static?
builtin/pack-refs.c:10:5: warning: symbol 'cmd_pack_refs' was not
declared. Should it be static?
builtin/patch-id.c:60:5: warning: symbol 'get_one_patchid' was not
declared. Should it be static?
builtin/patch-id.c:149:5: warning: symbol 'cmd_patch_id' was not
declared. Should it be static?
builtin/remote.c:1512:5: warning: symbol 'cmd_remote' was not declared.
Should it be static?
builtin/remote-ext.c:240:5: warning: symbol 'cmd_remote_ext' was not
declared. Should it be static?
builtin/remote-fd.c:53:5: warning: symbol 'cmd_remote_fd' was not
declared. Should it be static?
builtin/reset.c:236:5: warning: symbol 'cmd_reset' was not declared.
Should it be static?
builtin/send-pack.c:384:5: warning: symbol 'cmd_send_pack' was not
declared. Should it be static?
builtin/unpack-file.c:25:5: warning: symbol 'cmd_unpack_file' was not
declared. Should it be static?
builtin/var.c:75:5: warning: symbol 'cmd_var' was not declared. Should
it be static?
daemon.c:663:38: warning: Using plain integer as NULL pointer
fast-import.c:2942:35: warning: Using plain integer as NULL pointer
imap-send.c:1072:48: warning: Using plain integer as NULL pointer

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is one mega-patch. I can split it into separate files if that's
desirable but I figured it was easier to avoid spamming the list
with a bunch of oneline patches. There are two trivial conflicts
in pu with this patch.

 builtin/clone.c           |    1 +
 builtin/fetch-pack.c      |    1 +
 builtin/fmt-merge-msg.c   |    2 +-
 builtin/hash-object.c     |    1 +
 builtin/index-pack.c      |    2 +-
 builtin/merge-index.c     |    1 +
 builtin/merge-recursive.c |    1 +
 builtin/merge-tree.c      |    1 +
 builtin/mktag.c           |    1 +
 builtin/notes.c           |    4 ++--
 builtin/pack-redundant.c  |    1 +
 builtin/pack-refs.c       |    1 +
 builtin/patch-id.c        |    3 ++-
 builtin/remote-ext.c      |    1 +
 builtin/remote-fd.c       |    1 +
 builtin/remote.c          |    1 +
 builtin/reset.c           |    1 +
 builtin/send-pack.c       |    1 +
 builtin/unpack-file.c     |    1 +
 builtin/var.c             |    1 +
 daemon.c                  |    2 +-
 diff.c                    |    2 +-
 fast-import.c             |    2 +-
 imap-send.c               |    2 +-
 notes-merge.c             |    2 +-
 parse-options.c           |    4 ++--
 replace_object.c          |    1 +
 submodule.c               |    6 +++---
 thread-utils.c            |    1 +
 trace.c                   |    2 +-
 transport-helper.c        |    2 +-
 transport.c               |    2 +-
 unpack-trees.c            |    2 +-
 url.c                     |    1 +
 usage.c                   |    8 ++++----
 35 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 02547ad..53ea012 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "builtin.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 272bc38..9d1505c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include "builtin.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 5189b16..7581632 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -31,7 +31,7 @@ struct src_data {
 	int head_status;
 };
 
-void init_src_data(struct src_data *data)
+static void init_src_data(struct src_data *data)
 {
 	data->branch.strdup_strings = 1;
 	data->tag.strdup_strings = 1;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c90acdd..8cbbba9 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c7e600d..5a67c81 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -207,7 +207,7 @@ static void parse_pack_header(void)
 static NORETURN void bad_object(unsigned long offset, const char *format,
 		       ...) __attribute__((format (printf, 2, 3)));
 
-static void bad_object(unsigned long offset, const char *format, ...)
+static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 {
 	va_list params;
 	char buf[1024];
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..634327c 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 static const char *pgm;
 static int one_shot, quiet;
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c33091b..f8ca00a 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -3,6 +3,7 @@
 #include "tag.h"
 #include "merge-recursive.h"
 #include "xdiff-interface.h"
+#include "builtin.h"
 
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9b25ddc..ad5afd2 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "xdiff-interface.h"
 #include "blob.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1cb0f3f..6132a43 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/builtin/notes.c b/builtin/notes.c
index 0aab150..a0f310b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -423,7 +423,7 @@ void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c)
 	free(c);
 }
 
-int notes_copy_from_stdin(int force, const char *rewrite_cmd)
+static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct notes_rewrite_cfg *c = NULL;
@@ -819,7 +819,7 @@ static int merge_commit(struct notes_merge_options *o)
 	t = xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
-	o->local_ref = resolve_ref("NOTES_MERGE_REF", sha1, 0, 0);
+	o->local_ref = resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..8fcba68 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -8,6 +8,7 @@
 
 #include "cache.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 #define BLKSIZE 512
 
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 091860b..9b32efb 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "pack-refs.h"
+#include "builtin.h"
 
 static char const * const pack_refs_usage[] = {
 	"git pack-refs [options]",
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 49a0472..d008960 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
 {
@@ -57,7 +58,7 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
+static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 {
 	static char line[1000];
 	int patchlen = 0, found_next = 0;
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index ea71977..6ebc26d 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "transport.h"
 #include "run-command.h"
+#include "builtin.h"
 
 /*
  * URL syntax:
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 1f2467b..bdecd3a 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "transport.h"
+#include "builtin.h"
 
 /*
  * URL syntax:
diff --git a/builtin/remote.c b/builtin/remote.c
index cb26080..6faec63 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
+#include "builtin.h"
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
diff --git a/builtin/reset.c b/builtin/reset.c
index 5de2bce..fdac49e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "builtin.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]",
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2cd1c40..973ac66 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -8,6 +8,7 @@
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
+#include "builtin.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 608590a..d3e962a 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 static char *create_temp_file(unsigned char *sha1)
 {
diff --git a/builtin/var.c b/builtin/var.c
index 0744bb8..6173e0e 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "builtin.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
diff --git a/daemon.c b/daemon.c
index 347fd0c..4c8346d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -660,7 +660,7 @@ static void check_dead_children(void)
 static char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
-	struct child_process cld = { 0 };
+	struct child_process cld = { NULL };
 	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
 	char *env[] = { addrbuf, portbuf, NULL };
 
diff --git a/diff.c b/diff.c
index 42a107c..9b3eb99 100644
--- a/diff.c
+++ b/diff.c
@@ -628,7 +628,7 @@ struct diff_words_style {
 	const char *newline;
 };
 
-struct diff_words_style diff_words_styles[] = {
+static struct diff_words_style diff_words_styles[] = {
 	{ DIFF_WORDS_PORCELAIN, {"+", "\n"}, {"-", "\n"}, {" ", "\n"}, "~\n" },
 	{ DIFF_WORDS_PLAIN, {"{+", "+}"}, {"[-", "-]"}, {"", ""}, "\n" },
 	{ DIFF_WORDS_COLOR, {"", ""}, {"", ""}, {"", ""}, "\n" }
diff --git a/fast-import.c b/fast-import.c
index d9f9a3f..65d65bf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2939,7 +2939,7 @@ static void parse_ls(struct branch *b)
 {
 	const char *p;
 	struct tree_entry *root = NULL;
-	struct tree_entry leaf = {0};
+	struct tree_entry leaf = {NULL};
 
 	/* ls SP (<treeish> SP)? <path> */
 	p = command_buf.buf + strlen("ls ");
diff --git a/imap-send.c b/imap-send.c
index 71506a8..9adf4b9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1069,7 +1069,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 
 	if (srvc->tunnel) {
 		const char *argv[] = { srvc->tunnel, NULL };
-		struct child_process tunnel = {0};
+		struct child_process tunnel = {NULL};
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
diff --git a/notes-merge.c b/notes-merge.c
index 1467ad3..28046a9 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -359,7 +359,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	read_mmblob(&remote, p->remote);
 
 	status = ll_merge(&result_buf, sha1_to_hex(p->obj), &base, NULL,
-			  &local, o->local_ref, &remote, o->remote_ref, 0);
+			  &local, o->local_ref, &remote, o->remote_ref, NULL);
 
 	free(base.ptr);
 	free(local.ptr);
diff --git a/parse-options.c b/parse-options.c
index 42b51ef..73bd28a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -561,14 +561,14 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 	return PARSE_OPT_HELP;
 }
 
-void usage_with_options(const char * const *usagestr,
+void NORETURN usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
 	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
 	exit(129);
 }
 
-void usage_msg_opt(const char *msg,
+void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
 {
diff --git a/replace_object.c b/replace_object.c
index eb59604..7c6c754 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "sha1-lookup.h"
 #include "refs.h"
+#include "commit.h"
 
 static struct replace_object {
 	unsigned char sha1[2][20];
diff --git a/submodule.c b/submodule.c
index e9f2b19..0cb6d18 100644
--- a/submodule.c
+++ b/submodule.c
@@ -9,9 +9,9 @@
 #include "refs.h"
 #include "string-list.h"
 
-struct string_list config_name_for_path;
-struct string_list config_fetch_recurse_submodules_for_name;
-struct string_list config_ignore_for_name;
+static struct string_list config_name_for_path;
+static struct string_list config_fetch_recurse_submodules_for_name;
+static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules;
 
 static int add_submodule_odb(const char *path)
diff --git a/thread-utils.c b/thread-utils.c
index 589f838..2c8c1e3 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include <pthread.h>
+#include "thread-utils.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
diff --git a/trace.c b/trace.c
index 8390bf7..d953416 100644
--- a/trace.c
+++ b/trace.c
@@ -75,7 +75,7 @@ void trace_vprintf(const char *key, const char *fmt, va_list ap)
 	strbuf_release(&buf);
 }
 
-void trace_printf_key(const char *key, const char *fmt, ...)
+static void trace_printf_key(const char *key, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
diff --git a/transport-helper.c b/transport-helper.c
index 0c5b1bd..5846b55 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -76,7 +76,7 @@ static void write_constant(int fd, const char *str)
 		die_errno("Full write to remote helper failed");
 }
 
-const char *remove_ext_force(const char *url)
+static const char *remove_ext_force(const char *url)
 {
 	if (url) {
 		const char *colon = strchr(url, ':');
diff --git a/transport.c b/transport.c
index 0078660..f1c0781 100644
--- a/transport.c
+++ b/transport.c
@@ -192,7 +192,7 @@ static const char *rsync_url(const char *url)
 static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
-	struct ref dummy = {0}, *tail = &dummy;
+	struct ref dummy = {NULL}, *tail = &dummy;
 	struct child_process rsync;
 	const char *args[5];
 	int temp_dir_len;
diff --git a/unpack-trees.c b/unpack-trees.c
index b68ec82..500ebcf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,7 +16,7 @@
  * situation better.  See how "git checkout" and "git merge" replaces
  * them using setup_unpack_trees_porcelain(), for example.
  */
-const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
+static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_OVERWRITE */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
diff --git a/url.c b/url.c
index 6a54959..3e06fd3 100644
--- a/url.c
+++ b/url.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "url.h"
 
 int is_urlschemechar(int first_flag, int ch)
 {
diff --git a/usage.c b/usage.c
index ec4cf53..b5e67e3 100644
--- a/usage.c
+++ b/usage.c
@@ -46,7 +46,7 @@ void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list param
 	die_routine = routine;
 }
 
-void usagef(const char *err, ...)
+void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
 
@@ -55,12 +55,12 @@ void usagef(const char *err, ...)
 	va_end(params);
 }
 
-void usage(const char *err)
+void NORETURN usage(const char *err)
 {
 	usagef("%s", err);
 }
 
-void die(const char *err, ...)
+void NORETURN die(const char *err, ...)
 {
 	va_list params;
 
@@ -69,7 +69,7 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
-void die_errno(const char *fmt, ...)
+void NORETURN die_errno(const char *fmt, ...)
 {
 	va_list params;
 	char fmt_with_err[1024];
-- 
1.7.4.1.343.ga91df
