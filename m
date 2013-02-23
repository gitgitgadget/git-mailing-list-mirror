From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 01/13] Use 'Git' in help messages
Date: Sat, 23 Feb 2013 23:05:49 +0000
Message-ID: <1361660761-1932-2-git-send-email-philipoakley@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OAM-00023c-St
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205Ab3BWXFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:05:31 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:61712 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758808Ab3BWXFa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:05:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EANpKKVFZ8rke/2dsb2JhbABFwVGBCBdzgiABBScvMwhJOR4GE4gXvn6PFYNAA6cigwc
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="409919183"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:05:28 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216925>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 help.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index 1dfa0b0..1c0e17d 100644
--- a/help.c
+++ b/help.c
@@ -209,14 +209,14 @@ void list_commands(unsigned int colopts,
 {
 	if (main_cmds->cnt) {
 		const char *exec_path = git_exec_path();
-		printf_ln(_("available git commands in '%s'"), exec_path);
+		printf_ln(_("available Git commands in '%s'"), exec_path);
 		putchar('\n');
 		pretty_print_string_list(main_cmds, colopts);
 		putchar('\n');
 	}
 
 	if (other_cmds->cnt) {
-		printf_ln(_("git commands available from elsewhere on your $PATH"));
+		printf_ln(_("Git commands available from elsewhere on your $PATH"));
 		putchar('\n');
 		pretty_print_string_list(other_cmds, colopts);
 		putchar('\n');
@@ -232,7 +232,7 @@ void list_common_cmds_help(void)
 			longest = strlen(common_cmds[i].name);
 	}
 
-	puts(_("The most commonly used git commands are:"));
+	puts(_("The most commonly used Git commands are:"));
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
 		printf("   %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
@@ -289,7 +289,7 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
 
 static const char bad_interpreter_advice[] =
-	N_("'%s' appears to be a git command, but we were not\n"
+	N_("'%s' appears to be a Git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
 
 const char *help_unknown_cmd(const char *cmd)
@@ -380,7 +380,7 @@ const char *help_unknown_cmd(const char *cmd)
 		return assumed;
 	}
 
-	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+	fprintf_ln(stderr, _("git: '%s' is not a Git command. See 'git --help'."), cmd);
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf_ln(stderr,
@@ -397,6 +397,6 @@ const char *help_unknown_cmd(const char *cmd)
 
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
-	printf("git version %s\n", git_version_string);
+	printf("Git version %s\n", git_version_string);
 	return 0;
 }
-- 
1.8.1.msysgit.1
