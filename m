From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 6/6] send-email: fix a typo in a comment
Date: Wed, 10 Jun 2009 00:17:33 -0700
Message-ID: <7vy6s0sgky.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:17:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI45-000088-Bo
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbZFJHRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbZFJHRb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:17:31 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59419 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbZFJHRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:17:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071732.HMJZ20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jun 2009 03:17:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 27HZ1c0074aMwMQ037HZoS; Wed, 10 Jun 2009 03:17:33 -0400
X-VR-Score: -62.00
X-Authority-Analysis: v=1.0 c=1 a=3Ix8pbdRy7oA:10 a=eHyQ-0M6HeAA:10
 a=ybZZDoGAAAAA:8 a=5bTkchfFgGhy581Bo5QA:9 a=RW77_Fxrq9qJ7gStGNXhANltwoMA:4
 a=5KVauyKsRKMA:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121259>

From: Markus Heidelberg <markus.heidelberg@web.de>
Date: Sun, 7 Jun 2009 23:40:52 +0200

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is pretty much an independent fix; applicable to 'master'.

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index be7eb5c..303e03a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -812,7 +812,7 @@ sub sanitize_address
 }
 
 # Returns 1 if the message was sent, and 0 otherwise.
-# In actuality, the whole program dies when a there
+# In actuality, the whole program dies when there
 # is an error sending a message.
 
 sub send_message
-- 
1.6.3.2.214.gf4f78e
