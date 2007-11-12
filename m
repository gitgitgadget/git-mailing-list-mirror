From: Thomas Neumann <tneumann@users.sourceforge.net>
Subject: wishlist: git info
Date: Mon, 12 Nov 2007 21:30:56 +0100
Message-ID: <fhad5q$iia$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 21:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irg9r-0004jb-85
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXKLUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbXKLUpH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:45:07 -0500
Received: from main.gmane.org ([80.91.229.2]:56898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbXKLUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:45:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Irg9W-0008F2-6Z
	for git@vger.kernel.org; Mon, 12 Nov 2007 20:45:02 +0000
Received: from dslb-084-058-234-234.pools.arcor-ip.net ([84.58.234.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 20:45:02 +0000
Received: from tneumann by dslb-084-058-234-234.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 20:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-058-234-234.pools.arcor-ip.net
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64703>

Hi,

while git is pleasant to use in everyday work, there is one svn feature
which is miss dearly, namely "svn info". svn info can give information
about specific file objects, but I think its main feature is to use it
without any path and thus just describe the current project.
I use this a lot to quickly find out to which remote repository the
current directory belongs (yes, some work projects tend to look very
similar...) and what is the current state of the directory.

As a crude approximation, "git info" should print something like:
cat .git/config | grep url
git show | head -3

Probably not the most intelligent way to compute it, but you get the
idea. git info should give a brief overview over the current working
directory.
If there is consensus that this is a useful feature I can try to suggest
a patch (although honestly I would prefer that someone else does it, I
am not familiar with the git internals).

Thomas
