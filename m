From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rev-parse.txt: In @{date} spec mention that spaces can be substituted with dots
Date: Sun, 08 Feb 2009 15:01:44 +0200
Message-ID: <87iqnlxetj.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 14:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW9Ji-0002jF-QH
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 14:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbZBHNB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 08:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbZBHNB4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 08:01:56 -0500
Received: from main.gmane.org ([80.91.229.2]:36536 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbZBHNB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 08:01:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LW9IH-0004QE-2z
	for git@vger.kernel.org; Sun, 08 Feb 2009 13:01:53 +0000
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 13:01:53 +0000
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 13:01:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:oH9EIFXl9A6FH509ZOP9UhtruM0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108974>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rev-parse.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 3ccef2f..7a081b3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -193,7 +193,9 @@ when you run 'git-merge'.
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
-  of the ref at a prior point in time.  This suffix may only be
+  of the ref at a prior point in time. At shell prompt, enclose the
+  value in quotes due to embedded spaces. Alternatively the spaces can
+  be substituted with dots like in '\{1.hour.ago}\'. This suffix may only be
   used immediately following a ref name and the ref must have an
   existing log ($GIT_DIR/logs/<ref>). Note that this looks up the state
   of your *local* ref at a given time; e.g., what was in your local
-- 
1.5.6.5
