From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (topgit) 2/2] tg-completion: complete options for `tg remote`
Date: Mon,  5 Jan 2009 18:08:20 +0300
Message-ID: <954f3890c44839e0fe3f6bcbb8d477efc35292c8.1231167904.git.kirr@landau.phys.spbu.ru>
References: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 16:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJrUj-000682-Sb
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 16:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbZAEPeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 10:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbZAEPeO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 10:34:14 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1640 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZAEPeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 10:34:12 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 941E917B6B7; Mon,  5 Jan 2009 18:07:03 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LJr40-0001ao-HN; Mon, 05 Jan 2009 18:08:20 +0300
X-Mailer: git-send-email 1.6.1.40.g8ea6a
In-Reply-To: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
References: <cover.1231167904.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104578>

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 contrib/tg-completion.bash |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 4d69c05..9641d04 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -369,6 +369,11 @@ _tg_remote ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
 	case "$cur" in
+	-*)
+		__tgcomp "
+			--populate
+		"
+		;;
 	*)
 		__tgcomp "$(__tg_remotes)"
 	esac
-- 
1.6.1.40.g8ea6a
