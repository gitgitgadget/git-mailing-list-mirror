From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Sat, 13 Dec 2008 20:08:08 +0100
Message-ID: <200812132008.08543.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 13 20:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBZry-00080v-Kv
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 20:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYLMTIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbYLMTIN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 14:08:13 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48470 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYLMTIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 14:08:10 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id F00E7FA897BB;
	Sat, 13 Dec 2008 20:08:08 +0100 (CET)
Received: from [91.19.61.9] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LBZqS-0001fa-00; Sat, 13 Dec 2008 20:08:08 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/vtlIwVtnKygZXF1WuVHaKaXYP2BQACacWkW2z
	BtZGe/qlmjgta31WcPVyuP3n1hsVcHxvawxK/SfEy2XL9gcFOh
	kB4q+swXz16xd0EiLq8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103011>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c79c98f..9e0c48b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -835,7 +835,7 @@ _git_gc ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--prune --aggressive"
+		__gitcomp "--aggressive"
 		return
 		;;
 	esac
-- 
1.6.1.rc1.54.gd1643
