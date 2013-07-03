From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-config: update doc for --get with multiple values
Date: Wed,  3 Jul 2013 19:27:39 +0100
Message-ID: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 20:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRmc-0008Fu-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab3GCS16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:27:58 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:59236 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3GCS16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:27:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9A945606507;
	Wed,  3 Jul 2013 19:27:57 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FqBjGgSVRh2v; Wed,  3 Jul 2013 19:27:57 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id B04016064D6;
	Wed,  3 Jul 2013 19:27:56 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A0D49161E481;
	Wed,  3 Jul 2013 19:27:56 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUGPoIMQEA6F; Wed,  3 Jul 2013 19:27:54 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 338B7161E3F7;
	Wed,  3 Jul 2013 19:27:48 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.747.g77f7d3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229505>

Since commit 00b347d (git-config: do not complain about duplicate
entries, 2012-10-23), "git config --get" does not exit with an error if
there are multiple values for the specified key but instead returns the
last value.  Update the documentation to reflect this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 19a7be0..fbad05e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -82,7 +82,7 @@ OPTIONS
 --get::
 	Get the value for a given key (optionally filtered by a regex
 	matching the value). Returns error code 1 if the key was not
-	found and error code 2 if multiple key values were found.
+	found and the last value if multiple key values were found.
 
 --get-all::
 	Like get, but does not fail if the number of values for the key
-- 
1.8.3.1.747.g77f7d3a
