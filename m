From: Jon Jensen <jon@endpoint.com>
Subject: [PATCH] Mark post-receive-email with Precedence: list to avoid
 autoresponder replies
Date: Tue, 2 Aug 2011 21:35:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.02.1108022134520.3386@ybpnyubfg6.ybpnyqbznva6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 06:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoSeH-0005ZT-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 06:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060Ab1HCEB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 00:01:29 -0400
Received: from mail.endcrypt.com ([74.205.105.202]:51921 "EHLO
	mail.endcrypt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1HCEB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 00:01:27 -0400
X-Greylist: delayed 1594 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Aug 2011 00:01:27 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id D0AE830889
	for <git@vger.kernel.org>; Wed,  3 Aug 2011 03:35:47 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178538>

Signed-off-by: Jon Jensen <jon@endpoint.com>
---
 contrib/hooks/post-receive-email |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 5b9b26d..c5b1891 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -236,6 +236,7 @@ generate_email_header()
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
 	X-Git-Newrev: $newrev
+	Precedence: list
 
 	This is an automated email from the git hooks/post-receive script. It was
 	generated because a ref change was pushed to the repository containing
-- 
1.7.6.233.gd79bc
