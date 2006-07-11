From: Alp Toker <alp@atoker.com>
Subject: [PATCH] git-send-email: Remove redundant Reply-To header
Date: Tue, 11 Jul 2006 11:19:37 +0100
Message-ID: <11526131792773-git-send-email-alp@atoker.com>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 12:20:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0FLK-0003i0-6K
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 12:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWGKKTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 06:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWGKKTp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 06:19:45 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:11283 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1750915AbWGKKTp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 06:19:45 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 2B1451645F5; Tue, 11 Jul 2006 11:19:39 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g97c7-dirty
In-Reply-To: <11526131791902-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23705>

There is no sense in duplicating the sender address in Reply-To as it's
already provided in the From header.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 git-send-email.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 64a8eef..1e2777c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -413,7 +413,6 @@ sub send_message
 To: $to
 Cc: $cc
 Subject: $subject
-Reply-To: $from
 Date: $date
 Message-Id: $message_id
 X-Mailer: git-send-email $gitversion
-- 
1.4.1.g97c7-dirty
