From: maximilian attems <max@stro.at>
Subject: [PATCH] git-am: Document new --exclude=<file> option
Date: Tue,  9 Aug 2011 17:21:08 +0200
Message-ID: <1312903268-19994-1-git-send-email-max@stro.at>
Cc: Junio C Hamano <gitster@pobox.com>, maximilian attems <max@stro.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 17:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqo6Z-0000eX-Qw
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 17:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab1HIPU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 11:20:26 -0400
Received: from vostochny.stro.at ([78.47.22.85]:59624 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778Ab1HIPUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 11:20:25 -0400
Received: from stro.at (cp6.itp.tuwien.ac.at [128.131.48.206])
	by vostochny.stro.at (Postfix) with ESMTPA id 9FE21C14A;
	Tue,  9 Aug 2011 15:20:24 +0000 (UTC)
Received: by stro.at (Postfix, from userid 1000)
	id AF6F7161B66; Tue,  9 Aug 2011 17:21:18 +0200 (CEST)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179032>

--exclude is passed down to apply, document it as such.

Signed-off-by: maximilian attems <max@stro.at>
---
 Documentation/git-am.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

Had to break up a line, not sure if the chose way is the preferred.
Thank you.

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6b1b5af..62c8e3c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
+	 [--exclude=<file>] [--reject] [-q | --quiet]
+	 [--scissors | --no-scissors]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
@@ -87,6 +88,7 @@ default.   You can use `--no-utf8` to override this.
 -C<n>::
 -p<n>::
 --directory=<dir>::
+--exclude=<file>::
 --reject::
 	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
 	program that applies
-- 
1.7.5.4
