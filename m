From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 07/11] i18n: remote: mark strings for translation
Date: Mon, 16 Apr 2012 19:49:59 +0700
Message-ID: <1334580603-11577-8-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlPl-0007ET-U6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab2DPMwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:52:12 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:62670 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2DPMwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:52:10 -0400
Received: by dake40 with SMTP id e40so6882057dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wbL6feV3g//kGolt5D9SNNKKbK12GuAeULN6CDvdwSY=;
        b=uWq9slsu+XzrKg6T3p4d2Ih+Ud0U0pbLiucz6qpZVfFMrlM9wsnwtd7155chB8TVd1
         kpO/+umW/SE7h4w0di4H1XBOlZSp6NIltaNS5Aq0U8Jmty+BSQxwQJFaF/9uDSr/m5yO
         VopJWVOBUoL1n9HFtTe5OFxGpikjTprw8b74nkni+yrQ6nPQDLOytupx/xgoJd0HeFfN
         y1zjDJmOUOavuKm+6ljVGVFMDubzfPAIWl0JgYU7LDupCFZN5Uk+IpXQH9Bn/MzXMvkv
         I+9MrLfzrv38pLH+5kcPaqt8zG/TtVfOSevebD7jzfe8mXch6vgfYRdD4G1PAdwwbnFq
         6zig==
Received: by 10.68.225.195 with SMTP id rm3mr27605480pbc.96.1334580730257;
        Mon, 16 Apr 2012 05:52:10 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id vr9sm3092483pbc.38.2012.04.16.05.52.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:52:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:51:17 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195630>

---
 builtin/remote.c |  252 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 133 insertions(+), 119 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1b03473..db28750 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -8,18 +8,18 @@
 #include "refs.h"
 
 static const char * const builtin_remote_usage[] = {
-	"git remote [-v | --verbose]",
-	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror=<fetch|push>] <name> <url>",
-	"git remote rename <old> <new>",
-	"git remote rm <name>",
-	"git remote set-head <name> (-a | -d | <branch>)",
-	"git remote [-v | --verbose] show [-n] <name>",
-	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]",
-	"git remote set-branches [--add] <name> <branch>...",
-	"git remote set-url <name> <newurl> [<oldurl>]",
-	"git remote set-url --add <name> <newurl>",
-	"git remote set-url --delete <name> <url>",
+	N_("git remote [-v | --verbose]"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote rename <old> <new>"),
+	N_("git remote rm <name>"),
+	N_("git remote set-head <name> (-a | -d | <branch>)"),
+	N_("git remote [-v | --verbose] show [-n] <name>"),
+	N_("git remote prune [-n | --dry-run] <name>"),
+	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
+	N_("git remote set-branches [--add] <name> <branch>..."),
+	N_("git remote set-url <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url --add <name> <newurl>"),
+	N_("git remote set-url --delete <name> <url>"),
 	NULL
 };
 
@@ -95,9 +95,9 @@ static int fetch_remote(const char *name)
 		argv[1] = "-v";
 		argv[2] = name;
 	}
-	printf("Updating %s\n", name);
+	printf_ln(_("Updating %s"), name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
-		return error("Could not fetch %s", name);
+		return error(_("Could not fetch %s"), name);
 	return 0;
 }
 
@@ -127,8 +127,8 @@ static int add_branch(const char *key, const char *branchname,
 }
 
 static const char mirror_advice[] =
-"--mirror is dangerous and deprecated; please\n"
-"\t use --mirror=fetch or --mirror=push instead";
+N_("--mirror is dangerous and deprecated; please\n"
+   "\t use --mirror=fetch or --mirror=push instead");
 
 static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 {
@@ -136,7 +136,7 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	if (not)
 		*mirror = MIRROR_NONE;
 	else if (!arg) {
-		warning("%s", mirror_advice);
+		warning("%s", _(mirror_advice));
 		*mirror = MIRROR_BOTH;
 	}
 	else if (!strcmp(arg, "fetch"))
@@ -144,7 +144,7 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	else if (!strcmp(arg, "push"))
 		*mirror = MIRROR_PUSH;
 	else
-		return error("unknown mirror argument: %s", arg);
+		return error(_("unknown mirror argument: %s"), arg);
 	return 0;
 }
 
