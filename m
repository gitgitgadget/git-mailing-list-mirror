From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] Improve English grammar
Date: Sat, 23 Aug 2014 02:52:15 -0600
Message-ID: <20140823025215.d559001d2dded97c8e3e8248@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL74h-0005zW-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 10:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbaHWIxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 04:53:24 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:45199 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaHWIxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 04:53:22 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so763110igd.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Tm5hbsLOVkkdvsvUYoV36a9S2mRVd8fdfBvJ9Efb2hU=;
        b=s+OS39hF2bZEDK5TyDXnWZqD4PB9eYMrhA98q8xBi4x1BAEjODmALToDpObSznTZoJ
         0dQIZBBoXrk9RoXBRcxOUJqiCcT9aUZUCm34H96xn/cOCvA9Ma8GmPM6tYlUHUXwCdux
         DHvjXroBFUxxaRjS5THc23MInCwChgE3oUBjZ9bOEtJ6i60R/HbX9suxqqv/jUvMjC8X
         MEnxImw2uXYznKFiT+ZhZJH/zrqw6CI5mbeUiIt2ZJLRwlMRQ0piVpk53Fh7PrN2N62p
         tyXDOArul2G+gOZ73F8AsHKoNhB+xgMziWwd9u9/LFkw++ZKNS2rw8DnQNzVLmadutEZ
         FSWQ==
X-Received: by 10.42.96.132 with SMTP id j4mr13790171icn.16.1408784001788;
        Sat, 23 Aug 2014 01:53:21 -0700 (PDT)
Received: from alex-wolverine ([2601:7:6100:c2:39a3:c409:6553:f331])
        by mx.google.com with ESMTPSA id z12sm8703660igu.11.2014.08.23.01.53.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Aug 2014 01:53:21 -0700 (PDT)
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255740>

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
