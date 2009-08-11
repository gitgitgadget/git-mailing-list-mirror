From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] [TRIVIAL] Documentation: add: <filepattern>... is optional
Date: Tue, 11 Aug 2009 15:03:10 +0200
Message-ID: <1249995790.1589.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MarHd-0004lx-1i
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZHKNUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbZHKNUn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:20:43 -0400
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:36949 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZHKNUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:20:43 -0400
Received: from [212.123.169.34] (helo=[192.168.1.61])
	by smtp-out3.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1Mar0d-0007Pr-23; Tue, 11 Aug 2009 15:03:23 +0200
X-Mailer: Evolution 2.27.5 (2.27.5-3.kb.1.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125555>

<filepattern>... is optional (e.g. when the --all or --update
options are used) so use square brackets in the synopsis.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 Documentation/git-add.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ab1943c..e67b7e8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
-	  [--refresh] [--ignore-errors] [--] <filepattern>...
+	  [--refresh] [--ignore-errors] [--] [<filepattern>...]
 
 DESCRIPTION
 -----------
-- 
1.6.4
