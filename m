From: "Richard P. Curnow" <rc@rc0.org.uk>
Subject: [PATCH] Fix documentation of tag in git-fast-import.txt
Date: Wed, 9 May 2007 23:13:44 +0100
Message-ID: <20070509221344.GA3210@rc0.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 01:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlvmu-0007Dm-2y
	for gcvg-git@gmane.org; Thu, 10 May 2007 01:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760063AbXEIXlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760055AbXEIXlZ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 19:41:25 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:41278 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759961AbXEIXlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 19:41:22 -0400
X-Greylist: delayed 5255 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 May 2007 19:41:22 EDT
Received: from [84.92.131.215] (helo=oxide.rc0.org.uk)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1HluPo-0003Ei-QM
	for git@vger.kernel.org; Wed, 09 May 2007 23:13:44 +0100
Received: from richard  by oxide.rc0.org.uk with local (Exim 4.66)
	id 1HluPo-0000qI-Kn
	for git@vger.kernel.org; Wed, 09 May 2007 23:13:44 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46813>

The tag command does not take a trailing LF.

Signed-off-by: Richard P. Curnow <rc@rc0.org.uk>
---
 Documentation/git-fast-import.txt |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index eaba6fd..8d06775 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -548,7 +548,6 @@ lightweight (non-annotated) tags see the `reset` command below.
 	'from' SP <committish> LF
 	'tagger' SP <name> SP LT <email> GT SP <when> LF
 	data
-	LF
 ....
 
 where `<name>` is the name of the tag to create.
-- 
1.5.1
