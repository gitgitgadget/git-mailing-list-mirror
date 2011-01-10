From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH maint] Documentation/githooks: post-rewrite-copy-notes never existed
Date: Mon, 10 Jan 2011 13:42:23 +0100
Message-ID: <9012ee1af6ed9872a679c6d82c6003d1be6859a6.1294663222.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 13:43:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcH5b-0006dc-JR
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 13:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab1AJMm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 07:42:27 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50272 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab1AJMmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 07:42:25 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 13:42:23 +0100
Received: from localhost.localdomain (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 13:42:24 +0100
X-Mailer: git-send-email 1.7.4.rc1.309.g58aa0
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164873>

The documentation for the post-rewrite hook contains a paragraph from
its early development, where the automatic notes copying facilities
were not part of the series and thus this had to be a hook.  Later
versions of the series implemented notes copying as a core feature.

Thus mentioning post-rewrite-copy-notes was never correct.  As the
other hooks do not have a "there is no default hook, but..." sentence
unless they ship a sample hook in either templates or contrib, we
simply remove the whole paragraph.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/githooks.txt |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7183aa9..28edefa 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -350,10 +350,6 @@ rebase::
 The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
-There is no default 'post-rewrite' hook, but see the
-`post-receive-copy-notes` script in `contrib/hooks` for an example
-that copies your git-notes to the rewritten commits.
-
 
 GIT
 ---
-- 
1.7.4.rc1.309.g58aa0
