From: Paul Mackerras <paulus@samba.org>
Subject: new features in gitk
Date: Tue, 28 Jun 2005 08:22:46 +1000
Message-ID: <17088.31798.17291.605567@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 28 00:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn1tR-00079U-Rz
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 00:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVF0WWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 18:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVF0WWy
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 18:22:54 -0400
Received: from ozlabs.org ([203.10.76.45]:37316 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261952AbVF0WWw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 18:22:52 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4B83F67A79; Tue, 28 Jun 2005 08:22:51 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

New features that I have added recently to the gitk repository at

rsync://rsync.kernel.org/pub/scm/gitk/gitk.git

include:

* Added a right-click context menu on the headlines displayed in the
  top-left pane with the following entries:
  - Display diff between two commits
  - Generate a patch file containing the diff between two commits
  - Create a local direct tag for a commit

* Left-click on a graph line now displays the parent and the children
  connected by that line in the bottom-left pane, with buttons
  allowing you to jump to the parent or a child.

* Pasting into the SHA1 ID field clears it first if it already
  contains a SHA1 ID.

* Checks for a .git (or $GIT_DIR) directory at startup.

I'm interested to know if people find the diff/patch generation
options useful.

Paul.
