From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/10] git-remote-mediawiki: spelling fixes
Date: Thu, 11 Apr 2013 23:50:58 -0700
Message-ID: <20130412065058.GC5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 08:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQXpL-0008HR-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 08:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab3DLGvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 02:51:11 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43607 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab3DLGvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 02:51:10 -0400
Received: by mail-pb0-f52.google.com with SMTP id mc8so1260069pbc.39
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FTVj4uwIce9nrwPFSQtfLKdEiLs0NbFv2jAeSIdJak4=;
        b=EeCirCQLuynuNJmwh03qW+u/jeWqASc3LF3LSNiDk5VTSCfno+txgAqDDDqCl/c2NJ
         HBNA0iHGgjUqbbScdGgbHQJ2wTGNGFxTH8CcRMVaLXFQ7ufjL4x9swhrtQRb2SxaoQj3
         brSpvJke6Uw56Q24J7E+CywszghQZreOgo7O9WjJ14yhq6PohtqDhdQldQhb2SNCAY9B
         YLyZES/aOudDNC/Bxwn8nFhlrnbTAyitwYMC4TL/PoJ6tJQqq4bXGED4sYZflDSyp7Ge
         hh8lqA2UA4ah0Np48JbGfWV7S9/LcTdZtpltxBtwNZKwn8ZcAkrEYdahROhm/dJfH5BZ
         p0qw==
X-Received: by 10.66.246.131 with SMTP id xw3mr13555175pac.114.1365749469963;
        Thu, 11 Apr 2013 23:51:09 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id j13sm6057641pat.17.2013.04.11.23.51.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 23:51:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220960>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Most of these were found using Lucas De Marchi's codespell tool.
Others were pointed out by Eric Sunshine.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl        |  6 +++---
 contrib/mw-to-git/t/README                         |  6 +++---
 contrib/mw-to-git/t/install-wiki/LocalSettings.php |  2 +-
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 14 +++++++-------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 094129de..9c14c1f8 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -28,7 +28,7 @@
 use constant SLASH_REPLACEMENT => "%2F";
 
 # It's not always possible to delete pages (may require some
-# priviledges). Deleted pages are replaced with this content.
+# privileges). Deleted pages are replaced with this content.
 use constant DELETED_CONTENT => "[[Category:Deleted]]\n";
 
 # It's not possible to create empty pages. New empty files in Git are
@@ -841,7 +841,7 @@ sub mw_import_ref {
 	if ($fetch_from == 1 && $n == 0) {
 		print STDERR "You appear to have cloned an empty MediaWiki.\n";
 		# Something has to be done remote-helper side. If nothing is done, an error is
-		# thrown saying that HEAD is refering to unknown object 0000000000000000000
+		# thrown saying that HEAD is referring to unknown object 0000000000000000000
 		# and the clone fails.
 	}
 }
@@ -1067,7 +1067,7 @@ sub mw_push_file {
 		my $file_content;
 		if ($page_deleted) {
 			# Deleting a page usually requires
-			# special priviledges. A common
+			# special privileges. A common
 			# convention is to replace the page
 			# with this content instead:
 			$file_content = DELETED_CONTENT;
diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
index 96e97390..03f6ee5d 100644
--- a/contrib/mw-to-git/t/README
+++ b/contrib/mw-to-git/t/README
@@ -25,7 +25,7 @@ Principles and Technical Choices
 
 The test environment makes it easy to install and manipulate one or
 several MediaWiki instances. To allow developers to run the testsuite
-easily, the environment does not require root priviledge (except to
+easily, the environment does not require root privilege (except to
 install the required packages if needed). It starts a webserver
 instance on the user's account (using lighttpd greatly helps for
 that), and does not need a separate database daemon (thanks to the use
@@ -81,7 +81,7 @@ parameters, please refer to the `test-gitmw-lib.sh` and
 
 ** `test_check_wiki_precond`:
 Check if the tests must be skipped or not. Please use this function
-at the beggining of each new test file.
+at the beginning of each new test file.
 
 ** `wiki_getpage`:
 Fetch a given page from the wiki and puts its content in the
@@ -113,7 +113,7 @@ Tests if a given page exists on the wiki.
 
 ** `wiki_reset`:
 Reset the wiki, i.e. flush the database. Use this function at the
-begining of each new test, except if the test re-uses the same wiki
+beginning of each new test, except if the test re-uses the same wiki
 (and history) as the previous test.
 
 How to write a new test
diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
index 29f12511..745e47e8 100644
--- a/contrib/mw-to-git/t/install-wiki/LocalSettings.php
+++ b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
@@ -88,7 +88,7 @@ $wgShellLocale = "en_US.utf8";
 
 ## Set $wgCacheDirectory to a writable directory on the web server
 ## to make your wiki go slightly faster. The directory should not
-## be publically accessible from the web.
+## be publicly accessible from the web.
 #$wgCacheDirectory = "$IP/cache";
 
 # Site language code, should be one of the list in ./languages/Names.php
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
index b6405ce2..37021e20 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -139,7 +139,7 @@ test_expect_success 'character $ in file name (git -> mw) ' '
 '
 
 
-test_expect_failure 'capital at the begining of file names' '
+test_expect_failure 'capital at the beginning of file names' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_10 &&
 	(
@@ -156,7 +156,7 @@ test_expect_failure 'capital at the begining of file names' '
 '
 
 
-test_expect_failure 'special character at the begining of file name from mw to git' '
+test_expect_failure 'special character at the beginning of file name from mw to git' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_11 &&
 	wiki_editpage {char_1 "expect to be renamed {char_1" false &&
@@ -189,7 +189,7 @@ test_expect_success 'Push page with title containing ":" other than namespace se
 	wiki_page_exist NotANameSpace:Page
 '
 
-test_expect_success 'test of correct formating for file name from mw to git' '
+test_expect_success 'test of correct formatting for file name from mw to git' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_12 &&
 	wiki_editpage char_%_7b_1 "expect to be renamed char{_1" false &&
@@ -207,7 +207,7 @@ test_expect_success 'test of correct formating for file name from mw to git' '
 '
 
 
-test_expect_failure 'test of correct formating for file name begining with special character' '
+test_expect_failure 'test of correct formatting for file name beginning with special character' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_13 &&
 	(
@@ -215,7 +215,7 @@ test_expect_failure 'test of correct formating for file name begining with speci
 		echo "my new file {char_1" >\{char_1.mw &&
 		echo "my new file [char_2" >\[char_2.mw &&
 		git add . &&
-		git commit -am "commiting some exotic file name..." &&
+		git commit -am "committing some exotic file name..." &&
 		git push &&
 		git pull
 	) &&
@@ -226,7 +226,7 @@ test_expect_failure 'test of correct formating for file name begining with speci
 '
 
 
-test_expect_success 'test of correct formating for file name from git to mw' '
+test_expect_success 'test of correct formatting for file name from git to mw' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_14 &&
 	(
@@ -234,7 +234,7 @@ test_expect_success 'test of correct formating for file name from git to mw' '
 		echo "my new file char{_1" >Char\{_1.mw &&
 		echo "my new file char[_2" >Char\[_2.mw &&
 		git add . &&
-		git commit -m "commiting some exotic file name..." &&
+		git commit -m "committing some exotic file name..." &&
 		git push
 	) &&
 	wiki_getallpage ref_page_14 &&
-- 
1.8.2.1
