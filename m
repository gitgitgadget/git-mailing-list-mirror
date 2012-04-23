From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/10] i18n: help: mark strings for translation
Date: Mon, 23 Apr 2012 19:30:24 +0700
Message-ID: <1335184230-8870-5-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMITa-0005YB-Cp
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab2DWMeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:34:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:34:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GDNdx52wwcaxddtAeCZXHcOMY9cgUX4z8KyJOewAVV0=;
        b=W9VkjW0rpRQjlqf0J3GPz+IJgx/9dIbabfIysV9tZe0CeNTe26t1j64vVmChA8lrv/
         Qs5DXDwakhTWrJSThOLKKbNWsvX8ESbrJqkdT47kPnUSrJM7ff7lcqDegDPg7nLD1AWd
         S1tfavw4RrzCQzMNyzbFqslEoP/WOV3Bh+SIuFqb92oixpLNY2f2l1BTMgwVywoYMpQU
         iCew/6UeagMMSt+CWIiQ4O/bKkaPrt3rpOnegGGnC8bpQojlOobPObgoYnTwoYR8qbHq
         n844l5mvkuVZpMX5L1fDjxPeocHwxSOr8fu413Wggf6jOHwuKfyuRYV/TeAXicA/Fd85
         E7oA==
Received: by 10.68.233.99 with SMTP id tv3mr5725289pbc.11.1335184474299;
        Mon, 23 Apr 2012 05:34:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id tk8sm223125pbc.33.2012.04.23.05.34.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:17 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196118>

This patch also marks most common commands' synopsis for translation
so that "git help" gives a friendly listing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile            |    1 +
 builtin/help.c      |   48 ++++++++++++++++++++++++-------------------=
-----
 generate-cmdlist.sh |    2 +-
 git.c               |    2 +-
 help.c              |   32 ++++++++++++++++++++------------
 5 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index dab7362..39a3c6b 100644
--- a/Makefile
+++ b/Makefile
@@ -563,6 +563,7 @@ VCSSVN_H +=3D vcs-svn/svndump.h
 MISC_H +=3D branch.h
 MISC_H +=3D bundle.h
 MISC_H +=3D bisect.h
+MISC_H +=3D common-cmds.h
 MISC_H +=3D fetch-pack.h
 MISC_H +=3D thread-utils.h
 MISC_H +=3D send-pack.h
diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..96a462c 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -54,7 +54,7 @@ static enum help_format parse_help_format(const char =
*format)
 		return HELP_FORMAT_INFO;
 	if (!strcmp(format, "web") || !strcmp(format, "html"))
 		return HELP_FORMAT_WEB;
-	die("unrecognized help format '%s'", format);
+	die(_("unrecognized help format '%s'"), format);
 }
=20
 static const char *get_man_viewer_info(const char *name)
@@ -82,7 +82,7 @@ static int check_emacsclient_version(void)
 	ec_process.err =3D -1;
 	ec_process.stdout_to_stderr =3D 1;
 	if (start_command(&ec_process))
-		return error("Failed to start emacsclient.");
+		return error(_("Failed to start emacsclient."));
=20
 	strbuf_read(&buffer, ec_process.err, 20);
 	close(ec_process.err);
@@ -95,7 +95,7 @@ static int check_emacsclient_version(void)
=20
 	if (prefixcmp(buffer.buf, "emacsclient")) {
 		strbuf_release(&buffer);
-		return error("Failed to parse emacsclient version.");
+		return error(_("Failed to parse emacsclient version."));
 	}
=20
 	strbuf_remove(&buffer, 0, strlen("emacsclient"));
@@ -103,7 +103,7 @@ static int check_emacsclient_version(void)
=20
 	if (version < 22) {
 		strbuf_release(&buffer);
-		return error("emacsclient version '%d' too old (< 22).",
+		return error(_("emacsclient version '%d' too old (< 22)."),
 			version);
 	}
=20
@@ -121,7 +121,7 @@ static void exec_woman_emacs(const char *path, cons=
t char *page)
 			path =3D "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
 		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
-		warning("failed to exec '%s': %s", path, strerror(errno));
+		warning(_("failed to exec '%s': %s"), path, strerror(errno));
 	}
 }
=20
@@ -149,7 +149,7 @@ static void exec_man_konqueror(const char *path, co=
nst char *page)
 			path =3D "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
 		execlp(path, filename, "newTab", man_page.buf, (char *)NULL);
