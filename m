From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t/README: document --root option
Date: Thu, 10 Jun 2010 20:24:46 +0200
Message-ID: <c5efa5c15498fe562af98b9b16165127bc1690c2.1276193888.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:24:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmQz-0006iO-8I
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab0FJSYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:24:49 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43009 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902Ab0FJSYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:24:48 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 20:24:48 +0200
Received: from localhost.localdomain (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 20:24:48 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148904>

We've had this option since f423ef5 (tests: allow user to specify
trash directory location, 2009-08-09).  Make it easier to look up :-)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/README |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index dcd3ebb..0470c14 100644
--- a/t/README
+++ b/t/README
@@ -84,6 +84,12 @@ appropriately before running "make".
 	implied by other options like --valgrind and
 	GIT_TEST_INSTALLED.
 
+--root=<directory>::
+	Use <directory> as a trash directory to store all temporary
+	data during testing, instead of the t/ directory itself.
+	Using this option with a RAM-based filesystem (such as tmpfs)
+	can massively speed up the test suite.
+
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
 You still need to have built this git sandbox, from which various
-- 
1.7.1.553.ga798e
