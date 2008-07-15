From: "W Snyder" <wsnyder@wsnyder.org>
Subject: git-svn: add/obey a hooks/prepare-commit-msg
Date: Tue, 15 Jul 2008 15:10:25 -0400 (EDT)
Message-ID: <20080715191025.43B9811BB3@wsnyder.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 21:11:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIpw9-0000Cz-G0
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 21:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762481AbYGOTKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 15:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761283AbYGOTKg
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 15:10:36 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:56276
	"EHLO QMTA03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754687AbYGOTKf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 15:10:35 -0400
Received: from OMTA06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id qF3K1Z00116LCl053KAZ1K; Tue, 15 Jul 2008 19:10:33 +0000
Received: from wsnyder.org ([24.91.159.26])
	by OMTA06.westchester.pa.mail.comcast.net with comcast
	id qKAR1Z00D0aTpm03SKAR6z; Tue, 15 Jul 2008 19:10:25 +0000
X-Authority-Analysis: v=1.0 c=1 a=-1bqaIEjc8kA:10 a=uAvsjA9mcioA:10
 a=4S75kIoMmfewEBsk06UA:9 a=LYREXTfCTVSAyHISe7bWKKhgZb4A:4 a=c06vB5MgL9cA:10
Received: by wsnyder.org (Postfix, from userid 1017)
	id 43B9811BB3; Tue, 15 Jul 2008 15:10:25 -0400 (EDT)
X-ssh-sendmail: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88589>


First, thanks for git-svn!

I'm trying to make a edit to the log message when pulling
from SVN into GIT using git-svn.

It's going bidirectionally, so I don't want to
git-filter-branch.

I tried creating a hooks/prepare-commit-msg script; it works
ok when manually doing a "git-commit" but seems to be
ignored by "git-svn fetch".  I made a hacked-up copy of
git-svn that edits the log message the way I want and it all
seems to work.

Can support for obeying commit-msg hooks be added to
git-svn?  Or, is there another way to do this?

Thanks!
