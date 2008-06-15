From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 15:05:27 +0200
Message-ID: <200806151505.27686.robin.rosenberg.lists@dewire.com>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz> <m3od63ozuf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7rzz-0001E2-6j
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbYFONI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 09:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757376AbYFONI4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:08:56 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18951 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbYFONI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 09:08:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E41558026D9;
	Sun, 15 Jun 2008 15:08:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86xYE7MC5I7e; Sun, 15 Jun 2008 15:08:53 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1C61C8006AA;
	Sun, 15 Jun 2008 15:08:53 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <m3od63ozuf.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85087>

Clarify that a clone is not an exact copy.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-clone.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7973e6a..c9bc627 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -31,7 +31,12 @@ This default configuration is achieved by creating references to
 the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
 by initializing `remote.origin.url` and `remote.origin.fetch`
 configuration variables.
-
++
+*NOTE*: Although this command is called clone, the clone is not identical
+in all respects. Local branches in the repository being cloned
+becomes remote tracking branches in the clone and remote tracking
+branches are not cloned at all. For security reasone the config sections
+and triggers are not cloned either.
 
 OPTIONS
 -------
-- 
1.5.5.1.178.g1f811
