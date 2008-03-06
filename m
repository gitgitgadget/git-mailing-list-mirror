From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add more long options to be completed with "git --<TAB>"
Date: Thu,  6 Mar 2008 18:52:37 +0200
Message-ID: <1204822357-10210-1-git-send-email-tlikonen@iki.fi>
Cc: Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 06 17:53:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXJLJ-0004QW-U6
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 17:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763223AbYCFQwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 11:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764238AbYCFQwk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 11:52:40 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:51484 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763098AbYCFQwj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 11:52:39 -0500
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96002C8C35; Thu, 6 Mar 2008 17:52:38 +0100
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JXJKf-0002f0-1W; Thu, 06 Mar 2008 18:52:37 +0200
X-Mailer: git-send-email 1.5.4.3.451.g43956
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76399>

Add the following long options to be completed with command "git":

	--paginate
	--work-tree=
	--help

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

I'm not at all expert in bash completion code but this seems to work and can be
useful.

 contrib/completion/git-completion.bash |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49e6df0..1198547 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1194,11 +1194,14 @@ _git ()
 		case "${COMP_WORDS[COMP_CWORD]}" in
 		--*=*) COMPREPLY=() ;;
 		--*)   __gitcomp "
+			--paginate
 			--no-pager
 			--git-dir=
 			--bare
 			--version
 			--exec-path
+			--work-tree=
+			--help
 			"
 			;;
 		*)     __gitcomp "$(__git_commands) $(__git_aliases)" ;;
-- 
1.5.4.3.451.g43956

