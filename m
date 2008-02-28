From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Correct name of diff_flush() in API documentation
Date: Thu, 28 Feb 2008 12:24:42 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281224300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUmVW-00084L-5V
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbYB1RYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 12:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbYB1RYo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:24:44 -0500
Received: from iabervon.org ([66.92.72.58]:40363 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085AbYB1RYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 12:24:43 -0500
Received: (qmail 9811 invoked by uid 1000); 28 Feb 2008 17:24:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 17:24:42 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75425>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/technical/api-diff.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 83b007e..20b0241 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -39,7 +39,7 @@ Calling sequence
 * Once you finish feeding the pairs of files, call `diffcore_std()`.
   This will tell the diffcore library to go ahead and do its work.
 
-* Calling `diffcore_flush()` will produce the output.
+* Calling `diff_flush()` will produce the output.
 
 
 Data structures
-- 
1.5.4.3.328.gcaed
