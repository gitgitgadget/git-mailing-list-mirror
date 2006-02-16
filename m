From: Paul Mackerras <paulus@samba.org>
Subject: git-rev-list --date-order ?
Date: Thu, 16 Feb 2006 13:40:46 +1100
Message-ID: <17395.58926.26670.23572@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 03:41:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Z4o-0004iX-C9
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 03:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWBPCkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 21:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWBPCkq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 21:40:46 -0500
Received: from ozlabs.org ([203.10.76.45]:37810 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751368AbWBPCkp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 21:40:45 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0C6DA679F8; Thu, 16 Feb 2006 13:40:44 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16262>

Junio,

Gitk has a -d option that tells it to reorder the commits in
decreasing order of their commit time, subject to the constraint that
parents come after all of their children.  Currently it uses
git-rev-list --header --topo-order --parents and then reorders the
commits internally.

How hard would it be to add a --date-order flag to git-rev-list to
make it order the commits in decreasing commit time order, subject to
the constraint that parents come after their children?

If we had that then I could remove another chunk of code from gitk and
make it a bit faster.

Thanks,
Paul.
