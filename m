From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Document git-ls-tree --full-tree
Date: Tue, 30 Dec 2008 07:18:18 +0900
Message-ID: <20081230071818.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 23:21:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQTc-0005iM-82
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbYL2WTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYL2WTK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:19:10 -0500
Received: from karen.lavabit.com ([72.249.41.33]:59654 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbYL2WTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 17:19:08 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id A2E3DC8421;
	Mon, 29 Dec 2008 16:19:05 -0600 (CST)
Received: from 7042.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id OMWQL50B8CP6; Mon, 29 Dec 2008 16:19:05 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=e1T1gxxVUXDjJDPfVcAv7VRysrFswpuzGTpsxb1otNb+MebqUOppU4U5wEhZpjlUYRr7aF26KVsJJH1b4TM4S6HJw77TmBXN2r9v8eJZmvOQJdm9OY3860AduzbSWZ16dfLx9svTi35juCyMHWViIDq4ngifBrGYbMFF60lowTM=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104134>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/git-ls-tree.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 4c7262f..db6ebcc 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
+	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=[<n>]]
 	    <tree-ish> [paths...]
 
 DESCRIPTION
@@ -30,6 +30,8 @@ in the current working directory.  Note that:
    'sub/dir' in 'HEAD').  You don't want to give a tree that is not at the
    root level (e.g. 'git ls-tree -r HEAD:sub dir') in this case, as that
    would result in asking for 'sub/sub/dir' in the 'HEAD' commit.
+   However, the current working directory can be ignored by passing
+   --full-tree option.
 
 OPTIONS
 -------
@@ -66,6 +68,10 @@ OPTIONS
 	Instead of showing the path names relative to the current working
 	directory, show the full path names.
 
+--full-tree::
+	Do not limit the listing to the current working directory.
+	Implies --full-name.
+
 paths::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
-- 
1.6.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
