From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: receive.denyCurrentBranch defaults to 'refuse'
Date: Wed, 17 Mar 2010 12:14:57 +0100
Message-ID: <601e919ea039016fb58543eeee6717a03bf453d5.1268824465.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 12:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrrDP-0000Fg-4P
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 12:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab0CQLO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 07:14:59 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:54101 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367Ab0CQLO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 07:14:58 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Mar
 2010 12:14:55 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Mar
 2010 12:14:56 +0100
X-Mailer: git-send-email 1.7.0.2.454.gdb120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142373>

acd2a45 (Refuse updating the current branch in a non-bare repository
via push, 2009-02-11) changed the default to refuse such a push, but
it forgot to update the docs.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---


 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 48d8825..b3b6544 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1535,7 +1535,7 @@ receive.denyCurrentBranch::
 	out of sync with the index and working tree. If set to "warn",
 	print a warning of such a push to stderr, but allow the push to
 	proceed. If set to false or "ignore", allow such pushes with no
-	message. Defaults to "warn".
+	message. Defaults to "refuse".
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
-- 
1.7.0.2.454.gdb120
