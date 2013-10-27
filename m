From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 11/10] fixup! transport-helper: add support to delete branches
Date: Sun, 27 Oct 2013 00:34:12 -0400
Message-ID: <1382848452-7953-1-git-send-email-rhansen@bbn.com>
References: <1381561533-20381-6-git-send-email-felipe.contreras@gmail.com>
Cc: srabbelier@gmail.com, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 05:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaI43-0001V7-LD
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 05:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab3J0Ee4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 00:34:56 -0400
Received: from smtp.bbn.com ([128.33.1.81]:56096 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab3J0Eez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 00:34:55 -0400
Received: from socket.bbn.com ([192.1.120.102]:44138)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VaI3v-0007Iq-Kh; Sun, 27 Oct 2013 00:34:51 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A4CEE4007B
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1381561533-20381-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236772>

Patch 2/10 (transport-helper: fix extra lines) deleted one copy of the
lines; patch 9/10 (transport-helper: add support to delete branches)
should delete the other copy of the lines.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 10db28e..23526de 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -878,9 +878,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
-- 
1.8.4.1
