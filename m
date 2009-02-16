From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 10:06:37 +0000 (UTC)
Message-ID: <loom.20090216T095523-830@post.gmane.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm> <20090216000220.GA3503@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 11:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0Of-0003ux-MM
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbZBPKGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbZBPKGu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:06:50 -0500
Received: from main.gmane.org ([80.91.229.2]:46453 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbZBPKGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:06:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZ0NB-0006AK-M5
	for git@vger.kernel.org; Mon, 16 Feb 2009 10:06:46 +0000
Received: from host172-56-dynamic.10-87-r.retail.telecomitalia.it ([87.10.56.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:06:45 +0000
Received: from sergio.callegari by host172-56-dynamic.10-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:06:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.10.56.172 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.6) Gecko/2009020911 Ubuntu/8.10 (intrepid) Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110159>

In my workflows (and let me remark it, in mine, which might well be mine only or
even very stupid), what would be nice would be the possibility of triggering the
following scenario:

- When you push to a repo which is not bare, if you push to a checked out
branch, the branch gets updated, the worktree is not touched, the head becomes
detached, the branch the head was on gets saved somewhere, and when someone
tries asking for status or committing on the repo he gets a message like:

"The branch has been changed behind your shoulders from remote. Your work tree
changes are anyway safe. Head has been detached, your former branch was .... You
can either:
- start a new branch with the changes that are currently in your worktree with
command so and so...
- stash the current status, peek at the new head of your former branch, try
applying your current changes there."

Also it would be nice to be able to store my "standard initial setup" in
.gitinit or something like this, so that whenever I git init I have my own
defaults (which is not the same as having global config info).

...thanks for pre-announcing incompatible changes.

Sergio
