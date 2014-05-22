From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 3/3] Documentation: replace: add --graft option
Date: Thu, 22 May 2014 23:33:06 +0200
Message-ID: <20140522213307.27162.3251.chriscool@tuxfamily.org>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 07:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnhjK-0008LM-0g
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 07:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaEWFJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 01:09:12 -0400
Received: from [194.158.98.45] ([194.158.98.45]:42029 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751603AbaEWFJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 01:09:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id CDCC150;
	Fri, 23 May 2014 07:08:40 +0200 (CEST)
X-git-sha1: c49a664207974aca93b90491f6341b30ba2daa04 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140522211836.27162.80311.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249974>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 61461b9..491875e 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git replace' [-f] <object> <replacement>
 'git replace' [-f] --edit <object>
+'git replace' [-f] --graft <commit> [<parent>...]
 'git replace' -d <object>...
 'git replace' [--format=<format>] [-l [<pattern>]]
 
@@ -73,6 +74,13 @@ OPTIONS
 	newly created object. See linkgit:git-var[1] for details about
 	how the editor will be chosen.
 
+--graft <commit> [<parent>...]::
+	Create a graft commit. A new commit is created with the same
+	content as <commit> except that its parents will be
+	[<parent>...] instead of <commit>'s parents. A replacement ref
+	is then created to replace <commit> with the newly created
+	commit.
+
 -l <pattern>::
 --list <pattern>::
 	List replace refs for objects that match the given pattern (or
-- 
1.9.rc0.17.g651113e
