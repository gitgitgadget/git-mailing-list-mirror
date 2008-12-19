From: jidanni@jidanni.org
Subject: [PATCH] Clarify git-format-patch --in-reply-to
Date: Sat, 20 Dec 2008 03:12:12 +0800
Message-ID: <87k59wc73n.fsf@jidanni.org>
References: <7vzlitho1o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDkoq-0000V3-1j
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 20:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYLSTOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 14:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYLSTOD
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 14:14:03 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:37534
	"EHLO homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751168AbYLSTOC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 14:14:02 -0500
Received: from jidanni.org (122-127-33-249.dynamic.hinet.net [122.127.33.249])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 34E99414B0;
	Fri, 19 Dec 2008 11:14:00 -0800 (PST)
In-Reply-To: <7vzlitho1o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103574>

Signed-off-by: jidanni <jidanni@jidanni.org>

diff --git a/git-format-patch.txt b/git-format-patch.txt
index ee27eff..04958de 100644
--- a/git-format-patch.txt
+++ b/git-format-patch.txt
@@ -130 +130,2 @@ include::diff-options.txt[]
-	provide a new patch series.
+	provide a new patch series. Generates coresponding References and
+	In-Reply-To headers. Angle brackets around <Message-Id> are optional.
-- 
1.5.6.5
