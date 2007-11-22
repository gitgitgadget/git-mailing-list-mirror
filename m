From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 4/4] Update git-add documentation for multiple interactive paths
Date: Thu, 22 Nov 2007 01:02:53 +0100
Message-ID: <1195689773-28601-5-git-send-email-win@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
 <1195689773-28601-1-git-send-email-win@wincent.com>
 <1195689773-28601-2-git-send-email-win@wincent.com>
 <1195689773-28601-3-git-send-email-win@wincent.com>
 <1195689773-28601-4-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 01:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuzXy-0004Wi-Dk
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbXKVADd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbXKVADd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:03:33 -0500
Received: from wincent.com ([72.3.236.74]:56121 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbXKVADc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:03:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM02s0X030459;
	Wed, 21 Nov 2007 18:03:01 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195689773-28601-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65718>

Tweak the documentation to reflect that git-add--interactive can now
accept multiple path parameters.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-add.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 4b44802..0675dbe 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -61,9 +61,9 @@ OPTIONS
 
 -i, \--interactive::
 	Add modified contents in the working tree interactively to
-	the index. If a single optional file argument is supplied the
+	the index. If optional path arguments are supplied the
 	initial command loop is bypassed and the 'patch' subcommand is
-	invoked for the specified file. See ``Interactive mode'' below
+	invoked for each specified path. See ``Interactive mode'' below
 	for details.
 
 -u::
-- 
1.5.3.6.867.g539b6-dirty
