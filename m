From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH] Documentation/git-am.txt: Pass -r in the example
	invocation of rm -f .dotest
Date: Mon, 25 Feb 2008 17:43:40 -0500
Message-ID: <20080225224340.GA8860@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 23:54:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmDa-0002gR-FU
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 23:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866AbYBYWyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 17:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758527AbYBYWyD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 17:54:03 -0500
Received: from satoko.is.fushizen.net ([64.71.152.231]:48697 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758184AbYBYWyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 17:54:01 -0500
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2008 17:54:01 EST
Received: from bryan-donlan.um.maine.edu ([130.111.184.236] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JTm2w-0005e3-1f; Mon, 25 Feb 2008 22:43:42 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JTm2u-0002Kn-O1; Mon, 25 Feb 2008 17:43:40 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75084>

>From 7cd3c1e333a5176dbae209630d6fac15539777c0 Mon Sep 17 00:00:00 2001
From: Bryan Donlan <bdonlan@fushizen.net>
Date: Mon, 25 Feb 2008 17:40:19 -0500
Subject: [PATCH] Documentation/git-am.txt: Pass -r in the example invocation of rm -f .dotest
 Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>

---
 Documentation/git-am.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 2ffba21..8c96b53 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -138,7 +138,7 @@ aborts in the middle,.  You can recover from this in one of two ways:
 
 The command refuses to process new mailboxes while `.dotest`
 directory exists, so if you decide to start over from scratch,
-run `rm -f .dotest` before running the command with mailbox
+run `rm -rf .dotest` before running the command with mailbox
 names.
 
 
-- 
1.5.3.8
