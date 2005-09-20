From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 8/8] cogito: Add deprecated_alias to cg-object-id
Date: Mon, 19 Sep 2005 22:29:14 -0400
Message-ID: <1127183354.31115.40.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:29:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXsl-0007ZU-Si
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVITC3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVITC3R
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:29:17 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:29100 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964846AbVITC3R
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:29:17 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXsi-0006O4-Df
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:29:16 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXsg-0001ih-UE
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:29:14 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8960>

Add deprecated_alias to cg-object-id

List all old *-id scripts.

diff --git a/cg-object-id b/cg-object-id
--- a/cg-object-id
+++ b/cg-object-id
@@ -25,10 +25,12 @@
 #	An ID resolving to a commit.
 
 USAGE="cg-object-id [-n | -p | -t] [OBJECT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
+deprecated_alias cg-object-id commit-id cg-commit-id \
+	parent-id cg-parent-id tree-id cg-tree-id
 
 
 # Normalize argument.  The normalized SHA1 ID is put to $normid.
 # If type is known, it's put to $type.
 normalize_id()



-- 
Regards,
Pavel Roskin
