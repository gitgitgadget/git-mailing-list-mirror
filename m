From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
Subject: gitview: pass the missing argument _show_clicked_cb
Date: Thu, 2 Mar 2006 17:17:39 +0530
Message-ID: <20060302114739.GC10593@satan.india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 02 12:48:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEmHY-0001Zn-GU
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 12:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWCBLrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 06:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWCBLrl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 06:47:41 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:46485 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932409AbWCBLrl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 06:47:41 -0500
Received: from localhost (unknown [15.76.101.80])
	by atlrel6.hp.com (Postfix) with ESMTP id 0DE7335D9E;
	Thu,  2 Mar 2006 06:47:39 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r655 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17064>


From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
Subject: gitview: pass the missing argument _show_clicked_cb.

In our last update to use the encoding while showing the commit
diff we added a new argument to this function. But we missed
updating all the callers.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

225f953266128b0703fd8d8a20b3167d06503e4a
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index de9f3f3..781badb 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -798,7 +798,7 @@ class GitView:
 			button.set_relief(gtk.RELIEF_NONE)
 			button.set_sensitive(True)
 			button.connect("clicked", self._show_clicked_cb,
-					child_id, commit.commit_sha1)
+					child_id, commit.commit_sha1, self.encoding)
 			hbox.pack_start(button, expand=False, fill=True)
 			button.show()
 
-- 
1.2.3.gc55f-dirty
