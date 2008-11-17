From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: [PATCH] request-pull: make usage string match manpage
Date: Mon, 17 Nov 2008 09:57:19 +0100
Message-ID: <1226912239-7248-1-git-send-email-stefan.naewe@atlas-elektronik.com>
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 10:04:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L202D-00067u-Q6
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 10:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYKQJDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 04:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYKQJDT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 04:03:19 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:60023 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbYKQJDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 04:03:17 -0500
Received: from vssrv01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with SMTP id DC722138A2
	for <git@vger.kernel.org>; Mon, 17 Nov 2008 10:03:13 +0100 (CET)
Received: from mgsrv01.atlas.de ([10.200.101.16])
 by vssrv01.atlas.de (SMSSMTP 4.1.9.35) with SMTP id M2008111710031317807
 for <git@vger.kernel.org>; Mon, 17 Nov 2008 10:03:13 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 9EE232719C;
	Mon, 17 Nov 2008 10:03:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mail01.atlas.de (Postfix) with ESMTP id 95D8E2719B;
	Mon, 17 Nov 2008 10:03:13 +0100 (CET)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id 4908114101; Mon, 17 Nov 2008 09:57:19 +0100 (CET)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101200>

The usage string of 'git request-pull' differs from he manpage
which gives the correct 'synopsis'.

Signed-off-by: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
---
 git-request-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 073a314..9088019 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -4,9 +4,9 @@
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.
 
-USAGE='<commit> <url> [<head>]'
-LONG_USAGE='Summarizes the changes since <commit> to the standard output,
-and includes <url> in the message generated.'
+USAGE='<start> <url> [<end>]'
+LONG_USAGE='Summarizes the changes between two commits to the standard output, 
+and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
 OPTIONS_SPEC=
 . git-sh-setup
-- 
1.5.6.5
