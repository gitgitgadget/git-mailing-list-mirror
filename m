From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V2 1/3] Doc URLs: relative paths imply the dot-respository
Date: Fri, 13 Sep 2013 22:23:15 +0100
Message-ID: <1379107397-964-2-git-send-email-philipoakley@iee.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
 <1379107397-964-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 23:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKapw-0003am-Nq
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 23:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab3IMVXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 17:23:12 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:47794 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753932Ab3IMVXK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 17:23:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnQHABmBM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgESiAe5MI9xB4QeA6lugyU7
X-IPAS-Result: AnQHABmBM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgESiAe5MI9xB4QeA6lugyU7
X-IronPort-AV: E=Sophos;i="4.90,900,1371078000"; 
   d="scan'208";a="441146855"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 13 Sep 2013 22:23:09 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379107397-964-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234772>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/urls.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9ccb246..5350a63 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -55,6 +55,13 @@ These two syntaxes are mostly equivalent, except the former implies
 --local option.
 endif::git-clone[]
 
+Relative paths are relative to the `$GIT_DIR`, thus the path:
+
+- '.'
+
+is the current repository and acts as if it were a repository
+named `'.'`.
+
 When Git doesn't know how to handle a certain transport protocol, it
 attempts to use the 'remote-<transport>' remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
-- 
1.8.1.msysgit.1
