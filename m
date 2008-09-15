From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documenation: git-bundle: quote tildes that cause subscript
Date: Mon, 15 Sep 2008 11:19:57 +0200
Message-ID: <1221470398-8698-2-git-send-email-trast@student.ethz.ch>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 11:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfAGs-0006I0-N8
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYIOJUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 05:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbYIOJUJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 05:20:09 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:47761 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbYIOJUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 05:20:06 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Sep 2008 11:20:03 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Sep 2008 11:20:03 +0200
X-Mailer: git-send-email 1.6.0.2.451.ga9ffc
In-Reply-To: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Sep 2008 09:20:03.0095 (UTC) FILETIME=[3C0BA270:01C91714]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95895>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-bundle.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..fc229f6 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -79,11 +79,11 @@ SPECIFYING REFERENCES
 
 'git-bundle' will only package references that are shown by
 'git-show-ref': this includes heads, tags, and remote heads.  References
-such as master~1 cannot be packaged, but are perfectly suitable for
+such as master{tilde}1 cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g., ^master~10), or implicitly (e.g.,
+specified explicitly (e.g., ^master{tilde}10), or implicitly (e.g.,
 master~10..master, master --since=10.days.ago).
 
 It is very important that the basis used be held by the destination.
-- 
1.6.0.2.451.ga9ffc
