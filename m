From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v3 3/5] git-reset.txt: better docs for '--patch'
Date: Thu,  5 May 2011 20:48:46 +0200
Message-ID: <1304621328-17184-3-git-send-email-valentin.haenel@gmx.de>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3e5-0006jm-Qw
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164Ab1EESvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:51:24 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:60246 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:51:24 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45Ins3a017260;
	Thu, 5 May 2011 20:49:54 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45Ins9b017259;
	Thu, 5 May 2011 20:49:54 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172876>

* Include '-p' in the synopsis.
* Include a better wording for what 'git reset -p' does.
  (interactively unstage hunks)
* Include a link to the git-add manpage for a description of the patch-mode.

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Mentored-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-reset.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 8481f9d..b6ed0c7 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<commit>] [--] <paths>...
-'git reset' --patch [<commit>] [--] [<paths>...]
+'git reset' --patch|-p [<commit>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
@@ -39,8 +39,9 @@ working tree in one go.
 	and <commit> (defaults to HEAD).  The chosen hunks are applied
 	in reverse to the index.
 +
-This means that `git reset -p` is the opposite of `git add -p` (see
-linkgit:git-add[1]).
+This means that `git reset -p` is the opposite of `git add -p`, i.e.
+you can use it to selectively unstage hunks. See the ``Interactive Mode''
+section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 
 'git reset' [--<mode>] [<commit>]::
 	This form resets the current branch head to <commit> and
-- 
1.7.1
