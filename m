From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 6/6] send-email: fix a typo in a comment
Date: Fri, 12 Jun 2009 12:51:42 +0200
Message-ID: <1244803902-8068-6-git-send-email-markus.heidelberg@web.de>
References: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4N3-0002Bm-1I
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933723AbZFLKvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764140AbZFLKvw
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:51:52 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59909 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709AbZFLKvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:51:47 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 40051102EB04E;
	Fri, 12 Jun 2009 12:51:49 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF4MP-00044V-00; Fri, 12 Jun 2009 12:51:49 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18+3zsEAnbYxNfba8rw0yAz0kFHfysw/wC1cfPy
	co8b1Rz6xktR25rrMPV9HyTt4zwu9wsFNO/mEB+TIRF4vk1BvS
	dGwlHmNzFFK4KNLl2dpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121404>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is pretty much an independent fix; applicable to 'master'.

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 16d12e0..4a77d44 100755
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
1.6.3.2.236.ge505d
