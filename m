From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-daemon documentation: use {tilde}
Date: Tue, 16 Dec 2008 16:48:12 +0100
Message-ID: <1229442492-11993-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 16:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCc9M-0004I1-BX
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 16:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbYLPPqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 10:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756075AbYLPPqh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 10:46:37 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:51926 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbYLPPqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 10:46:37 -0500
Received: from vmobile.example.net (dsl5402CEC5.pool.t-online.hu [84.2.206.197])
	by yugo.frugalware.org (Postfix) with ESMTPA id F2E89446CDE;
	Tue, 16 Dec 2008 16:46:33 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 171DE19DBE1; Tue, 16 Dec 2008 16:48:13 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103283>

Use '{tilde}' instead of '~', becase the later does not appear in the
manpage version, just in the HTML one.

Noticed by gonzzor on IRC.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-daemon.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index f1a570a..36f00ae 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -110,9 +110,9 @@ OPTIONS
 
 --user-path::
 --user-path=path::
-	Allow ~user notation to be used in requests.  When
+	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
-	git://host/~alice/foo is taken as a request to access
+	git://host/{tilde}alice/foo is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
 	If `--user-path=path` is specified, the same request is
 	taken as a request to access `path/foo` repository in
-- 
1.6.1.rc1.35.gae26e.dirty
