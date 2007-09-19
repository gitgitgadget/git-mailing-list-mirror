From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Don't create .git/branches
Date: Wed, 19 Sep 2007 01:08:02 -0400
Message-ID: <20070919050802.13422.8384.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 07:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrnS-0002a6-5p
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 07:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbXISFIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 01:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbXISFIG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 01:08:06 -0400
Received: from c60.cesmail.net ([216.154.195.49]:30149 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbXISFIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 01:08:04 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 19 Sep 2007 01:08:03 -0400
Received: from dv.roinet.com (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id F38AF618FE1
	for <git@vger.kernel.org>; Wed, 19 Sep 2007 01:08:02 -0400 (EDT)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58680>

.git/branches was obsoleted by .git/remotes in August 2005, and the
later was obsoleted in December 2006.  .git/branches was kept for
compatibility with Cogito.  Since Cogito is not developed any longer,
the .git/branches directory is no longer useful, especially in newly
created repositories.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 templates/branches-- |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 templates/branches--


diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae8870..0000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
