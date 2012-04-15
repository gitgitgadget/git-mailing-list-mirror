From: Chris Hiestand <chiestand@salk.edu>
Subject: [PATCH] Add Auto-Submitted header to post-receive-email
Date: Sat, 14 Apr 2012 18:15:10 -0700
Message-ID: <E4715C92-2BE5-484E-A55B-273CAB5EB6B4@salk.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 15 03:22:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJEAV-0002Zt-Qc
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 03:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690Ab2DOBWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 21:22:03 -0400
Received: from riis.snl.salk.edu ([198.202.70.55]:47917 "EHLO
	riis.snl.salk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab2DOBWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 21:22:02 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Apr 2012 21:22:02 EDT
Received: from [172.18.0.7] (wsip-68-15-20-133.sd.sd.cox.net [68.15.20.133])
	(Authenticated sender: chiestand)
	by riis.snl.salk.edu (Postfix) with ESMTPSA id 82280EE0C8;
	Sat, 14 Apr 2012 18:15:10 -0700 (PDT)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195541>

Hi,

I think the Auto-Submitted header is a useful hook mail header to include by default.

This conforms to RFC3834 and is useful in preventing e.g. vacation auto-responders
from replying by default.

Perhaps you have already considered this and decided not to include it, but I found
no record of such a conversation on this list.

Thanks,
Chris Hiestand


>From 358fc3ae1ebfd7723d54e4033d3e9a9a0322c873 Mon Sep 17 00:00:00 2001
From: Chris Hiestand <chiestand@salk.edu>
Date: Sat, 14 Apr 2012 17:58:39 -0700
Subject: [PATCH] Add Auto-Submitted header to post-receive-email

Adds Auto-Submitted: auto-generated to post-receive-email header
This conforms to RFC3834 and is useful in preventing eg
vacation auto-responders from replying by default
---
 contrib/hooks/post-receive-email |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 01af9df..282507c 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -237,6 +237,7 @@ generate_email_header()
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
 	X-Git-Newrev: $newrev
+	Auto-Submitted: auto-generated
 
 	This is an automated email from the git hooks/post-receive script. It was
 	generated because a ref change was pushed to the repository containing
-- 
1.7.9
