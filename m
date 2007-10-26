From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] hooks-pre-commit: use \t, rather than a literal TAB in regexp
Date: Fri, 26 Oct 2007 12:48:41 +0200
Message-ID: <87tzoei22e.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 12:49:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlMkc-0006Yi-20
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 12:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbXJZKso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 06:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXJZKsn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 06:48:43 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:53208 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbXJZKsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 06:48:43 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id ECD0817B566
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 12:48:41 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D5FE817B550
	for <git@vger.kernel.org>; Fri, 26 Oct 2007 12:48:41 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 7FA36335CA; Fri, 26 Oct 2007 12:48:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62408>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 templates/hooks--pre-commit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 18b8730..a19279b 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -58,7 +58,7 @@ perl -e '
 	    if (/\s$/) {
 		bad_line("trailing whitespace", $_);
 	    }
-	    if (/^\s* 	/) {
+	    if (/^\s* \t/) {
 		bad_line("indent SP followed by a TAB", $_);
 	    }
 	    if (/^(?:[<>=]){7}/) {
-- 
1.5.3.4.383.gd90a7
