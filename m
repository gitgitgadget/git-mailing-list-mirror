From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 1/2] More precisely described how "git submodule add" handles relative submodule URLs.
Date: Mon,  6 Jun 2011 16:49:12 -0400
Message-ID: <1307393353-32389-2-git-send-email-marcnarc@xiplink.com>
References: <4DED314C.3000203@web.de>
 <1307393353-32389-1-git-send-email-marcnarc@xiplink.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, mlevedahl@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgk3-0002K0-IQ
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab1FFUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:49:36 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:32808 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753834Ab1FFUtg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 16:49:36 -0400
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p56KnVBI002061;
	Mon, 6 Jun 2011 16:49:32 -0400
X-Mailer: git-send-email 1.7.6.rc0.17.g3eac3
In-Reply-To: <1307393353-32389-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175163>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-submodule.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 408998e..83c59cc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -77,8 +77,11 @@ to exist in the superproject. If <path> is not given, the
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
-repository. If the superproject doesn't have an origin configured
+or ../) a location relative to one of the superproject's remote
+repositories:  If the superproject's currently checked-out branch tracks
+a remote branch then that remote's URL is used, otherwise the "origin"
+remote's URL is used.
+If the superproject doesn't have an "origin" remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-- 
1.7.6.rc0.17.g3eac3
