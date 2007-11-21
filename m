From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 4/4] Document optional file parameter to git-add--interactive
Date: Wed, 21 Nov 2007 13:36:41 +0100
Message-ID: <1195648601-21736-5-git-send-email-win@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
 <1195648601-21736-2-git-send-email-win@wincent.com>
 <1195648601-21736-3-git-send-email-win@wincent.com>
 <1195648601-21736-4-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 13:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuopm-0002sG-E4
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbXKUMhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbXKUMhE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:37:04 -0500
Received: from wincent.com ([72.3.236.74]:54659 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840AbXKUMhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:37:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCagcn013817;
	Wed, 21 Nov 2007 06:36:50 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195648601-21736-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65638>

Update the documentation for git-add to mention the new optional
file parameter to git-add--interactive.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-add.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 63829d9..4b44802 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -61,7 +61,10 @@ OPTIONS
 
 -i, \--interactive::
 	Add modified contents in the working tree interactively to
-	the index.
+	the index. If a single optional file argument is supplied the
+	initial command loop is bypassed and the 'patch' subcommand is
+	invoked for the specified file. See ``Interactive mode'' below
+	for details.
 
 -u::
 	Update only files that git already knows about. This is similar
-- 
1.5.3.5.737.gdee1b
