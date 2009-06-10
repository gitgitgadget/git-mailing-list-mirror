From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 3/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
Date: Wed, 10 Jun 2009 00:16:18 -0700
Message-ID: <7vk53ktv7h.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI2r-0007la-9G
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbZFJHQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZFJHQR
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:16:17 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59253 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZFJHQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:16:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071617.HJLM20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Jun 2009 03:16:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 27GJ1c0034aMwMQ047GJEC; Wed, 10 Jun 2009 03:16:18 -0400
X-VR-Score: -62.00
X-Authority-Analysis: v=1.0 c=1 a=9SSC8r5syM0A:10 a=GWGFlOqvqn0A:10
 a=ybZZDoGAAAAA:8 a=GO9c2UkNudvj46Vg9K4A:9 a=DFv9f20H4XVN-SmTMjMA:7
 a=hCYx02SgrSFp8mjNyIt-L7OJblkA:4 a=MCAouRVjatsA:10 a=5KVauyKsRKMA:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121256>

From: Markus Heidelberg <markus.heidelberg@web.de>
Date: Sun, 7 Jun 2009 23:40:57 +0200

Also remove the argument from --[no-]chain-reply-to.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Applies on top of [2/6]

 Documentation/git-send-email.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 794224b..3c7f896 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -155,7 +155,7 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to=<identifier>::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -204,7 +204,8 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 --[no-]thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
-	header set. Default is the value of the 'sendemail.thread' configuration
+	header set, unless specified with --in-reply-to.
+	Default is the value of the 'sendemail.thread' configuration
 	value; if that is unspecified, default to --thread.
 
 
-- 
1.6.3.2.214.gf4f78e
