From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] bash completion: add 'rename' subcommand to git-remote
Date: Mon, 22 Dec 2008 03:56:16 +0100
Message-ID: <200812220356.17253.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 22 03:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEb0q-000730-SN
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYLVC4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYLVC4K
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:56:10 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:46714 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYLVC4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:56:09 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 330C7F5B152F;
	Mon, 22 Dec 2008 03:56:08 +0100 (CET)
Received: from [91.19.14.55] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LEaxk-0000OZ-00; Mon, 22 Dec 2008 03:56:08 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19b/mBhD2UDbNsV/iR5EYG7HZj+51jABbl56LFQ
	LQiCV9PUN46hVspEtxMts4aDkR9jinhtZssKeE6/YRKphJkoOu
	Dj0EyDRno1jZm/nHB8Ew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103742>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 108859e..e0d96f3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1367,7 +1367,7 @@ _git_config ()
 
 _git_remote ()
 {
-	local subcommands="add rm show prune update"
+	local subcommands="add rename rm show prune update"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -1375,7 +1375,7 @@ _git_remote ()
 	fi
 
 	case "$subcommand" in
-	rm|show|prune)
+	rename|rm|show|prune)
 		__gitcomp "$(__git_remotes)"
 		;;
 	update)
-- 
1.6.1.rc3.64.ga0b5a
