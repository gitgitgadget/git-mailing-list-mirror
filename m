From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 0/5] Various updates to the new infrastructure
Date: Wed, 04 Jun 2008 22:13:08 +0100
Message-ID: <20080604210655.32531.82580.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40XW-00070Z-Qn
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYFDV2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbYFDV2I
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:28:08 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:33740 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752063AbYFDV2H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 17:28:07 -0400
X-Greylist: delayed 893 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jun 2008 17:28:07 EDT
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080604211726.KJEU7070.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Wed, 4 Jun 2008 22:17:26 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20080604211317.FPIL18637.aamtaout04-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 4 Jun 2008 22:13:17 +0100
User-Agent: StGIT/0.14.2.152.g3f19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83830>

For a wider review and to avoid merging conflicts with other developer's 
tree (especially Karl's), I created a "proposed" branch in my StGIT tree
(http://homepage.ntlworld.com/cmarinas/stgit.git) containing patches that 
I intend to merge on "master". I'll also post these patches on the list.

---

Catalin Marinas (5):
      Add stack creation and deletion support to the new infrastructure
      Add stack creation and initialisation support to lib.Stack
      Create a git.Branch class as ancestor of stack.Stack
      Rename Repository.head to Repository.head_ref
      Allow stack.patchorder.all to return hidden patches


 stgit/commands/commit.py  |    4 +-
 stgit/commands/init.py    |   14 ++------
 stgit/commands/new.py     |    3 +-
 stgit/lib/git.py          |   55 ++++++++++++++++++++++++++++-
 stgit/lib/stack.py        |   84 ++++++++++++++++++++++++++++++++-------------
 stgit/lib/stackupgrade.py |    7 ++++
 6 files changed, 127 insertions(+), 40 deletions(-)

-- 
Catalin
