From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 09/10] Make <identifier> lowercase as per CodingGuidelines
Date: Tue, 15 Feb 2011 14:09:12 +0100
Message-ID: <560074f9c7b62040e07a412146a947fff41a086e.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKj5-00053u-9b
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab1BONMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39473 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752621Ab1BONMd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:33 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 78380208CA;
	Tue, 15 Feb 2011 08:12:33 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 15 Feb 2011 08:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=BY0EEdmWVRwjWjigjicqadtKo20=; b=K9VPxtTRe7Q8yI8hooC9Mkgw0x8HzHDMPWi0CTxivViIjHMGwu5Zn3ciBZi2WAO15GXOgZJEViQE0aFfN3ZHLaegOjxt/4XDnB0k2WrUJH6HFu8EJh9nKaIX82e8iSdTREI6pAyc0YfgLjczpNBQHbX66u+4du3UtFxVjBZPcQQ=
X-Sasl-enc: G3W+DPCp21/GUEr/ax4Wm4OwTKiYL5+kaqG2XmASC1we 1297775552
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C7EED443C98;
	Tue, 15 Feb 2011 08:12:32 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166852>

*.c part for matches with '"[A-Z]+"'.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c      |   14 +++++++-------
 builtin/config.c      |    2 +-
 builtin/fast-export.c |    4 ++--
 builtin/fetch.c       |    6 +++---
 builtin/merge.c       |    2 +-
 builtin/notes.c       |   16 ++++++++--------
 builtin/read-tree.c   |    4 ++--
 builtin/tag.c         |    2 +-
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d7f55e3..355b2cb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -119,13 +119,13 @@ static struct option builtin_commit_options[] = {
 
 	OPT_GROUP("Commit message options"),
 	OPT_FILENAME('F', "file", &logfile, "read message from file"),
-	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
-	OPT_STRING(0, "date", &force_date, "DATE", "override date for commit"),
-	OPT_CALLBACK('m', "message", &message, "MESSAGE", "commit message", opt_parse_m),
-	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
-	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
-	OPT_STRING(0, "fixup", &fixup_message, "COMMIT", "use autosquash formatted message to fixup specified commit"),
-	OPT_STRING(0, "squash", &squash_message, "COMMIT", "use autosquash formatted message to squash specified commit"),
+	OPT_STRING(0, "author", &force_author, "author", "override author for commit"),
+	OPT_STRING(0, "date", &force_date, "date", "override date for commit"),
+	OPT_CALLBACK('m', "message", &message, "message", "commit message", opt_parse_m),
+	OPT_STRING('c', "reedit-message", &edit_message, "commit", "reuse and edit message from specified commit"),
+	OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse message from specified commit"),
+	OPT_STRING(0, "fixup", &fixup_message, "commit", "use autosquash formatted message to fixup specified commit"),
+	OPT_STRING(0, "squash", &squash_message, "commit", "use autosquash formatted message to squash specified commit"),
 	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
diff --git a/builtin/config.c b/builtin/config.c
index ca4a0db..b8b18e3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -52,7 +52,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
 	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
 	OPT_BOOLEAN(0, "local", &use_local_config, "use repository config file"),
-	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
+	OPT_STRING('f', "file", &given_config_file, "file", "use given config file"),
 	OPT_GROUP("Action"),
 	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_GET),
 	OPT_BIT(0, "get-all", &actions, "get all values: key [value-regex]", ACTION_GET_ALL),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ba57457..daf1945 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -619,9 +619,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, "mode",
 			     "select handling of tags that tag filtered objects",
 			     parse_opt_tag_of_filtered_mode),
