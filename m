From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] contrib/hooks/post-receive-email: remove cruft, $committer is not used
Date: Thu, 8 Nov 2007 12:11:57 +0000
Message-ID: <20071108121157.9749.qmail@db594f724cf2e2.315fe32.mid.smarden.org>
References: <20071108094809.22151.qmail@97f06c2e73713e.315fe32.mid.smarden.org> <7vode52hag.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6F0-0006lm-LC
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944AbXKHMLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757920AbXKHMLj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:11:39 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:48380 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757842AbXKHMLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:11:38 -0500
Received: (qmail 9750 invoked by uid 1000); 8 Nov 2007 12:11:57 -0000
Content-Disposition: inline
In-Reply-To: <7vode52hag.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64001>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 3904c18..7511ea0 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -156,10 +156,6 @@ generate_email()
 	fi
 
 	# Email parameters
-	# The committer will be obtained from the latest existing rev; so
-	# for a deletion it will be the oldrev, for the others, then newrev
-	committer=$(git show --pretty=full -s $rev | sed -ne "s/^Commit: //p" |
-		sed -ne 's/\(.*\) </"\1" </p')
 	# The email subject will contain the best description of the ref
 	# that we can build from the parameters
 	describe=$(git describe $rev 2>/dev/null)
-- 
1.5.3.5
