From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git-rev-parse.txt: clarify meaning of rev~ and rev~0.
Date: Fri, 14 Mar 2008 20:20:06 +0300
Message-ID: <87wso5mcs7.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 18:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDmw-0004Xv-VO
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbYCNRdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbYCNRdK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:33:10 -0400
Received: from javad.com ([216.122.176.236]:1801 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613AbYCNRdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:33:09 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m2EHX3V04271;
	Fri, 14 Mar 2008 17:33:03 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JaDm4-00056k-C1; Fri, 14 Mar 2008 20:32:56 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77262>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/git-rev-parse.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6513c2e..0234f89 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -200,8 +200,9 @@ blobs contained in a commit.
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parent.  I.e. rev~3 is
   equivalent to rev{caret}{caret}{caret} which is equivalent to
-  rev{caret}1{caret}1{caret}1.  See below for a illustration of
-  the usage of this form.
+  rev{caret}1{caret}1{caret}1.  See below for an illustration of
+  the usage of this form.  'rev{tilde}' is equivalent to 'rev{tilde}0'
+  which in turn is equivalent to 'rev'.
 
 * A suffix '{caret}' followed by an object type name enclosed in
   brace pair (e.g. `v0.99.8{caret}\{commit\}`) means the object
-- 
1.5.4.4.551.g1658c
