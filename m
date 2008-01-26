From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Documentation: add a bit about sendemail.to configuration
Date: Sat, 26 Jan 2008 12:04:30 +0100
Message-ID: <1201345470-22549-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 12:03:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIiow-0004q8-Lq
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 12:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYAZLCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 06:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYAZLCu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 06:02:50 -0500
Received: from vuizook.err.no ([85.19.215.103]:51471 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYAZLCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 06:02:50 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JIioZ-00004x-9n; Sat, 26 Jan 2008 12:03:18 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JIipq-0005s9-Sj; Sat, 26 Jan 2008 12:04:30 +0100
X-Mailer: git-send-email 1.5.4.rc3.30.gb084e
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71775>

While there is information about this in the configuration section, it was
missing in the options section.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/git-send-email.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 4b8ec8a..0554f2b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -137,6 +137,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	Specify the primary recipient of the emails generated.
 	Generally, this will be the upstream maintainer of the
 	project involved.
+	Default is the value of the 'sendemail.to' configuration value;
+	if that is unspecified, this will be prompted for.
 +
 The --to option must be repeated for each user you want on the to list.
 
-- 
1.5.4.rc3.30.gb084e
