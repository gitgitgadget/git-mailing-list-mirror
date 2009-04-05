From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/3] doc/merge-config: list ecmerge as a built-in merge tool
Date: Sun, 5 Apr 2009 14:42:27 +0200
Message-ID: <200904051442.27683.markus.heidelberg@web.de>
References: <200904051440.33154.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 14:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqRhg-0004TC-0w
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 14:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbZDEMmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 08:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbZDEMmZ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 08:42:25 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52971 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZDEMmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 08:42:24 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 89E06F9FF1B8;
	Sun,  5 Apr 2009 14:42:22 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqRg6-0003Zu-00; Sun, 05 Apr 2009 14:42:22 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904051440.33154.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/4DelNrczKb1g+0oXuU/oDC1dJGQfALyFAo0MK
	qpPDJ+Bb54nCjxttAplQn3EvnOuitNwCYwdHcvDq6u9gWwEDwu
	O9thc1/inWpOYpp5/7dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115659>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/merge-config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 1ff08ff..9c44af8 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -22,7 +22,8 @@ merge.stat::
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
+	"ecmerge" and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
-- 
1.6.2.2.460.g49e5c