-		warning("failed to exec '%s': %s", path, strerror(errno));
+		warning(_("failed to exec '%s': %s"), path, strerror(errno));
 	}
 }
=20
@@ -158,7 +158,7 @@ static void exec_man_man(const char *path, const ch=
ar *page)
 	if (!path)
 		path =3D "man";
 	execlp(path, "man", page, (char *)NULL);
-	warning("failed to exec '%s': %s", path, strerror(errno));
+	warning(_("failed to exec '%s': %s"), path, strerror(errno));
 }
=20
 static void exec_man_cmd(const char *cmd, const char *page)
@@ -166,7 +166,7 @@ static void exec_man_cmd(const char *cmd, const cha=
r *page)
 	struct strbuf shell_cmd =3D STRBUF_INIT;
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
-	warning("failed to exec '%s': %s", cmd, strerror(errno));
+	warning(_("failed to exec '%s': %s"), cmd, strerror(errno));
 }
=20
 static void add_man_viewer(const char *name)
@@ -206,8 +206,8 @@ static int add_man_viewer_path(const char *name,
 	if (supported_man_viewer(name, len))
 		do_add_man_viewer_info(name, len, value);
 	else
-		warning("'%s': path for unsupported man viewer.\n"
-			"Please consider using 'man.<tool>.cmd' instead.",
+		warning(_("'%s': path for unsupported man viewer.\n"
+			  "Please consider using 'man.<tool>.cmd' instead."),
 			name);
=20
 	return 0;
@@ -218,8 +218,8 @@ static int add_man_viewer_cmd(const char *name,
 			      const char *value)
 {
 	if (supported_man_viewer(name, len))
-		warning("'%s': cmd for supported man viewer.\n"
-			"Please consider using 'man.<tool>.path' instead.",
+		warning(_("'%s': cmd for supported man viewer.\n"
+			  "Please consider using 'man.<tool>.path' instead."),
 			name);
 	else
 		do_add_man_viewer_info(name, len, value);
@@ -280,11 +280,11 @@ void list_common_cmds_help(void)
 			longest =3D strlen(common_cmds[i].name);
 	}
=20
-	puts("The most commonly used git commands are:");
+	puts(_("The most commonly used git commands are:"));
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
 		printf("   %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
+		puts(_(common_cmds[i].help));
 	}
 }
=20
@@ -348,7 +348,7 @@ static void exec_viewer(const char *name, const cha=
r *page)
 	else if (info)
 		exec_man_cmd(info, page);
 	else
-		warning("'%s': unknown man viewer.", name);
+		warning(_("'%s': unknown man viewer."), name);
 }
=20
 static void show_man_page(const char *git_cmd)
@@ -365,7 +365,7 @@ static void show_man_page(const char *git_cmd)
 	if (fallback)
 		exec_viewer(fallback, page);
 	exec_viewer("man", page);
-	die("no man viewer handled the request");
+	die(_("no man viewer handled the request"));
 }
=20
 static void show_info_page(const char *git_cmd)
@@ -373,7 +373,7 @@ static void show_info_page(const char *git_cmd)
 	const char *page =3D cmd_to_page(git_cmd);
 	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, (char *)NULL);
-	die("no info viewer handled the request");
+	die(_("no info viewer handled the request"));
 }
=20
 static void get_html_page_path(struct strbuf *page_path, const char *p=
age)
@@ -384,7 +384,7 @@ static void get_html_page_path(struct strbuf *page_=
path, const char *page)
 	/* Check that we have a git documentation directory. */
 	if (stat(mkpath("%s/git.html", html_path), &st)
 	    || !S_ISREG(st.st_mode))
-		die("'%s': not a documentation directory.", html_path);
+		die(_("'%s': not a documentation directory."), html_path);
=20
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
@@ -424,16 +424,16 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
 	parsed_help_format =3D help_format;
=20
 	if (show_all) {
-		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", &main_cmds, &other_cmds);
-		printf("%s\n", git_more_info_string);
+		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
+		list_commands(_("git commands"), &main_cmds, &other_cmds);
+		printf("%s\n", _(git_more_info_string));
 		return 0;
 	}
