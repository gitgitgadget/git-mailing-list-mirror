From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] git-pack-objects.txt: Make wording slightly less ambiguous
Date: Sat, 5 Apr 2008 21:46:49 +0200
Message-ID: <20080405194649.GA248@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 21:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiEMT-0005Oj-H1
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 21:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYDETqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 15:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYDETqw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 15:46:52 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:55558 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753326AbYDETqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 15:46:51 -0400
Received: (qmail 533 invoked by uid 5842); 5 Apr 2008 21:46:49 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78861>

It is a bit confusing on first read, that

        "The packed archive format (.pack) is designed
        to be unpackable..."

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 Documentation/git-pack-objects.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index eed0a94..3a1be08 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -22,8 +22,9 @@ archive with specified base-name, or to the standard output.
 A packed archive is an efficient way to transfer set of objects
 between two repositories, and also is an archival format which
 is efficient to access.  The packed archive format (.pack) is
-designed to be unpackable without having anything else, but for
-random access, accompanied with the pack index file (.idx).
+designed to be self contained so that it can be unpacked without
+any further information, but for fast, random access to the objects
+in the pack, a pack index file (.idx) will be generated.
 
 Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
 any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
-- 
1.5.5-rc3.GIT
