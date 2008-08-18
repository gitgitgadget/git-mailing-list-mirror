From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] Update t/.gitignore to ignore all trash directories
Date: Mon, 18 Aug 2008 12:25:40 -0400
Message-ID: <1219076740-24236-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:27:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV7Z8-0007mm-2c
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 18:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbYHRQZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbYHRQZl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 12:25:41 -0400
Received: from boohaunt.net ([209.40.206.144]:57581 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbYHRQZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 12:25:41 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 42C811878ACB; Mon, 18 Aug 2008 12:25:40 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc3.286.gd4df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92711>

The current .gitignore only ignores the old "trash directory" and
not the new "trash directory.[test]".  This ignores both forms.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 t/.gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index b27e280..7dcbb23 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,2 +1,2 @@
-/trash directory
+/trash directory*
 /test-results
-- 
1.6.0.rc3.286.gd4df
