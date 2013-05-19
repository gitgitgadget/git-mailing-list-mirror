From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 1/2] config doc: add dot-repository note
Date: Sun, 19 May 2013 12:54:08 +0100
Message-ID: <1368964449-2724-2-git-send-email-philipoakley@iee.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 19 13:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Bf-00070D-6F
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3ESLx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:53:58 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:27090 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754289Ab3ESLx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:53:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtULAIK8mFFZ8YNG/2dsb2JhbABbgwiDAr5kBAF9F3SCIAEFVjMISTkeBhOIEbt5jgSBJINUA6h4gxA7
X-IronPort-AV: E=Sophos;i="4.87,703,1363132800"; 
   d="scan'208";a="72637075"
Received: from host-89-241-131-70.as13285.net (HELO localhost) ([89.241.131.70])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 19 May 2013 12:53:56 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224868>

branch.<name>.remote can be set to '.' (period) as a dot repository
as part of the remote name dwimmery. Tell the reader.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/config.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..fd42509 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -734,6 +734,8 @@ branch.<name>.remote::
 	overridden by `branch.<name>.pushremote`.  If no remote is
 	configured, or if you are not on any branch, it defaults to
 	`origin` for fetching and `remote.pushdefault` for pushing.
+	Additionally, a `.` (period) means the current local repository
+	(a dot-repository), see `branch.<name>.merge`'s final note below.
 
 branch.<name>.pushremote::
 	When on branch <name>, it overrides `branch.<name>.remote` for
-- 
1.8.1.msysgit.1
