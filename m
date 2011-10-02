From: Kevin Lyda <kevin@ie.suberic.net>
Subject: [PATCH] Spell retrieve correctly.
Date: Sun, 2 Oct 2011 22:44:45 +0100
Message-ID: <20111002214908.34DDF274805@banshee.ie.suberic.net>
Cc: kevin@ie.suberic.net
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 02 23:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAU1r-0004lX-3x
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 23:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab1JBV4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 17:56:48 -0400
Received: from banshee.ie.suberic.net ([93.93.131.204]:53364 "EHLO
	banshee.ie.suberic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1JBV4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 17:56:47 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Oct 2011 17:56:46 EDT
Received: by banshee.ie.suberic.net (Postfix, from userid 1000)
	id 34DDF274805; Sun,  2 Oct 2011 22:49:08 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182610>

---
 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index a86ab70..7422e13 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -962,7 +962,7 @@ my (%TEMP_FILEMAP, %TEMP_FILES);
 
 =item temp_acquire ( NAME )
 
-Attempts to retreive the temporary file mapped to the string C<NAME>. If an
+Attempts to retrieve the temporary file mapped to the string C<NAME>. If an
 associated temp file has not been created this session or was closed, it is
 created, cached, and set for autoflush and binmode.
 
-- 
1.7.0.4
