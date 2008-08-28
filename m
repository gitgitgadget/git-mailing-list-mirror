From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH] bash-completion: Add all submodule subcommands to the completion list
Date: Thu, 28 Aug 2008 10:57:55 +0200
Message-ID: <1219913875-20749-1-git-send-email-mk@spinlock.ch>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Matthias Kestenholz <mk@spinlock.ch>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 11:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYdSD-0005NI-0w
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 11:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbYH1JFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 05:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYH1JFE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 05:05:04 -0400
Received: from mail17.bluewin.ch ([195.186.18.64]:60361 "EHLO
	mail17.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbYH1JFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 05:05:03 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Aug 2008 05:05:03 EDT
X-FXIT-IP: IPv4[85.1.198.122] Epoch[1219913876]
Received: from [85.1.198.122] ([85.1.198.122:6387] helo=localhost.localdomain)
	by mail17.bluewin.ch (envelope-from <mk@spinlock.ch>)
	(ecelerity 2.2.2.32 r(25176)) with ESMTP
	id 3B/2A-11150-39866B84; Thu, 28 Aug 2008 08:57:56 +0000
X-Mailer: git-send-email 1.6.0.174.gd789c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matthias Kestenholz <mk@spinlock.ch>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 89858c2..4f64f8a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1483,7 +1483,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init update"
+	local subcommands="add status init update summary foreach sync"
 	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
 		local cur="${COMP_WORDS[COMP_CWORD]}"
 		case "$cur" in
-- 
1.6.0.174.gd789c
