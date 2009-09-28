From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Documentation/git-gc.txt: default --aggressive window is 250, not 10
Date: Mon, 28 Sep 2009 09:56:00 -0500
Message-ID: <3OUjPFzCqTwhiqxi-6df9MkmWbE5Q1i5ydAmhmm0QaaYK9pmBl3RELw7IGRAcPnWtwMJL3CLrGw@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Sep 28 16:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsHeM-00055p-FZ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 16:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbZI1O4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 10:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZI1O4Q
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 10:56:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44358 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZI1O4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 10:56:16 -0400
Received: by mail.nrlssc.navy.mil id n8SEuHc7024037; Mon, 28 Sep 2009 09:56:17 -0500
X-OriginalArrivalTime: 28 Sep 2009 14:56:16.0866 (UTC) FILETIME=[D4B24C20:01CA404B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129267>

From: Brandon Casey <drafnel@gmail.com>

The default --aggressive window has been 250 since 1c192f34 "gc
--aggressive: make it really aggressive", released in git v1.6.3.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/git-gc.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index dcac8c8..1f6df6a 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -106,7 +106,7 @@ much time is spent optimizing the delta compression of the objects in
 the repository when the --aggressive option is specified.  The larger
 the value, the more time is spent optimizing the delta compression.  See
 the documentation for the --window' option in linkgit:git-repack[1] for
-more details.  This defaults to 10.
+more details.  This defaults to 250.
 
 The optional configuration variable 'gc.pruneExpire' controls how old
 the unreferenced loose objects have to be before they are pruned.  The
-- 
1.6.4.3
