From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/4] First set of improvements to git-svn user doc
Date: Mon,  6 Jul 2009 00:03:13 +0200
Message-ID: <1246831397-19489-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 00:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNZmZ-0000Tw-Ln
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 00:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbZGEWBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 18:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbZGEWBp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 18:01:45 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39787 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbZGEWBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 18:01:44 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 17AAA9400BC;
	Mon,  6 Jul 2009 00:01:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2D3FA940124;
	Mon,  6 Jul 2009 00:01:37 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1BA2AA003; Mon,  6 Jul 2009 00:03:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122758>

>From my previous post, I have splitted the changes to the manpage for easier
review and incremental integration.  Here are the parts I consider mature
enough to be proposed into master.  The other ones are still WIP and I'll
repost them when I have made real progress on them.

Yann Dirson (4):
  git-svn.txt: stop using dash-form of commands.
  git-svn.txt: make formatting more consistent.
  git-svn.txt: fix fetch flags incorrectly documented as init flags.
  git-svn.txt: fix description of fetch flags accepted by clone.

 Documentation/git-svn.txt |  337 ++++++++++++++++++++++-----------------------
 1 files changed, 164 insertions(+), 173 deletions(-)
