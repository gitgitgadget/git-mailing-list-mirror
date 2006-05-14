From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH/RFC] gitopt - command-line parsing enhancements (take #2)
Date: Sun, 14 May 2006 08:19:17 -0700
Message-ID: <11476199622462-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 14 17:19:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfINS-0004nO-PG
	for gcvg-git@gmane.org; Sun, 14 May 2006 17:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWENPTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 11:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWENPTX
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 11:19:23 -0400
Received: from hand.yhbt.net ([66.150.188.102]:64668 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751438AbWENPTX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 11:19:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 833377DC005
	for <git@vger.kernel.org>; Sun, 14 May 2006 08:19:22 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19963>

This should be a less scary series of patches for gitopt.

[PATCH 1/5] gitopt: a new command-line option parser for git

[PATCH 2/5] gitopt: convert ls-files, ls-tree, update-index
	Simple conversions.

[PATCH 3/5] gitopt: convert setup_revisions() and friends
	This one is pretty big, some extra testing + review would be
	nice.

[PATCH 4/5] commit: allow --pretty= args to be abbreviated
	Not strictly related to gitopt, but finger-friendly nevertheless.

[PATCH 5/5] diff: parse U/u/unified options with an optional integer arg
	Originally, this was bundled into:
		<11471512123005-git-send-email-normalperson@yhbt.net>,
	Then Linus did a more correct one that didn't forget combine-diff:
		<Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	This one combines both of them.
