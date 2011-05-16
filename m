From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Documentation/git-fsck.txt: fix typo: unreadable -> unreachable
Date: Mon, 16 May 2011 20:23:35 +0200
Message-ID: <874o4uwllk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 20:23:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM2SL-0005h5-QZ
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 20:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab1EPSXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 14:23:44 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39040 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303Ab1EPSXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 14:23:44 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id CE7B79401F1
	for <git@vger.kernel.org>; Mon, 16 May 2011 20:23:36 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 7335260151; Mon, 16 May 2011 20:23:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173749>



Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/git-fsck.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index c9ede79..a2a508d 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -26,7 +26,7 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 --no-reflogs is given) as heads.

 --unreachable::
-	Print out objects that exist but that aren't readable from any
+	Print out objects that exist but that aren't reachable from any
 	of the reference nodes.

 --root::
@@ -76,7 +76,7 @@ It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
 '--unreachable' flag it will also print out objects that exist but
-that aren't readable from any of the specified head nodes.
+that aren't reachable from any of the specified head nodes.

 So for example

--
1.7.5.1.467.g1a85
