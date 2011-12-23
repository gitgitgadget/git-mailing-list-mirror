From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] fix shell command line in example
Date: Fri, 23 Dec 2011 12:41:29 -0400
Message-ID: <20111223164128.GA21918@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 17:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re8Bo-0007Ar-KN
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 17:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474Ab1LWQlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 11:41:42 -0500
Received: from wren.kitenet.net ([80.68.85.49]:58008 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab1LWQlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 11:41:36 -0500
Received: from gnu.kitenet.net (dialup-4.252.10.92.Dial1.Atlanta1.Level3.net [4.252.10.92])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 08B491183CA
	for <git@vger.kernel.org>; Fri, 23 Dec 2011 11:41:34 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 4100C4497B; Fri, 23 Dec 2011 11:41:29 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187633>

The comma was probably intended to be a semicolon so that the
two commands can be run by cut-n-paste.

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 Documentation/git-pull.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 0f18ec8..628695d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -194,7 +194,7 @@ EXAMPLES
   current branch:
 +
 ------------------------------------------------
-$ git pull, git pull origin
+$ git pull; git pull origin
 ------------------------------------------------
 +
 Normally the branch merged in is the HEAD of the remote repository,
-- 
1.7.7.3
