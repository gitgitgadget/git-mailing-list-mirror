From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v2 2/5] git-add.txt: document 'interactive.singlekey'
Date: Mon,  2 May 2011 15:44:29 +0200
Message-ID: <1304343872-1654-3-git-send-email-valentin.haenel@gmx.de>
References: <20110501045140.GA13387@sigill.intra.peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 02 15:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGtS0-0007Ni-0X
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 15:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721Ab1EBNqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 09:46:06 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:38714 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757695Ab1EBNqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 09:46:03 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p42DjjSi002111;
	Mon, 2 May 2011 15:45:45 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p42Djjfe002110;
	Mon, 2 May 2011 15:45:45 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110501045140.GA13387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172587>

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/git-add.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 7eebbef..c172989 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -86,6 +86,9 @@ OPTIONS
 This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
++
+The configuration `interactive.singlekey` allows the user to provide
+one-letter input with a single key in this mode (i.e., without hitting enter).
 
 -e, \--edit::
 	Open the diff vs. the index in an editor and let the user
-- 
1.7.1
