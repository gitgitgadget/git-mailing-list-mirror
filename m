From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] gitk: Rename "next" and "prev" buttons to "older" and "newer".
Date: Tue,  8 Oct 2013 16:49:21 -0400
Message-ID: <1381265361-10147-1-git-send-email-marcnarc@xiplink.com>
References: <525445FB.6000806@xiplink.com>
Cc: lucas@threeamdesign.com.au, paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 22:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTeMJ-0008TY-NA
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab3JHU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:58:19 -0400
Received: from IP-192-252-130-194.static.fibrenoire.ca ([192.252.130.194]:16410
	"EHLO cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753479Ab3JHU6T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 16:58:19 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2013 16:58:19 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 00F0860184;
	Tue,  8 Oct 2013 16:49:19 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.dirty
In-Reply-To: <525445FB.6000806@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235796>

Users often find that "next" and "prev" do the opposite of what they
expect.  For example, "next" moves to the next match down the list, but
that is almost always backwards in time.  Renaming "next" to "older"
and "prev" to "newer" makes it clear where the buttons will take the user.
---

(Apologies to Lucas and Paul -- my previous patch email didn't include
the git list.)

 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 5cd00d8..e610010 100755
--- a/gitk
+++ b/gitk
@@ -2244,8 +2244,8 @@ proc makewindow {} {
 
     # build up the bottom bar of upper window
     ${NS}::label .tf.lbar.flabel -text "[mc "Find"] "
-    ${NS}::button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1}
-    ${NS}::button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1}
+    ${NS}::button .tf.lbar.fnext -text [mc "older"] -command {dofind 1 1}
+    ${NS}::button .tf.lbar.fprev -text [mc "newer"] -command {dofind -1 1}
     ${NS}::label .tf.lbar.flab2 -text " [mc "commit"] "
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
 	-side left -fill y
-- 
1.8.4.dirty
