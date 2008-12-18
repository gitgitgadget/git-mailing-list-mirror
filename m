From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] guilt doc: use literal paragraphs for example commands
Date: Thu, 18 Dec 2008 19:39:34 +0800
Message-ID: <20081218113934.GA16171@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Josef Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu Dec 18 12:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDHFe-00018n-EN
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 12:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYLRLjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 06:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYLRLjq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 06:39:46 -0500
Received: from mga03.intel.com ([143.182.124.21]:12637 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYLRLjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 06:39:45 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 18 Dec 2008 03:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,242,1228118400"; 
   d="scan'208";a="91609589"
Received: from unknown (HELO localhost) ([10.254.153.195])
  by azsmga001.ch.intel.com with ESMTP; 18 Dec 2008 03:39:40 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LDHE6-0004F6-6v; Thu, 18 Dec 2008 19:39:34 +0800
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103454>

Display example commands verbatim by indenting the paragraphs.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 Documentation/guilt-add.txt    |    4 ++--
 Documentation/guilt-delete.txt |    2 +-
 Documentation/guilt-diff.txt   |    2 +-
 Documentation/guilt-help.txt   |    4 ++--
 Documentation/guilt-init.txt   |    7 +++----
 Documentation/guilt-new.txt    |    6 +++---
 Documentation/guilt-rebase.txt |    5 ++---
 7 files changed, 14 insertions(+), 16 deletions(-)

--- guilt.orig/Documentation/guilt-add.txt
+++ guilt/Documentation/guilt-add.txt
@@ -23,8 +23,8 @@ EXAMPLES
 
 Create and add a new file example.c
 
-$ touch example.c
-$ guilt-add example.c
+	$ touch example.c
+	$ guilt-add example.c
 
 Author
 ------
--- guilt.orig/Documentation/guilt-delete.txt
+++ guilt/Documentation/guilt-delete.txt
@@ -25,7 +25,7 @@ EXAMPLES
 --------
 Delete a patch called 'foobar':
 
-$ guilt-delete foobar
+	$ guilt-delete foobar
 
 Author
 ------
--- guilt.orig/Documentation/guilt-diff.txt
+++ guilt/Documentation/guilt-diff.txt
@@ -18,7 +18,7 @@ OPTIONS
 -------
 -z::
 	Output a interdiff against the top-most applied patch. This should
-	produce the same diff as "guilt-new -f foo".
+	produce the same diff as "+guilt-new -f foo+".
 
 <path>...::
 	Restrict diff output to a given set of files.
--- guilt.orig/Documentation/guilt-help.txt
+++ guilt/Documentation/guilt-help.txt
@@ -18,11 +18,11 @@ EXAMPLES
 
 Open the guilt-status man page 
 
-$ guilt-help status
+	$ guilt-help status
 
 Open the guilt man page 
 
-$ guilt-help
+	$ guilt-help
 
 Author
 ------
--- guilt.orig/Documentation/guilt-init.txt
+++ guilt/Documentation/guilt-init.txt
@@ -17,13 +17,12 @@ EXAMPLES
 --------
 First, get a repository to work on. Here's one that we'll use as an example:
 
-$ git-clone git://git.kernel.org/pub/scm/linux/kernel/jsipek/guilt-hello.git
+	$ git-clone git://git.kernel.org/pub/scm/linux/kernel/jsipek/guilt-hello.git
 
 Now, it initialize the patches directory using guilt's init command:
 
-$ cd hello
-
-$ guilt-init
+	$ cd hello
+	$ guilt-init
 
 Author
 ------
--- guilt.orig/Documentation/guilt-new.txt
+++ guilt/Documentation/guilt-new.txt
@@ -42,16 +42,16 @@ EXAMPLES
 
 Create a new patch called 'foobar':
 
-$ guilt-new foobar
+	$ guilt-new foobar
 
 Create a patch called 'foo' and supply a patch description interactively:
 
-$ guilt-new -e foo
+	$ guilt-new -e foo
 
 Create a patch called 'bar' with a provided patch description and sign off
 on the patch:
 
-$ guilt-new -s -m patch-fu bar
+	$ guilt-new -s -m patch-fu bar
 
 Author
 ------
--- guilt.orig/Documentation/guilt-rebase.txt
+++ guilt/Documentation/guilt-rebase.txt
@@ -24,9 +24,8 @@ EXAMPLES
 
 Rebase current tree against Linus's 2.6 tree
 
-$ git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/tovalds/linux-2.6.git
-
-$ guilt-rebase FETCH_HEAD
+	$ git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/tovalds/linux-2.6.git
+	$ guilt-rebase FETCH_HEAD
 
 Author
 ------
