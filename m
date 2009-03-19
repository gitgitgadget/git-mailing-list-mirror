From: Johan Herland <johan@herland.net>
Subject: [PATCH] Documentation/git-filter-branch.txt: Remove unnecessary URL
 quoting
Date: Fri, 20 Mar 2009 00:12:10 +0100
Message-ID: <200903200012.10454.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 01:13:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSMw-0003Kb-IY
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759679AbZCTAMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759299AbZCTAMU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:12:20 -0400
Received: from mx.getmail.no ([84.208.15.66]:64922 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757703AbZCTAMT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 20:12:19 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2009 20:12:19 EDT
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGS0030V0GC1GC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Mar 2009 00:12:12 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGS00AGC0GACRB0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Mar 2009 00:12:12 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.19.230146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113870>

Embedding the URL in '+++' causes AsciiDoc (v8.4.1) to generate invalid XML.
None of the other URLs in Git's documentation are quoted in this manner.
There's no reason to treat this URL differently.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 237f85e..64b99d7 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -361,7 +361,7 @@ objects until you tell it to.  First make sure that:
 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
 
-* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
+* Clone it with `git clone file:///path/to/repo`.  The clone
   will not have the removed objects.  See linkgit:git-clone[1].  (Note
   that cloning with a plain path just hardlinks everything!)
 
-- 
1.6.2.1.352.gae594.dirty
