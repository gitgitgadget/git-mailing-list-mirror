From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 2/3] Document a couple of missing command-line options.
Date: Tue, 15 Nov 2005 00:20:01 +0100
Message-ID: <11320104011291-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11320104011582-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Tue Nov 15 00:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbncN-0008EQ-As
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVKNXUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVKNXUA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:20:00 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:62422 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751295AbVKNXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:19:59 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051114231958.SCJV21433.mxfep01.bredband.com@puritan.petwork>;
          Tue, 15 Nov 2005 00:19:58 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 5D79CADFEA;
	Tue, 15 Nov 2005 00:20:01 +0100 (CET)
In-Reply-To: <11320104011582-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11867>

This patch adds documentation to quite a few command-line options.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-checkout-index.txt |   10 +++++-----
 Documentation/git-prune-packed.txt   |    6 ++++++
 Documentation/git-read-tree.txt      |    4 ++++
 3 files changed, 15 insertions(+), 5 deletions(-)

applies-to: fc4d52c0050cf3af0aa501ba7e33d3e0622f0fdc
798cec0159df6f4fefd35c63ad4a59a0399bbd22
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 94b283a..5bff486 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -18,21 +18,21 @@ Will copy all files listed from the inde
 
 OPTIONS
 -------
--u::
+-u|--index::
 	update stat information for the checked out entries in
 	the index file.
 
--q::
+-q|--quiet::
 	be quiet if files exist or are not in the index
 
--f::
+-f|--force::
 	forces overwrite of existing files
 
--a::
+-a|--all::
 	checks out all files in the index.  Cannot be used
 	together with explicit filenames.
 
--n::
+-n|--no-create::
 	Don't checkout new files, only refresh files already checked
 	out.
 
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 28a1500..8d96a91 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -23,6 +23,12 @@ compression applied, stored in a single 
 
 Packs are used to reduce the load on mirror systems, backup engines, disk storage, etc.
 
+OPTIONS
+-------
+-n::
+        Don't actually remove any objects, only show those that would have been
+        removed.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index e219c6a..7be0cbd 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -30,6 +30,10 @@ OPTIONS
 -m::
 	Perform a merge, not just a read.
 
+--reset::
+
+        Same as -m except that unmerged entries will be silently ignored.
+
 -u::
 	After a successful merge, update the files in the work
 	tree with the result of the merge.
---
0.99.9g