=20
 	if (!argv[0]) {
-		printf("usage: %s\n\n", git_usage_string);
+		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
-		printf("\n%s\n", git_more_info_string);
+		printf("\n%s\n", _(git_more_info_string));
 		return 0;
 	}
=20
@@ -445,7 +445,7 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
=20
 	alias =3D alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
+		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
 		return 0;
 	}
=20
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 1093ef4..9a4c9b9 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -16,7 +16,7 @@ do
      /^NAME/,/git-'"$cmd"'/H
      ${
 	    x
-	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
+	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", N_("\1")},/
 	    p
      }' "Documentation/git-$cmd.txt"
 done
diff --git a/git.c b/git.c
index 3805616..4486deb 100644
--- a/git.c
+++ b/git.c
@@ -13,7 +13,7 @@ const char git_usage_string[] =3D
 	"           <command> [<args>]";
=20
 const char git_more_info_string[] =3D
-	"See 'git help <command>' for more information on a specific command.=
";
+	N_("See 'git help <command>' for more information on a specific comma=
nd.");
=20
 static struct startup_info git_startup_info;
 static int use_pager =3D -1;
diff --git a/help.c b/help.c
index 14eefc9..9e6e0f2 100644
--- a/help.c
+++ b/help.c
@@ -217,8 +217,9 @@ void list_commands(const char *title, struct cmdnam=
es *main_cmds,
=20
 	if (main_cmds->cnt) {
 		const char *exec_path =3D git_exec_path();
-		printf("available %s in '%s'\n", title, exec_path);
-		printf("----------------");
+		printf_ln(_("available %s in '%s'"), title, exec_path);
+		/* TRANSLATORS: this must align with "available %s in '%s'" */
+		printf(_("----------------"));
 		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
 		pretty_print_string_list(main_cmds, longest);
@@ -226,8 +227,12 @@ void list_commands(const char *title, struct cmdna=
mes *main_cmds,
 	}
=20
 	if (other_cmds->cnt) {
-		printf("%s available from elsewhere on your $PATH\n", title);
-		printf("---------------------------------------");
+		printf_ln(_("%s available from elsewhere on your $PATH"), title);
+		/* TRANSLATORS:
+		 * this must align with
+		 * "%s available from elsewhere on your $PATH"
+		 */
+		printf(_("---------------------------------------"));
 		mput_char('-', strlen(title));
 		putchar('\n');
 		pretty_print_string_list(other_cmds, longest);
@@ -341,7 +346,7 @@ const char *help_unknown_cmd(const char *cmd)
 	      sizeof(*main_cmds.names), levenshtein_compare);
=20
 	if (!main_cmds.cnt)
-		die ("Uh oh. Your system reports no Git commands at all.");
+		die(_("Uh oh. Your system reports no Git commands at all."));
=20
 	/* skip and count prefix matches */
 	for (n =3D 0; n < main_cmds.cnt && !main_cmds.names[n]->len; n++)
@@ -362,23 +367,26 @@ const char *help_unknown_cmd(const char *cmd)
 		const char *assumed =3D main_cmds.names[0]->name;
 		main_cmds.names[0] =3D NULL;
 		clean_cmdnames(&main_cmds);
-		fprintf(stderr, "WARNING: You called a Git command named '%s', "
-			"which does not exist.\n"
-			"Continuing under the assumption that you meant '%s'\n",
+		fprintf_ln(stderr,
+			   _("WARNING: You called a Git command named '%s', "
+			     "which does not exist.\n"
+			     "Continuing under the assumption that you meant '%s'"),
 			cmd, assumed);
 		if (autocorrect > 0) {
-			fprintf(stderr, "in %0.1f seconds automatically...\n",
+			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
 				(float)autocorrect/10.0);
 			poll(NULL, 0, autocorrect * 100);
 		}
 		return assumed;
 	}
=20
-	fprintf(stderr, "git: '%s' is not a git command. See 'git --help'.\n"=
, cmd);
+	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help=
'."), cmd);
=20
 	if (SIMILAR_ENOUGH(best_similarity)) {
-		fprintf(stderr, "\nDid you mean %s?\n",
-			n < 2 ? "this": "one of these");
+		fprintf_ln(stderr,
+			   Q_("\nDid you mean this?",
+			      "\nDid you mean one of these?",
+			   n));
=20
 		for (i =3D 0; i < n; i++)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
--=20
1.7.8.36.g69ee2