@@ -182,9 +182,9 @@ static int add(int argc, const char **argv)
 		usage_with_options(builtin_remote_add_usage, options);
 
 	if (mirror && master)
-		die("specifying a master branch makes no sense with --mirror");
+		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
-		die("specifying branches to track makes sense only with fetch mirrors");
+		die(_("specifying branches to track makes sense only with fetch mirrors"));
 
 	name = argv[0];
 	url = argv[1];
@@ -192,11 +192,11 @@ static int add(int argc, const char **argv)
 	remote = remote_get(name);
 	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
 			remote->fetch_refspec_nr))
-		die("remote %s already exists.", name);
+		die(_("remote %s already exists."), name);
 
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
 	if (!valid_fetch_refspec(buf2.buf))
-		die("'%s' is not a valid remote name", name);
+		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
 	if (git_config_set(buf.buf, url))
@@ -240,7 +240,7 @@ static int add(int argc, const char **argv)
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
 
 		if (create_symref(buf.buf, buf2.buf, "remote add"))
-			return error("Could not setup master '%s'", master);
+			return error(_("Could not setup master '%s'"), master);
 	}
 
 	strbuf_release(&buf);
@@ -296,7 +296,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		info = item->util;
 		if (type == REMOTE) {
 			if (info->remote_name)
-				warning("more than one %s", orig_key);
+				warning(_("more than one %s"), orig_key);
 			info->remote_name = xstrdup(value);
 		} else if (type == MERGE) {
 			char *space = strchr(value, ' ');
@@ -336,7 +336,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
 		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
-			die("Could not get fetch map for refspec %s",
+			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch_refspec[i]);
 
 	states->new.strdup_strings = 1;
@@ -437,7 +437,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 
 	states->push.strdup_strings = 1;
 	if (!remote->push_refspec_nr) {
-		item = string_list_append(&states->push, "(matching)");
+		item = string_list_append(&states->push, _("(matching)"));
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(item->string);
@@ -445,11 +445,11 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	for (i = 0; i < remote->push_refspec_nr; i++) {
 		struct refspec *spec = remote->push + i;
 		if (spec->matching)
-			item = string_list_append(&states->push, "(matching)");
+			item = string_list_append(&states->push, _("(matching)"));
 		else if (strlen(spec->src))
 			item = string_list_append(&states->push, spec->src);
 		else
-			item = string_list_append(&states->push, "(delete)");
+			item = string_list_append(&states->push, _("(delete)"));
 
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->forced = spec->force;
@@ -592,19 +592,19 @@ static int migrate_file(struct remote *remote)
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
-			return error("Could not append '%s' to '%s'",
+			return error(_("Could not append '%s' to '%s'"),
 					remote->url[i], buf.buf);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push_refspec_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0))
-			return error("Could not append '%s' to '%s'",
+			return error(_("Could not append '%s' to '%s'"),
 					remote->push_refspec[i], buf.buf);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0))
-			return error("Could not append '%s' to '%s'",
+			return error(_("Could not append '%s' to '%s'"),
 					remote->fetch_refspec[i], buf.buf);
 	if (remote->origin == REMOTE_REMOTES)
 		path = git_path("remotes/%s", remote->name);
@@ -636,30 +636,30 @@ static int mv(int argc, const char **argv)
 
 	oldremote = remote_get(rename.old);
 	if (!oldremote)
-		die("No such remote: %s", rename.old);
+		die(_("No such remote: %s"), rename.old);
 
 	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
 		return migrate_file(oldremote);
 
 	newremote = remote_get(rename.new);
 	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_nr))
-		die("remote %s already exists.", rename.new);
+		die(_("remote %s already exists."), rename.new);
 
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
 	if (!valid_fetch_refspec(buf.buf))
-		die("'%s' is not a valid remote name", rename.new);
+		die(_("'%s' is not a valid remote name"), rename.new);
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s", rename.old);
 	strbuf_addf(&buf2, "remote.%s", rename.new);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
