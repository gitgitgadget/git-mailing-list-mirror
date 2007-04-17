From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] git-commit.txt: better warning about -f option
Date: Tue, 17 Apr 2007 09:59:03 -0400
Message-ID: <20070417135903.GF11907@fieldses.org>
References: <9733.45415336571$1176698256@news.gmane.org> <7v4pngyk9n.fsf@assigned-by-dhcp.cox.net> <20070417135812.GE11907@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 15:59:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdoDF-0003Iu-TS
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 15:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbXDQN7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 09:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754389AbXDQN7G
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 09:59:06 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39458 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388AbXDQN7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 09:59:04 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdoD1-00045a-I0; Tue, 17 Apr 2007 09:59:03 -0400
Content-Disposition: inline
In-Reply-To: <20070417135812.GE11907@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44768>

Make sure the reader understands that -f may cause the loss of any local
changes.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 337b3d5..7aa877f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -39,7 +39,7 @@ OPTIONS
 
 -f::
 	Proceed even if the index or the working tree differs
-	from HEAD.
+	from HEAD, possibly overwriting and losing any local changes.
 
 -b::
 	Create a new branch named <new_branch> and start it at
-- 
1.5.1.1.98.gedb4f
