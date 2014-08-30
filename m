From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] Improve English grammar
Date: Sat, 30 Aug 2014 13:56:01 -0600
Message-ID: <20140830135601.0f9fce66fe68968f56bd2879@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, avarab@gmail.com, vmiklos@frugalware.org,
	johan@herland.net, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 21:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNokv-0007XK-Li
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 21:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbaH3T4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 15:56:08 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42036 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaH3T4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 15:56:07 -0400
Received: by mail-ie0-f170.google.com with SMTP id rl12so4414036iec.29
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=lL+/IzXWIlu2zevrCeWWReumtL+u3x5j+l7X5faXscE=;
        b=RTLxdgylIaBVH9ERFWMLdCsjVq2VYrFuA2Y7sY68jIalRIPrFG5mwatbFKDLgocSQ3
         BaCz9Qo+bARDvpMOmjCD1QqBRRXE7C/dRKeYwmIeLkbOgiFN52eVZNZ9Q+64wjp/kige
         TKAAtkWkAk9ni1EbLhnqQhZZXA0WSYfikvuhHDNWfiWkQqM004SikSTtlrrTXUHYg2U+
         ZjYoXV9vc06tMGlVUsBwjacX0GYvwrwgfI4lBU0RCdgFv+Os/ymr2udELSqY1MR6MpQE
         5m7qhp47D9Ficrk/f7n0lW0zVzE3/ysW1InwHTqngI6F4WqutI3GK4mZYP3cWpeM0vEP
         lvYg==
X-Received: by 10.50.79.197 with SMTP id l5mr12195255igx.12.1409428565739;
        Sat, 30 Aug 2014 12:56:05 -0700 (PDT)
Received: from alex-wolverine (173-10-19-157-BusName-utah.ut.hfc.comcastbusiness.net. [173.10.19.157])
        by mx.google.com with ESMTPSA id rr3sm9555797igb.19.2014.08.30.12.56.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 12:56:05 -0700 (PDT)
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256261>

Hi, I submitted this patch a week ago and got no reply, so I'm sending
it again and CC'ing the original authors this time...

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/commit.c   | 2 +-
 builtin/ls-files.c | 2 +-
 builtin/merge.c    | 4 ++--
 builtin/notes.c    | 2 +-
 builtin/rm.c       | 2 +-
 git-bisect.sh      | 4 ++--
 git-stash.sh       | 2 +-
 git.c              | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..59c91ea 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1778,7 +1778,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
-		     "new_index file. Check that disk is not full or quota is\n"
+		     "new_index file. Check that disk is not full and quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..99cee20 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -474,7 +474,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
-			N_("show 'other' directories' name only"),
+			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			N_("don't show empty directories"),
diff --git a/builtin/merge.c b/builtin/merge.c
index ce82eb2..db47200 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1144,14 +1144,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your merge (MERGE_HEAD exists).\n"
-				  "Please, commit your changes before you can merge."));
+				  "Please, commit your changes before you merge."));
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
 	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
-			    "Please, commit your changes before you can merge."));
+			    "Please, commit your changes before you merge."));
 		else
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists)."));
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index 820c341..0606964 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -211,7 +211,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		if (write_sha1_file(msg->buf.buf, msg->buf.len, blob_type, result)) {
 			error(_("unable to write note object"));
 			if (path)
-				error(_("The note contents has been left in %s"),
+				error(_("The note contents have been left in %s"),
 				      path);
 			exit(128);
 		}
diff --git a/builtin/rm.c b/builtin/rm.c
index bc6490b..2b61d3b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -65,7 +65,7 @@ static void error_removing_concrete_submodules(struct string_list *files, int *e
 			  Q_("the following submodule (or one of its nested "
 			     "submodules)\n"
 			     "uses a .git directory:",
-			     "the following submodules (or one of its nested "
+			     "the following submodules (or one of their nested "
 			     "submodules)\n"
 			     "use a .git directory:", files->nr),
 			  _("\n(use 'rm -rf' if you really want to remove "
diff --git a/git-bisect.sh b/git-bisect.sh
index 1e0d602..6cda2b5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -286,11 +286,11 @@ bisect_next_check() {
 
 		if test -s "$GIT_DIR/BISECT_START"
 		then
-			gettextln "You need to give me at least one good and one bad revisions.
+			gettextln "You need to give me at least one good and one bad revision.
 (You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
 		else
 			gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one good and one bad revisions.
+You then need to give me at least one good and one bad revision.
 (You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
 		fi
 		exit 1 ;;
diff --git a/git-stash.sh b/git-stash.sh
index bcc757b..a640a36 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -394,7 +394,7 @@ parse_flags_and_rev()
 
 	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
 		reference="$1"
-		die "$(eval_gettext "\$reference is not valid reference")"
+		die "$(eval_gettext "\$reference is not a valid reference")"
 	}
 
 	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
diff --git a/git.c b/git.c
index 9c49519..465d33a 100644
--- a/git.c
+++ b/git.c
@@ -14,7 +14,7 @@ const char git_usage_string[] =
 	"           <command> [<args>]";
 
 const char git_more_info_string[] =
-	N_("'git help -a' and 'git help -g' lists available subcommands and some\n"
+	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
 	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 	   "to read about a specific subcommand or concept.");
 
-- 
1.9.1
