From: David Kastrup <dak@gnu.org>
Subject: How to use git-svn to clone from a mirror?
Date: Sat, 02 Jun 2007 14:54:40 +0200
Message-ID: <86hcpq8qjz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 14:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuTCj-0003rh-Jj
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 14:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbXFBM7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 08:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755738AbXFBM7a
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 08:59:30 -0400
Received: from main.gmane.org ([80.91.229.2]:41790 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143AbXFBM73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 08:59:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HuTBz-00074Z-Vb
	for git@vger.kernel.org; Sat, 02 Jun 2007 14:58:51 +0200
Received: from dslb-084-061-016-061.pools.arcor-ip.net ([84.61.16.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 14:58:51 +0200
Received: from dak by dslb-084-061-016-061.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 14:58:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-016-061.pools.arcor-ip.net
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:X1ZrLCKz45JwTmQX3HkHvrQ4msk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48927>


Hi, I seem to be too stupid to get this right.

I have used something like

git-svn clone -T trunk -b branches -t tags file:///tmp/rsync-mirror

to clone an rsync mirror of an SVN repository.  Now I want to have
fetch revert to pulling from the upstream repository in future.
However, if I change the respective line in .git/config to
svn://the.svn.link/whatever, git-rebase will fetch the right updates,
but then says that it can't work with the objects in the git
repository.

Changing the config back will make git-rebase -l work.

So what would be the right procedure to shift the SVN source from an
rsync mirror to the original, without git-svn breaking?

-- 
David Kastrup
