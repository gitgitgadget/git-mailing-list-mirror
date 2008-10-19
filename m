From: Francis Galiegue <fg@one2team.net>
Subject: Moving a 5 person dev team from CVS to git
Date: Sun, 19 Oct 2008 21:27:55 +0200
Organization: One2team
Message-ID: <200810192127.55954.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 12:26:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KreL0-000834-DP
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 21:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYJSTwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYJSTwE
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 15:52:04 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:43498 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbYJSTwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 15:52:03 -0400
X-Greylist: delayed 1196 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Oct 2008 15:52:03 EDT
Received: from erwin.kitchen.eel (unknown [90.63.85.196])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 2CA2A92C011
	for <git@vger.kernel.org>; Sun, 19 Oct 2008 21:31:53 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98643>

Hello,

I work for a software company with a dev team of 5, and right now a CVS 
repository is used for all the code which covers 8 years of history among 52 
modules and 1.6 GB data.

All devs use Eclipse, and its featureful CVS plugin. As for myself, I also 
write to the CVS tree, but in a CVS-to-git-to-CVS cycle (I don't use Eclipse 
but command line). I have talked about git, shown some of its capabilities, 
and my boss agreed to give it a shot, but with the following conditions:

* it must provide CVS access (branching and tagging included), as a transition 
measure;
* there must be an Eclipse plugin.

I have successfully imported all CVS modules into an equivalent number of git 
repositories so far. Unfortunately, I have two problems:

* the git-cvsserver does not support branching and tagging;
* I have successfully built the Eclipse plugin (Java 6, Eclipse 3.4), but am 
unable to make it clone a repository and see it in a project, despite quite a 
few hours googling around (it _does_ clone, I see the repo in the workspace; 
but it's invisible within Eclipse).

Is branching and tagging support a planned feature for git-cvsserver? Also, is 
there a step-by-step guide on using egit to clone an existing repository? 
(I'm a total beginner with Eclipse, so it may well be that I need to google 
some more.)

Thanks,
-- 
fge
