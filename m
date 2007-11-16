From: Sergei Organov <osv@javad.com>
Subject: [PATCH] Documentation: fix git-clone manpage not to refer to itself
Date: Fri, 16 Nov 2007 21:43:16 +0300
Message-ID: <87ejeq1131.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 19:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It6CN-0003mw-PZ
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 19:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbXKPSpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 13:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXKPSpe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 13:45:34 -0500
Received: from javad.com ([216.122.176.236]:3991 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbXKPSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 13:45:33 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAGIjSi60342;
	Fri, 16 Nov 2007 18:45:28 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1It6Bu-0005E6-O5; Fri, 16 Nov 2007 21:45:22 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65240>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/git-clone.txt |    1 +
 Documentation/urls.txt      |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 14e58f3..c90bcec 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -130,6 +130,7 @@ OPTIONS
 	for "host.xz:foo/.git").  Cloning into an existing directory
 	is not allowed.
 
+:git-clone: 1
 include::urls.txt[]
 
 Examples
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index e67f914..4f66738 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -36,5 +36,11 @@ To sync with a local directory, you can use:
 - file:///path/to/repo.git/
 ===============================================================
 
+ifndef::git-clone[]
 They are mostly equivalent, except when cloning.  See
 gitlink:git-clone[1] for details.
+endif::git-clone[]
+
+ifdef::git-clone[]
+They are equivalent, except the former implies --local option.
+endif::git-clone[]
-- 
1.5.3.4
