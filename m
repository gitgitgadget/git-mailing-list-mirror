From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Correct ^0 asciidoc syntax in fast-import docs.
Date: Thu, 8 Feb 2007 02:58:45 -0500
Message-ID: <20070208075844.GA3950@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:58:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4BA-0006D2-NK
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbXBHH6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 02:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161533AbXBHH6t
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:58:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60200 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161461AbXBHH6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 02:58:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HF4B4-0008FI-BJ; Thu, 08 Feb 2007 02:58:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 58F2620FBAE; Thu,  8 Feb 2007 02:58:45 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39039>

I wrote this documentation with asciidoc 7.1.2, but apparently
asciidoc 8 assumes ^ means superscript.  The solution was already
documented in rev-parse's manpage and is to use {caret} instead.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fast-import.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 0b64d33..0c44761 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -380,9 +380,9 @@ current branch value should be written as:
 ----
 	from refs/heads/branch^0
 ----
-The `^0` suffix is necessary as gfi does not permit a branch to
+The `{caret}0` suffix is necessary as gfi does not permit a branch to
 start from itself, and the branch is created in memory before the
-`from` command is even read from the input.  Adding `^0` will force
+`from` command is even read from the input.  Adding `{caret}0` will force
 gfi to resolve the commit through Git's revision parsing library,
 rather than its internal branch table, thereby loading in the
 existing value of the branch.
-- 
1.5.0.rc3.175.g6506
