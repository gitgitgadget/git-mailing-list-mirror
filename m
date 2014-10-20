From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/3] Documentation: adjust document title underlining
Date: Mon, 20 Oct 2014 00:20:36 +0000
Message-ID: <1413764438-297386-2-git-send-email-sandals@crustytoothpaste.net>
References: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 02:21:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg0ik-0006xT-19
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 02:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbaJTAUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 20:20:51 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49407 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964AbaJTAUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 20:20:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 39BD628090;
	Mon, 20 Oct 2014 00:20:46 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
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
