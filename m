From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH v2] Fix compiler warning
Date: Tue,  4 Aug 2009 11:28:40 +0200
Message-ID: <1249378120-97998-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 11:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYGKh-0007mQ-IC
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 11:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbZHDJ3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 05:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbZHDJ3M
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 05:29:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755287AbZHDJ3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 05:29:11 -0400
Received: (qmail invoked by alias); 04 Aug 2009 09:29:10 -0000
Received: from e180064096.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.64.96]
  by mail.gmx.net (mp013) with SMTP; 04 Aug 2009 11:29:10 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX184DtU8/aI4IkY8y/r7jELDEmMZlDVccOHGPdQdNC
	sg18QnulMacx0R
X-Mailer: git-send-email 1.6.4.212.g4719
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124773>

From: David Soria Parra <dsp@php.net>

Initilize failed_error in start_command to avoid compiler warning

Signed-off-by: David Soria Parra <dsp@php.net>
---
 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index dc09433..f3e7abb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,7 +19,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno;
+	int failed_errno = failed_errno;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
-- 
1.6.4.212.g4719
