From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V2 3/3] doc: command line interface (cli) dot-repository dwimmery
Date: Fri, 13 Sep 2013 22:23:17 +0100
Message-ID: <1379107397-964-4-git-send-email-philipoakley@iee.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
 <1379107397-964-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 23:23:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKapx-0003am-8M
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 23:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab3IMVXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 17:23:18 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:32639 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754688Ab3IMVXM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 17:23:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnQHAI+BM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgESiAe5Po9xB4QeA6lugyU7
X-IPAS-Result: AnQHAI+BM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgESiAe5Po9xB4QeA6lugyU7
X-IronPort-AV: E=Sophos;i="4.90,900,1371078000"; 
   d="scan'208";a="436928833"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 13 Sep 2013 22:23:10 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379107397-964-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234770>

The Git cli will accept dot '.' (period) as the relative path
to the current repository. Explain this action.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/gitcli.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 7d54b77..b065c0e 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -58,6 +58,10 @@ the paths in the index that match the pattern to be checked out to your
 working tree.  After running `git add hello.c; rm hello.c`, you will _not_
 see `hello.c` in your working tree with the former, but with the latter
 you will.
++
+Just as the filesystem '.' (period) refers to the current directory,
+using a '.' as a repository name in Git (a dot-repository) is a relative
+path for your current repository.
 
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
-- 
1.8.1.msysgit.1
