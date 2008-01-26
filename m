From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Add a missing dependency on http.h
Date: Sat, 26 Jan 2008 13:19:02 +0100
Message-ID: <1201349942-28688-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 13:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIjyn-00066B-No
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 13:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbYAZMRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 07:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYAZMRT
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 07:17:19 -0500
Received: from vuizook.err.no ([85.19.215.103]:39773 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbYAZMRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 07:17:18 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JIjye-0007Aa-62; Sat, 26 Jan 2008 13:17:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JIjzy-0007T4-CR; Sat, 26 Jan 2008 13:19:02 +0100
X-Mailer: git-send-email 1.5.4.rc3.31.g3ddfb-dirty
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71779>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 82e9cd6..e960043 100644
--- a/Makefile
+++ b/Makefile
@@ -926,7 +926,7 @@ git-%$X: %.o $(GITLIBS)
 
 git-imap-send$X: imap-send.o $(LIB_FILE)
 
-http.o http-walker.o http-push.o: http.h
+http.o http-walker.o http-push.o transport.o: http.h
 
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-- 
1.5.4.rc3.31.g3ddfb-dirty
