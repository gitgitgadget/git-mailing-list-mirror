From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH] Documentation: git-archive: mark --format as optional in summary
Date: Thu, 27 Aug 2009 17:08:40 -0600
Message-ID: <1251414520-28519-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 01:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgo5S-0001nh-E0
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 01:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbZH0XIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZH0XIt
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 19:08:49 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:38002 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750891AbZH0XIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 19:08:49 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 4F7D335A02;
	Fri, 28 Aug 2009 01:08:47 +0200 (CEST)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id A88BF2906CA;
	Thu, 27 Aug 2009 17:08:45 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 90BD32FD29; Thu, 27 Aug 2009 17:08:45 -0600 (MDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127233>

The --format option was made optional in v1.5.1-105-g8ff21b1, but it was
not marked as optional in the summary. This trival patch just changes
the summary to match the rest of the documentation.
---
 Documentation/git-archive.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc132c8..92444dd 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -9,7 +9,7 @@ git-archive - Create an archive of files from a named tree
 SYNOPSIS
 --------
 [verse]
-'git archive' --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
+'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
 	      [--output=<file>] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [path...]
-- 
1.6.3.3
