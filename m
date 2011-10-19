From: mhagger@alum.mit.edu
Subject: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Wed, 19 Oct 2011 20:52:16 +0200
Message-ID: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 20:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGbFp-0004uK-GS
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab1JSSwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 14:52:36 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60374 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab1JSSwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 14:52:36 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGb9l-0003ge-9L; Wed, 19 Oct 2011 20:46:25 +0200
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183940>

From: Michael Haggerty <mhagger@alum.mit.edu>

One of the "^" characters was not coming through in the man page.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-show-ref.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 3c45895..87f358d 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -44,7 +44,7 @@ OPTIONS
 -d::
 --dereference::
 
-	Dereference tags into object IDs as well. They will be shown with "^{}"
+	Dereference tags into object IDs as well. They will be shown with "{caret}\{\}"
 	appended.
 
 -s::
@@ -75,7 +75,7 @@ OPTIONS
 	Make 'git show-ref' act as a filter that reads refs from stdin of the
 	form "^(?:<anything>\s)?<refname>(?:{backslash}{caret}\{\})?$"
 	and performs the following actions on each:
-	(1) strip "^{}" at the end of line if any;
+	(1) strip "{caret}\{\}" at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
 	(3) warn if refname is not a well-formed refname and skip;
 	(4) ignore if refname is a ref that exists in the local repository;
-- 
1.7.7
