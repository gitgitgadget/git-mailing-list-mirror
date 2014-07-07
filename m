From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 04/10] Documentation: replace: add --graft option
Date: Mon, 07 Jul 2014 08:35:33 +0200
Message-ID: <20140707063540.3708.57293.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X42Xo-0007iA-2T
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 08:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaGGGgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 02:36:47 -0400
Received: from [194.158.98.14] ([194.158.98.14]:57005 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751401AbaGGGgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 02:36:36 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id F2A556E;
	Mon,  7 Jul 2014 08:36:14 +0200 (CEST)
X-git-sha1: 07c07a7aa534b81ad8663917efb3eb0b8873ab74 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252956>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.0.0.421.g786a89d.dirty
