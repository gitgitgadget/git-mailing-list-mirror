From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] gitweb on repo.or.cz shows buggy commitdiff
Date: Sun, 29 Jul 2007 11:46:45 +0200
Message-ID: <20070729094645.GU23229@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:48:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF5NX-0005hG-J2
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759828AbXG2Jrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760971AbXG2Jrp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:47:45 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:37421 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759826AbXG2Jro (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 05:47:44 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 816525A172
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 11:47:42 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6C1617A0E
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 11:47:42 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 5C2F31F155; Sun, 29 Jul 2007 11:46:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54101>

Looking at [1] one can see that the diff, instead of showing the
changes to the various .gitignore files touched by the commit,
displays again and again the data/.gitignore one, but even confuses a
Makefile modified by the commit for the .gitignore file to diff.


|diff --git a/data/pics/.gitignore b/data/pics/.gitignore
|index c5ec666af7db2d53e7ed86090c88f62ab8ec25a4..912bca74cbee222936f08e421230fd9dde903ecb 100644 (file)
|--- a/lua/Makefile
|+++ b/data/pics/.gitignore

Also, despite "+++ b/data/pics/.gitignore" being displayed in the diff
header, it is indeed showing the diffs to "b/lua/Makefile".


[1] http://repo.or.cz/w/tagua/ydirson.git?a=commitdiff;h=1f285b312fa526293164548d88e8403dfb354eb4

Best regards,
-- 
Yann
