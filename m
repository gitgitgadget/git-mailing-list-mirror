From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] [TRIVIAL] Documentation: merge: one <remote> is required
Date: Tue, 11 Aug 2009 15:03:58 +0200
Message-ID: <1249995838.1589.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MarGt-0004Nq-KJ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbZHKNSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZHKNSp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:18:45 -0400
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:36665 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbZHKNSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:18:43 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2009 09:18:43 EDT
Received: from [212.123.169.34] (helo=[192.168.1.61])
	by smtp-out3.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1Mar1E-0007TQ-DD; Tue, 11 Aug 2009 15:04:00 +0200
X-Mailer: Evolution 2.27.5 (2.27.5-3.kb.1.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125554>

merge only requires one <remote>, so "<remote>..." should be used in the
synopsis (and not "<remote> <remote>...").

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 Documentation/git-merge.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c04ae73..af68d69 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
-	[-m <msg>] <remote> <remote>...
+	[-m <msg>] <remote>...
 'git merge' <msg> HEAD <remote>...
 
 DESCRIPTION
-- 
1.6.4
