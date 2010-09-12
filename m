From: Daniel Trebbien <dtrebbien@gmail.com>
Subject: git-svn: How dependent is the git-svn repository on the Subversion repository URL?
Date: Sun, 12 Sep 2010 01:29:52 +0000 (UTC)
Message-ID: <loom.20100912T032208-79@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 03:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OubOu-0006id-Gy
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 03:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab0ILBaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 21:30:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:60660 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036Ab0ILBaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 21:30:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OubON-0006cf-6Q
	for git@vger.kernel.org; Sun, 12 Sep 2010 03:30:03 +0200
Received: from cpe-76-88-109-104.san.res.rr.com ([76.88.109.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 03:30:03 +0200
Received: from dtrebbien by cpe-76-88-109-104.san.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 03:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.88.109.104 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100824 Firefox/3.6.3 NET_mmhpset)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156015>

If I initialize the git-svn repository by passing in the location of a local
mirror, as in:
git svn init -s file:///path/to/mirror
and proceed to fetch all revisions from the mirror, may I simply change the
`url = ` line of `.git/config` to make it point to the real repository, or is
the git repository that is created by git-svn dependent on the original URL that
was specified in the initialization?
