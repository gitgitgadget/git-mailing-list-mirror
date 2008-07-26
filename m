From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: Add long options for 'git describe'
Date: Sat, 26 Jul 2008 12:26:56 +0200
Message-ID: <1217068016-10954-1-git-send-email-trast@student.ethz.ch>
References: <20080725162028.GB21117@spearce.org>
Cc: gitster@pobox.com, "Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 12:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMh0M-0003Js-CF
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 12:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYGZK1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 06:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYGZK1B
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 06:27:01 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:43893 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbYGZK1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 06:27:00 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 26 Jul 2008 12:26:58 +0200
Received: from localhost.localdomain ([84.75.148.145]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 26 Jul 2008 12:26:58 +0200
X-Mailer: git-send-email 1.6.0.rc0.50.g6a66e
In-Reply-To: <20080725162028.GB21117@spearce.org>
X-OriginalArrivalTime: 26 Jul 2008 10:26:58.0672 (UTC) FILETIME=[2272CF00:01C8EF0A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90204>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3b04934..4ae8b36 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -665,6 +665,15 @@ _git_commit ()
 
 _git_describe ()
 {
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--all --tags --contains --abbrev= --candidates=
+			--exact-match --debug --long --match --always
+			"
+		return
+	esac
 	__gitcomp "$(__git_refs)"
 }
 
-- 
1.6.0.rc0.50.g6a66e
