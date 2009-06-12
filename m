From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Print HEAD instead of Head for the current branch in the status line
Date: Fri, 12 Jun 2009 14:07:57 +0200
Message-ID: <1244808481-13012-3-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5aG-0007v7-23
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbZFLMKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbZFLMJ6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:09:58 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54683 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbZFLMJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:09:56 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 96060FFA44E7;
	Fri, 12 Jun 2009 14:08:12 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YK-0007lD-01; Fri, 12 Jun 2009 14:08:12 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19vNb7IHlPWod64V7v8L6xR8BsKlvTqvFlklGh2
	cp7o3UKIkk+p7hGCPh/8sl20ldsfGsfXo71eHgjlMc7TOxu6XX
	jF2KZsEo0UfW8WrQBWQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121417>

HEAD is the correct identifier for the currently checked out branch in
git terminology.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/git.cpp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index 357383d..a20bf0d 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -594,7 +594,7 @@ const QString Git::getRevInfo(SCRef sha) {
 
 	QString refsInfo;
 	if (type & BRANCH) {
-		const QString cap(type & CUR_BRANCH ? "Head: " : "Branch: ");
+		const QString cap(type & CUR_BRANCH ? "HEAD: " : "Branch: ");
 		refsInfo =  cap + getRefName(sha, BRANCH).join(" ");
 	}
 	if (type & RMT_BRANCH)
-- 
1.6.3.2.236.ge505d
