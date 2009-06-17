From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] EGit and JGit projects have split
Date: Wed, 17 Jun 2009 08:06:57 -0700
Message-ID: <20090617150657.GF11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 17:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGwjB-0003Ls-Qf
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 17:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZFQPG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZFQPGz
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 11:06:55 -0400
Received: from george.spearce.org ([209.20.77.23]:42044 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZFQPGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 11:06:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 85132381FD; Wed, 17 Jun 2009 15:06:57 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121751>

The EGit and JGit projects have now split apart.  Up until today
they were housed in the same repository at repo.or.cz.

As EGit is moving to the Eclipse Foundation umbrella, we wanted to
fully split JGit off such that applications trying to make use of
JGit can do so without dragging in the EGit specific code.

JGit is now here:

  http://repo.or.cz/w/jgit.git
  git://repo.or.cz/jgit.git

  direct patches to git ML
  same maintainers (myself, Robin Rosenberg)


EGit is still in the same location:

  http://repo.or.cz/w/egit.git
  git://repo.or.cz/egit.git

  direct patches to egit-dev@eclipse.org
  same maintainers (myself, Robin Rosenberg)


FYI, no history was rewritten.  Two commits were introduced to
create the fork:

  JGit: 9171327f92240a3dbef4a389a2a6378044013803 (rm -rf *egit*)
  EGit: 8f4475f4324599ab704eb1dc3adec92d3b1b85df (rm -rf *jgit*)


Please update your personal forks and clones as necessary.

-- 
Shawn.
