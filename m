From: Stefan Sperling <stsp@stsp.name>
Subject: [PATCH] Small comment fix for git-cvsimport.
Date: Fri, 21 Dec 2007 16:57:26 +0100
Message-ID: <20071221155726.GD1720@ted.stsp.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 16:57:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5kG1-0001jb-Tb
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 16:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbXLUP5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 10:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbXLUP5a
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 10:57:30 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57436 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbXLUP5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 10:57:30 -0500
X-Envelope-From: stsp@stsp.name
Received: from stsp.lan (stsp.in-vpn.de [217.197.85.96])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id lBLFvR0X010295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 16:57:28 +0100
Received: from ted.stsp.lan (localhost [127.0.0.1])
	by stsp.lan (8.13.8/8.13.8) with ESMTP id lBLFvR0J006639
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 16:57:27 +0100 (CET)
	(envelope-from stsp@ted.stsp.lan)
Received: (from stsp@localhost)
	by ted.stsp.lan (8.13.8/8.13.8/Submit) id lBLFvQU0006638
	for git@vger.kernel.org; Fri, 21 Dec 2007 16:57:26 +0100 (CET)
	(envelope-from stsp)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69069>

Signed-off-by: Stefan Sperling <stsp@stsp.name>

---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 92648f4..1fa9a22 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -848,7 +848,7 @@ while (<CVS>) {
 		}
 		if (!$opt_a && $starttime - 300 - (defined $opt_z ? $opt_z : 300) <= $date) {
 			# skip if the commit is too recent
-			# that the cvsps default fuzz is 300s, we give ourselves another
+			# given that the cvsps default fuzz is 300s, we give ourselves another
 			# 300s just in case -- this also prevents skipping commits
 			# due to server clock drift
 			print "skip patchset $patchset: $date too recent\n" if $opt_v;
-- 
1.5.3.2

-- 
stefan
http://stsp.name                                         PGP Key: 0xF59D25F0
