From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/5] Documentation/replace: state that objects must be of
 the same type
Date: Tue, 27 Aug 2013 21:48:24 +0200
Message-ID: <20130827194828.11172.75730.chriscool@tuxfamily.org>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPGX-0006qj-0S
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab3H0TtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:49:03 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:53250 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab3H0TtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:49:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 314937A;
	Tue, 27 Aug 2013 21:48:59 +0200 (CEST)
X-git-sha1: 5eb1803fdf6c150bb294d9b70429beb2c8a60421 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233153>

A previous patch ensures that both the replaced and the replacement
objects passed to git replace must be of the same type.

While at it state that there is no other restriction on both objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index e0b4057..aa66d27 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -20,6 +20,9 @@ The name of the 'replace' reference is the SHA-1 of the object that is
 replaced. The content of the 'replace' reference is the SHA-1 of the
 replacement object.
 
+The replaced object and the replacement object must be of the same type.
+There is no other restriction on them.
+
 Unless `-f` is given, the 'replace' reference must not yet exist.
 
 Replacement references will be used by default by all Git commands
@@ -69,9 +72,7 @@ go back to a replaced commit will move the branch to the replacement
 commit instead of the replaced commit.
 
 There may be other problems when using 'git rev-list' related to
-pending objects. And of course things may break if an object of one
-type is replaced by an object of another type (for example a blob
-replaced by a commit).
+pending objects.
 
 SEE ALSO
 --------
-- 
1.8.4.rc1.26.gdd51ee9
