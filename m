From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Documentation: Add create-ignore to git svn manual
Date: Mon,  5 May 2008 00:33:10 +0200
Message-ID: <1209940390-22622-2-git-send-email-hendeby@isy.liu.se>
References: <1209940390-22622-1-git-send-email-hendeby@isy.liu.se>
Cc: gitster@pobox.com, normalperson@yhbt.net,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 00:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmmU-0002W2-MC
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 00:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbYEDWdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYEDWdO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 18:33:14 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:63719 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbYEDWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 18:33:13 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 61EAB259B1;
	Mon,  5 May 2008 00:33:11 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 12443-10; Mon,  5 May 2008 00:33:10 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 263B42598F;
	Mon,  5 May 2008 00:33:10 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 1109C1779C; Mon,  5 May 2008 00:33:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.246.gafa4
In-Reply-To: <1209940390-22622-1-git-send-email-hendeby@isy.liu.se>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81209>


Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 Documentation/git-svn.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index bec9acc..f4ba105 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -188,6 +188,12 @@ All arguments are passed directly to `git blame'.
 	commit.  All merging is assumed to have taken place
 	independently of git-svn functions.
 
+'create-ignore'::
+
+	Recursively finds the svn:ignore property on directories and
+	creates matching .gitignore files. The resulting files are staged to
+	be committed, but are not committed.
+
 'show-ignore'::
 	Recursively finds and lists the svn:ignore property on
 	directories.  The output is suitable for appending to
-- 
1.5.5.1.246.gafa4
