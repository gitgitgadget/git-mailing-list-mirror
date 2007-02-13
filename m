From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git merge documentation: -m is optional
Date: Tue, 13 Feb 2007 10:46:12 +0100
Message-ID: <20070213094612.GA6110@moooo.ath.cx>
References: <20070205113727.GB27077@moooo.ath.cx> <20070212170757.GA20826@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 10:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGuEt-0005ye-LA
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 10:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbXBMJqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 04:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965483AbXBMJqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 04:46:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:52477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965480AbXBMJqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 04:46:16 -0500
Received: (qmail invoked by alias); 13 Feb 2007 09:46:14 -0000
X-Provags-ID: V01U2FsdGVkX18AzRIdfdoAvYzZKyVuneZjHOWbxgM+/b9Z3EiMrB
	dBfw==
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070212170757.GA20826@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39505>

Changed -m=<msg> to -m <msg> too.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Here it is again.
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

