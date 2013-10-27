From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v4 11/10] fixup! transport-helper: add 'force' to 'export' helpers
Date: Sun, 27 Oct 2013 17:11:13 -0400
Message-ID: <1382908273-11200-1-git-send-email-rhansen@bbn.com>
References: <1382857521-7005-7-git-send-email-felipe.contreras@gmail.com>
Cc: srabbelier@gmail.com, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 22:11:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaXcP-0004UR-HD
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 22:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab3J0VL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 17:11:26 -0400
Received: from smtp.bbn.com ([128.33.0.80]:63727 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab3J0VLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 17:11:25 -0400
Received: from socket.bbn.com ([192.1.120.102]:57063)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VaXcJ-0002AI-I3; Sun, 27 Oct 2013 17:11:23 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A254B4007B
X-Mailer: git-send-email 1.8.4.1.610.g2fe5c0e
In-Reply-To: <1382857521-7005-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236810>

document the new 'force' option

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/gitremote-helpers.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f1f4ca9..e75699c 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -437,6 +437,10 @@ set by Git if the remote helper has the 'option' capability.
 'option check-connectivity' \{'true'|'false'\}::
 	Request the helper to check connectivity of a clone.
 
+'option force' \{'true'|'false'\}::
+	Request the helper to perform a force update.  Defaults to
+	'false'.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
-- 
1.8.4.1.610.g2fe5c0e
