From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH, resend] bash completion: add 'rename' subcommand to git-remote
Date: Thu, 8 Jan 2009 19:53:11 +0100
Message-ID: <200901081953.11236.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 20:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL01t-0000ph-FI
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761656AbZAHSxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 13:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761645AbZAHSw7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:52:59 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:49780 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761564AbZAHSw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 13:52:58 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 221C9F6518BF;
	Thu,  8 Jan 2009 19:52:57 +0100 (CET)
Received: from [89.59.114.169] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LL000-0005su-00; Thu, 08 Jan 2009 19:52:56 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19saFx+M0lGIhIjvLecrb45670VKqtTaD3i8AgP
	xwqBmDrkIjdOaRxC7yEJrAe+0Fz8Si30gQdN6C/RMwTjd3MT9S
	WvxWcOGnJiQ5NZPhld6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104950>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 187f3de..4717c93 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1369,7 +1369,7 @@ _git_config ()
 
 _git_remote ()
 {
-	local subcommands="add rm show prune update"
+	local subcommands="add rename rm show prune update"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -1377,7 +1377,7 @@ _git_remote ()
 	fi
 
 	case "$subcommand" in
-	rm|show|prune)
+	rename|rm|show|prune)
 		__gitcomp "$(__git_remotes)"
 		;;
 	update)
-- 
1.6.1.35.g0c23
