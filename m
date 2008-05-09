From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Added -A option to man page, to match 'git-repack -h' output.
Date: Thu, 8 May 2008 22:24:51 -0400
Message-ID: <20080509022451.GA31203@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuINt-00049F-6c
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYEICaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYEICaI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:30:08 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:47734 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYEICaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:30:06 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:30:05 EDT
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m492Op2p031735;
	Thu, 8 May 2008 22:24:51 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81586>

Simple patch to make documentation match the git-repack help message.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---
 Documentation/git-repack.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 3d95749..f53e777 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
+'git-repack' [-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,9 @@ OPTIONS
 	leaves behind, but `git fsck --full` shows as
 	dangling.
 
+-A::
+	Same as `-a`, and keep unreachable objects too.
+
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
-- 
1.5.4.4
