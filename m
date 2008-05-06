From: Michael Fischer <michael@visv.net>
Subject: git-svn trouble finding all branches/tags
Date: Tue, 6 May 2008 16:16:02 -0400
Message-ID: <20080506201602.GB10561@marlowe.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 22:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtTwH-0004un-Mr
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 22:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217AbYEFUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbYEFUiQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 16:38:16 -0400
Received: from www.visv.net ([64.81.194.132]:39859 "EHLO visv.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301AbYEFUiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 16:38:14 -0400
X-Greylist: delayed 1329 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 May 2008 16:38:14 EDT
Received: by visv.net (Postfix, from userid 1000)
	id 4AD2A6FC269; Tue,  6 May 2008 16:16:02 -0400 (EDT)
Mail-Followup-To: Michael Fischer <michael@visv.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81379>


Scenario is initialization  of a local git repo from a remote
SVN repo.


$ git svn init -s https://svn.our.office/projname

$ git svn fetch
.........................

Now, git branch -r shows trunk, one branch, 3 tags. There ought to be
7 branches, and about 20 tags.

If I go into .git/svn/.metadata and change the 

branches-maxRev
tags-maxRev 

values to something much larger than anything in SVN (e.g. 1000000), 
and repeat 'git svn fetch', lather, rinse repeat, then I eventually
have all the branches and tags.

Surely this isn't the way its supposed to happen?

TIA.


Michael
-- 
Michael Fischer
michael@visv.net
