From: Ted Percival <ted@midg3t.net>
Subject: [PATCH] Don't use dash commands (git-foo) in tutorial-2
Date: Thu, 26 Jun 2008 23:22:19 +1000
Message-ID: <4863980B.3090300@midg3t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 18:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBuDz-00059U-Av
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 18:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbYFZQUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 12:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYFZQUe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 12:20:34 -0400
Received: from nschwqsrv02p.mx.bigpond.com ([61.9.189.234]:30598 "EHLO
	nschwqsrv02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753660AbYFZQUd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 12:20:33 -0400
X-Greylist: delayed 10680 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 12:20:32 EDT
Received: from nschwotgx01p.mx.bigpond.com ([121.210.210.178])
          by nschwmtas04p.mx.bigpond.com with ESMTP
          id <20080626132227.DEDU21542.nschwmtas04p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>
          for <git@vger.kernel.org>; Thu, 26 Jun 2008 13:22:27 +0000
Received: from erwin.midg3t.net ([121.210.210.178])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20080626132226.HMBN5002.nschwotgx01p.mx.bigpond.com@erwin.midg3t.net>
          for <git@vger.kernel.org>; Thu, 26 Jun 2008 13:22:26 +0000
Received: from tohno.local ([10.0.0.147])
	by erwin.midg3t.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <ted@midg3t.net>)
	id 1KBrQf-0005J7-Ei
	for git@vger.kernel.org; Thu, 26 Jun 2008 23:22:25 +1000
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
X-SA-Exim-Connect-IP: 10.0.0.147
X-SA-Exim-Mail-From: ted@midg3t.net
X-SA-Exim-Scanned: No (on erwin.midg3t.net); SAEximRunCond expanded to false
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150202.48639812.0092,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86461>

Signed-off-by: Ted Percival <ted@midg3t.net>
---
 Documentation/gittutorial-2.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gittutorial-2.txt
b/Documentation/gittutorial-2.txt
index e3d5c1f..31e8a23 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -61,9 +61,9 @@ from your own version. Note that you can shorten it to
only a few
 characters to save yourself typing all 40 hex digits:

 ------------------------------------------------
-$ git-cat-file -t 54196cc2
+$ git cat-file -t 54196cc2
 commit
-$ git-cat-file commit 54196cc2
+$ git cat-file commit 54196cc2
 tree 92b8b694ffb1675e5975148e1121810081dbdffe
 author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
 committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
@@ -166,7 +166,7 @@ hello world!
 and the "parent" object refers to the previous commit:

 ------------------------------------------------
-$ git-cat-file commit 54196cc2
+$ git cat-file commit 54196cc2
 tree 92b8b694ffb1675e5975148e1121810081dbdffe
 author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
 committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
@@ -246,7 +246,7 @@ The last diff is empty, but no new commits have been
made, and the
 head still doesn't contain the new line:

 ------------------------------------------------
-$ git-diff HEAD
+$ git diff HEAD
 diff --git a/file.txt b/file.txt
 index a042389..513feba 100644
 --- a/file.txt
@@ -273,7 +273,7 @@ hello world, again

 So what our "git add" did was store a new blob and then put
 a reference to it in the index file.  If we modify the file again,
-we'll see that the new modifications are reflected in the "git-diff"
+we'll see that the new modifications are reflected in the "git diff"
 output:

 ------------------------------------------------
-- 
1.5.5.4
