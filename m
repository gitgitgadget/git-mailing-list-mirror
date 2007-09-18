From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Documentation/git-svn: updated design philosophy notes
Date: Tue, 18 Sep 2007 16:50:42 -0700
Message-ID: <20070918235042.GA11992@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:50:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXmqC-0006zn-NN
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXIRXur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXIRXur
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:50:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51673 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbXIRXur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:50:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A66037DC029;
	Tue, 18 Sep 2007 16:50:42 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58661>

This section has not been updated in a while and
--branches/--tags/--trunk options are commonly used nowadays.

Noticed-by: Lars Hjemli <hjemli@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

  Eric Wong <normalperson@yhbt.net> wrote:
  > Lars Hjemli <hjemli@gmail.com> wrote:
  > > When updating git-svn.txt, I noticed that we might want to update the
  > > section "DESIGN PHILOSOPHY". Eric?
  > 
  > Yeah.  That's very much out of date.  I'll update it in a bit.

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index be2e34e..e157c6a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -478,11 +478,12 @@ previous commits in SVN.
 DESIGN PHILOSOPHY
 -----------------
 Merge tracking in Subversion is lacking and doing branched development
-with Subversion is cumbersome as a result.  git-svn does not do
-automated merge/branch tracking by default and leaves it entirely up to
-the user on the git side.  git-svn does however follow copy
-history of the directory that it is tracking, however (much like
-how 'svn log' works).
+with Subversion can be cumbersome as a result.  While git-svn can track
+copy history (including branches and tags) for repositories adopting a
+standard layout, it cannot yet represent merge history that happened
+inside git back upstream to SVN users.  Therefore it is advised that
+users keep history as linear as possible inside git to ease
+compatibility with SVN (see the CAVEATS section below).
 
 CAVEATS
 -------
-- 
Eric Wong
