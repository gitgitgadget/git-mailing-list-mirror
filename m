From: jidanni@jidanni.org
Subject: [PATCH] Documentation/gitcore-tutorial.txt: HEAD not symlink these days
Date: Tue,  6 Jan 2009 10:18:39 +0800
Message-ID: <1231208319-12673-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 03:20:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK1Y8-0006tJ-54
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 03:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZAFCSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 21:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbZAFCSo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 21:18:44 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:46878 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752979AbZAFCSn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 21:18:43 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 34360D26E9;
	Mon,  5 Jan 2009 18:18:42 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104618>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/gitcore-tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index e4dd551..05328cf 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -751,7 +751,7 @@ Creating a new branch
 
 Branches in git are really nothing more than pointers into the git
 object database from within the `.git/refs/` subdirectory, and as we
-already discussed, the `HEAD` branch is nothing but a symlink to one of
+already discussed, the `HEAD` branch is nothing but a pointer to one of
 these object pointers.
 
 You can at any time create a new branch by just picking an arbitrary
-- 
1.6.0.6
