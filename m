From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git merge documentation: -m is optional
Date: Mon, 5 Feb 2007 12:37:27 +0100
Message-ID: <20070205113727.GB27077@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 12:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE2A9-00054m-Rz
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 12:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXBELha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 06:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbXBELha
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 06:37:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:59748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932095AbXBELha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 06:37:30 -0500
Received: (qmail invoked by alias); 05 Feb 2007 11:37:28 -0000
Received: from pD9EB951F.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.149.31]
  by mail.gmx.net (mp032) with SMTP; 05 Feb 2007 12:37:28 +0100
X-Authenticated: #5358227
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38743>

Changed -m=<msg> to -m <msg> too.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/git-merge.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3c08a6f..e53ff4b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-merge' [-n] [--no-commit] [--squash] [-s <strategy>]...
-	-m=<msg> <remote> <remote>...
+	[-m <msg>] <remote> <remote>...
 
 DESCRIPTION
 -----------
-- 
1.5.0.rc3.544.g79b8
