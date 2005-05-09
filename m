From: Paul Mackerras <paulus@samba.org>
Subject: Prototype git commit viewer
Date: Mon, 9 May 2005 11:40:13 +1000
Message-ID: <17022.49021.344841.79940@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 09 03:31:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUx7G-00029u-Hg
	for gcvg-git@gmane.org; Mon, 09 May 2005 03:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVEIBib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 21:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVEIBib
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 21:38:31 -0400
Received: from ozlabs.org ([203.10.76.45]:53144 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263021AbVEIBi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 21:38:28 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id CC232679F8; Mon,  9 May 2005 11:38:26 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Over the weekend I hacked up a prototype viewer for git commits in
Tk.  It's called gitk and is at:

	http://ozlabs.org/~paulus/gitk

(that's the actual script itself :).

It displays a window with two panes; the upper one shows a summary of
all the commits with a graph on the left showing the relationship of
the commits (each dot represents a commit, with lines joining parents
and children).  The list is displayed with the most recent commit at
the top, and parents below their children.

If you click on a commit, the bottom pane shows more details of the
commit including the commit comments.

I plan to add a pane to show the list of files changed by the commit,
and provide a way to pop up a dirdiff-style diff viewer window to view
the actual diffs.  I also plan to add a way to view the diffs between
arbitrary points in the graph using girdiff.  There is quite a lot of
UI tweaking to be done too.  However, it's already quite useful in its
current state.

Paul.
