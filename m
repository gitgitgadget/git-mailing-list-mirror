From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] doc/git-send-email: mention sendemail.cc config variable
Date: Mon, 29 Dec 2008 00:37:25 +0100
Message-ID: <200812290037.25890.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 00:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH5DZ-0006Ur-T4
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 00:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbYL1XhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 18:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYL1XhV
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 18:37:21 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:39140 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYL1XhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 18:37:21 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 85642F846F64;
	Mon, 29 Dec 2008 00:37:19 +0100 (CET)
Received: from [91.19.28.232] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LH5CB-0005vR-00; Mon, 29 Dec 2008 00:37:19 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18Ha4NuJJw+1OfxJ0+DsEgKhkil8u0SQyV4vaLX
	DaJjvedug1MDlfY9DliMAmOY5Lnu3BeKssLTKTcubhsiuRVOfC
	KMdggJBHXK0sE7dOSqKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104062>

This variable was added in 5f8b9fc (git-send-email: add a new
sendemail.cc configuration variable, 2008-04-27), but is not yet refered
to by the documentation.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-send-email.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b69846e..ff4aeff 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -34,6 +34,7 @@ The --bcc option must be repeated for each user you want on the bcc list.
 
 --cc::
 	Specify a starting "Cc:" value for each email.
+	Default is the value of 'sendemail.cc'.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
-- 
1.6.1.21.g0298
