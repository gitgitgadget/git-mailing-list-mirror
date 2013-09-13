From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V2 2/3] config doc: update dot-repository notes
Date: Fri, 13 Sep 2013 22:23:16 +0100
Message-ID: <1379107397-964-3-git-send-email-philipoakley@iee.org>
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
	id 1VKapx-0003am-P8
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 23:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab3IMVX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 17:23:29 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:40791 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754308Ab3IMVXL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 17:23:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnQHAI+BM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgESiAe5Po9xB4QeA6lugyU7
X-IPAS-Result: AnQHAI+BM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgESiAe5Po9xB4QeA6lugyU7
X-IronPort-AV: E=Sophos;i="4.90,900,1371078000"; 
   d="scan'208";a="588341511"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 13 Sep 2013 22:23:10 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379107397-964-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234773>

branch.<name>.remote can be set to '.' (period) as the repository
path (URL) as part of the remote name dwimmery. Tell the reader.

Such relative paths are not 'special'. Correct the branch.<name>.merge
note.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/config.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 599ca52..da63043 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -718,6 +718,8 @@ branch.<name>.remote::
 	overridden by `branch.<name>.pushremote`.  If no remote is
 	configured, or if you are not on any branch, it defaults to
 	`origin` for fetching and `remote.pushdefault` for pushing.
+	Additionally, `.` (a period) is the current local repository
+	(a dot-repository), see `branch.<name>.merge`'s final note below.
 
 branch.<name>.pushremote::
 	When on branch <name>, it overrides `branch.<name>.remote` for
@@ -743,8 +745,8 @@ branch.<name>.merge::
 	Specify multiple values to get an octopus merge.
 	If you wish to setup 'git pull' so that it merges into <name> from
 	another branch in the local repository, you can point
-	branch.<name>.merge to the desired branch, and use the special setting
-	`.` (a period) for branch.<name>.remote.
+	branch.<name>.merge to the desired branch, and use the relative path
+	setting `.` (a period) for branch.<name>.remote.
 
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
-- 
1.8.1.msysgit.1
