From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v2 5/5] git-checkout.txt: document 'interactive.singlekey'
Date: Mon,  2 May 2011 15:44:32 +0200
Message-ID: <1304343872-1654-6-git-send-email-valentin.haenel@gmx.de>
References: <20110501045140.GA13387@sigill.intra.peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 02 15:46:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGtSA-0007UC-0O
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 15:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807Ab1EBNqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 09:46:11 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:38721 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812Ab1EBNqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 09:46:10 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p42Djjva002123;
	Mon, 2 May 2011 15:45:45 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p42Djj1H002122;
	Mon, 2 May 2011 15:45:45 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110501045140.GA13387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172591>

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/git-checkout.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1063f69..556c82b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -63,6 +63,9 @@ Using `-f` will ignore these unmerged entries.  The contents from a
 specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
++
+The configuration `interactive.singlekey` allows the user to provide
+one-letter input with a single key when using `--patch` (i.e., without hitting enter).
 
 OPTIONS
 -------
-- 
1.7.1
