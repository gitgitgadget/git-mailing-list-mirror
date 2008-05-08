From: Dustin Sallings <dustin@spy.net>
Subject: [PATCH] Doc: Mention branch.<name>.rebase applies to "git pull"
Date: Thu,  8 May 2008 11:28:07 -0700
Message-ID: <1210271287-36719-2-git-send-email-dustin@spy.net>
References: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, Dustin Sallings <dustin@spy.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 20:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuArg-0007Qc-G5
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYEHS2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbYEHS2R
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:28:17 -0400
Received: from basket.west.spy.net ([69.230.8.154]:57995 "EHLO
	mail.west.spy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbYEHS2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 14:28:16 -0400
Received: from localhost.localdomain (dsl092-049-060.sfo4.dsl.speakeasy.net [66.92.49.60])
	by mail.west.spy.net (Postfix) with ESMTP id 0C6257D;
	Thu,  8 May 2008 11:28:15 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.100.g65b98
In-Reply-To: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81549>

Signed-off-by: Dustin Sallings <dustin@spy.net>
---
 Documentation/config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6413f70..44bd20b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -441,7 +441,8 @@ branch.<name>.mergeoptions::
 
 branch.<name>.rebase::
 	When true, rebase the branch <name> on top of the fetched branch,
-	instead of merging the default branch from the default remote.
+	instead of merging the default branch from the default remote when
+	"git pull" is run.
 	*NOTE*: this is a possibly dangerous operation; do *not* use
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
-- 
1.5.5.1.100.g65b98
