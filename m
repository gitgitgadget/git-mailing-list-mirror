From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/4] Documentation: adjust document title underlining
Date: Sat, 11 Oct 2014 23:37:33 +0000
Message-ID: <1413070656-241955-2-git-send-email-sandals@crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 01:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd6Eb-0004Lp-7H
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 01:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbaJKXh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 19:37:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49219 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752224AbaJKXhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 19:37:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5D8AE28090
	for <git@vger.kernel.org>; Sat, 11 Oct 2014 23:37:42 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_FILL_THIS_FORM_SHORT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AsciiDoc specification states that in two-line titles, the title
underline has to be the same length as the title text, plus or minus two
characters.  Asciidoctor, however, requires that this must be plus or
minus one character.  Adjust the underlines to be the same length as the
title text to improve compatibility.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-prune-packed.txt | 2 +-
 Documentation/git-quiltimport.txt  | 2 +-
 Documentation/git-stage.txt        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 6738055..9fed59a 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -1,5 +1,5 @@
 git-prune-packed(1)
-=====================
+===================
 
 NAME
 ----
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index a356196..d64388c 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -1,5 +1,5 @@
 git-quiltimport(1)
-================
+==================
 
 NAME
 ----
diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index ba3fe0d..25bcda9 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -1,5 +1,5 @@
 git-stage(1)
-==============
+============
 
 NAME
 ----
-- 
2.1.1
