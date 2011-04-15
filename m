From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] doc: Use the term "remark" in "cherry-pick -x" to disambiguate
 from "git notes"
Date: Fri, 15 Apr 2011 09:43:55 +0200
Message-ID: <4DA7F73B.9050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 09:44:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAdhO-0001e4-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 09:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab1DOHoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 03:44:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:48877 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754672Ab1DOHoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 03:44:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QAdhH-0001aN-7p
	for git@vger.kernel.org; Fri, 15 Apr 2011 09:44:07 +0200
Received: from berry.zib.de ([130.73.68.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 09:44:07 +0200
Received: from sschuberth by berry.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 09:44:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: berry.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171592>

The documentation for "cherry-pick -x" can be misread in the way that a
"git notes" object is attached to the new commit, which is not the case.
Instead, just some text is appended to the original commit message. Make this
more clear by simply using the term "remark" instead of "note".

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-cherry-pick.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 01db830..5afc2b0 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -52,8 +52,8 @@ OPTIONS
 
 -x::
 	When recording the commit, append to the original commit
-	message a note that indicates which commit this change
-	was cherry-picked from.  Append the note only for cherry
+	message a remark that indicates which commit this change
+	was cherry-picked from.  Append the remark only for cherry
 	picks without conflicts.  Do not use this option if
 	you are cherry-picking from your private branch because
 	the information is useless to the recipient.  If on the
-- 
1.7.3.2.msysgit.11
