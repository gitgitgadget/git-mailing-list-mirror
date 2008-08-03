From: Marc Weber <marco-oweber@gmx.de>
Subject: small merge tool for temporary merges
Date: Sun, 3 Aug 2008 18:34:15 +0200
Message-ID: <20080803163415.GB14513@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 18:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPgaC-0008J1-VP
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 18:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbYHCQeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 12:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756451AbYHCQeU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 12:34:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:35808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756440AbYHCQeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 12:34:19 -0400
Received: (qmail invoked by alias); 03 Aug 2008 16:34:15 -0000
Received: from pD9E0990A.dip.t-dialin.net (EHLO nixos) [217.224.153.10]
  by mail.gmx.net (mp057) with SMTP; 03 Aug 2008 18:34:15 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19ySf0d0kZy8QMkhG9yt/pWzlbFXpLrrHWIR5E7+s
	1V/2BlAJ6j/xBp
Received: by nixos (sSMTP sendmail emulation); Sun, 03 Aug 2008 18:34:15 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91251>

Hi at all,

I'd like to announce the exisntance of my small git test merge tool.

After reading 
 Linux kernel mailing list may remember that Linus complained about such
 too frequent test merges when a subsystem maintainer asked to pull from
 a branch full of "useless merges"
in the man page of git-rerere I had to start it..

$ git clone git://mawercer.de/git-test-merge

=============  =======================================================
small HOWTO:

$ alias gtm=git-test-merge

$ gtm h # show the help
$ gtm s mytestmerge branch{1,2} # define testmerge "mytestmerge" which is formed by merging branch1 and branch2
$ gtm u mytestmerge # merge first using octopus, if it fails merge with
                    # the previous merge result with next branch until
                    # no branches are left to merge

If the merge fails you can resolve the conflicts and run
$ gtm c # you don't have to git-add the resolved files, will be done by the script

I hope its useful for you as well. If you have patches you may push them
instantly.
If it's obsolete because there is a better tool I appreciat you pointing
me to it

Sincerly
Marc Weber
