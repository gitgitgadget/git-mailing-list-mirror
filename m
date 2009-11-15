From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] Documentation: clarify 'ours' merge strategy
Date: Sun, 15 Nov 2009 19:25:30 +0100
Message-ID: <234d8bfd14ef0a90d4df16e00864058ff8ac8d38.1258309432.git.trast@student.ethz.ch>
References: <cover.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 19:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9joI-0003jh-2K
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbZKOS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 13:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZKOS0S
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:26:18 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7158 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbZKOS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 13:26:12 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:16 +0100
Received: from localhost.localdomain (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:15 +0100
X-Mailer: git-send-email 1.6.5.2.420.gf6c057.dirty
In-Reply-To: <cover.1258309432.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132948>

Make it clear in the docs that the merge takes the tree of HEAD and
ignores everything in the other branches.  This should hopefully clear
up confusion, usually caused by the user looking for a strategy that
resolves all conflict hunks in favour of HEAD (which is completely
different and currently not supported).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/merge-strategies.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 4365b7e..42910a3 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -29,8 +29,9 @@ octopus::
 	pulling or merging more than one branch.
 
 ours::
-	This resolves any number of heads, but the result of the
-	merge is always the current branch head.  It is meant to
+	This resolves any number of heads, but the resulting tree of the
+	merge is always that of the current branch head, effectively
+	ignoring all changes from all other branches.  It is meant to
 	be used to supersede old development history of side
 	branches.
 
-- 
1.6.5.2.420.gf6c057.dirty
