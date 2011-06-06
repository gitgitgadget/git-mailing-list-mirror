From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 2/2] Moved paragraph describing the utility of relative submodule URLs.
Date: Mon,  6 Jun 2011 16:49:13 -0400
Message-ID: <1307393353-32389-3-git-send-email-marcnarc@xiplink.com>
References: <4DED314C.3000203@web.de>
 <1307393353-32389-1-git-send-email-marcnarc@xiplink.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, mlevedahl@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgk4-0002K0-51
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043Ab1FFUth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:49:37 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:32809 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756701Ab1FFUtg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 16:49:36 -0400
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p56KnVBJ002061;
	Mon, 6 Jun 2011 16:49:32 -0400
X-Mailer: git-send-email 1.7.6.rc0.17.g3eac3
In-Reply-To: <1307393353-32389-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175162>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-submodule.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 83c59cc..ad67541 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -85,6 +85,14 @@ If the superproject doesn't have an "origin" remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
+In any case, the given URL is recorded into .gitmodules for
+use by subsequent users cloning the superproject. If the URL is
+given relative to the superproject's repository, the presumption
+is the superproject and submodule repositories will be kept
+together in the same relative location, and only the
+superproject's URL needs to be provided: git-submodule will correctly
+locate the submodule using the relative URL in .gitmodules.
++
 <path> is the relative location for the cloned submodule to
 exist in the superproject. If <path> does not exist, then the
 submodule is created by cloning from the named URL. If <path> does
@@ -92,14 +100,6 @@ exist and is already a valid git repository, then this is added
 to the changeset without cloning. This second form is provided
 to ease creating a new submodule from scratch, and presumes
 the user will later push the submodule to the given URL.
-+
-In either case, the given URL is recorded into .gitmodules for
-use by subsequent users cloning the superproject. If the URL is
-given relative to the superproject's repository, the presumption
-is the superproject and submodule repositories will be kept
-together in the same relative location, and only the
-superproject's URL needs to be provided: git-submodule will correctly
-locate the submodule using the relative URL in .gitmodules.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
-- 
1.7.6.rc0.17.g3eac3
