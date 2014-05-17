From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/10] Documentation: replace: describe new --edit option
Date: Sat, 17 May 2014 08:41:32 +0200
Message-ID: <20140517064133.18932.96622.chriscool@tuxfamily.org>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 08:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYLg-0006qT-Sa
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129AbaEQGnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:43:53 -0400
Received: from [194.158.98.45] ([194.158.98.45]:61592 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756985AbaEQGnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:43:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id ACDB86C;
	Sat, 17 May 2014 08:43:14 +0200 (CEST)
X-git-sha1: c8708e5afdfedc7c27601233f0c1022f7ecffec1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249447>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 0a02f70..37d872d 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git replace' [-f] <object> <replacement>
+'git replace' [-f] --edit <object>
 'git replace' -d <object>...
 'git replace' [--format=<format>] [-l [<pattern>]]
 
@@ -63,6 +64,14 @@ OPTIONS
 --delete::
 	Delete existing replace refs for the given objects.
 
+--edit <object>::
+	Launch an editor to let the user change the content of
+	<object>, then create a new object of the same type with the
+	changed content, and create a replace ref to replace <object>
+	with the new object. See linkgit:git-commit[1] and
+	linkgit:git-var[1] for details about how the editor will be
+	chosen.
+
 -l <pattern>::
 --list <pattern>::
 	List replace refs for objects that match the given pattern (or
@@ -92,7 +101,9 @@ CREATING REPLACEMENT OBJECTS
 
 linkgit:git-filter-branch[1], linkgit:git-hash-object[1] and
 linkgit:git-rebase[1], among other git commands, can be used to create
-replacement objects from existing objects.
+replacement objects from existing objects. The `--edit` option can
+also be used with 'git replace' to create a replacement object by
+editing an existing object.
 
 If you want to replace many blobs, trees or commits that are part of a
 string of commits, you may just want to create a replacement string of
@@ -117,6 +128,8 @@ linkgit:git-filter-branch[1]
 linkgit:git-rebase[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
+linkgit:git-commit[1]
+linkgit:git-var[1]
 linkgit:git[1]
 
 GIT
-- 
1.9.rc0.17.g651113e
