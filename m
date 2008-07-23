From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] am --abort: Add to bash-completion and mention in git-rerere documentation
Date: Wed, 23 Jul 2008 02:10:25 +0200
Message-ID: <1216771825-21457-1-git-send-email-s-beyer@gmx.net>
References: <4882350B.6020003@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRx4-0004eJ-Ns
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbYGWAKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYGWAKb
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:10:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:34571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750983AbYGWAKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:10:30 -0400
Received: (qmail invoked by alias); 23 Jul 2008 00:10:28 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 23 Jul 2008 02:10:28 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+V5nNjY3KVwt5J136FJTnFu9raaE+8XCtreZmu30
	yYxHixMqPdpCEb
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLRw1-0005ag-2T; Wed, 23 Jul 2008 02:10:25 +0200
X-Mailer: git-send-email 1.5.6.4.459.gfa44d
In-Reply-To: <4882350B.6020003@free.fr>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89573>

The git-rerere documentation talks about commands that invoke
"git rerere clear" automatically. git am --abort is added and
a typo is fixed additionally.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/git-rerere.txt           |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index beebd53..89f321b 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -37,7 +37,7 @@ its working state.
 'clear'::
 
 This resets the metadata used by rerere if a merge resolution is to be
-is aborted.  Calling 'git-am --skip' or 'git-rebase [--skip|--abort]'
+aborted.  Calling 'git-am [--skip|--abort]' or 'git-rebase [--skip|--abort]'
 will automatically invoke this command.
 
 'diff'::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2edb341..8fc9145 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -489,7 +489,7 @@ _git_am ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ]; then
-		__gitcomp "--skip --resolved"
+		__gitcomp "--skip --resolved --abort"
 		return
 	fi
 	case "$cur" in
-- 
1.5.6.4.459.gfa44d
