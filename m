From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Document all help keys in "git add -i" patch mode.
Date: Wed, 28 Nov 2007 19:21:42 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071128182142.GE26591@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 19:22:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxRXx-0005pt-UX
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXK1SVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXK1SVq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:21:46 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:40081 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbXK1SVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:21:45 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id BC80E400002A1
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:21:43 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66397>

---
 Documentation/git-add.txt |    2 ++
 git-add--interactive.perl |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 63829d9..f4aad90 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -210,6 +210,8 @@ patch::
        k - do not decide on this hunk now, and view the previous
            undecided hunk
        K - do not decide on this hunk now, and view the previous hunk
+       s - split the current hunk into smaller hunks
+       ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fb1e92a..613cf3c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -551,6 +551,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+? - print help
 EOF
 }
 
-- 
1.5.3.6.959.g1ab5
