From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] git-remote: document -n
Date: Sun, 18 Mar 2007 22:01:26 +1200
Message-ID: <20070318100249.B2C9C13A382@magnus.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 11:02:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSsE1-0005GK-Nl
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 11:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbXCRKCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 06:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbXCRKCw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 06:02:52 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46428 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbXCRKCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 06:02:51 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id B2C9C13A382; Sun, 18 Mar 2007 22:02:49 +1200 (NZST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42486>

The 'show' and 'prune' commands accept an option '-n'; document what
it does.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/git-remote.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a9fb6a9..de2658c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -49,6 +49,9 @@ branch the `HEAD` at the remote repository actually points at.
 'show'::
 
 Gives some information about the remote <name>.
++
+With `-n` option, the remote heads are not queried first with
+`git ls-remote <name>`; cached information is used instead.
 
 'prune'::
 
@@ -56,6 +59,10 @@ Deletes all stale tracking branches under <name>.
 These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
++
+With `-n` option, the remote heads are not confirmed first with `git
+ls-remote <name>`; cached information is used instead.  Use with
+caution.
 
 'update'::
 
-- 
1.5.0.2.gdcde2
