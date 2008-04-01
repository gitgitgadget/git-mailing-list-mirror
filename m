From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/4] templates: add an example pre-auto-gc hook
Date: Tue, 1 Apr 2008 13:39:43 +0200
Message-ID: <3ab373c8a2bbe5d682852050fe0692c78fcc151b.1207049697.git.vmiklos@frugalware.org>
References: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgeqt-0002Ca-R0
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834AbYDALjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbYDALjp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:39:45 -0400
Received: from virgo.iok.hu ([193.202.89.103]:18406 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758834AbYDALjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:39:44 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4693C1B25A7;
	Tue,  1 Apr 2008 13:39:43 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D1E1B44659;
	Tue,  1 Apr 2008 13:36:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 255AF1190A3B; Tue,  1 Apr 2008 13:39:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78649>

it's empty by default.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 templates/hooks--pre-auto-gc |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 templates/hooks--pre-auto-gc

diff --git a/templates/hooks--pre-auto-gc b/templates/hooks--pre-auto-gc
new file mode 100644
index 0000000..8a9bf37
--- /dev/null
+++ b/templates/hooks--pre-auto-gc
@@ -0,0 +1,9 @@
+#!/bin/sh
+#
+# An example hook that is called by git-gc --auto with no arguments. The
+# hook should exit with non-zero status after issuing an appropriate
+# message if it wants to stop the auto repacking.
+#
+# To enable this hook, make this file executable.
+
+: Nothing
-- 
1.5.5.rc2.4.gec07.dirty
