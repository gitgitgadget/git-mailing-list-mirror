From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Doc repository-layout: Show refs/replace
Date: Sun, 21 Oct 2012 21:52:37 +0100
Message-ID: <1350852757-3924-1-git-send-email-philipoakley@iee.org>
Cc: Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 22:55:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ2YZ-0003qo-U4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab2JUUwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:52:43 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:55100 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754468Ab2JUUwm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 16:52:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAA9ghFBcHlx7/2dsb2JhbABDhSu7ZIEJgn0jGIECJBOICAe6F5JOA5cIjyKCcA
X-IronPort-AV: E=Sophos;i="4.80,626,1344207600"; 
   d="scan'208";a="397216862"
Received: from host-92-30-92-123.as13285.net (HELO localhost) ([92.30.92.123])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 21 Oct 2012 21:52:40 +0100
X-Mailer: git-send-email 1.7.11.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208148>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

My question on stackoverflow http://stackoverflow.com/questions/6800692
how-do-git-grafts-and-replace-differ-are-grafts-now-deprecated
noted that the gitrepository-layout(5) wasn't up to date. 

Recent hits have propmted me to offer a patch.

Here is that patch.

Philip

---

 Documentation/gitrepository-layout.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 5c891f1..d546e20 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -93,6 +93,12 @@ refs/remotes/`name`::
 	records tip-of-the-tree commit objects of branches copied
 	from a remote repository.
 
+refs/replace/`<obj-sha1>`::
+	records the SHA1 of the object that replaces `<obj-sha1>`.
+	This is similar to info/grafts and is internally used and
+	maintained by `git replace`. Such refs can be exchanged between
+	repositories while grafts are not.
+
 packed-refs::
 	records the same information as refs/heads/, refs/tags/,
 	and friends record in a more efficient way.  See
-- 
1.7.11.msysgit.1
