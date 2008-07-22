From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-filter-branch: Remove Useless Use of
	Plumbing
Date: Wed, 23 Jul 2008 00:24:35 +0200
Message-ID: <20080722222418.15372.62190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 23 00:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLQIk-0007M5-HQ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 00:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbYGVWYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 18:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYGVWYr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 18:24:47 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:56514 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754088AbYGVWYq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 18:24:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 790A52ACC76;
	Wed, 23 Jul 2008 00:24:35 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89553>

The example to remove file using index-filter uses git update-index
 --remove where git rm --cached works as well.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index a3edc00..7ba9dab 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -191,7 +191,7 @@ Thus you may instead want to use `rm -f filename` as the script.
 A significantly faster version:
 
 --------------------------------------------------------------------------
-git filter-branch --index-filter 'git update-index --remove filename' HEAD
+git filter-branch --index-filter 'git rm --cached filename' HEAD
 --------------------------------------------------------------------------
 
 Now, you will get the rewritten history saved in HEAD.
