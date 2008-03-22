From: Sven Marnach <sven@pantoffel-wg.de>
Subject: Rebasing a complete revision graph
Date: Sat, 22 Mar 2008 13:19:55 +0100
Message-ID: <20080322121954.GA5578@pantoffel-wg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 13:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd33g-0005u1-4f
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 13:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbYCVMmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 08:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbYCVMmF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 08:42:05 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:56586 "EHLO
	relay.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbYCVMmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 08:42:04 -0400
X-Greylist: delayed 1321 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Mar 2008 08:42:04 EDT
Received: from ix.urz.uni-heidelberg.de (cyrus1.urz.uni-heidelberg.de [129.206.119.235])
	by relay.uni-heidelberg.de (8.14.1/8.14.1) with ESMTP id m2MCJuAd014055
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 13:19:57 +0100
Received: from extmail.urz.uni-heidelberg.de (extmail.urz.uni-heidelberg.de [129.206.100.140])
	by ix.urz.uni-heidelberg.de (8.8.8/8.8.8) with ESMTP id NAA14630980
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 13:19:56 +0100
Received: from bagheera.suspekt (dslb-084-056-239-215.pools.arcor-ip.net [84.56.239.215])
	(authenticated bits=0)
	by extmail.urz.uni-heidelberg.de (8.13.4/8.13.1) with ESMTP id m2MCJoFO019931
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 13:19:52 +0100
Received: from sven by bagheera.suspekt with local (Exim 4.69)
	(envelope-from <sven@pantoffel-wg.de>)
	id 1Jd2hX-0002Ga-2F
	for git@vger.kernel.org; Sat, 22 Mar 2008 13:19:55 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77801>

Hi,

I'm wondering if there is a way of rebasing a wohle revision graph
with multiple branches and merges, but I didn't find anything in the
documentation or on the mailing list.

My use case is as follows: I imported an svn repository to git using
git-svn, but threw away all svn metadata because I just wanted a
one-shot import.  Now I changed my mind and I would like to use "git
svn dcommit" to push the master branch commits to that old svn
repository stil lying around.  There were no changes to that
repository meanwhile, and I'm the only one committing to the git
repository.

So my idea is to reimport the svn repository with git-svn, this time
preserving metadata, and rebasing all the branches in my old git
repository on that new import.  (I don't care about all the commits
being rewritten.)  Doing this manually is a big mess, because you have
to do it for every branch and you have to decide each time onto which
commit the branch should be rebased.  If the graph is more complex, it
seems completely impossible to me to do this using git-rebase.
Moreover, all tags must be moved manually to the new repository.

Is there some automated way to to this?

(I'm not on the list, please reply directly to me.)

Greetings and thanks,
    Sven
