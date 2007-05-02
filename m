From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-merge.1: Mention option -s at topic MERGE STRATEGIES
Date: Thu, 03 May 2007 02:01:35 +0300
Organization: Private
Message-ID: <1whyesog.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 01:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjNqB-0001So-80
	for gcvg-git@gmane.org; Thu, 03 May 2007 01:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767194AbXEBXCN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 19:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767193AbXEBXCN
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 19:02:13 -0400
Received: from main.gmane.org ([80.91.229.2]:36736 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767138AbXEBXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 19:02:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjNpm-0003zn-24
	for git@vger.kernel.org; Thu, 03 May 2007 01:02:06 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2007 01:02:06 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2007 01:02:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:Q0k0kVA0DpkR2cgtgCQi+9skm4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46051>

When the option is reminded at the same place as the explanation text,
this will help reader to associate these two. Sidenote: text may be
currently scrolled in a manual reader or HTML page to hide the
mentioned options at the beginning.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 9c08efa..fb0c9f7 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -38,7 +38,7 @@ include::merge-options.txt[]
 
 include::merge-strategies.txt[]
 
-
+The strategy is defined by supplying option '-s'.
 If you tried a merge which resulted in a complex conflicts and
 would want to start over, you can recover with
 gitlink:git-reset[1].
-- 
1.5.1.3
