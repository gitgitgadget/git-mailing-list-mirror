From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH v2] t/README: unify documentation of test function args
Date: Tue, 26 Apr 2011 12:33:26 +0200
Message-ID: <1303814006-4109-1-git-send-email-misfire@debugon.org>
References: <7vzknei0vn.fsf@alter.siamese.dyndns.org>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 12:33:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEfaY-0006eM-1B
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 12:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab1DZKdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 06:33:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab1DZKdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 06:33:44 -0400
Received: from localhost.localdomain (pD955443D.dip.t-dialin.net [217.85.68.61])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LdL6H-1PWqKC2KMD-00iw2q; Tue, 26 Apr 2011 12:33:42 +0200
X-Mailer: git-send-email 1.7.5
In-Reply-To: <7vzknei0vn.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:k/xyZfL977OeCuFd4PRCb0Qv3F9rNxftIVHAt7xmQzI
 F5qXoc0XO3ndc2sRTrFGGTRQ9F4rQ86yDP4MmuNYTVqAi1jcUb
 VAE/z5bXA0n+tTTm2TaFzuNhwpIdjqZ2XgHbHJDp4zpq5Wudmv
 LRxKYof9+gqzUBT+R6crsRPI391e/RSKntrMJHdiRoBR4OZuCG
 mgHUN1Fyz1JfdlVT61ZnhG9bMl4juc/evsqHabpiqQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172084>

Document all test function arguments in the same way.

While at it, tweak the description of test_path_is_* (thanks to Junio),
and correct some grammatical errors.

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 t/README |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/README b/t/README
index 428ee05..a90b043 100644
--- a/t/README
+++ b/t/README
@@ -379,7 +379,7 @@ library for your script to use.
 
  - test_expect_success [<prereq>] <message> <script>
 
-   Usually takes two strings as parameter, and evaluates the
+   Usually takes two strings as parameters, and evaluates the
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.
 
@@ -389,7 +389,7 @@ library for your script to use.
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=$(git-write-tree)'
 
-   If you supply three parameters the first will be taken to be a
+   If you supply three parameters, the first will be taken to be a
    prerequisite, see the test_set_prereq and test_have_prereq
    documentation below:
 
@@ -446,7 +446,7 @@ library for your script to use.
    Merges the given rev using the given message.  Like test_commit,
    creates a tag and calls test_tick before committing.
 
- - test_set_prereq SOME_PREREQ
+ - test_set_prereq <prereq>
 
    Set a test prerequisite to be used later with test_have_prereq. The
    test-lib will set some prerequisites for you, see the
@@ -456,7 +456,7 @@ library for your script to use.
    test_have_prereq directly, or the three argument invocation of
    test_expect_success and test_expect_failure.
 
- - test_have_prereq SOME PREREQ
+ - test_have_prereq <prereq>
 
    Check if we have a prerequisite previously set with
    test_set_prereq. The most common use of this directly is to skip
@@ -526,12 +526,13 @@ library for your script to use.
 
    Check whether a file has the length it is expected to.
 
- - test_path_is_file <file> [<diagnosis>]
-   test_path_is_dir <dir> [<diagnosis>]
+ - test_path_is_file <path> [<diagnosis>]
+   test_path_is_dir <path> [<diagnosis>]
    test_path_is_missing <path> [<diagnosis>]
 
-   Check whether a file/directory exists or doesn't. <diagnosis> will
-   be displayed if the test fails.
+   Check if the named path is a file, if the named path is a
+   directory, or if the named path does not exist, respectively,
+   and fail otherwise, showing the <diagnosis> text.
 
  - test_when_finished <script>
 
-- 
1.7.5
