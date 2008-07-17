From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/RelNotes-1.6.0.txt: Expand on the incompatible
	packfiles
Date: Thu, 17 Jul 2008 19:01:30 +0200
Message-ID: <20080717170118.14083.87086.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 19:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWsU-0000un-Re
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbYGQRBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYGQRBv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:01:51 -0400
Received: from [212.249.11.140] ([212.249.11.140]:51586 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754052AbYGQRBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:01:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 2F93E2AC73C;
	Thu, 17 Jul 2008 19:01:31 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88887>

Note that v1.4.4.5 supports pack index v2, and describe how to keep
your repositories backwards-compatible, shall you need to.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/RelNotes-1.6.0.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.txt b/Documentation/RelNotes-1.6.0.txt
index b29ba25..9bbb07e 100644
--- a/Documentation/RelNotes-1.6.0.txt
+++ b/Documentation/RelNotes-1.6.0.txt
@@ -21,7 +21,9 @@ main git.git codebase.
 By default, packfiles created with this version uses delta-base-offset
 encoding introduced in v1.4.4.  Pack idx files are using version 2 that
 allows larger packs and added robustness thanks to its CRC checking,
-introduced in v1.5.2.
+introduced in v1.5.2 and v1.4.4.5.  If you want to keep your repositories
+backwards compatible past these versions, set repack.useDeltaBaseOffset
+to false or pack.indexVersion to 1, respectively.
 
 GIT_CONFIG, which was only documented as affecting "git config", but
 actually affected all git commands, now only affects "git config".
