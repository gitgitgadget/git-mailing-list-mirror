From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/4] Documentation: replace: add --graft option
Date: Fri, 06 Jun 2014 22:25:34 +0200
Message-ID: <20140606202536.3722.22418.chriscool@tuxfamily.org>
References: <20140606201741.3722.96819.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 08:45:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtANI-0000k1-Dj
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 08:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbaFGGoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 02:44:54 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:51167 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaFGGoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 02:44:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B415A5E;
	Sat,  7 Jun 2014 08:44:44 +0200 (CEST)
X-git-sha1: 9684a5140cba6b964e12fad2cf706d5a637c017f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140606201741.3722.96819.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251025>

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
2.0.0.rc0.40.gd30ccc4
