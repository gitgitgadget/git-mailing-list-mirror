From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] run-command documentation: add 4 missing slashes
Date: Sat, 14 Jun 2008 03:01:59 +0200
Message-ID: <1213405319-25256-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 03:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7KAM-0006VM-K7
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 03:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbYFNBB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 21:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757091AbYFNBB5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 21:01:57 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52752 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbYFNBB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 21:01:56 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 1F0B61DDC5B;
	Sat, 14 Jun 2008 03:01:55 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2680018DFDC; Sat, 14 Jun 2008 03:01:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84957>

When initializing the struct async and struct child_process structures,
the documentation suggested "clearing" the structure with '0' instead of
'\0'.

Also asciidoc would parse '\0' as a markup, changing it to \'0' prevents
this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/technical/api-run-command.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index c364a22..6591db9 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -63,7 +63,7 @@ command to run in a sub-process.
 
 The caller:
 
-1. allocates and clears (memset(&chld, '0', sizeof(chld));) a
+1. allocates and clears (memset(&chld, \'\0', sizeof(chld));) a
    struct child_process variable;
 2. initializes the members;
 3. calls start_command();
@@ -136,7 +136,7 @@ to produce output that the caller reads.
 
 The caller:
 
-1. allocates and clears (memset(&asy, '0', sizeof(asy));) a
+1. allocates and clears (memset(&asy, \'\0', sizeof(asy));) a
    struct async variable;
 2. initializes .proc and .data;
 3. calls start_async();
-- 
1.5.6.rc2.dirty
