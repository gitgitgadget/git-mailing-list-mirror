From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 4/7] user-manual: fix discussion of default clone
Date: Mon, 16 Apr 2007 00:37:13 -0400
Message-ID: <17615.9037546769$1176698258@news.gmane.org>
References: <11766982362087-git-send-email->
 <11766982361830-git-send-email->
 <1176698236722-git-send-email->
 <11766982363767-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy2-0008Sb-Ka
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbXDPEhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbXDPEhV
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:21 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36498 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxo-0005YX-QC; Mon, 16 Apr 2007 00:37:16 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11766982363767-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44574>

From: J. Bruce Fields <bfields@citi.umich.edu>

The name "master" isn't actually quite so special.  Also, fix some bad
grammar.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d43d237..49e936f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -298,9 +298,9 @@ $ git branch
 * master
 ------------------------------------------------
 
-A freshly cloned repository contains a single branch head, named
-"master", and working directory is initialized to the state of
-the project referred to by "master".
+A freshly cloned repository contains a single branch head, by default
+named "master", with the working directory initialized to the state of
+the project referred to by that branch head.
 
 Most projects also use <<def_tag,tags>>.  Tags, like heads, are
 references into the project's history, and can be listed using the
-- 
1.5.1.1.98.gedb4f
