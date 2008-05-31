From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sat, 31 May 2008 14:34:46 -0400
Message-ID: <1212258886-87484-1-git-send-email-mfwitten@mit.edu>
Cc: Michael Witten <mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 20:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Vvi-0002cT-6J
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 20:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYEaSe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYEaSe5
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 14:34:57 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:51211 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753131AbYEaSe5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2008 14:34:57 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m4VIYtmm009636;
	Sat, 31 May 2008 14:34:55 -0400 (EDT)
Received: from localhost.localdomain (MACGREGOR-SEVEN-O-FIVE.MIT.EDU [18.239.7.194])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m4VIYkwr029223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 31 May 2008 14:34:54 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.GIT
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83400>

This should make PERL_PATH more robust, as some
systems may have multiple version of perl installed.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 865e2bf..5828745 100644
--- a/Makefile
+++ b/Makefile
@@ -323,7 +323,7 @@ ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
 ifndef PERL_PATH
-	PERL_PATH = /usr/bin/perl
+	PERL_PATH = /usr/bin/env perl
 endif
 
 export PERL_PATH
-- 
1.5.5.GIT
