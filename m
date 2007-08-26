From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 3/6] user-manual: introduce the word "commit" earlier
Date: Sun, 26 Aug 2007 12:16:59 -0400
Message-ID: <10992.4252414659$1188145046@news.gmane.org>
References: <11881450221019-git-send-email->
 <11881450231606-git-send-email->
 <11881450231010-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKnc-00030a-2K
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbXHZQRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbXHZQRN
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57981 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKnP-0007Ty-6l; Sun, 26 Aug 2007 12:17:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11881450231010-git-send-email->
Message-Id: <a2ef9d633f67edc227b00209d5b72ec388388877.1188139206.git.bfields@citi.umich.edu>
In-Reply-To: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
References: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56698>

From: J. Bruce Fields <bfields@citi.umich.edu>

Use the word "commit" as a synonym for "version" from the start.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 933177a..6d35a1f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -66,14 +66,14 @@ contains all the information about the history of the project.
 How to check out a different version of a project
 -------------------------------------------------
 
-Git is best thought of as a tool for storing the history of a
-collection of files.  It stores the history as a compressed
-collection of interrelated snapshots (versions) of the project's
-contents.
+Git is best thought of as a tool for storing the history of a collection
+of files.  It stores the history as a compressed collection of
+interrelated snapshots of the project's contents.  In git each such
+version is called a <<def_commit,commit>>.
 
 A single git repository may contain multiple branches.  It keeps track
 of them by keeping a list of <<def_head,heads>> which reference the
-latest version on each branch; the gitlink:git-branch[1] command shows
+latest commit on each branch; the gitlink:git-branch[1] command shows
 you the list of branch heads:
 
 ------------------------------------------------
-- 
1.5.3.rc5.19.g0734d
