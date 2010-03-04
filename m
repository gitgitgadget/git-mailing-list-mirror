From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Thu, 04 Mar 2010 15:32:10 +0100
Message-ID: <m2tyswb1jp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 15:32:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnC69-00008d-Td
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 15:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab0CDOcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 09:32:18 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39659 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab0CDOcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 09:32:14 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 414B31C15A91
	for <git@vger.kernel.org>; Thu,  4 Mar 2010 15:32:11 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.166])
	by mail.m-online.net (Postfix) with ESMTP id AABE7901FA
	for <git@vger.kernel.org>; Thu,  4 Mar 2010 15:32:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.6.166]) (amavisd-new, port 10024)
	with ESMTP id M7c+rbHPEk2r for <git@vger.kernel.org>;
	Thu,  4 Mar 2010 15:32:10 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.30.ip-pool.NEFkom.net [83.171.145.30])
	by mail.mnet-online.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Thu,  4 Mar 2010 15:32:10 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 39130CA297; Thu,  4 Mar 2010 15:32:10 +0100 (CET)
X-Yow: HUMAN REPLICAS are inserted into VATS of NUTRITIONAL YEAST...
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141525>

The nested list in the description of the -t option wasn't properly
indented.  Additionally, make it a horizontal labeled list since the
labels are all short.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-ls-files.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..c0dc3ec 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -108,13 +108,14 @@ OPTIONS
 -t::
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
-	H::	cached
-	S::	skip-worktree
-	M::	unmerged
-	R::	removed/deleted
-	C::	modified/changed
-	K::	to be killed
-	?::	other
+[horizontal]
+	H:::	cached
+	S:::	skip-worktree
+	M:::	unmerged
+	R:::	removed/deleted
+	C:::	modified/changed
+	K:::	to be killed
+	?:::	other
 
 -v::
 	Similar to `-t`, but use lowercase letters for files
-- 
1.7.0.1


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
