From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/7] Documentation/replace: add Creating Replacement
 Objects section
Date: Fri, 06 Sep 2013 07:10:57 +0200
Message-ID: <20130906051100.6657.16629.chriscool@tuxfamily.org>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoLK-0005O4-8Q
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776Ab3IFFMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:12:17 -0400
Received: from [194.158.98.14] ([194.158.98.14]:38064 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750754Ab3IFFL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:56 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 9B97450;
	Fri,  6 Sep 2013 07:11:35 +0200 (CEST)
X-git-sha1: dbb64178b79908a93fe18c9b09bb5192220c3363 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234026>

There were no hints in the documentation about how to create
replacement objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index d198006..a2bd2ee 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -66,6 +66,19 @@ OPTIONS
 	Typing "git replace" without arguments, also lists all replace
 	refs.
 
+CREATING REPLACEMENT OBJECTS
+----------------------------
+
+linkgit:git-filter-branch[1], linkgit:git-hash-object[1] and
+linkgit:git-rebase[1], among other git commands, can be used to create
+replacement objects from existing objects.
+
+If you want to replace many blobs, trees or commits that are part of a
+string of commits, you may just want to create a replacement string of
+commits and then only replace the commit at the tip of the target
+string of commits with the commit at the tip of the replacement string
+of commits.
+
 BUGS
 ----
 Comparing blobs or trees that have been replaced with those that
@@ -78,6 +91,9 @@ pending objects.
 
 SEE ALSO
 --------
+linkgit:git-hash-object[1]
+linkgit:git-filter-branch[1]
+linkgit:git-rebase[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
 linkgit:git[1]
-- 
1.8.4.rc1.28.ge2684af
