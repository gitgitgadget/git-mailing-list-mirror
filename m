From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 1/2] doc: command line interface (cli) dot-repository dwimmery
Date: Sat, 21 Sep 2013 16:11:08 +0100
Message-ID: <1379776269-4496-2-git-send-email-philipoakley@iee.org>
References: <1379776269-4496-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 17:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNOpS-0007pg-J5
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 17:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3IUPKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 11:10:12 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52297 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752353Ab3IUPKL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 11:10:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArwGAGG2PVJOl3GZ/2dsb2JhbABbgweuWJQSgRoXdIImAQVWIxAISTkeBgESiAm6fI9lB4QeA6lzgyU7
X-IPAS-Result: ArwGAGG2PVJOl3GZ/2dsb2JhbABbgweuWJQSgRoXdIImAQVWIxAISTkeBgESiAm6fI9lB4QeA6lzgyU7
X-IronPort-AV: E=Sophos;i="4.90,952,1371078000"; 
   d="scan'208";a="442604118"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 21 Sep 2013 16:10:09 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379776269-4496-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235122>

The Git cli will accept dot '.' (period) as the relative path,
and thus the current repository. Explain this action.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

This updates 431260cc8dd

 Documentation/gitcli.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index b065c0e..50e4ce0 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -58,10 +58,10 @@ the paths in the index that match the pattern to be checked out to your
 working tree.  After running `git add hello.c; rm hello.c`, you will _not_
 see `hello.c` in your working tree with the former, but with the latter
 you will.
-+
-Just as the filesystem '.' (period) refers to the current directory,
-using a '.' as a repository name in Git (a dot-repository) is a relative
-path for your current repository.
+
+ * Just as the filesystem '.' (period) refers to the current directory,
+   using a '.' as a repository name in Git (a dot-repository) is a relative
+   path and hence will be your current repository.
 
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
-- 
1.8.1.msysgit.1
