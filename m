From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v2 4/4] git-svn: Note about tags.
Date: Fri, 30 Nov 2012 08:16:30 +0100
Message-ID: <ce1aae1a3130b92e2253ce1d737036980ee8a67a.1354324110.git.Sebastian.Leske@sleske.name>
References: <cover.1354324110.git.Sebastian.Leske@sleske.name>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 12:00:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TekoD-0008Rq-1W
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 12:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab2LALAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 06:00:15 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:54871 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2LALAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 06:00:12 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id D7EC11F54A34;
	Sat,  1 Dec 2012 11:59:39 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tekn9-00040J-7C; Sat, 01 Dec 2012 11:59:27 +0100
In-Reply-To: <cover.1354324110.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210962>

Document that 'git svn' will import SVN tags as branches.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 6bda014..18d5e45 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -959,6 +959,13 @@ the possible corner cases (git doesn't do it, either).  Committing
 renamed and copied files is fully supported if they're similar enough
 for git to detect them.
 
+SVN tags (if tracked using options '--tags' or '--stdlayout') are
+imported as git branches, prefixing the tag name with 'tags/'.
+This is because tags in SVN behave more like git branches: The contents
+of a tag need not be identical to the tagged commit, and it is possible
+(though discouraged) to commit changes to a tag (because a tag is just a
+directory copy, thus technically the same as a branch).
+
 CONFIGURATION
 -------------
 
-- 
1.7.10.4
