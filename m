From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/4] Documentation: replace: add --graft option
Date: Sun, 01 Jun 2014 17:10:36 +0200
Message-ID: <20140601151038.15428.11090.chriscool@tuxfamily.org>
References: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 17:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr7QU-0000Wm-92
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 17:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbaFAPLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 11:11:38 -0400
Received: from [194.158.98.15] ([194.158.98.15]:42108 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752271AbaFAPLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 11:11:36 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 3F07358;
	Sun,  1 Jun 2014 17:11:12 +0200 (CEST)
X-git-sha1: 9349e6f8264f331b73ef11eda2b47f3e26347202 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250530>

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
