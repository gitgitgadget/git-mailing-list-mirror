From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] v2: Checklist clarifications: added "Commits", "Patch:" headings
Date: Mon, 30 Apr 2007 19:04:25 +0300
Organization: Private
Message-ID: <y7k9x306.fsf_-_@cante.net>
References: <r6q2xgws.fsf@cante.net>
	<Pine.LNX.4.64.0704301333400.29859@racer.site>
	<abwqxe6t.fsf@cante.net>
	<Pine.LNX.4.64.0704301306340.2279@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 18:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiYOH-0006Cl-Vp
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 18:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423599AbXD3QFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423600AbXD3QF3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 12:05:29 -0400
Received: from main.gmane.org ([80.91.229.2]:51280 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423751AbXD3QFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 12:05:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HiYNF-0007Cw-1s
	for git@vger.kernel.org; Mon, 30 Apr 2007 18:05:13 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 18:05:13 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 18:05:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:9r0CSdC7nC4OseZr+Y9rM+yezXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45871>


>From e65853b7bede747912a51fd77d5cf62fb255b116 Mon Sep 17 00:00:00 2001
From: Jari Aalto <jari.aalto@cante.net>
Date: Mon, 30 Apr 2007 18:57:25 +0300
Subject: [PATCH] Checklist clarifications: added Commits, Patch: headings

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 This is version 2 of the orignal patch. Corrected according
 to Julian Phillips's comments.

 Documentation/SubmittingPatches |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2386f49..6a4da2d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -1,5 +1,7 @@
 Checklist (and a short version for the impatient):
 
+	Commits:
+
 	- make commits of logical units
 	- check for unnecessary whitespace with "git diff --check"
 	  before committing
@@ -12,8 +14,14 @@ Checklist (and a short version for the impatient):
 	  commit message (or just use the option "-s" when
 	  committing) to confirm that you agree to the Developer's
 	  Certificate of Origin
-	- do not PGP sign your patch
+
+	Patch:
+
 	- use "git format-patch -M" to create the patch
+	- send your patch to <git@vger.kernel.org>. If you use
+	  git-send-email(1), please test it first by sending
+	  email to yourself.
+	- do not PGP sign your patch
 	- do not attach your patch, but read in the mail
 	  body, unless you cannot teach your mailer to
 	  leave the formatting of the patch alone.
-- 
1.5.1.2.GIT
