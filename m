From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] Documentation/replace: add Creating Replacement Objects
 section
Date: Sun, 25 Aug 2013 15:06:08 +0200
Message-ID: <20130825130609.4681.95932.chriscool@tuxfamily.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 15:06:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDa1p-0003bG-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 15:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab3HYNGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 09:06:40 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:62422 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345Ab3HYNGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 09:06:37 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id CEBD269;
	Sun, 25 Aug 2013 15:06:36 +0200 (CEST)
X-git-sha1: 3b26ec0137efd30f1784c7449b3612bef44614e6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232958>

There were no hints in the documentation about how to create
replacement objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index aa66d27..736b48c 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -64,6 +64,19 @@ OPTIONS
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
@@ -76,6 +89,9 @@ pending objects.
 
 SEE ALSO
 --------
+linkgit:git-hash-object[1]
+linkgit:git-filter-branch[1]
+linkgit:git-rebase[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
 linkgit:git[1]
-- 
1.8.4.rc1.24.g13dc82a