-		return error("Could not rename config section '%s' to '%s'",
+		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
 	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
-		return error("Could not remove config section '%s'", buf.buf);
+		return error(_("Could not remove config section '%s'"), buf.buf);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
@@ -674,13 +674,13 @@ static int mv(int argc, const char **argv)
 				      strlen(rename.old), rename.new,
 				      strlen(rename.new));
 		} else
-			warning("Not updating non-default fetch respec\n"
-				"\t%s\n"
-				"\tPlease update the configuration manually if necessary.",
+			warning(_("Not updating non-default fetch respec\n"
+				  "\t%s\n"
+				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
 
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
-			return error("Could not append '%s'", buf.buf);
+			return error(_("Could not append '%s'"), buf.buf);
 	}
 
 	read_branches();
@@ -691,7 +691,7 @@ static int mv(int argc, const char **argv)
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
-				return error("Could not set '%s'", buf.buf);
+				return error(_("Could not set '%s'"), buf.buf);
 			}
 		}
 	}
@@ -713,7 +713,7 @@ static int mv(int argc, const char **argv)
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
-			die("deleting '%s' failed", item->string);
+			die(_("deleting '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -728,7 +728,7 @@ static int mv(int argc, const char **argv)
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
-			die("renaming '%s' failed", item->string);
+			die(_("renaming '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -747,7 +747,7 @@ static int mv(int argc, const char **argv)
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
-			die("creating '%s' failed", buf.buf);
+			die(_("creating '%s' failed"), buf.buf);
 	}
 	return 0;
 }
@@ -761,7 +761,7 @@ static int remove_branches(struct string_list *branches)
 		unsigned char *sha1 = item->util;
 
 		if (delete_ref(refname, sha1, 0))
-			result |= error("Could not remove branch %s", refname);
+			result |= error(_("Could not remove branch %s"), refname);
 	}
 	return result;
 }
@@ -789,14 +789,14 @@ static int rm(int argc, const char **argv)
 
 	remote = remote_get(argv[1]);
 	if (!remote)
-		die("No such remote: %s", argv[1]);
+		die(_("No such remote: %s"), argv[1]);
 
 	known_remotes.to_delete = remote;
 	for_each_remote(add_known_remote, &known_remotes);
 
 	strbuf_addf(&buf, "remote.%s", remote->name);
 	if (git_config_rename_section(buf.buf, NULL) < 1)
