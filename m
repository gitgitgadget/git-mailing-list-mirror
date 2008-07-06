From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/5] hg-to-git: use git init instead of git init-db
Date: Sun,  6 Jul 2008 05:15:20 +0200
Message-ID: <b9e0cd170819882800fe1f0def7ac740a3176a7b.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
 <89a68bb21125c4ff706412cde5c04f5d96658789.1215313871.git.vmiklos@frugalware.org>
 <ca2e01fa1446afa551f5a6a36242a03d79cb685c.1215313871.git.vmiklos@frugalware.org>
 <5b692cd189e0afbd4b0e372f1671aa343dfb0d78.1215313871.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKjr-0000sb-Ny
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbYGFDPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 23:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbYGFDPT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:15:19 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57913 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbYGFDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 23:15:11 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 7481F1DDC5D;
	Sun,  6 Jul 2008 05:15:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AD8FF1A9CF3; Sun,  6 Jul 2008 05:15:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <5b692cd189e0afbd4b0e372f1671aa343dfb0d78.1215313871.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87490>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hg-to-git/hg-to-git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 61540ef..7b03204 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -152,7 +152,7 @@ for cset in range(1, int(tip) + 1):
 
 if not hgvers.has_key("0"):
     print 'creating repository'
-    os.system('git init-db')
+    os.system('git init')
 
 # loop through every hg changeset
 for cset in range(int(tip) + 1):
-- 
1.5.6.1.322.ge904b.dirty
