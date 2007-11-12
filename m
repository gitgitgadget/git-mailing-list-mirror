From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Sun, 11 Nov 2007 19:57:56 -0500
Message-ID: <1194829077-14320-1-git-send-email-tytso@mit.edu>
References: <20071111235819.GB7392@thunk.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 02:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNeu-0004wL-BR
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 02:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbXKLA75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 19:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbXKLA74
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:59:56 -0500
Received: from thunk.org ([69.25.196.29]:60681 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbXKLA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:59:54 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IrNn8-0002jN-VB; Sun, 11 Nov 2007 20:10:34 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IrNcj-0003jJ-7Y; Sun, 11 Nov 2007 19:57:57 -0500
X-Mailer: git-send-email 1.5.3.5.623.g91546-dirty
In-Reply-To: <20071111235819.GB7392@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64546>

Remove apply, archive, cherry-pick, prune, revert, and show-branch, so
"git help" is less intimidating.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 generate-cmdlist.sh |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 17df47b..1ba27ec 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -11,12 +11,9 @@ static struct cmdname_help common_cmds[] = {"
 
 sort <<\EOF |
 add
-apply
-archive
 bisect
 branch
 checkout
-cherry-pick
 clone
 commit
 diff
@@ -26,15 +23,12 @@ init
 log
 merge
 mv
-prune
 pull
 push
 rebase
 reset
-revert
 rm
 show
-show-branch
 status
 tag
 EOF
-- 
1.5.3.5.623.g91546-dirty
