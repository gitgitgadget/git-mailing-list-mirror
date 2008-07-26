From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Clarify that "git log x.c y.h" lists commits that touch either file
Date: Sat, 26 Jul 2008 22:20:35 +0530
Message-ID: <20080726165035.GA32046@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 18:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMmzn-00025X-Qg
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbYGZQui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 12:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbYGZQui
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:50:38 -0400
Received: from fugue.toroid.org ([85.10.196.113]:34729 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757073AbYGZQuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:50:37 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 20A3A558379;
	Sat, 26 Jul 2008 18:50:36 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 2FC55ADC368; Sat, 26 Jul 2008 22:20:35 +0530 (IST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90258>

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 Documentation/git-log.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5a58d5b..05cbac5 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -58,7 +58,7 @@ include::diff-options.txt[]
 	its size is not included.
 
 <paths>...::
-	Show only commits that affect the specified paths.
+	Show only commits that affect any of the specified paths.
 
 
 include::rev-list-options.txt[]
-- 
1.6.0.rc0.43.g2aa74
