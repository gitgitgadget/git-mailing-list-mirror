From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Correct shebang line for contrib/stats/packinfo.pl
Date: Thu, 12 Jul 2007 09:16:11 -0500
Message-ID: <11842497711330-git-send-email-bdowning@lavos.net>
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 16:16:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8zSq-0007MJ-Jr
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 16:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXGLOQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 10:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760683AbXGLOQK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 10:16:10 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:53996 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762916AbXGLOQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 10:16:09 -0400
Received: by silvara (Postfix, from userid 1000)
	id CEB6252133; Thu, 12 Jul 2007 09:16:11 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52293>

"/bin/perl"?  What was I thinking?

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 contrib/stats/packinfo.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
index 792673a..aab501e 100755
--- a/contrib/stats/packinfo.pl
+++ b/contrib/stats/packinfo.pl
@@ -1,4 +1,4 @@
-#!/bin/perl
+#!/usr/bin/perl
 #
 # This tool will print vaguely pretty information about a pack.  It
 # expects the output of "git-verify-pack -v" as input on stdin.
-- 
1.5.2.GIT