-		return error("Could not remove config section '%s'", buf.buf);
+		return error(_("Could not remove config section '%s'"), buf.buf);
 
 	read_branches();
 	for (i = 0; i < branch_list.nr; i++) {
@@ -830,11 +830,11 @@ static int rm(int argc, const char **argv)
 	string_list_clear(&branches, 1);
 
 	if (skipped.nr) {
-		fprintf(stderr, skipped.nr == 1 ?
-			"Note: A branch outside the refs/remotes/ hierarchy was not removed;\n"
-			"to delete it, use:\n" :
-			"Note: Some branches outside the refs/remotes/ hierarchy were not removed;\n"
-			"to delete them, use:\n");
+		fprintf_ln(stderr, skipped.nr == 1 ?
+			   _("Note: A branch outside the refs/remotes/ hierarchy was not removed;\n"
+			     "to delete it, use:") :
+			   _("Note: Some branches outside the refs/remotes/ hierarchy were not removed;\n"
+			     "to delete them, use:"));
 		for (i = 0; i < skipped.nr; i++)
 			fprintf(stderr, "  git branch -d %s\n",
 				skipped.items[i].string);
@@ -886,7 +886,7 @@ static int get_remote_ref_states(const char *name,
 
 	states->remote = remote_get(name);
 	if (!states->remote)
-		return error("No such remote: %s", name);
+		return error(_("No such remote: %s"), name);
 
 	read_branches();
 
@@ -939,14 +939,14 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 		const char *fmt = "%s";
 		const char *arg = "";
 		if (string_list_has_string(&states->new, name)) {
-			fmt = " new (next fetch will store in remotes/%s)";
+			fmt = _(" new (next fetch will store in remotes/%s)");
 			arg = states->remote->name;
 		} else if (string_list_has_string(&states->tracked, name))
-			arg = " tracked";
+			arg = _(" tracked");
 		else if (string_list_has_string(&states->stale, name))
-			arg = " stale (use 'git remote prune' to remove)";
+			arg = _(" stale (use 'git remote prune' to remove)");
 		else
-			arg = " ???";
+			arg = _(" ???");
 		printf("    %-*s", info->width, name);
 		printf(fmt, arg);
 		printf("\n");
@@ -987,21 +987,21 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	int i;
 
 	if (branch_info->rebase && branch_info->merge.nr > 1) {
-		error("invalid branch.%s.merge; cannot rebase onto > 1 branch",
+		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
 			item->string);
 		return 0;
 	}
 
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf("rebases onto remote %s\n", merge->items[0].string);
+		printf_ln(_("rebases onto remote %s"), merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
-		printf(" merges with remote %s\n", merge->items[0].string);
-		also = "    and with remote";
+		printf_ln(_(" merges with remote %s"), merge->items[0].string);
+		also = _("    and with remote");
 	} else {
-		printf("merges with remote %s\n", merge->items[0].string);
-		also = "   and with remote";
+		printf_ln(_("merges with remote %s"), merge->items[0].string);
+		also = _("   and with remote");
 	}
 	for (i = 1; i < merge->nr; i++)
 		printf("    %-*s %s %s\n", show_info->width, "", also,
@@ -1043,36 +1043,43 @@ static int show_push_info_item(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct push_info *push_info = item->util;
-	char *src = item->string, *status = NULL;
+	const char *src = item->string, *status = NULL;
 
 	switch (push_info->status) {
 	case PUSH_STATUS_CREATE:
-		status = "create";
+		status = _("create");
 		break;
 	case PUSH_STATUS_DELETE:
-		status = "delete";
-		src = "(none)";
+		status = _("delete");
+		src = _("(none)");
 		break;
 	case PUSH_STATUS_UPTODATE:
-		status = "up to date";
+		status = _("up to date");
 		break;
 	case PUSH_STATUS_FASTFORWARD:
-		status = "fast-forwardable";
+		status = _("fast-forwardable");
 		break;
 	case PUSH_STATUS_OUTOFDATE:
-		status = "local out of date";
+		status = _("local out of date");
 		break;
 	case PUSH_STATUS_NOTQUERIED:
 		break;
 	}
-	if (status)
-		printf("    %-*s %s to %-*s (%s)\n", show_info->width, src,
-			push_info->forced ? "forces" : "pushes",
-			show_info->width2, push_info->dest, status);
-	else
-		printf("    %-*s %s to %s\n", show_info->width, src,
-			push_info->forced ? "forces" : "pushes",
-			push_info->dest);
+	if (status) {
+		if (push_info->forced)
+			printf_ln(_("    %-*s forces to %-*s (%s)"), show_info->width, src,
+			       show_info->width2, push_info->dest, status);
+		else
+			printf_ln(_("    %-*s pushes to %-*s (%s)"), show_info->width, src,
+			       show_info->width2, push_info->dest, status);
+	} else {
+		if (push_info->forced)
+			printf_ln(_("    %-*s forces to %s"), show_info->width, src,
+			       push_info->dest);
+		else
+			printf_ln(_("    %-*s pushes to %s"), show_info->width, src,
+			       push_info->dest);
+	}
 	return 0;
 }
 
@@ -1107,9 +1114,9 @@ static int show(int argc, const char **argv)
 
 		get_remote_ref_states(*argv, &states, query_flag);
 
-		printf("* remote %s\n", *argv);
-		printf("  Fetch URL: %s\n", states.remote->url_nr > 0 ?
-			states.remote->url[0] : "(no URL)");
+		printf_ln(_("* remote %s"), *argv);
+		printf_ln(_("  Fetch URL: %s"), states.remote->url_nr > 0 ?
+		       states.remote->url[0] : _("(no URL)"));
 		if (states.remote->pushurl_nr) {
 			url = states.remote->pushurl;
 			url_nr = states.remote->pushurl_nr;
@@ -1118,18 +1125,18 @@ static int show(int argc, const char **argv)
 			url_nr = states.remote->url_nr;
 		}
 		for (i = 0; i < url_nr; i++)
-			printf("  Push  URL: %s\n", url[i]);
+			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
-			printf("  Push  URL: %s\n", "(no URL)");
+			printf_ln(_("  Push  URL: %s"), "(no URL)");
 		if (no_query)
-			printf("  HEAD branch: (not queried)\n");
+			printf_ln(_("  HEAD branch: %s"), "(not queried)");
 		else if (!states.heads.nr)
-			printf("  HEAD branch: (unknown)\n");
+			printf_ln(_("  HEAD branch: %s"), "(unknown)");
 		else if (states.heads.nr == 1)
-			printf("  HEAD branch: %s\n", states.heads.items[0].string);
+			printf_ln(_("  HEAD branch: %s"), states.heads.items[0].string);
 		else {
-			printf("  HEAD branch (remote HEAD is ambiguous,"
-			       " may be one of the following):\n");
+			printf(_("  HEAD branch (remote HEAD is ambiguous,"
+				 " may be one of the following):\n"));
 			for (i = 0; i < states.heads.nr; i++)
 				printf("    %s\n", states.heads.items[i].string);
 		}
@@ -1140,9 +1147,10 @@ static int show(int argc, const char **argv)
 		for_each_string_list(&states.tracked, add_remote_to_show_info, &info);
 		for_each_string_list(&states.stale, add_remote_to_show_info, &info);
 		if (info.list->nr)
-			printf("  Remote branch%s:%s\n",
-			       info.list->nr > 1 ? "es" : "",
-				no_query ? " (status not queried)" : "");
+			printf_ln(Q_("  Remote branch:%s",
+				     "  Remote branches:%s",
+				     info.list->nr),
+				  no_query ? _(" (status not queried)") : "");
 		for_each_string_list(info.list, show_remote_info_item, &info);
 		string_list_clear(info.list, 0);
 
@@ -1151,23 +1159,25 @@ static int show(int argc, const char **argv)
 		info.any_rebase = 0;
 		for_each_string_list(&branch_list, add_local_to_show_info, &info);
 		if (info.list->nr)
-			printf("  Local branch%s configured for 'git pull':\n",
-			       info.list->nr > 1 ? "es" : "");
+			printf_ln(Q_("  Local branch configured for 'git pull':",
+				     "  Local branches configured for 'git pull':",
+				     info.list->nr));
 		for_each_string_list(info.list, show_local_info_item, &info);
 		string_list_clear(info.list, 0);
 
 		/* git push info */
 		if (states.remote->mirror)
-			printf("  Local refs will be mirrored by 'git push'\n");
+			printf_ln(_("  Local refs will be mirrored by 'git push'"));
 
 		info.width = info.width2 = 0;
 		for_each_string_list(&states.push, add_push_to_show_info, &info);
 		qsort(info.list->items, info.list->nr,
 			sizeof(*info.list->items), cmp_string_with_push);
 		if (info.list->nr)
-			printf("  Local ref%s configured for 'git push'%s:\n",
-				info.list->nr > 1 ? "s" : "",
-				no_query ? " (status not queried)" : "");
+			printf_ln(Q_("  Local ref configured for 'git push'%s:",
+				     "  Local refs configured for 'git push'%s:",
+				     info.list->nr),
+				  no_query ? _(" (status not queried)") : "");
 		for_each_string_list(info.list, show_push_info_item, &info);
 		string_list_clear(info.list, 0);
 
@@ -1202,10 +1212,10 @@ static int set_head(int argc, const char **argv)
 		memset(&states, 0, sizeof(states));
 		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
-			result |= error("Cannot determine remote HEAD");
+			result |= error(_("Cannot determine remote HEAD"));
 		else if (states.heads.nr > 1) {
-			result |= error("Multiple remote HEAD branches. "
-					"Please choose one explicitly with:");
+			result |= error(_("Multiple remote HEAD branches. "
+					  "Please choose one explicitly with:"));
 			for (i = 0; i < states.heads.nr; i++)
 				fprintf(stderr, "  git remote set-head %s %s\n",
 					argv[0], states.heads.items[i].string);
@@ -1214,7 +1224,7 @@ static int set_head(int argc, const char **argv)
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
-			result |= error("Could not delete %s", buf.buf);
+			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
 
@@ -1222,9 +1232,9 @@ static int set_head(int argc, const char **argv)
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
 		if (!ref_exists(buf2.buf))
-			result |= error("Not a valid ref: %s", buf2.buf);
+			result |= error(_("Not a valid ref: %s"), buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
-			result |= error("Could not setup %s", buf.buf);
+			result |= error(_("Could not setup %s"), buf.buf);
 		if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
@@ -1260,18 +1270,18 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0, i;
 	struct ref_states states;
 	const char *dangling_msg = dry_run
-		? " %s will become dangling!"
-		: " %s has become dangling!";
+		? _(" %s will become dangling!")
+		: _(" %s has become dangling!");
 
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
 	if (states.stale.nr) {
-		printf("Pruning %s\n", remote);
-		printf("URL: %s\n",
+		printf_ln(_("Pruning %s"), remote);
+		printf_ln(_("URL: %s"),
 		       states.remote->url_nr
 		       ? states.remote->url[0]
-		       : "(no URL)");
+		       : _("(no URL)"));
 	}
 
 	for (i = 0; i < states.stale.nr; i++) {
@@ -1280,8 +1290,12 @@ static int prune_remote(const char *remote, int dry_run)
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
 
-		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
-		       abbrev_ref(refname, "refs/remotes/"));
+		if (dry_run)
+			printf_ln(_(" * [would prune] %s"),
+			       abbrev_ref(refname, "refs/remotes/"));
+		else
+			printf_ln(_(" * [pruned] %s"),
+			       abbrev_ref(refname, "refs/remotes/"));
 		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
 
@@ -1369,7 +1383,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	strbuf_addf(&key, "remote.%s.fetch", remotename);
 
 	if (!remote_is_configured(remotename))
-		die("No such remote '%s'", remotename);
+		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
 
 	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
@@ -1396,7 +1410,7 @@ static int set_branches(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options,
 			     builtin_remote_setbranches_usage, 0);
 	if (argc == 0) {
-		error("no remote specified");
+		error(_("no remote specified"));
 		usage_with_options(builtin_remote_setbranches_usage, options);
 	}
 	argv[argc] = NULL;
@@ -1429,7 +1443,7 @@ static int set_url(int argc, const char **argv)
 			     PARSE_OPT_KEEP_ARGV0);
 
 	if (add_mode && delete_mode)
-		die("--add --delete doesn't make sense");
+		die(_("--add --delete doesn't make sense"));
 
 	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
 		usage_with_options(builtin_remote_seturl_usage, options);
@@ -1443,7 +1457,7 @@ static int set_url(int argc, const char **argv)
 		oldurl = newurl;
 
 	if (!remote_is_configured(remotename))
-		die("No such remote '%s'", remotename);
+		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
 
 	if (push_mode) {
@@ -1469,7 +1483,7 @@ static int set_url(int argc, const char **argv)
 
 	/* Old URL specified. Demand that one matches. */
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
-		die("Invalid old URL pattern: %s", oldurl);
+		die(_("Invalid old URL pattern: %s"), oldurl);
 
 	for (i = 0; i < urlset_nr; i++)
 		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
@@ -1477,9 +1491,9 @@ static int set_url(int argc, const char **argv)
 		else
 			negative_matches++;
 	if (!delete_mode && !matches)
-		die("No such URL found: %s", oldurl);
+		die(_("No such URL found: %s"), oldurl);
 	if (delete_mode && !negative_matches && !push_mode)
-		die("Will not delete all non-push URLs");
+		die(_("Will not delete all non-push URLs"));
 
 	regfree(&old_regex);
 
@@ -1551,7 +1565,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT__VERBOSE(&verbose, "be verbose; must be placed before a subcommand"),
+		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subcommand")),
 		OPT_END()
 	};
 	int result;
@@ -1580,7 +1594,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "update"))
 		result = update(argc, argv);
 	else {
-		error("Unknown subcommand: %s", argv[0]);
+		error(_("Unknown subcommand: %s"), argv[0]);
 		usage_with_options(builtin_remote_usage, options);
 	}
 
-- 
1.7.3.1.256.g2539c.dirty
