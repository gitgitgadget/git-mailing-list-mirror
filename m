From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: fix typo in lib/spellcheck.tcl
Date: Thu, 21 Feb 2008 15:38:56 +0100
Message-ID: <200802211538.56190.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 15:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSCRL-0003Xo-CU
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 15:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbYBUO3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 09:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbYBUO3s
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 09:29:48 -0500
Received: from smtp.katamail.com ([62.149.157.154]:57755 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751555AbYBUO3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 09:29:47 -0500
Received: (qmail 10395 invoked by uid 89); 21 Feb 2008 14:29:41 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host51-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.51)
  by smtp1-pc with SMTP; 21 Feb 2008 14:29:41 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74618>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 lib/spellcheck.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
index 76a2f17..9be7486 100644
--- a/lib/spellcheck.tcl
+++ b/lib/spellcheck.tcl
@@ -70,7 +70,7 @@ method _connect {pipe_fd} {
 					[mc "Reverting dictionary to %s." $s_lang]]
 			}
 		} else {
-			error_popup [mc "Spell checker sliently failed on startup"]
+			error_popup [mc "Spell checker silently failed on startup"]
 		}
 		return
 	}
-- 
1.5.4.2
