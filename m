From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH/RFC] Documentation and Code: Fix misspellings and grammar
Date: Fri, 22 Jun 2012 18:40:14 -0400
Message-ID: <1340404814-29790-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 00:40:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCXC-0002gG-5N
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab2FVWkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:40:19 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57263 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2FVWkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:40:17 -0400
Received: by vbbff1 with SMTP id ff1so1118276vbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=eyTn7DEPGrvu5D2zQHf11qttWakk4qG9kgGnjz872OY=;
        b=l8PBl9dVDAc26tT9iw0zMA/kmMnRHSJQgU2C0/mLE5k5SNr4JYRheIAXKZgGQvjQ2i
         J3qGADa2F2wiuIsG6HpKHFCPp03SZ+841YGl1366lbGlUJqgzrhVQO0wG6RvRY+rgNN0
         qBfQ0xNtvBnlaQK4FbC9wkGJGQYBeT+wPZu1eM6pW8WExWhTdCbrfXe/GaxXpUgbD7Og
         jjZhiFRSoJFu1/hZuCieuGgTSCA3aqkK9g51cDC/yM1eQ5oigiUp871S+oHcn+Jrwsun
         zXcefip4uqpH3Hb5HGPfQmwI5Lx3vi9n5I+vGN3PYgshmQwkScYZ2120KUxwFhsGUlkK
         puwA==
Received: by 10.52.22.50 with SMTP id a18mr1564799vdf.60.1340404816552;
        Fri, 22 Jun 2012 15:40:16 -0700 (PDT)
Received: from localhost ([38.117.156.148])
        by mx.google.com with ESMTPS id l9sm34671657vdw.14.2012.06.22.15.40.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 15:40:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200483>


Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
Let me know if you'd like me to break this up into separate patches.
I ran 'git grep occured' to make sure I got all of them.
Do you think it's a problem to fix misspellings in printf output?


 Documentation/git-diff.txt                  |    2 +-
 Documentation/technical/api-credentials.txt |    2 +-
 compat/regex/regcomp.c                      |    4 ++--
 compat/regex/regex_internal.c               |    6 +++---
 gitweb/gitweb.perl                          |    2 +-
 perl/Git/I18N.pm                            |    2 +-
 po/README                                   |    6 +++---
 sequencer.c                                 |    2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f8d0819..6ef3403 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -38,7 +38,7 @@ directories. This behavior can be forced by --no-index.
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
 	do not give <commit>, it defaults to HEAD.
-	If HEAD does not exist (e.g. unborned branches) and
+	If HEAD does not exist (e.g. unborn branches) and
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
 
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..9a3941a 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -113,7 +113,7 @@ int foo_login(struct foo_connection *f)
 		break;
 	default:
 		/*
-		 * Some other error occured. We don't know if the
+		 * Some other error occurred. We don't know if the
 		 * credential is good or bad, so report nothing to the
 		 * credential subsystem.
 		 */
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 8c96ed9..8387f74 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2095,7 +2095,7 @@ peek_token_bracket (re_token_t *token, re_string_t *input, reg_syntax_t syntax)
 
 /* Entry point of the parser.
    Parse the regular expression REGEXP and return the structure tree.
-   If an error is occured, ERR is set by error code, and return NULL.
+   If an error has occurred, ERR is set by error code, and return NULL.
    This function build the following tree, from regular expression <reg_exp>:
 	   CAT
 	   / \
@@ -3715,7 +3715,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
 /* This is intended for the expressions like "a{1,3}".
    Fetch a number from `input', and return the number.
    Return -1, if the number field is empty like "{,1}".
-   Return -2, If an error is occured.  */
+   Return -2, If an error has occurred.  */
 
 static int
 fetch_number (re_string_t *input, re_token_t *token, reg_syntax_t syntax)
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index 193854c..d4121f2 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1284,7 +1284,7 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have ELEM.
-   return -1 if an error is occured, return 1 otherwise.  */
+   return -1 if an error has occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1341,7 +1341,7 @@ re_node_set_insert (re_node_set *set, int elem)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have any element greater than or equal to ELEM.
-   Return -1 if an error is occured, return 1 otherwise.  */
+   Return -1 if an error has occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1416,7 +1416,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
 
 
 /* Add the token TOKEN to dfa->nodes, and return the index of the token.
-   Or return -1, if an error will be occured.  */
+   Or return -1, if an error has occurred.  */
 
 static int
 internal_function
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55e0e9e..0e92e0b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1132,7 +1132,7 @@ sub handle_errors_html {
 
 	# to avoid infinite loop where error occurs in die_error,
 	# change handler to default handler, disabling handle_errors_html
-	set_message("Error occured when inside die_error:\n$msg");
+	set_message("Error occurred when inside die_error:\n$msg");
 
 	# you cannot jump out of die_error when called as error handler;
 	# the subroutine set via CGI::Carp::set_message is called _after_
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 40dd897..f889fd6 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -68,7 +68,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	print __("Welcome to Git!\n");
 
-	printf __("The following error occured: %s\n"), $error;
+	printf __("The following error occurred: %s\n"), $error;
 
 =head1 DESCRIPTION
 
diff --git a/po/README b/po/README
index c1520e8..d8c9111 100644
--- a/po/README
+++ b/po/README
@@ -232,7 +232,7 @@ Shell:
 
        # To interpolate variables:
        details="oh noes"
-       eval_gettext "An error occured: \$details"; echo
+       eval_gettext "An error occurred: \$details"; echo
 
    In addition we have wrappers for messages that end with a trailing
    newline. I.e. you could write the above as:
@@ -242,7 +242,7 @@ Shell:
 
        # To interpolate variables:
        details="oh noes"
-       eval_gettextln "An error occured: \$details"
+       eval_gettextln "An error occurred: \$details"
 
    More documentation about the interface is available in the GNU info
    page: `info '(gettext)sh'`. Looking at git-am.sh (the first shell
@@ -257,7 +257,7 @@ Perl:
 
        use Git::I18N;
        print __("Welcome to Git!\n");
-       printf __("The following error occured: %s\n"), $error;
+       printf __("The following error occurred: %s\n"), $error;
 
    Run `perldoc perl/Git/I18N.pm` for more info.
 
diff --git a/sequencer.c b/sequencer.c
index bf078f2..17d5115 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -131,7 +131,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
 		/*
-		 * A conflict has occured but the porcelain
+		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-- 
1.7.7.5 (Apple Git-26)
