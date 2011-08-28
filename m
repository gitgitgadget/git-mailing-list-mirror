From: Anthony Foiani <tkil@scrye.com>
Subject: extracting original git commits from "git svn" repository?
Date: Sun, 28 Aug 2011 02:13:21 -0600
Message-ID: <gmxeuhs2m.fsf@dworkin.scrye.com>
Reply-To: Anthony Foiani <tkil@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 10:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxadK-0008QO-H2
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 10:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab1H1IWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 04:22:07 -0400
Received: from 75-148-32-185-Colorado.hfc.comcastbusiness.net ([75.148.32.185]:49546
	"EHLO mail.scrye.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab1H1IWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 04:22:03 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Aug 2011 04:22:03 EDT
Received: by mail.scrye.com (Postfix, from userid 19)
	id 030D66582FD; Sun, 28 Aug 2011 02:13:22 -0600 (MDT)
X-Attribution: Tony
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b31 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180262>


About two years ago, I started an SVN repo for a private project.
After a few months, I started using "git svn" for day-to-day updating
(to take advantage of offline commits, etc).  git-svn has been
fantastic, but since it doesn't maintain AuthorDate (or, if it does, I
don't know how to ask it to do so), I'd like to migrate that SVN repo
to a git repo.

Is there any straightforward way to recover the "original" git commits
(spread out across two different workstations), so I can reinstate the
proper AuthorDate information?

Does this request even make sense?

I can have all the original data in one place, and I've got plenty of
CPU and RAM to throw at the problem:

  server.svn/...
  workstation1.git/...
  workstation2.git/...

I'm hoping that it can be done with sufficient trawling through the
reflog, but I thought I'd ask before trying to do the conversion
myself.

Thanks in advance,
Tony
