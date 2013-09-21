From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 2/2] Doc URLs: relative paths imply the dot-respository
Date: Sat, 21 Sep 2013 16:11:09 +0100
Message-ID: <1379776269-4496-3-git-send-email-philipoakley@iee.org>
References: <1379776269-4496-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 17:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNOpT-0007pg-Kt
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 17:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab3IUPKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 11:10:22 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59965 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752395Ab3IUPKM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 11:10:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArwGAGG2PVJOl3GZ/2dsb2JhbABbgweuWJQSgRoXdIImAQVWIxAISTkeBgESiAm6fI9lB4QeA6lzgyU7
X-IPAS-Result: ArwGAGG2PVJOl3GZ/2dsb2JhbABbgweuWJQSgRoXdIImAQVWIxAISTkeBgESiAm6fI9lB4QeA6lzgyU7
X-IronPort-AV: E=Sophos;i="4.90,952,1371078000"; 
   d="scan'208";a="442604119"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 21 Sep 2013 16:10:09 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379776269-4496-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235124>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/urls.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9ccb246..3469e8b 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -55,6 +55,14 @@ These two syntaxes are mostly equivalent, except the former implies
 --local option.
 endif::git-clone[]
 
+Relative paths are relative to the current directory. Hence while the
+path:
+
+- '.'
+
+is the current directory, it is also the current repository and acts
+as if it were a repository named `'.'`.
+
 When Git doesn't know how to handle a certain transport protocol, it
 attempts to use the 'remote-<transport>' remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
-- 
1.8.1.msysgit.1
