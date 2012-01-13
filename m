From: mhagger@alum.mit.edu
Subject: [PATCH v2 2/2] git-show-ref doc: typeset regexp in fixed width font
Date: Fri, 13 Jan 2012 17:39:16 +0100
Message-ID: <1326472756-15227-3-git-send-email-mhagger@alum.mit.edu>
References: <1326472756-15227-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 17:39:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlkAF-0001Bk-JL
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 17:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758500Ab2AMQja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 11:39:30 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:45606 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab2AMQjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 11:39:25 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1Rlk07-0007wV-3U; Fri, 13 Jan 2012 17:29:11 +0100
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326472756-15227-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188519>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Optional; I think it looks better.

 Documentation/git-show-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 8dfcbe3..fcee000 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -73,7 +73,7 @@ OPTIONS
 --exclude-existing[=<pattern>]::
 
 	Make 'git show-ref' act as a filter that reads refs from stdin of the
-	form "{caret}(?:<anything>\s)?<refname>(?:{backslash}{caret}{})?$"
+	form "`{caret}(?:<anything>\s)?<refname>(?:{backslash}{caret}{})?$`"
 	and performs the following actions on each:
 	(1) strip "{caret}{}" at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
-- 
1.7.8.3
