From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/6] Remove the "windows isn't supported" remark from README
Date: Mon,  4 Aug 2008 19:47:16 -0700
Message-ID: <1217904436-1989-7-git-send-email-spearce@spearce.org>
References: <1217904436-1989-1-git-send-email-spearce@spearce.org>
 <1217904436-1989-2-git-send-email-spearce@spearce.org>
 <1217904436-1989-3-git-send-email-spearce@spearce.org>
 <1217904436-1989-4-git-send-email-spearce@spearce.org>
 <1217904436-1989-5-git-send-email-spearce@spearce.org>
 <1217904436-1989-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCbV-0006tq-F8
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589AbYHECrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbYHECrb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:31 -0400
Received: from george.spearce.org ([209.20.77.23]:45387 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434AbYHECrX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DFCC238448; Tue,  5 Aug 2008 02:47:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 39A6738446;
	Tue,  5 Aug 2008 02:47:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217904436-1989-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91413>

The Windows support has come a long way since this was written
into the README.  We actually (mostly) support repositories that
were created on Cygwin, even if they used --shared to setup object
alternates with Cygwin paths, and we honor the user's Cygwin home
directory for configuration and SSH keys.  Windows is about as well
supported as one can get on Java.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 README |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 334f3d5..dd4a910 100644
--- a/README
+++ b/README
@@ -174,10 +174,6 @@ partial files simple.
 
 - Documentation. :-)
 
-- Windows support is new and very ligthly tested. Do not blame us if
-  it blows, but tell us about it and what you did. Double check
-  everything.
-
 - gitattributes support
   In particular CRLF conversion is not implemented. Files are treated
   as byte sequences.
-- 
1.6.0.rc1.250.g9b5e2
