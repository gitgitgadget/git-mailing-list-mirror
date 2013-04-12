From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/10] Correct common spelling mistakes in comments and tests
Date: Fri, 12 Apr 2013 00:11:02 -0700
Message-ID: <20130412071102.GK5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQY8h-0002Av-4J
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3DLHLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:11:10 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47473 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab3DLHLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:11:08 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro12so1267131pbb.32
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GHhYKfu0etKKgd7K8H15+3Ol/GeyubJ6/icoekXWT0c=;
        b=MFLRNy9wpZMYaZucmm4IfTxzwU3f9dumWkmqp8AEhwU705UIvujfPRSnzA7w0UOB9u
         nOjEsEnDjmVOyqNEc4YnCCjSM9xC/JwiJ5AbaRf0PCx43Y+nDreIF77hWCtf9uRMB9Po
         hHCuQD5ut7szdbNy6O6MEUF6DvrMxqRt51p9BylbAYWkhdBcJPALnCp0TBAAiMsPtGDo
         zNK3OuVimlh26K08r1GYc63gmSvNc9dm6VCxHj6JYCU/CwA9mxujUM6X8UzPZ8eQiyhx
         OrP1W5R6Y3zAQXTHyv7knlsNLd/beGDCDdpcMjRR/0jCeZ0N8bXOQQkOurKqUS71NV5B
         xpeA==
X-Received: by 10.68.90.36 with SMTP id bt4mr13131658pbb.42.1365750667787;
        Fri, 12 Apr 2013 00:11:07 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id b3sm7427904pbw.4.2013.04.12.00.11.05
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 00:11:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220968>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Most of these were found using Lucas De Marchi's codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 builtin/apply.c              | 6 +++---
 commit.c                     | 2 +-
 commit.h                     | 2 +-
 diff.c                       | 2 +-
 git-add--interactive.perl    | 2 +-
 git-cvsserver.perl           | 4 ++--
 git-quiltimport.sh           | 2 +-
 gitweb/gitweb.perl           | 6 +++---
 perl/Git.pm                  | 2 +-
 perl/Git/I18N.pm             | 2 +-
 perl/private-Error.pm        | 2 +-
 sequencer.c                  | 2 +-
 t/t1006-cat-file.sh          | 2 +-
 t/t3701-add-interactive.sh   | 2 +-
 t/t4014-format-patch.sh      | 6 +++---
 t/t4124-apply-ws-rule.sh     | 2 +-
 t/t6030-bisect-porcelain.sh  | 2 +-
 t/t7601-merge-pull-config.sh | 2 +-
 t/t7610-mergetool.sh         | 2 +-
 t/t9001-send-email.sh        | 4 ++--
 transport-helper.c           | 2 +-
 transport.h                  | 2 +-
 xdiff/xdiffi.c               | 2 +-
 xdiff/xhistogram.c           | 2 +-
 24 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 06f5320b..f6a3c97d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1921,7 +1921,7 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 }
 
 /*
- * Read the patch text in "buffer" taht extends for "size" bytes; stop
+ * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
  * Return the number of bytes consumed, so that the caller can call us
@@ -3025,7 +3025,7 @@ static struct patch *in_fn_table(const char *name)
  *
  * The latter is needed to deal with a case where two paths A and B
  * are swapped by first renaming A to B and then renaming B to A;
- * moving A to B should not be prevented due to presense of B as we
+ * moving A to B should not be prevented due to presence of B as we
  * will remove it in a later patch.
  */
 #define PATH_TO_BE_DELETED ((struct patch *) -2)
@@ -3509,7 +3509,7 @@ static int check_patch(struct patch *patch)
 	 *
 	 * A patch to swap-rename between A and B would first rename A
 	 * to B and then rename B to A.  While applying the first one,
