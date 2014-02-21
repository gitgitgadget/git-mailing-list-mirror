From: John Marshall <jm18@sanger.ac.uk>
Subject: [PATCH] stash doc: mention short form -k in save description
Date: Fri, 21 Feb 2014 17:25:24 +0000
Message-ID: <20140221172524.GA18357@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 21 18:45:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGuAZ-00072E-Hj
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbaBURpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:45:47 -0500
Received: from wtsi-nat-11.sanger.ac.uk ([193.62.202.235]:31714 "EHLO
	smtp.sanger.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754883AbaBURpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:45:46 -0500
X-Greylist: delayed 1219 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2014 12:45:46 EST
Received: from gen1b.internal.sanger.ac.uk ([172.17.49.33])
	by intmail3a.internal.sanger.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <jm18@sanger.ac.uk>)
	id 1WGtqm-000H2P-8W; Fri, 21 Feb 2014 17:25:24 +0000
Received: from jm18 by gen1b.internal.sanger.ac.uk with local (Exim 4.76)
	(envelope-from <jm18@sanger.ac.uk>)
	id 1WGtqm-0004zG-5y; Fri, 21 Feb 2014 17:25:24 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Message-Source: gen1b.internal.sanger.ac.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242480>

Document --keep-index's short form -k in both main synopsis and
the save synopsis in the Options section.

Signed-off-by: John Marshall <jm18@sanger.ac.uk>
---
A very small documentation patch: I'd not read the main synopsis
carefully (just skipped to the save details!) and didn't realise 
that --keep-index had a short form...

 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..375213f 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -44,7 +44,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
-- 
1.8.3.4 (Apple Git-47)



-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
