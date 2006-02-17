From: Martin Mares <mj@ucw.cz>
Subject: git-cvs-import and branches
Date: Fri, 17 Feb 2006 20:55:25 +0100
Message-ID: <mj+md-20060217.193815.10412.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: CVSps@dm.cobite.com
X-From: git-owner@vger.kernel.org Fri Feb 17 20:55:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FABhQ-000848-A3
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 20:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWBQTzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 14:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWBQTzY
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 14:55:24 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:31627 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1750899AbWBQTzX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 14:55:23 -0500
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id A05B0110090; Fri, 17 Feb 2006 20:55:25 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16363>

Hello!

I'm git-importing a rather large CVS repository with lots of branches and
although the mainline is imported correctly, the branches aren't. They
usually contain some changes introduced to the ancestor branch after
the point the new branch has been tagged.

I haven't studied git-cvsimport and cvsps in much detail yet, but it seems
that git-cvsimport forks off the branch at the first patchset reported by
cvsps which mentions the branch and copies the current state of the ancestor
branch at that time.

This doesn't seem to be correct, since many changes might have happened
to the ancestor branch since the real branching point. However, since
cvsps doesn't report the branching points (and they aren't exact points anyway
since tagging is not atomic in CVS), I don't see how to make cvsimport
find the right starting revision.

Does anybody have an idea how to solve this?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
COBOL -- Completely Outdated, Badly Overused Language
