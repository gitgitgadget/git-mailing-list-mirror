From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] t/README: --valgrind already implies -v
Date: Sun, 31 Mar 2013 10:00:15 +0200
Message-ID: <b8b1ac77b7b81a37ff2918b5d9ec1dae8e364ee1.1364716452.git.trast@inf.ethz.ch>
References: <cover.1364716452.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 10:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMDCE-0005O3-4P
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 10:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab3CaIAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 04:00:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:15920 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543Ab3CaIA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 04:00:29 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:26 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.251) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:26 +0200
X-Mailer: git-send-email 1.8.2.467.gedf93a5
In-Reply-To: <cover.1364716452.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219603>

From: Thomas Rast <trast@inf.ethz.ch>

This was missed in 3da9365 (Tests: let --valgrind imply --verbose and
--tee, 2009-02-04).

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/README b/t/README
index e4128e5..bc7253c5 100644
--- a/t/README
+++ b/t/README
@@ -95,8 +95,7 @@ appropriately before running "make".
 --valgrind::
 	Execute all Git binaries with valgrind and exit with status
 	126 on errors (just like regular tests, this will only stop
-	the test script when running under -i).  Valgrind errors
-	go to stderr, so you might want to pass the -v option, too.
+	the test script when running under -i).
 
 	Since it makes no sense to run the tests with --valgrind and
 	not see any output, this option implies --verbose.  For
-- 
1.8.2.467.gedf93a5
