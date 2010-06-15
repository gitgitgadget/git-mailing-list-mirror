From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] rerere.txt: Document forget subcommand
Date: Tue, 15 Jun 2010 08:21:06 +0200
Message-ID: <ebd2b2b5bb3352c6204f181416a7a521f8c6abf7.1276582759.git.git@drmicha.warpmail.net>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 08:21:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOPWs-0001zI-GV
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 08:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0FOGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 02:21:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53977 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916Ab0FOGVk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 02:21:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F2331F8A1D;
	Tue, 15 Jun 2010 02:21:39 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 15 Jun 2010 02:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=HaAwDugytGq1abthJ/eLYV5FYbQ=; b=Yfw/oo3uYt3B7B70f+VJZwozlFOPuYCwTi9gicnd0j4/r5XmugBOUyTww8I+CNl4WCfI/eBXBrWKDJrEktgd0oAm02BAZNdAAe51twCFhqvpKGuA9ItvSvPL3YF9Ac+Si+Qm1NkwjIEcvyyFX86JgGKkD8lfZW+CqNqNZuPQx5s=
X-Sasl-enc: 0Sk+GgMx3VkAhFPowDfc+FjGdKszVGC9MBwzcz2GidJR 1276582899
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 64CB045E98;
	Tue, 15 Jun 2010 02:21:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.511.gfbed4
In-Reply-To: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149160>

dea4562 (rerere forget path: forget recorded resolution, 2009-12-25)
introduced the forget subcommand for rerere.

Document it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rerere.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index acc220a..a7370d3 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,7 +7,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 
 SYNOPSIS
 --------
-'git rerere' ['clear'|'diff'|'status'|'gc']
+'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
 
 DESCRIPTION
 -----------
@@ -40,6 +40,10 @@ This resets the metadata used by rerere if a merge resolution is to be
 aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--abort]'
 will automatically invoke this command.
 
+'forget' <pathspec>::
+
+This resets the conflict resolutions which rerere has recorded for <pathspec>.
+
 'diff'::
 
 This displays diffs for the current state of the resolution.  It is
-- 
1.7.1.511.gfbed4
