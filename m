From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: bug fixes (some resends)
Date: Sun, 11 Jun 2006 00:03:40 -0700
Message-ID: <11500094252972-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 11 09:04:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJzM-0005iD-HR
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 09:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFKHDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 03:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWFKHDs
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 03:03:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:28593 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750725AbWFKHDr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 03:03:47 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 02EA07DC005;
	Sun, 11 Jun 2006 00:03:45 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Jun 2006 00:03:45 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g2dc7b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21637>


[PATCH 1/5] git-svn: t0000: add -f flag to checkout
[PATCH 2/5] git-svn: fix handling of filenames with embedded '@'
	These two are resends, patch 2 only affects 1.1.0-pre.

[PATCH 3/5] git-svn: eol_cp corner-case fixes
	Kinda urgent (but only affects 1.1.0-pre)

[PATCH 4/5] git-svn: restore original LC_ALL setting (or unset) for commit
	For people that want to commit UTF-8 commit messages.

[PATCH 5/5] git-svn: don't allow commit if svn tree is not current
	Extra sanity check, just in case.