-		OPT_STRING(0, "export-marks", &export_filename, "FILE",
+		OPT_STRING(0, "export-marks", &export_filename, "file",
 			     "Dump marks to this file"),
-		OPT_STRING(0, "import-marks", &import_filename, "FILE",
+		OPT_STRING(0, "import-marks", &import_filename, "file",
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 357f3cd..7efecfe 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -49,7 +49,7 @@ static struct option builtin_fetch_options[] = {
 		    "fetch from all remotes"),
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
-	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
+	OPT_STRING(0, "upload-pack", &upload_pack, "path",
 		   "path to upload pack on remote end"),
 	OPT__FORCE(&force, "force overwrite of local branch"),
 	OPT_BOOLEAN('m', "multiple", &multiple,
@@ -69,9 +69,9 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
 	OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
-	OPT_STRING(0, "depth", &depth, "DEPTH",
+	OPT_STRING(0, "depth", &depth, "depth",
 		   "deepen history of shallow clone"),
-	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, "DIR",
+	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, "dir",
 		   "prepend this to submodule path output", PARSE_OPT_HIDDEN },
 	OPT_END()
 };
diff --git a/builtin/merge.c b/builtin/merge.c
index 8c58c3c..0710281 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -194,7 +194,7 @@ static struct option builtin_merge_options[] = {
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, "option=value",
 		"option for selected merge strategy", option_parse_x),
-	OPT_CALLBACK('m', "message", &merge_msg, "MESSAGE",
+	OPT_CALLBACK('m', "message", &merge_msg, "message",
 		"merge commit message (for a non-fast-forward merge)",
 		option_parse_message),
 	OPT__VERBOSITY(&verbosity),
diff --git a/builtin/notes.c b/builtin/notes.c
index 4d5556e..0aab150 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -537,16 +537,16 @@ static int add(int argc, const char **argv, const char *prefix)
 	const unsigned char *note;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'm', "message", &msg, "MSG",
+		{ OPTION_CALLBACK, 'm', "message", &msg, "msg",
 			"note contents as a string", PARSE_OPT_NONEG,
 			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &msg, "FILE",
+		{ OPTION_CALLBACK, 'F', "file", &msg, "file",
 			"note contents in a file", PARSE_OPT_NONEG,
 			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "OBJECT",
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "object",
 			"reuse and edit specified note object", PARSE_OPT_NONEG,
 			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "OBJECT",
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "object",
 			"reuse specified note object", PARSE_OPT_NONEG,
 			parse_reuse_arg},
 		OPT__FORCE(&force, "replace existing notes"),
@@ -682,16 +682,16 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const char * const *usage;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'm', "message", &msg, "MSG",
+		{ OPTION_CALLBACK, 'm', "message", &msg, "msg",
 			"note contents as a string", PARSE_OPT_NONEG,
 			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &msg, "FILE",
+		{ OPTION_CALLBACK, 'F', "file", &msg, "file",
 			"note contents in a file", PARSE_OPT_NONEG,
 			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "OBJECT",
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "object",
 			"reuse and edit specified note object", PARSE_OPT_NONEG,
 			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "OBJECT",
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "object",
 			"reuse specified note object", PARSE_OPT_NONEG,
 			parse_reuse_arg},
 		OPT_END()
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 73c89ed..93c9281 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -104,8 +104,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	struct unpack_trees_options opts;
 	int prefix_set = 0;
 	const struct option read_tree_options[] = {
-		{ OPTION_CALLBACK, 0, "index-output", NULL, "FILE",
-		  "write resulting index to <FILE>",
+		{ OPTION_CALLBACK, 0, "index-output", NULL, "file",
+		  "write resulting index to <file>",
 		  PARSE_OPT_NONEG, index_output_cb },
 		OPT_SET_INT(0, "empty", &read_empty,
 			    "only empty the index", 1),
diff --git a/builtin/tag.c b/builtin/tag.c
index 246a2bc..7cf48ab 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -376,7 +376,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Tag creation options"),
 		OPT_BOOLEAN('a', NULL, &annotate,
 					"annotated tag, needs a message"),
-		OPT_CALLBACK('m', NULL, &msg, "MESSAGE",
+		OPT_CALLBACK('m', NULL, &msg, "message",
 			     "tag message", parse_msg_arg),
 		OPT_FILENAME('F', NULL, &msgfile, "read message from file"),
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
-- 
1.7.4.1.74.gf39475.dirty
