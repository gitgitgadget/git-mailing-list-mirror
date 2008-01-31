From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] filter-branch docs: remove brackets so not to imply revision
 arg is optional
Date: Wed, 30 Jan 2008 18:41:25 -0600
Message-ID: <47A11935.6000707@nrlssc.navy.mil>
References: <47A109A7.1070502@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 01:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKNVO-0005jI-1n
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 01:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYAaAlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 19:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYAaAlm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 19:41:42 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41216 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYAaAll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 19:41:41 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0V0fPpo012313;
	Wed, 30 Jan 2008 18:41:25 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 18:41:25 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47A109A7.1070502@nrlssc.navy.mil>
X-OriginalArrivalTime: 31 Jan 2008 00:41:25.0712 (UTC) FILETIME=[0274CD00:01C863A2]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--8.395700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 
	150643-700160-704410-188019-707451-704568-702038-148039-148051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72082>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/git-filter-branch.txt |    2 +-
 git-filter-branch.sh                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e22dfa5..6145322 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
 	[--original <namespace>] [-d <directory>] [-f | --force]
-	[<rev-list options>...]
+	<rev-list options>
 
 DESCRIPTION
 -----------
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 25f18f8..7f71523 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -92,7 +92,7 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 [--msg-filter <command>] [--commit-filter <command>] \
 [--tag-name-filter <command>] [--subdirectory-filter <directory>] \
 [--original <namespace>] [-d <directory>] [-f | --force] \
-[<rev-list options>...]"
+<rev-list options>"
 
 OPTIONS_SPEC=
 . git-sh-setup
-- 
1.5.4.rc5.14.gaa8fc
