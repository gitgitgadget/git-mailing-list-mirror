From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] bash completion: log --date, --no-date and --date=normal
Date: Tue, 28 Jul 2009 10:40:22 +0200
Message-ID: <81549fbc4542ee9a2ff1f3d216e3e592d30512b3.1248770042.git.trast@student.ethz.ch>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 10:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MViEo-0002f8-Gl
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZG1Iki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZG1Iki
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:40:38 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20204 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbZG1Ikg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:40:36 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 10:40:31 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 10:40:31 +0200
X-Mailer: git-send-email 1.6.4.rc3.218.g43757
In-Reply-To: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 28 Jul 2009 08:40:31.0414 (UTC) FILETIME=[10F2D560:01CA0F5F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124222>

The preceding patches made the argument to --date optional and
introduced --date=normal and --no-date.  Teach the bash completion
about this.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 745b5fb..4ddeacf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1143,7 +1143,7 @@ __git_log_shortlog_options="
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
-__git_log_date_formats="relative iso8601 rfc2822 short local default raw"
+__git_log_date_formats="relative iso8601 rfc2822 short local default raw normal"
 
 _git_log ()
 {
@@ -1178,7 +1178,7 @@ _git_log ()
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
 			--abbrev-commit --abbrev=
-			--relative-date --date=
+			--relative-date --date= --date --no-date
 			--pretty= --format= --oneline
 			--cherry-pick
 			--graph
-- 
1.6.4.rc3.218.gb7ac
