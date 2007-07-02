From: Jeff King <peff@peff.net>
Subject: [PATCH] git-stash: fix "no arguments" case in documentation
Date: Mon, 2 Jul 2007 00:20:06 -0400
Message-ID: <20070702042006.GA29384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 06:20:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5DOj-0007k2-MR
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 06:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbXGBEUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 00:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbXGBEUK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 00:20:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3520 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbXGBEUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 00:20:08 -0400
Received: (qmail 10740 invoked from network); 2 Jul 2007 04:20:29 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 04:20:29 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 00:20:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51340>

Commit 9488e875 changed this from 'save' to 'list', but
missed this spot in the documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-stash.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4815965..4dc344d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -21,8 +21,8 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git-stash list`, inspected with `git-stash show`, and restored
 (potentially on top of a different commit) with `git-stash apply`.
-The default operation when called without options is to save the
-changes away.
+Calling git-stash without any arguments is equivalent to `git-stash
+list`.
 
 The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
-- 
1.5.2.2.1452.g896f6
