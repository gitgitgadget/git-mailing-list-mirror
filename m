From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/3] transport-helper: fix typo in error message when --signed is not supported
Date: Thu, 12 Feb 2015 19:10:01 +0900
Message-ID: <1423735801-11108-3-git-send-email-mh@glandium.org>
References: <1423735801-11108-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 11:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLqj2-0007bX-FH
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 11:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbbBLKKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 05:10:12 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47767 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbbBLKKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 05:10:11 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YLqig-0002ty-0Y; Thu, 12 Feb 2015 19:10:02 +0900
X-Mailer: git-send-email 2.3.0.1.g55ac403.dirty
In-Reply-To: <1423735801-11108-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263713>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index c3868e4..b72fd4a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -861,7 +861,7 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	} else if (flags & TRANSPORT_PUSH_CERT) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
-			die("helper %s does not support dry-run", data->name);
+			die("helper %s does not support --signed", data->name);
 	}
 
 	if (flags & TRANSPORT_PUSH_FORCE) {
-- 
2.3.0.1.g55ac403.dirty