-	 * the presense of B should not stop A from getting renamed to
+	 * the presence of B should not stop A from getting renamed to
 	 * B; ask to_be_deleted() about the later rename.  Removal of
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
diff --git a/commit.c b/commit.c
index e8eb0aec..1a41757e 100644
--- a/commit.c
+++ b/commit.c
@@ -834,7 +834,7 @@ struct commit_list *get_merge_bases(struct commit *one, struct commit *two,
 }
 
 /*
- * Is "commit" a decendant of one of the elements on the "with_commit" list?
+ * Is "commit" a descendant of one of the elements on the "with_commit" list?
  */
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 {
diff --git a/commit.h b/commit.h
index 4138bb4c..252c7f87 100644
--- a/commit.h
+++ b/commit.h
@@ -164,7 +164,7 @@ extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *r
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
-/* largest postive number a signed 32-bit integer can contain */
+/* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
 extern int register_shallow(const unsigned char *sha1);
diff --git a/diff.c b/diff.c
index db952a5b..0eb26535 100644
--- a/diff.c
+++ b/diff.c
@@ -1565,7 +1565,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * Binary files are displayed with "Bin XXX -> YYY bytes"
 	 * instead of the change count and graph. This part is treated
 	 * similarly to the graph part, except that it is not
-	 * "scaled". If total width is too small to accomodate the
+	 * "scaled". If total width is too small to accommodate the
 	 * guaranteed minimum width of the filename part and the
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 710764ab..d2c4ce6e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1247,7 +1247,7 @@ sub summarize_hunk {
 
 
 # Print a one-line summary of each hunk in the array ref in
-# the first argument, starting wih the index in the 2nd.
+# the first argument, starting with the index in the 2nd.
 sub display_hunks {
 	my ($hunks, $i) = @_;
 	my $ctr = 0;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index f1c3f49a..a0d796e5 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2911,7 +2911,7 @@ sub filenamesplit
 }
 
 # Cleanup various junk in filename (try to canonicalize it), and
-# add prependdir to accomodate running CVS client from a
+# add prependdir to accommodate running CVS client from a
 # subdirectory (so the output is relative to top directory of the project).
 sub filecleanup
 {
@@ -4583,7 +4583,7 @@ sub getmeta
     #     the numerical value of the corresponding byte plus
     #     100.
     #      - "plus 100" avoids "0"s, and also reduces the
-    #        likelyhood of a collision in the case that someone someday
+    #        likelihood of a collision in the case that someone someday
     #        writes an import tool that tries to preserve original
     #        CVS revision numbers, and the original CVS data had done
     #        lots of branches off of branches and other strangeness to
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b9..8e17525d 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -59,7 +59,7 @@ tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"
 
 
-# Find the intial commit
+# Find the initial commit
 commit=$(git rev-parse HEAD)
 
 mkdir $tmp_dir || exit 2
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196d..80950c01 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -683,7 +683,7 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "++GITWEB_CONFIG_COMMON++";
 
-	# Protect agains duplications of file names, to not read config twice.
+	# Protect against duplications of file names, to not read config twice.
 	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
 	# there possibility of duplication of filename there doesn't matter.
 	$GITWEB_CONFIG = ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COMMON);
@@ -1136,7 +1136,7 @@ sub handle_errors_html {
 
 	# to avoid infinite loop where error occurs in die_error,
 	# change handler to default handler, disabling handle_errors_html
-	set_message("Error occured when inside die_error:\n$msg");
+	set_message("Error occurred when inside die_error:\n$msg");
 
 	# you cannot jump out of die_error when called as error handler;
 	# the subroutine set via CGI::Carp::set_message is called _after_
@@ -7485,7 +7485,7 @@ sub git_object {
 		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
 			or die_error(404, "Base object does not exist");
 
-		# here errors should not hapen
+		# here errors should not happen
 		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
 			or die_error(500, "Open git-ls-tree failed");
 		my $line = <$fd>;
diff --git a/perl/Git.pm b/perl/Git.pm
index 57a17160..f207b471 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1026,7 +1026,7 @@ my (%TEMP_FILEMAP, %TEMP_FILES);
 
 =item temp_acquire ( NAME )
 
-Attempts to retreive the temporary file mapped to the string C<NAME>. If an
+Attempts to retrieve the temporary file mapped to the string C<NAME>. If an
 associated temp file has not been created this session or was closed, it is
 created, cached, and set for autoflush and binmode.
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 40dd8971..f889fd6d 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -68,7 +68,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	print __("Welcome to Git!\n");
 
-	printf __("The following error occured: %s\n"), $error;
+	printf __("The following error occurred: %s\n"), $error;
 
 =head1 DESCRIPTION
 
diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index ea14ab27..6098135a 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -769,7 +769,7 @@ is a numeric value. These values are what will be returned by the
 overload methods.
 
 If the text value ends with C<at file line 1> as $@ strings do, then
-this infomation will be used to set the C<-file> and C<-line> arguments
+this information will be used to set the C<-file> and C<-line> arguments
 of the error object.
 
 This class is used internally if an eval'd block die's with an error
diff --git a/sequencer.c b/sequencer.c
index aef5e8a0..bad50779 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -133,7 +133,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
 		/*
-		 * A conflict has occured but the porcelain
+		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2ff..f8a08b7f 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -116,7 +116,7 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
-commit_message="Intial commit"
+commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
 commit_size=176
 commit_content="tree $tree_sha1
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 098a6ae4..9fab25cc 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -319,7 +319,7 @@ test_expect_success PERL 'split hunk "add -p (edit)"' '
 	# times to get out.
 	#
 	# 2. Correct version applies the (not)edited version, and asks
-	#    about the next hunk, against wich we say q and program
+	#    about the next hunk, against which we say q and program
 	#    exits.
 	for a in s e     q n q q
 	do
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index bb1fc47f..183fbe5b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -742,21 +742,21 @@ test_expect_success 'format-patch --signature --cover-letter' '
 	test 2 = $(grep "my sig" output | wc -l)
 '
 
-test_expect_success 'format.signature="" supresses signatures' '
+test_expect_success 'format.signature="" suppresses signatures' '
 	git config format.signature "" &&
 	git format-patch --stdout -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
 
-test_expect_success 'format-patch --no-signature supresses signatures' '
+test_expect_success 'format-patch --no-signature suppresses signatures' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --no-signature -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
 
-test_expect_success 'format-patch --signature="" supresses signatures' '
+test_expect_success 'format-patch --signature="" suppresses signatures' '
 	git format-patch --stdout --signature="" -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 6f6ee88b..581a8016 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -47,7 +47,7 @@ test_fix () {
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
 
-	# the changed lines are all expeced to change
+	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
 	case "$1" in
 	'') expect_cnt=$fixed_cnt ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3e0e15fb..8bf99e10 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -190,7 +190,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-test_expect_success 'bisect skip: successfull result' '
+test_expect_success 'bisect skip: successful result' '
 	git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index b44b2939..25dac798 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -109,7 +109,7 @@ test_expect_success 'setup conflicted merge' '
 '
 
 # First do the merge with resolve and recursive then verify that
-# recusive is choosen.
+# recusive is chosen.
 
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index bc38737b..d526b1d9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -237,7 +237,7 @@ test_expect_success 'mergetool takes partial path' '
     git submodule update -N &&
     test_must_fail git merge master &&
 
-    #shouldnt need these lines
+    #should not need these lines
     #( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     #( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     #( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 97d6f4c7..ebd5c5db 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -101,7 +101,7 @@ test_expect_success $PREREQ \
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
     clean_fake_sendmail &&
-     git send-email --envelope-sender="Patch Contributer <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --envelope-sender="Patch Contributor <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -787,7 +787,7 @@ test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
 	test $ret = "0"
 '
 
-test_expect_success $PREREQ 'confirm doesnt loop forever' '
+test_expect_success $PREREQ 'confirm does not loop forever' '
 	CONFIRM=$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=1 &&
diff --git a/transport-helper.c b/transport-helper.c
index cb3ef7d3..dcd8d974 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -991,7 +991,7 @@ struct unidirectional_transfer {
 	int src_is_sock;
 	/* Is destination socket? */
 	int dest_is_sock;
-	/* Transfer state (TRANSFERING/FLUSHING/FINISHED) */
+	/* Transfer state (TRANSFERRING/FLUSHING/FINISHED) */
 	int state;
 	/* Buffer. */
 	char buf[BUFFERSIZE];
diff --git a/transport.h b/transport.h
index a3450e97..e7beb815 100644
--- a/transport.h
+++ b/transport.h
@@ -74,7 +74,7 @@ struct transport {
 		       const char *executable, int fd[2]);
 
 	/** get_refs_list(), fetch(), and push_refs() can keep
-	 * resources (such as a connection) reserved for futher
+	 * resources (such as a connection) reserved for further
 	 * use. disconnect() releases these resources.
 	 **/
 	int (*disconnect)(struct transport *connection);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1b7012a1..b2eb6db2 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -490,7 +490,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		/*
 		 * Try to move back the possibly merged group of changes, to match
-		 * the recorded postion in the other file.
+		 * the recorded position in the other file.
 		 */
 		while (ixref < ix) {
 			rchg[--ixs] = 1;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index bf99787c..73210cb6 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -55,7 +55,7 @@ struct histindex {
 	struct record {
 		unsigned int ptr, cnt;
 		struct record *next;
-	} **records, /* an ocurrence */
+	} **records, /* an occurrence */
 	  **line_map; /* map of line to record chain */
 	chastore_t rcha;
 	unsigned int *next_ptrs;
-- 
1.8.2.1
