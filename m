From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (topgit) 1/2] tg-completion: complete options for `tg summary`
Date: Mon,  5 Jan 2009 18:08:19 +0300
Message-ID: <0de9cf9b84a63a4c33714806aa7eb70cb0d77021.1231167904.git.kirr@landau.phys.spbu.ru>
References: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 16:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJrUe-000682-6e
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 16:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbZAEPeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 10:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbZAEPeN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 10:34:13 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1642 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZAEPeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 10:34:12 -0500
X-Greylist: delayed 1626 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jan 2009 10:34:11 EST
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 70EE117B6B2; Mon,  5 Jan 2009 18:07:03 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LJr40-0001aj-Gg; Mon, 05 Jan 2009 18:08:20 +0300
X-Mailer: git-send-email 1.6.1.40.g8ea6a
In-Reply-To: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
References: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104576>

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 contrib/tg-completion.bash |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 67f820e..4d69c05 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -376,7 +376,15 @@ _tg_remote ()
 
 _tg_summary ()
 {
-	COMPREPLY=()
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	*)
+		__tgcomp "
+			--graphviz
+			-t
+		"
+	esac
 }
 
 _tg_update ()
-- 
1.6.1.40.g8ea6a
